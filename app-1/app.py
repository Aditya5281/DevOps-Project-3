from flask import Flask, render_template, jsonify

app = Flask(__name__)

# Frontend route
@app.route('/')
def home():
    return render_template('index.html')

# Backend API route
@app.route('/api/message')
def get_message():
    return jsonify({"message": "Hello from Flask Backend! This is starting of DevOps Project."})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
