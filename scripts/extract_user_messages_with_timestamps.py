import json
import sys
from datetime import datetime
from difflib import SequenceMatcher

# コマンドライン引数からファイルパスを取得
json_file_path = sys.argv[1]
output_file_path = sys.argv[2]
title_file_path = sys.argv[3]
exclude_single_line = '--exclude-single-line' in sys.argv
exclude_short_messages = '--exclude-short-messages' in sys.argv

# JSONファイルの読み込み
with open(json_file_path, 'r') as file:
    data = json.load(file)

# タイトルリストの読み込み
with open(title_file_path, 'r') as file:
    titles = [line.strip() for line in file.readlines()]

# デバッグ: タイトルリストを表示
print("Titles to be processed:", titles)

# ユーザーのメッセージを抽出する関数
def extract_user_messages(data, titles):
    user_messages = []

    for conversation in data:
        if conversation['title'] in titles:
            print(f"Processing title: {conversation['title']}")  # デバッグ: 現在処理中のタイトル
            mapping = conversation.get('mapping', {})
            visited = set()  # 訪問済みノードのセット

            def traverse(node_id):
                if node_id in visited:
                    return  # 既に訪問したノードはスキップ
                visited.add(node_id)

                node = mapping.get(node_id)
                if node and 'message' in node and node['message']:
                    message = node['message']
                    if message['author']['role'] == 'user':
                        content = message.get('content', {})
                        # "parts"キーがあれば利用し、なければ"text"キー、どちらもなければ空リスト
                        if 'parts' in content:
                            content_parts = content['parts']
                        elif 'text' in content:
                            content_parts = [content['text']]
                        else:
                            content_parts = []
                        # create_timeがNoneの場合に備えてデフォルト値を設定する例
                        if message.get('create_time'):
                            create_time = datetime.fromtimestamp(message['create_time']).strftime('%Y-%m-%d %H:%M:%S')
                        else:
                            create_time = "N/A"
                        for part in content_parts:
                            if isinstance(part, str):
                                if exclude_single_line and len(part.splitlines()) == 1:
                                    continue
                                if exclude_short_messages and len(part) <= 50:
                                    continue
                                print(f"Extracted message part: {part[:50]}...")  # デバッグ: 抽出されたメッセージの一部を表示
                                user_messages.append((create_time, part))
                for child_id in node.get('children', []):
                    traverse(child_id)

            for node_id in mapping:
                traverse(node_id)

    return user_messages

# メッセージを80%以上一致しているかどうかを判定する関数
def is_similar(msg1, msg2, threshold=0.8):
    return SequenceMatcher(None, msg1, msg2).ratio() > threshold

# ユーザーのメッセージを抽出
user_messages = extract_user_messages(data, titles)

# デバッグ: 抽出されたメッセージの数を表示
print(f"Total extracted messages: {len(user_messages)}")

# 日時でソート
user_messages.sort(key=lambda x: x[0])

# 80%以上一致するメッセージを前後10個と比較して削除
filtered_messages = []
for i, (timestamp, message) in enumerate(user_messages):
    similar_found = False
    for j in range(max(0, i-10), min(len(user_messages), i+11)):
        if i != j and is_similar(message, user_messages[j][1]):
            similar_found = True
            break
    if not similar_found:
        filtered_messages.append((timestamp, message))

# デバッグ: フィルタリングされたメッセージの数を表示
print(f"Total filtered messages: {len(filtered_messages)}")

# 抽出したメッセージを表示
print("Extracted messages:")
for i, (timestamp, message) in enumerate(filtered_messages):
    print(f"Message {i+1} (at {timestamp}):\n{message}\n")

# 必要に応じて、抽出したメッセージをファイルに保存
with open(output_file_path, 'w') as file:
    for timestamp, message in filtered_messages:
        file.write(f"{timestamp}\n{message}\n\n")

print(f"ユーザーのメッセージは '{output_file_path}' に保存されました。")
