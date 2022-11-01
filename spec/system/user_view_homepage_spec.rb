require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it ',vê o nome da app e opções' do
    user = User.create!(name:'Luciana', email: 'luciana@sistemadefrete.com.br', password: 'password')

    visit new_user_session_path
    login_as(user)
    visit root_path

    expect(page).to have_text('Sistema de frete')
    expect(page).to have_text('Selecione a opção desejada:')
    expect(page).to have_text('Modalidades de transporte')
    expect(page).to have_text('Ordens de serviço')
    expect(page).to have_text('Veículos')
    expect(page).to have_text('Olá Luciana')
    expect(page).to have_link('Ordens de serviço', href: work_orders_path)
    expect(page).to have_link('Busca por veículo', href: search_vehicles_path)
    expect(page).to have_link('Ver veículos', href: vehicles_path)
    expect(page).to have_link('Modalidades de transporte', href: shipping_methods_path)
    expect(page).to have_link('Sair')
  end

  it 'e não está autenticado' do
    user = User.create!(name: 'João', email: 'joãodasilva@sistemadefrete.com.br', password: 'password')

    visit root_path
    
    expect(page).to have_link ('Consultar entrega')
    expect(page).not_to have_link 'Sair'  
  end
end