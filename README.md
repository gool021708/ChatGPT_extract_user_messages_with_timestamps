# ChatGPT Conversation Extractor

このリポジトリは、指定されたタイトルの会話を`conversations.json`から抽出し、ユーザーのメッセージを含むファイルを生成するためのスクリプトを提供します。

## Description

このプロジェクトでは、ChatGPTのエクスポートされた会話ログから特定のタイトルを持つ会話を抽出し、ユーザーが入力したメッセージのみを抽出・保存するスクリプトを提供しています。これにより、特定の会話トピックに対するユーザーの入力内容を効率的に収集・分析することができます。

## フォルダ構造

- `input_files`: 入力ファイルを格納
- `scripts`: スクリプトを格納
- `output_files`: 出力ファイルを格納

## 前提条件

- WSL (Windows Subsystem for Linux) がインストールされている
- Python 3 がインストールされている
- `jq` がインストールされている
- `dos2unix` がインストールされている

### `jq` のインストール

```bash
sudo apt update
sudo apt install jq

以下に、READMEファイルにDescriptionセクションを追加した完全な内容を示します。

```markdown
# ChatGPT Conversation Extractor

このリポジトリは、指定されたタイトルの会話を`conversations.json`から抽出し、ユーザーのメッセージを含むファイルを生成するためのスクリプトを提供します。

## Description

このプロジェクトでは、ChatGPTのエクスポートされた会話ログから特定のタイトルを持つ会話を抽出し、ユーザーが入力したメッセージのみを抽出・保存するスクリプトを提供しています。これにより、特定の会話トピックに対するユーザーの入力内容を効率的に収集・分析することができます。

## フォルダ構造

- `input_files`: 入力ファイルを格納
- `scripts`: スクリプトを格納
- `output_files`: 出力ファイルを格納

## 前提条件

- WSL (Windows Subsystem for Linux) がインストールされている
- Python 3 がインストールされている
- `jq` がインストールされている
- `dos2unix` がインストールされている

### `jq` のインストール

```bash
sudo apt update
sudo apt install jq
```

### `dos2unix` のインストール

```bash
sudo apt update
sudo apt install dos2unix
```

## セットアップ

1. リポジトリをクローンします。

```bash
git clone https://github.com/yourusername/chatgpt-conversation-extractor.git
cd chatgpt-conversation-extractor
```

2. フォルダを作成し、ファイルを移動します。

```bash
# フォルダの作成
mkdir -p input_files scripts output_files

# 入力ファイルの移動
mv conversations.json input_files/

# スクリプトファイルの移動
mv extract_conversation.sh scripts/
mv extract_user_messages_with_timestamps.py scripts/

# extract_conversation.sh の内容を修正
cat << 'EOF' > scripts/extract_conversation.sh
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
EOF

# シェルスクリプトに実行権限を付与
chmod +x scripts/extract_conversation.sh
```

## 使用方法

指定したタイトル名の会話を抽出し、ユーザーのメッセージを含むファイルを生成します。

### 例

タイトルが「仕事プレッシャーと日常ジョーク」の場合：

```bash
./scripts/extract_conversation.sh "仕事プレッシャーと日常ジョーク"
```

生成されたユーザーメッセージは、`output_files/user_messages_with_timestamps_仕事プレッシャーと日常ジョーク.txt` に保存されます。

## ファイルの説明

### `scripts/extract_conversation.sh`

指定されたタイトル名の会話を抽出し、Pythonスクリプトを呼び出してユーザーのメッセージを抽出します。

### `scripts/extract_user_messages_with_timestamps.py`

抽出された会話からユーザーのメッセージとそのタイムスタンプを取得し、指定されたファイルに保存します。

## ライセンス

このプロジェクトはMITライセンスの下で提供されています。詳細については、`LICENSE`ファイルを参照してください。
```

このREADMEは、プロジェクトの目的、使用方法、フォルダ構造、前提条件、セットアップ手順、使用例、スクリプトの説明、およびライセンス情報を含んでいます。これをプロジェクトのルートディレクトリに`README.md`として保存してください。
