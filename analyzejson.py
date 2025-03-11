import json
import sys

def get_structure(sample):
    """JSONデータの構造を解析する関数"""
    if isinstance(sample, dict):
        return {key: get_structure(value) for key, value in sample.items()}
    elif isinstance(sample, list):
        if sample:
            return [get_structure(sample[0])]
        else:
            return ["empty array"]
    else:
        return type(sample).__name__

def main():
    # コマンドライン引数の確認
    if len(sys.argv) != 2:
        print("Usage: python3 script.py <json_file>")
        sys.exit(1)

    json_file = sys.argv[1]

    try:
        # JSONファイルを読み込む
        with open(json_file, "r", encoding="utf-8") as f:
            data = json.load(f)

        # 配列型JSONの場合、最初の1つを解析
        if isinstance(data, list) and data:
            structure = get_structure(data[0])
        else:
            structure = get_structure(data)

        # 構造を出力
        print(json.dumps(structure, indent=2, ensure_ascii=False))

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
