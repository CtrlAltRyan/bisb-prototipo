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

@auth_bp.route('/register', methods=["GET", "POST"])
def register_page():
   if request.method == 'POST':
       conn = get_db_connection()
       cur = conn.cursor()
       #name = request.form['name']
       user = request.form['user']
       password = request.form['password']
       password = password.encode('utf-8')
       cur.execute("SELECT usuario, senha_hash FROM salao.usuarios WHERE usuario = %s", (user,))
       result = cur.fetchone()
       cur.close()
       conn.close()
       if result:
           flash("Usuário existente.")
       else:
           password = bcrypt.hashpw(password, bcrypt.gensalt())
           password = str(password)
           password = password.replace("b'", "")
           password = password.replace("'", "")
           conn = get_db_connection()
           cur = conn.cursor()
           cur.execute("INSERT INTO salao.usuarios (usuario, senha_hash, is_adm) VALUES (%s, %s, false);", (user, password))
           conn.commit()
           cur.close()
           conn.close()
           return redirect(url_for('auth.login_page'))
   return render_template('register.html')

@auth_bp.route('/reset_password', methods=["GET", "POST"])
def reset_password_page():
    if request.method == 'POST':
        conn = get_db_connection()
        cur = conn.cursor()
        user = request.form['user']
        password = request.form['password']
        password = password.encode('utf-8')
        cur.execute("SELECT usuario FROM salao.usuarios WHERE usuario = %s", (user,))
        result = cur.fetchone()
        cur.close()
        conn.close()
        if result:
            password = bcrypt.hashpw(password, bcrypt.gensalt())
            password = str(password)
            password = password.replace("b'", "")
            password = password.replace("'", "")
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute("UPDATE salao.usuarios SET senha_hash = %s WHERE usuario = %s", (password, user))
            cur.close()
            conn.commit()
            conn.close()
            return redirect(url_for('auth.login_page'))
        else:
            flash("Usuário inexistente.")
    return render_template('reset_password.html')

