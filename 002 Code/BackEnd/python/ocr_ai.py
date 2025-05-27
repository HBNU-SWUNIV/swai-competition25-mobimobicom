import requests
import re
import json

def ocr_with_upstage(api_key, filename):
    url = "https://api.upstage.ai/v1/document-digitization"
    headers = {"Authorization": f"Bearer {api_key}"}
    data = {"model": "ocr"}

    with open(filename, "rb") as f:
        files = {"document": f}
        response = requests.post(url, headers=headers, files=files, data=data)

    result_json = response.json()
    return result_json.get("pages", [{}])[0].get("text", "")

def split_into_paragraphs(text):
    lines = text.split('\n')
    paragraphs = []
    current = ""

    for line in lines:
        line = line.strip()
        if not line:
            continue
        if re.match(r'^(\d+\.)|^[-·]', line) and current:
            paragraphs.append(current.strip())
            current = line
        else:
            current += ' ' + line

    if current:
        paragraphs.append(current.strip())
    return paragraphs

def run_ocr_pipeline(api_key, filename):
    text = ocr_with_upstage(api_key, filename)
    paragraphs = split_into_paragraphs(text)
    return json.dumps(paragraphs, ensure_ascii=False, indent=2)

api_key = f"{api_key}"
filename = "0001.png"

result_json = run_ocr_pipeline(api_key, filename)
print(result_json)