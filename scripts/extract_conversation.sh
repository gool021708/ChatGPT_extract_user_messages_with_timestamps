#!/bin/bash

# タイトルを入力するプロンプト / Prompt to enter titles
while true; do
    echo "抽出したい会話のタイトルを入力してください。改行し 'end' と入力してください。複数の場合は改行で区切って 'end' と入力してください。"
    echo "Enter the titles of the conversations to extract. Type 'end' after the title. For multiple titles, separate each with a newline and then type 'end'."
    
    TITLE_LIST=()
    
    while true; do
        read -r TITLE
        # 空白行を無視 / Ignore empty lines
        if [ -z "$TITLE" ]; then
            continue
        fi
        TITLE_LIST+=("$TITLE")
        if [ "$TITLE" == "end" ]; then
            unset TITLE_LIST[-1]  # Remove 'end' from the list
            break
        fi
    done

    if [ ${#TITLE_LIST[@]} -eq 0 ]; then
        echo "少なくとも1つのタイトルを入力してください。最初からやり直してください。"
        echo "Please enter at least one title. Start again."
        continue
    fi
    
    break
done

# タイトルをファイル名として使用可能な形式に変換 / Convert titles to a valid filename format
sanitize_title() {
    echo "$1" | sed -E 's/[<>:"/\\|?*]+//g'
}

# 出力ファイル名の設定 / Setting the output file name
if [ ${#TITLE_LIST[@]} -eq 1 ]; then
    SAVE_TITLE=$(sanitize_title "${TITLE_LIST[0]}")
elif [ ${#TITLE_LIST[@]} -eq 2 ]; then
    SAVE_TITLE=$(sanitize_title "${TITLE_LIST[0]}-and-${TITLE_LIST[1]}")
elif [ ${#TITLE_LIST[@]} -eq 3 ]; then
    SAVE_TITLE=$(sanitize_title "${TITLE_LIST[0]}-${TITLE_LIST[1]}-and-${TITLE_LIST[2]}")
else
    SAVE_TITLE=$(sanitize_title "${TITLE_LIST[0]}-${TITLE_LIST[1]}-and-others")
fi
OUTPUT_FILE="output_files/user_messages_with_timestamps_${SAVE_TITLE}.txt"

# オプションの入力（1行のプロンプトを除外するかどうか） / Prompt to exclude single line prompts
while true; do
    echo "1行のプロンプトを除外しますか？ (y/n)"
    read -p "Do you want to exclude single line prompts? (y/n): " EXCLUDE_SINGLE_LINE
    case "${EXCLUDE_SINGLE_LINE,,}" in
        y|yes) EXCLUDE_OPTION="--exclude-single-line"; break;;
        n|no) EXCLUDE_OPTION=""; break;;
        *) echo "無効な入力です。'y' または 'n' を入力してください。"
           echo "Invalid input. Please enter 'y' or 'n'.";;
    esac
done

# オプションの入力（50文字以下のメッセージを除外するかどうか） / Prompt to exclude messages shorter than 50 characters
while true; do
    echo "50文字以下のメッセージを除外しますか？ (y/n)"
    read -p "Do you want to exclude messages shorter than 50 characters? (y/n): " EXCLUDE_SHORT_MESSAGES
    case "${EXCLUDE_SHORT_MESSAGES,,}" in
        y|yes) EXCLUDE_OPTION="$EXCLUDE_OPTION --exclude-short-messages"; break;;
        n|no) break;;
        *) echo "無効な入力です。'y' または 'n' を入力してください。"
           echo "Invalid input. Please enter 'y' or 'n'.";;
    esac
done

# JSONファイルのパス / Path to JSON file
JSON_FILE="input_files/conversations.json"

# タイトルリストを一時ファイルに保存 / Save title list to a temporary file
TEMP_TITLE_FILE="input_files/temp_titles.txt"
printf "%s\n" "${TITLE_LIST[@]}" > "$TEMP_TITLE_FILE"

# Pythonスクリプトを実行して、ユーザーのメッセージを抽出し、結合する / Execute Python script to extract and combine user messages
python3 scripts/extract_user_messages_with_timestamps.py "$JSON_FILE" "$OUTPUT_FILE" "$TEMP_TITLE_FILE" $EXCLUDE_OPTION

# 一時ファイルを削除 / Remove temporary file
rm "$TEMP_TITLE_FILE"

# 完了メッセージ / Completion message
echo "ユーザーのメッセージは '$OUTPUT_FILE' に保存されました。"
echo "User messages have been saved to '$OUTPUT_FILE'."
