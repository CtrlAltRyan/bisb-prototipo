from flask import Flask, render_template, url_for
from routes.user import user_bp
from routes.auth import auth_bp

app = Flask(__name__)
app.secret_key  = '123'

app.register_blueprint(user_bp, url_prefix='/user')
app.register_blueprint(auth_bp, url_prefix='/auth')

@app.route('/')
def root():
    return render_template('login.html')

if __name__ == '__main__':
    app.run(debug=True)