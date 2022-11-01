require 'rails_helper'

describe 'Usuáro cadastra nova configuração para modalidade de transporte' do
  it 'de distância x preço' do
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Entrega Rápida', min_distance:5, max_distance:20, min_weight:5, max_weight:50,
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
           
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Ver detalhes' 
    click_link('Cadastrar intervalo', href: new_shipping_method_price_distance_path(sm.id))
    fill_in 'Distância mínima', with: '10'
    fill_in 'Distância máxima', with: '20'
    fill_in 'Preço', with: '50'
    click_on 'Salvar'
         
    expect(page).to have_content('Intervalo cadastrado com sucesso.')
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('10km')
    expect(page).to have_content('20km')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('Configuração de preços por distância')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Preço')
    expect(page).to have_link('Cadastrar intervalo', count:3)
  end

  it 'de distância x prazo' do
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Entrega Rápida', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
                      
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Ver detalhes' 
    click_link('Cadastrar intervalo', href:new_shipping_method_delivery_time_distance_path(sm.id))
    fill_in 'Distância mínima', with: '10'
    fill_in 'Distância máxima', with: '20'
    fill_in 'Prazo', with: '48'
    click_on 'Salvar'
         
    expect(page).to have_content('Intervalo cadastrado com sucesso.')
    expect(page).to have_content('Olá Carla')
    expect(page).to have_content('10km')
    expect(page).to have_content('20km')
    expect(page).to have_content('48h')
    expect(page).to have_content('Configuração de prazo por distância')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Prazo')
    expect(page).to have_link('Cadastrar intervalo', count:3)
  end

  it 'de peso x preço' do
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Ver detalhes' 
    click_link('Cadastrar intervalo', href:new_shipping_method_price_weight_path(sm.id))
    fill_in 'Peso mínimo', with: '10'
    fill_in 'Peso máximo', with: '30'
    fill_in 'Preço', with: '40'
    click_on 'Salvar'
         
    expect(page).to have_content('Intervalo cadastrado com sucesso.')
    expect(page).to have_content('Olá Carla')
    expect(page).to have_content('10kg')
    expect(page).to have_content('30kg')
    expect(page).to have_content('R$ 40,00')
    expect(page).to have_content('Peso | Valor por km')
    expect(page).to have_content('Peso mínimo')
    expect(page).to have_content('Peso máximo')
    expect(page).to have_content('Valor por km')
    expect(page).to have_link('Cadastrar intervalo', count:3)
  end

  it 'e mantém campos obrigatórios para distância x prazo' do
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Delivery', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
                    
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Ver detalhes' 
    click_link('Cadastrar intervalo', href: new_shipping_method_delivery_time_distance_path(sm.id))
    fill_in 'Distância mínima', with: '10'
    fill_in 'Distância máxima', with: ''
    fill_in 'Prazo', with: '100'
    click_on 'Salvar'
         
    expect(page).to have_content('Não foi possível cadastrar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_content('Distância máxima não pode ficar em branco')
    expect(page).to have_content('Distância máxima não é um número')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Prazo')
    expect(page).to have_link('Voltar', href: shipping_methods_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Cadastrar intervalo')
  end

  it 'e mantém campos obrigatórios para distância x preço' do
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Ultra Plus', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)               
    
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Ver detalhes' 
    click_link('Cadastrar intervalo', href: new_shipping_method_price_distance_path(sm.id))
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: '20'
    fill_in 'Preço', with: '24'
    click_on 'Salvar'
         
    expect(page).to have_content('Não foi possível cadastrar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_content('Distância mínima não pode ficar em branco')
    expect(page).to have_content('Distância mínima não é um número')
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_link('Voltar', href: shipping_methods_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Editar intervalo')
  end

  it 'e cadastra dados inválidos para peso | valor por km' do
    user = User.create!(email:'susanasousa@sistemadefrete.com.br', name:'Susana', password:'C3n0ur4$', admin:true)
    sm = ShippingMethod.create!(flat_fee:45, name:'Ultra Plus', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
                  
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Ver detalhes' 
    click_link('Cadastrar intervalo', href: new_shipping_method_price_weight_path(sm.id))
    fill_in 'Peso mínimo', with: 0
    fill_in 'Peso máximo', with: -1
    fill_in 'Preço', with: '10'
    click_on 'Salvar'
    
    expect(page).to have_content('Peso mínimo deve ser maior que 0')
    expect(page).to have_content('Peso máximo deve ser maior que 0')
    expect(page).to have_content('Peso mínimo abaixo do valor mínimo estipulado da modalidade de entrega')
    expect(page).to have_content('Não foi possível cadastrar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_link('Voltar', href: shipping_methods_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_content('Peso | Valor por km')
  end
end