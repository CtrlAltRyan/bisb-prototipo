from flask import Blueprint, render_template, session, redirect
from flask_login import login_required

user_bp = Blueprint('user', __name__, template_folder='templates')

@user_bp.route('/')
def root():
    return render_template('usuario.html')

@user_bp.route('/settings')
def settings():
    return render_template('settings.html')

@user_bp.route('/dashboard')
def dashboard():
    return render_template('dashboard.html') 

@user_bp.before_request
def check_authentication():
    if 'token' not in session:
        return redirect('/auth')
