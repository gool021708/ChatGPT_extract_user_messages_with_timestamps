#!/bin/bash

# 結合オプションを聞く
echo "結合する会話のタイトルを入力してください（改行で区切って入力し、すべて入力後に 'end' と入力してください）："
TITLE_LIST=()
while true; do
    read -r TITLE
    if [ "$TITLE" == "end" ]; then
        break
    fi
    TITLE_LIST+=("$TITLE")
done

# オプションの入力（1行のプロンプトを除外するかどうか）
read -p "1行のプロンプトを除外しますか？ (yes/no): " EXCLUDE_SINGLE_LINE
EXCLUDE_OPTION=""
if [ "$EXCLUDE_SINGLE_LINE" == "yes" ]; then
    EXCLUDE_OPTION="--exclude-single-line"
fi

# オプションの入力（50文字以下のメッセージを除外するかどうか）
read -p "50文字以下のメッセージを除外しますか？ (yes/no): " EXCLUDE_SHORT_MESSAGES
if [ "$EXCLUDE_SHORT_MESSAGES" == "yes" ]; then
    EXCLUDE_OPTION="$EXCLUDE_OPTION --exclude-short-messages"
fi

# JSONファイルのパス
JSON_FILE="input_files/conversations.json"

# タイトルリストを一時ファイルに保存
TEMP_TITLE_FILE="input_files/temp_titles.txt"
printf "%s\n" "${TITLE_LIST[@]}" > "$TEMP_TITLE_FILE"

# Pythonスクリプトを実行して、ユーザーのメッセージを抽出し、結合する
SAFE_TITLE="combined_titles"
OUTPUT_FILE="output_files/user_messages_with_timestamps_${SAFE_TITLE}.txt"

python3 scripts/extract_user_messages_with_timestamps.py "$JSON_FILE" "$OUTPUT_FILE" "$TEMP_TITLE_FILE" $EXCLUDE_OPTION

# 一時ファイルを削除
rm "$TEMP_TITLE_FILE"

echo "ユーザーのメッセージは '$OUTPUT_FILE' に保存されました。"
