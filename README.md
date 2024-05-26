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

## フォルダ構造

- `input_files`: 入力ファイルを格納
- `scripts`: スクリプトを格納
- `output_files`: 出力ファイルを格納

## 前提条件

- WSL (Windows Subsystem for Linux) がインストールされている
- Python 3 がインストールされている
- `jq` がインストールされている



## セットアップ

1. リポジトリをクローンします。

```bash
git clone https://github.com/yourusername/chatgpt-conversation-extractor.git
cd chatgpt-conversation-extractor
```

2. フォルダを作成し、ファイルを移動します。


## 使用方法

指定したタイトル名の会話を抽出し、ユーザーのメッセージを含むファイルを生成します。

### 例

タイトルが「TITLE」の場合：

```bash
./scripts/extract_conversation.sh "TITLE"
```

生成されたユーザーメッセージは、`output_files/user_messages_with_timestamps_TITLE.txt` に保存されます。

## ファイルの説明

### `scripts/extract_conversation.sh`

指定されたタイトル名の会話を抽出し、Pythonスクリプトを呼び出してユーザーのメッセージを抽出します。

### `scripts/extract_user_messages_with_timestamps.py`

抽出された会話からユーザーのメッセージとそのタイムスタンプを取得し、指定されたファイルに保存します。

## ライセンス

このプロジェクトはMITライセンスの下で提供されています。詳細については、`LICENSE`ファイルを参照してください。
```
