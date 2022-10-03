require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it ',vê o nome da app e opções' do
    # Arrange
    user = User.create!(name:'Luciana', email: 'luciana@sistemadefrete.com.br', password: 'password')
    # Act
    login_as(user)
    visit root_path
    
    # Assert
    expect(page).to have_content('Sistema de frete')
    expect(page).to have_content('Olá Luciana')
    expect(page).to have_link('Modalidades de transporte', href: shipping_methods_path)
    expect(page).to have_link('Ordens de serviço', href: orders_path)
    expect(page).to have_link('Veículos', href: vehicles_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
  end

  it 'e não está autenticado' do
    # Arrange
    user = User.create!(name: 'João', email: 'joãodasilva@sistemadefrete.com.br', password: 'password')

    # Act
    visit root_path
    
    # Assert
    expect(page).to have_field ('E-mail')
    expect(page).to have_field ('Senha')
    expect(page).to have_button ('Entrar')
    expect(page).to have_content ('Criar uma conta')
    expect(page).to have_content ('Para continuar, faça login ou registre-se.')
    expect(page).not_to have_content ('Olá João')
    expect(page).not_to have_link('Modalidades de transporte', href: shipping_methods_path)
    expect(page).not_to have_link 'Sair'  
  end
end