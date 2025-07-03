from flask import Blueprint, render_template, session, redirect, url_for, flash
from flask_login import login_required
from .info import get_topservice, get_amount, get_customersnum

user_bp = Blueprint('user', __name__, template_folder='templates')

@user_bp.route('/customers')
def customers_page():
    return render_template('customers.html')

@user_bp.route('/home')
def home_page():
    servico_mais_vendido = get_topservice()
    montante = get_amount()
    clientesnum = get_customersnum()
    return (render_template('home.html', servico_mais_vendido=servico_mais_vendido, montante=montante, 
                            clientesnum=clientesnum))

@user_bp.route('/services')
def services_page():
    return render_template('services.html')

@user_bp.route('/sales')
def sales_page():
    return render_template('sales.html')

@user_bp.before_request
def check_authentication():
    flash('Você precisa estar logado')
    if 'token' not in session:
        return redirect(url_for('auth.login_page'))
