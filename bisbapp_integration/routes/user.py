from flask import Blueprint, render_template, session, redirect
from flask_login import login_required

user_bp = Blueprint('user', __name__, template_folder='templates')

@user_bp.route('/')
def root():
    return render_template('home.html')

@user_bp.route('/customers')
def customers_page():
    return render_template('customers.html')

@user_bp.route('/home')
def home_page():
    return render_template('home.html') 

@user_bp.route('/services')
def services_page():
    return render_template('services.html')

@user_bp.route('/sales')
def sales_page():
    return render_template('sales.html')

@user_bp.before_request
def check_authentication():
    if 'token' not in session:
        return redirect('/auth')
