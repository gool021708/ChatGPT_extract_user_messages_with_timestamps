#!/bin/bash

# タイトルを入力するプロンプト / Prompt to enter titles
echo "抽出したい会話のタイトルを入力してください。改行し 'end' と入力してください。複数の場合は改行で区切って 'end' と入力してください。"
echo "Enter the titles of the conversations to extract. Type 'end' after the title. For multiple titles, separate each with a newline and then type 'end'."
TITLE_LIST=()
while true; do
    read -r TITLE
    if [ "$TITLE" == "end" ]; then
        break
    fi
    TITLE_LIST+=("$TITLE")
done

# オプションの入力（1行のプロンプトを除外するかどうか） / Prompt to exclude single line prompts
read -p "1行のプロンプトを除外しますか？ (yes/no): " EXCLUDE_SINGLE_LINE
read -p "Do you want to exclude single line prompts? (yes/no): " EXCLUDE_SINGLE_LINE_ENG
EXCLUDE_OPTION=""
if [ "$EXCLUDE_SINGLE_LINE" == "yes" ]; then
    EXCLUDE_OPTION="--exclude-single-line"
fi

# オプションの入力（50文字以下のメッセージを除外するかどうか） / Prompt to exclude messages shorter than 50 characters
read -p "50文字以下のメッセージを除外しますか？ (yes/no): " EXCLUDE_SHORT_MESSAGES
read -p "Do you want to exclude messages shorter than 50 characters? (yes/no): " EXCLUDE_SHORT_MESSAGES_ENG
if [ "$EXCLUDE_SHORT_MESSAGES" == "yes" ]; then
    EXCLUDE_OPTION="$EXCLUDE_OPTION --exclude-short-messages"
fi

# JSONファイルのパス / Path to JSON file
JSON_FILE="input_files/conversations.json"

# タイトルリストを一時ファイルに保存 / Save title list to a temporary file
TEMP_TITLE_FILE="input_files/temp_titles.txt"
printf "%s\n" "${TITLE_LIST[@]}" > "$TEMP_TITLE_FILE"

# Pythonスクリプトを実行して、ユーザーのメッセージを抽出し、結合する / Execute Python script to extract and combine user messages
SAFE_TITLE="combined_titles"
OUTPUT_FILE="output_files/user_messages_with_timestamps_${SAFE_TITLE}.txt"

python3 scripts/extract_user_messages_with_timestamps.py "$JSON_FILE" "$OUTPUT_FILE" "$TEMP_TITLE_FILE" $EXCLUDE_OPTION

# 一時ファイルを削除 / Remove temporary file
rm "$TEMP_TITLE_FILE"

# 完了メッセージ / Completion message
echo "ユーザーのメッセージは '$OUTPUT_FILE' に保存されました。"
echo "User messages have been saved to '$OUTPUT_FILE'."
