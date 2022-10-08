require 'rails_helper'

describe 'Usuáro vê modalidade de transporte Sedex' do
  it 'a partir da tela principal' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710')
    s = Sedex.create!(flat_fee:20)
    SecondDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_id:s.id)
    SecondPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_id:s.id)
    SecondPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_id:s.id)
                    
    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex'
         
    # Assert
    expect(page).to have_content('Modalidade de transporte Sedex')
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
    expect(current_path).to eq(sedexes_path)
  end
  it 'e volta para a tela inicial' do
    # Arrange 
    user = User.create!(email:'marianadasilva_user@sistemadefrete.com.br', name:'Mariana', password:'123G01@b@')
    s = Sedex.create!(flat_fee:20)
    SecondDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_id:s.id)
    SecondPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_id:s.id)
    SecondPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_id:s.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex'
    click_on 'Voltar'

    # Assert
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('Sedex')
    expect(page).to have_content('Sedex')
    expect(page).to have_content('Sedex 10')
    expect(page).to have_content('Lista de ordens de serviço:')
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Voltar')
    expect(current_path).to eq(root_path)
  end
  it 'e não tem acesso ao registro de configurações' do
    # Arrange 
    user = User.create!(email:'giovanadesouza@sistemadefrete.com.br', name:'Giovana', password:'123l@s@nh@')
    s = Sedex.create!(flat_fee:20)
    SecondDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_id:s.id)
    SecondPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_id:s.id)
    SecondPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_id:s.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex'
 
    # Assert
    expect(page).to have_link('Voltar', href: root_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_content('Olá Giovana')
    expect(page).not_to have_content('Cadastrar intervalo')
  end
  it 'e não está autorizado a realizar alterações no cadastro' do
    # Arrange 
    user = User.create!(email:'giovanadesouza@sistemadefrete.com.br', name:'Giovana', password:'lovewilltearusapart')
    s = Sedex.create!(flat_fee:20)
    SecondDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_id:s.id)
    SecondPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_id:s.id)
    SecondPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_id:s.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Sedex'
 
    # Assert
    expect(page).not_to have_content('Editar intervalo')
  end
end