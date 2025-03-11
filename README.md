# ChatGPT Conversation Extractor

このリポジトリは、指定されたタイトルの会話を `conversations.json` から抽出し、ユーザーのメッセージを含むファイルを生成するためのスクリプトを提供します。

## **Description**
This project extracts conversations with a specified title from an exported ChatGPT conversation log and saves only the user's messages. This helps efficiently collect and analyze user input for specific conversation topics.

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
