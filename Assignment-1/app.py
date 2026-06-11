from flask import Flask
import os
import mysql.connector

app = Flask(__name__)

@app.route('/')
def index():
    try:
        db_connection = mysql.connector.connect(
            host=os.getenv('DB_HOST'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD'),
            database=os.getenv('DB_NAME')
        )

        cursor = db_connection.cursor()
        cursor.execute("SELECT 'Hello, Docker Compose!' AS message")
        message = cursor.fetchone()[0]

        return f"<h1>{message}</h1>"

    except Exception as e:
        return f"<h1>Error: {e}</h1>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
