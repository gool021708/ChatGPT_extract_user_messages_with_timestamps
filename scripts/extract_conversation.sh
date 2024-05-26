#!/bin/bash

# 引数で指定されたタイトル名
TITLE=$1

# JSONファイルのパス
JSON_FILE="input_files/conversations.json"
FILTERED_FILE="input_files/filtered_conversation.json"

# jqを使って指定したタイトル名の会話を抽出
jq --arg title "$TITLE" '.[] | select(.title == $title)' "$JSON_FILE" > "$FILTERED_FILE"

# ファイル名にタイトル名を含めるために、スペースをアンダースコアに置換
SAFE_TITLE=$(echo "$TITLE" | tr ' ' '_')
OUTPUT_FILE="output_files/user_messages_with_timestamps_${SAFE_TITLE}.txt"

# Pythonスクリプトを実行して、ユーザーのメッセージを抽出
python3 scripts/extract_user_messages_with_timestamps.py "$FILTERED_FILE" "$OUTPUT_FILE"

echo "ユーザーのメッセージは '$OUTPUT_FILE' に保存されました。"
