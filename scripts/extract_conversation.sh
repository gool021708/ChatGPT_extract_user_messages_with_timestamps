#!/bin/bash

# ユーザーにタイトル名を入力させる
read -p "抽出したい会話のタイトル名を入力してください: " TITLE

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
FILTERED_FILE="input_files/filtered_conversation.json"

# jqを使って指定したタイトル名の会話を抽出
jq --arg title "$TITLE" '.[] | select(.title == $title)' "$JSON_FILE" > "$FILTERED_FILE"

# ファイルが空かどうか確認
if [ ! -s "$FILTERED_FILE" ]; then
    echo "エラー: 指定されたタイトル名の会話が見つかりませんでした。"
    exit 1
fi

# ファイル名にタイトル名を含めるために、スペースをアンダースコアに置換
SAFE_TITLE=$(echo "$TITLE" | tr ' ' '_')
OUTPUT_FILE="output_files/user_messages_with_timestamps_${SAFE_TITLE}.txt"

# Pythonスクリプトを実行して、ユーザーのメッセージを抽出
python3 scripts/extract_user_messages_with_timestamps.py "$FILTERED_FILE" "$OUTPUT_FILE" $EXCLUDE_OPTION
