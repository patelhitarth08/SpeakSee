import requests
from flask import Flask, request, Response, jsonify, make_response
import cv2
import numpy as np
from openai import OpenAI

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 1000 * 1024 * 1024  # 16 megabytes

@app.route('/upload', methods=['POST'])
def upload_file():
    print("hi")
    if 'image' not in request.files:
        return "No image file in the request", 400

    image = request.files['image']
    
    if image.filename == '':
        return "No selected image", 400

    img_stream = image.read()
    nparr = np.frombuffer(img_stream, np.uint8)
    img_cv2 = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    
    API_URL = "https://api-inference.huggingface.co/models/Salesforce/blip-image-captioning-large"
    headers = {"Authorization": f"Bearer {API_TOKEN}"}

    data = img_stream
    try:
        response = requests.post(API_URL, headers=headers, data=data)
        response.raise_for_status() 
        output =  response.json()
    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")
        return "Failed to retrieve response from the API.", 500

    if output:
        print(output)
        text = output[0]['generated_text']
        # Generate speech from the text
        return jsonify({"output": text})
        
    else:
        print("Failed to retrieve response from the API.")
        return "Failed to retrieve response from the API.", 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
