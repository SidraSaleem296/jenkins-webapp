from flask import Flask, jsonify
import sqlite3

app = Flask(__name__)

# Database setup
def init_db():
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS visitors (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        )
    ''')
    conn.commit()
    conn.close()

@app.route('/')
def home():
    return jsonify({"message": "Welcome to Sample Web App!"})

@app.route('/add-visitor/<name>')
def add_visitor(name):
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    cursor.execute('INSERT INTO visitors (name) VALUES (?)', (name,))
    conn.commit()
    conn.close()
    return jsonify({"message": f"Visitor {name} added!"})

@app.route('/visitors')
def get_visitors():
    conn = sqlite3.connect('app.db')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM visitors')
    visitors = cursor.fetchall()
    conn.close()
    return jsonify({"visitors": visitors})

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000)
