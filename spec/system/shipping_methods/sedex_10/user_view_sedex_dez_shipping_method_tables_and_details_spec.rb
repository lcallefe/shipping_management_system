require 'rails_helper'

describe 'Usuáro vê modalidade de transporte Sedex Dez' do
  it 'a partir da tela principal' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710')
    sd = SedexDez.create!(flat_fee:20)
    SedexDezDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_dez_id:sd.id)
    SedexDezPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_dez_id:sd.id)
    SedexDezPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_dez_id:sd.id)
                    
    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex 10'
         
    # Assert
    expect(page).to have_content('Modalidade de transporte Sedex Dez')
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
    expect(current_path).to eq(sedex_dezs_path)
  end
  it 'e volta para a tela inicial' do
    # Arrange 
    user = User.create!(email:'marianadasilva_user@sistemadefrete.com.br', name:'Mariana', password:'123G01@b@')
    sd = SedexDez.create!(flat_fee:20)
    SedexDezDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_dez_id:sd.id)
    SedexDezPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_dez_id:sd.id)
    SedexDezPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_dez_id:sd.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex 10'
    click_on 'Voltar'

    # Assert
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('Sedex 10')
    expect(page).to have_content('Sedex')
    expect(page).to have_content('Sedex 10')
    expect(page).to have_content('Ordens de serviço')
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Voltar')
    expect(current_path).to eq(root_path)
  end
  it 'e não tem acesso ao registro de configurações' do
    # Arrange 
    user = User.create!(email:'giovanadesouza@sistemadefrete.com.br', name:'Giovana', password:'123l@s@nh@')
    sd = SedexDez.create!(flat_fee:20)
    SedexDezDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_dez_id:sd.id)
    SedexDezPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_dez_id:sd.id)
    SedexDezPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_dez_id:sd.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex 10'
 
    # Assert
    expect(page).to have_link('Voltar', href: root_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_content('Olá Giovana')
    expect(page).not_to have_content('Cadastrar intervalo')
  end
  it 'e não está autorizado a realizar alterações no cadastro' do
    # Arrange 
    user = User.create!(email:'giovanadesouza@sistemadefrete.com.br', name:'Giovana', password:'lovewilltearusapart')
    sd = SedexDez.create!(flat_fee:20)
    SedexDezDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_dez_id:sd.id)
    SedexDezPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_dez_id:sd.id)
    SedexDezPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_dez_id:sd.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex 10'
 
    # Assert
    expect(page).not_to have_content('Editar intervalo')
  end
end