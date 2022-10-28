require 'rails_helper'

describe 'Usuáro vê modalidade de transporte ' do
  it 'a partir da tela principal' do
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710')
    sm = ShippingMethod.create!(flat_fee:20, name: 'Shipping Method')
    DeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, shipping_method_id:sm.id)
    PriceDistance.create!(min_distance:10, max_distance:30, price:40, shipping_method_id:sm.id)
    PriceWeight.create!(min_weight:5, max_weight:15, price:25, shipping_method_id:sm.id)
                    
    login_as(user)
    visit root_path
    click_on ''
         
    expect(page).to have_content("Modalidade de transporte Shipping Method")
    expect(page).to have_content('Configuração de preços por distância')
    expect(page).to have_content('Peso | Valor por km')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Preço')
    expect(page).to have_content('Prazo')
    expect(page).to have_content('Status: Ativo')
    expect(page).to have_content('Taxa fixa: R$ 20,00')
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_link('Voltar', href: root_path)
    expect(current_path).to eq(expressas_path)
  end
  it 'e volta para a tela inicial' do
    user = User.create!(email:'marianadasilva_user@sistemadefrete.com.br', name:'Mariana', password:'123G01@b@')
    sm = ShippingMethod.create!(flat_fee:20, name: 'Shipping Method')
    DeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, shipping_method_id:sm.id)
    PriceDistance.create!(min_distance:10, max_distance:30, price:40, shipping_method_id:sm.id)
    PriceWeight.create!(min_weight:5, max_weight:15, price:25, shipping_method_id:sm.id)

    login_as(user)
    visit root_path
    click_on ''
    click_on 'Voltar'

    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('Shipping Method')
    expect(page).to have_content('Ordens de serviço')
    expect(page).to have_content('Veículos')
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Voltar')
    expect(current_path).to eq(root_path)
  end
  it 'e não tem acesso ao registro de configurações' do
    user = User.create!(email:'giovanadesouza@sistemadefrete.com.br', name:'Giovana', password:'123l@s@nh@')
    sm = ShippingMethod.create!(flat_fee:20, name:'XPTO')
    DeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, shipping_method_id:sm.id)
    PriceDistance.create!(min_distance:10, max_distance:30, price:40, shipping_method_id:sm.id)
    PriceWeight.create!(min_weight:5, max_weight:15, price:25, shipping_method_id:sm.id)

    login_as(user)
    visit root_path
    click_on ''
 
    expect(page).to have_link('Voltar', href: root_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_content('Olá Giovana')
    expect(page).not_to have_content('Cadastrar intervalo')
  end
  it 'e não está autorizado a realizar alterações no cadastro' do
    user = User.create!(email:'giovanadesouza@sistemadefrete.com.br', name:'Giovana', password:'lovewilltearusapart')
    sm = ShippingMethod.create!(flat_fee:20, name: "Correios")
    DeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, shipping_method_id:sm.id)
    PriceDistance.create!(min_distance:10, max_distance:30, price:40, shipping_method_id:sm.id)
    PriceWeight.create!(min_weight:5, max_weight:15, price:25, shipping_method_id:sm.id)

    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Correios'
 
    expect(page).not_to have_content('Editar intervalo')
  end
end