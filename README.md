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






## 使用方法

すべてのフォルダを配置する。

## タイトルが「TITLE」の場合：

```bash
./scripts/extract_conversation.sh
```

プロンプトに従い、抽出したい会話のタイトル名を入力します。

生成されたユーザーメッセージは、`output_files/user_messages_with_timestamps_TITLE.txt` に保存されます。

## ファイルの説明

### `scripts/extract_conversation.sh`

指定されたタイトル名の会話を抽出し、Pythonスクリプトを呼び出してユーザーのメッセージを抽出します。

### `scripts/extract_user_messages_with_timestamps.py`

抽出された会話からユーザーのメッセージとそのタイムスタンプを取得し、指定されたファイルに保存します。


以下に、**英語版**と**日本語版**の説明・使い方をまとめました。

---

# **English Documentation**
# tools/analyzejson.py の説明
## **JSON Structure Analyzer**
This script analyzes the structure of a given JSON file and prints a simplified schema. It is useful when handling large JSON data and needing a quick overview of its structure.

### **Usage**
Run the script from the command line with the JSON file as an argument:

```bash
python3 script.py data.json
```

### **Features**
- Accepts a JSON file as a command-line argument.
- Extracts the structure from the first element if the JSON is an array.
- Provides a concise representation of the JSON schema.
- Handles errors gracefully (missing file, invalid JSON, etc.).
- Outputs formatted JSON with proper indentation.

### **Example**
#### **Input (`data.json`)**
```json
[
  {
    "id": 1,
    "name": "Alice",
    "details": {
      "age": 25,
      "address": {
        "city": "Tokyo",
        "zipcode": "100-0001"
      }
    },
    "tags": ["developer", "python"]
  }
]
```

#### **Command**
```bash
python3 script.py data.json
```

#### **Output**
```json
{
  "id": "int",
  "name": "str",
  "details": {
    "age": "int",
    "address": {
      "city": "str",
      "zipcode": "str"
    }
  },
  "tags": ["str"]
}
```

### **Error Handling**
- If no argument is provided:  
  ```bash
  Usage: python3 script.py <json_file>
  ```
- If the JSON file is invalid or missing, an error message is displayed.

---

# **日本語ドキュメント**
## **JSON構造解析スクリプト**
このスクリプトは、指定されたJSONファイルの構造を解析し、簡潔なスキーマを出力します。  
大きなJSONデータを扱う際に、素早く構造を把握するのに便利です。

### **使い方**
コマンドラインから、JSONファイルを引数として指定して実行します。

```bash
python3 script.py data.json
```

### **機能**
- JSONファイルをコマンドライン引数で指定可能。
- JSONが配列の場合は、最初の要素を解析。
- JSONのスキーマを簡潔に表示。
- エラーハンドリング（ファイルがない、JSONが壊れている場合）。
- 整形されたJSONを出力（インデント付き）。

### **例**
#### **入力 (`data.json`)**
```json
[
  {
    "id": 1,
    "name": "Alice",
    "details": {
      "age": 25,
      "address": {
        "city": "Tokyo",
        "zipcode": "100-0001"
      }
    },
    "tags": ["developer", "python"]
  }
]
```

#### **コマンド**
```bash
python3 script.py data.json
```

#### **出力**
```json
{
  "id": "int",
  "name": "str",
  "details": {
    "age": "int",
    "address": {
      "city": "str",
      "zipcode": "str"
    }
  },
  "tags": ["str"]
}
```

### **エラーハンドリング**
- 引数がない場合:  
  ```bash
  Usage: python3 script.py <json_file>
  ```
- JSONファイルが無効または存在しない場合、エラーメッセージを表示。

---

これで、英語と日本語どちらでも説明できるようになりました！ 🚀

## ライセンス

このプロジェクトはMITライセンスの下で提供されています。詳細については、`LICENSE`ファイルを参照してください。
```
