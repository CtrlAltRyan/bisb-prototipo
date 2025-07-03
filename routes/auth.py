from flask import Blueprint, render_template, request, redirect, session, flash, url_for
from connection import get_db_connection
import bcrypt


auth_bp = Blueprint('auth', __name__, template_folder='templates')


@auth_bp.route('/', methods=["GET", "POST"])
def login_page():
    if request.method == 'POST':
        conn = get_db_connection()
        cur = conn.cursor()
        username = request.form['user']
        password = request.form['password']
        password = password.encode('utf-8')
        cur.execute("SELECT usuario, senha_hash FROM salao.usuarios WHERE usuario = %s", (username,))
        result = cur.fetchone()
        cur.close()
        conn.close()
        if result:
            user_id, hashed_password = result
            if type(hashed_password) != bytes:
                hashed_password = hashed_password.encode('utf-8')
            if bcrypt.checkpw(password, hashed_password):
                session['user'] = user_id
                session['token'] = '000'
                return redirect(url_for('user.home_page'))
            else:
                flash('Usuário ou senha inválidos. Tente novamente.')
                return redirect(url_for('auth.login_page'))
        else:
            flash('Usuário ou senha inválidos. Tente novamente.')
            return redirect(url_for('auth.login_page'))
        
    return render_template('login.html')

@auth_bp.route('/logout')
def logout():
    session.clear()  
    flash("Você saiu com sucesso.")
    return redirect(url_for('auth.login_page'))

@auth_bp.route('/register')
def register_page():
   return render_template('register.html')

@auth_bp.route('/reset_password')
def reset_password_page():
    return render_template('reset_password.html')

