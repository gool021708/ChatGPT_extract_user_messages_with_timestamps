import json
import sys
from datetime import datetime

# コマンドライン引数からファイルパスを取得
log_file_path = sys.argv[1]
output_file_path = sys.argv[2]

# JSONファイルの読み込み
with open(log_file_path, 'r') as file:
    data = json.load(file)

# ユーザーのメッセージを抽出する関数
def extract_user_messages(data):
    user_messages = []
    visited = set()  # 訪問済みノードのセット

    def traverse(node_id):
        if node_id in visited:
            return  # 既に訪問したノードはスキップ
        visited.add(node_id)
        
        node = data['mapping'].get(node_id)
        if node and 'message' in node and node['message']:
            message = node['message']
            if message['author']['role'] == 'user':
                content_parts = message['content']['parts']
                create_time = datetime.fromtimestamp(message['create_time']).strftime('%Y-%m-%d %H:%M:%S')
                for part in content_parts:
                    user_messages.append((create_time, part))
        for child_id in node.get('children', []):
            traverse(child_id)

    for node_id in data['mapping']:
        traverse(node_id)

    return user_messages

# ユーザーのメッセージを抽出
user_messages = extract_user_messages(data)

# 抽出したメッセージを表示
for i, (timestamp, message) in enumerate(user_messages):
    print(f"Message {i+1} (at {timestamp}):\n{message}\n")

# 必要に応じて、抽出したメッセージをファイルに保存
with open(output_file_path, 'w') as file:
    for timestamp, message in user_messages:
        file.write(f"{timestamp}\n{message}\n\n")

print(f"ユーザーのメッセージは '{output_file_path}' に保存されました。")
