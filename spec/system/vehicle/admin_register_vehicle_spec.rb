require 'rails_helper'

describe 'Administrador cadastra um veículo' do
  it 'com sucesso' do

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)

    login_as(user)
    visit root_path
    click_on 'Ver veículos'
    click_on 'Cadastrar novo veículo'
    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Marca', with: 'Volvo'
    fill_in 'Modelo', with: '3345'
    fill_in 'Ano de fabricação', with: '2019'
    choose "#{sm.id}"
    fill_in 'Capacidade máxima de carga', with: 700
    click_on 'Salvar'

    expect(page).to have_content 'Veículo cadastrado com sucesso.'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq vehicles_path
  end

  it 'com dados inválidos' do

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)

    sm = ShippingMethod.create!(flat_fee:45, name:'Expressa', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)

    login_as(user)
    visit root_path
    click_on 'Ver veículos'
    click_on 'Cadastrar novo veículo'
    fill_in 'Placa', with: 'AB-123'
    fill_in 'Marca', with: 'A'
    fill_in 'Modelo', with: 'AB'
    fill_in 'Ano de fabricação', with: '1'
    choose "#{sm.id}"
    fill_in 'Capacidade máxima de carga', with: 0
    click_on 'Salvar'
 
    expect(page).to have_content 'Não foi possível cadastrar veículo.'
    expect(page).to have_content 'Placa não possui o formato esperado'
    expect(page).to have_content 'Marca é muito curto (mínimo: 4 caracteres)'
    expect(page).to have_content 'Modelo é muito curto (mínimo: 4 caracteres)'
    expect(page).to have_content 'Capacidade máxima de carga deve ser maior que 0'
    expect(page).to have_link('Voltar', href: vehicles_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
  end

  it 'e mantém campos obrigatórios' do

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Sedex', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
                              
    login_as(user)
    visit root_path
    click_on 'Ver veículos'
    click_on 'Cadastrar novo veículo'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: 'Mercedes'
    fill_in 'Modelo', with: ''
    fill_in 'Ano de fabricação', with: '2021'
    choose "#{sm.id}"
    fill_in 'Capacidade máxima de carga', with: 400
    click_on 'Salvar'
 
    expect(page).to have_content 'Não foi possível cadastrar veículo.'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Placa não pode ficar em branco'
    expect(page).to have_link('Voltar', href: vehicles_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
  end
end