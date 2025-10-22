from flask import Flask, render_template, jsonify
import os

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/message')
def message():
    return jsonify({"message": "Hello from Flask on Azure App Service!"})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))  # Use the PORT Azure gives, default to 5000 locally
    app.run(host='0.0.0.0', port=port)
