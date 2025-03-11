# ChatGPT Conversation Extractor

**English documentation follows after the Japanese version.**

このリポジトリは、指定されたタイトルの会話を `conversations.json` から抽出し、ユーザーのメッセージを含むファイルを生成するためのスクリプトを提供します。

## **概要**
このプロジェクトは、エクスポートされた ChatGPT の会話ログから特定のタイトルを持つ会話を抽出し、ユーザーが入力したメッセージのみを保存することで、特定の会話トピックに関するユーザーの入力を効率的に収集・分析できるようにします。

## **フォルダ構造**
```
ChatGPT_extract_user_messages_with_timestamps-main
│  LICENSE
│  README.md
│
├─input_files
│      conversations.json  # 会話ログを格納
│
├─output_files
│      user_messages_with_timestamps_＜TITLE＞.txt  # 抽出結果
│
├─scripts
│      extract_conversation.sh  # メインのシェルスクリプト
│      extract_user_messages_with_timestamps.py  # ユーザーメッセージを抽出するPythonスクリプト
│
└─tools
       analyzejson.py  # JSONの構造を解析するスクリプト
```

## **前提条件**
- **WSL (Windows Subsystem for Linux)** がインストールされている
- **Python 3** がインストールされている
- **`jq`** がインストールされている
- **`dos2unix`** がインストールされている (必要に応じて)

### **jq のインストール**
```bash
sudo apt update
sudo apt install jq
```

## **使用方法**
すべてのフォルダを適切なディレクトリに配置し、以下の手順で実行してください。

### **手順 1: 必要なディレクトリに移動**
```bash
cd <保存したディレクトリ>/ChatGPT_extract_user_messages_with_timestamps-main
```

### **手順 2: 会話の抽出を実行**
```bash
bash scripts/extract_conversation.sh
```

プロンプトに従い、抽出したい会話のタイトル名を入力してください。

### **出力**
抽出されたユーザーメッセージは、以下のファイルに保存されます。
```
output_files/user_messages_with_timestamps_＜TITLE＞.txt
```

---

## **スクリプトの説明**
### `scripts/extract_conversation.sh`
- 指定されたタイトル名の会話を抽出し、Pythonスクリプトを呼び出します。

### `scripts/extract_user_messages_with_timestamps.py`
- `extract_conversation.sh` で抽出された会話から、ユーザーのメッセージとタイムスタンプを取得し、ファイルに保存します。

### `tools/analyzejson.py`
- 任意のJSONファイルの構造を解析し、簡潔なスキーマを出力します。

---

## **エラーハンドリング**
- **引数なしで実行した場合**
  ```bash
  Usage: python3 script.py <json_file>
  ```
- **JSONファイルが存在しない場合**
  - エラーメッセージを表示

---

## **ライセンス**
このプロジェクトは MIT ライセンスの下で提供されています。詳細については、`LICENSE` ファイルを参照してください。

---

# **ChatGPT Conversation Extractor (English Version)**

This repository provides scripts to extract conversations with a specified title from `conversations.json` and generate a file containing only the user's messages.

## **Description**
This project extracts conversations with a specified title from an exported ChatGPT conversation log and saves only the user's messages. This helps efficiently collect and analyze user input for specific conversation topics.

## **Folder Structure**
```
ChatGPT_extract_user_messages_with_timestamps-main
│  LICENSE
│  README.md
│
├─input_files
│      conversations.json  # Stores conversation logs
│
├─output_files
│      user_messages_with_timestamps_＜TITLE＞.txt  # Extracted results
│
├─scripts
│      extract_conversation.sh  # Main shell script
│      extract_user_messages_with_timestamps.py  # Python script for extracting user messages
│
└─tools
       analyzejson.py  # Script for analyzing JSON structure
```

## **Prerequisites**
- **WSL (Windows Subsystem for Linux)** must be installed
- **Python 3** must be installed
- **`jq`** must be installed
- **`dos2unix`** must be installed (if needed)

### **Installing jq**
```bash
sudo apt update
sudo apt install jq
```

## **Usage**
Place all folders in the appropriate directory and follow these steps:

### **Step 1: Navigate to the required directory**
```bash
cd <your_directory>/ChatGPT_extract_user_messages_with_timestamps-main
```

### **Step 2: Execute the conversation extraction**
```bash
bash scripts/extract_conversation.sh
```

Follow the prompt to enter the title of the conversation you want to extract.

### **Output**
The extracted user messages will be saved in:
```
output_files/user_messages_with_timestamps_＜TITLE＞.txt
```

---

## **Script Descriptions**
### `scripts/extract_conversation.sh`
- Extracts conversations based on a specified title and calls a Python script.

### `scripts/extract_user_messages_with_timestamps.py`
- Extracts user messages and timestamps from the extracted conversation and saves them to a file.

### `tools/analyzejson.py`
- Analyzes the structure of a given JSON file and provides a simplified schema.

---

## **Error Handling**
- **If no argument is provided:**
  ```bash
  Usage: python3 script.py <json_file>
  ```
- **If the JSON file is missing or invalid, an error message is displayed.**

---

## **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.

