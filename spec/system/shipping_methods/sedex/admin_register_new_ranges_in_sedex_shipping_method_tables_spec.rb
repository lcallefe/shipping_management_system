require 'rails_helper'

describe 'Usuáro cadastra nova configuração para modalidade de transporte Sedex' do
  it 'de distância x preço' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    Sedex.create!(flat_fee:45)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar intervalo', href: new_second_price_distance_path)
    fill_in 'Distância mínima', with: '10'
    fill_in 'Distância máxima', with: '40'
    fill_in 'Preço', with: '40'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo cadastrado com sucesso.')
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('10km')
    expect(page).to have_content('40km')
    expect(page).to have_content('R$ 40,00')
    expect(page).to have_content('Configuração de preços por distância')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Preço')
    expect(page).to have_link('Cadastrar intervalo', count:3)
  end
  it 'de distância x prazo' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    Sedex.create!(flat_fee:45)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar intervalo', href: new_second_delivery_time_distance_path)
    fill_in 'Distância mínima', with: '10'
    fill_in 'Distância máxima', with: '40'
    fill_in 'Prazo', with: '100'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo cadastrado com sucesso.')
    expect(page).to have_content('Olá Carla')
    expect(page).to have_content('10km')
    expect(page).to have_content('40km')
    expect(page).to have_content('100h')
    expect(page).to have_content('Configuração de prazo por distância')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Prazo')
    expect(page).to have_link('Cadastrar intervalo', count:3)
  end
  it 'de peso x preço' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    Sedex.create!(flat_fee:80)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar intervalo', href: new_second_price_weight_path)
    fill_in 'Peso mínimo', with: '10'
    fill_in 'Peso máximo', with: '40'
    fill_in 'Preço', with: '40'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo cadastrado com sucesso.')
    expect(page).to have_content('Olá Carla')
    expect(page).to have_content('10kg')
    expect(page).to have_content('40kg')
    expect(page).to have_content('R$ 40,00')
    expect(page).to have_content('Peso | Valor por km')
    expect(page).to have_content('Peso mínimo')
    expect(page).to have_content('Peso máximo')
    expect(page).to have_content('Valor por km')
    expect(page).to have_link('Cadastrar intervalo', count:3)
  end
  it 'e mantém campos obrigatórios para distância x prazo' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    Sedex.create!(flat_fee:30)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar intervalo', href: new_second_price_distance_path)
    fill_in 'Distância mínima', with: '10'
    fill_in 'Distância máxima', with: ''
    fill_in 'Preço', with: '30'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Não foi possível cadastrar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_content('Distância máxima não pode ficar em branco')
    expect(page).to have_content('Distância máxima não é um número')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Preço')
    expect(page).to have_link('Voltar', href: sedexes_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Cadastrar intervalo')
    expect(current_path).to eq second_price_distances_path
  end
  it 'e mantém campos obrigatórios para distância x prazo' do
        # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    Sedex.create!(flat_fee:40)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar intervalo', href: new_second_delivery_time_distance_path)
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: '20'
    fill_in 'Prazo', with: '200'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Não foi possível cadastrar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_content('Distância mínima não pode ficar em branco')
    expect(page).to have_content('Distância mínima não é um número')
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_link('Voltar', href: sedexes_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Editar intervalo')
    expect(current_path).to eq second_delivery_time_distances_path
  end
  it 'e cadastra dados inválidos para peso | valor por km' do
        # Arrange 
    user = User.create!(email:'susanasousa@sistemadefrete.com.br', name:'Susana', password:'C3n0ur4$', admin:true)
    Sedex.create!(flat_fee:35)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar intervalo', href: new_second_price_weight_path)
    fill_in 'Peso mínimo', with: 0
    fill_in 'Peso máximo', with: -1
    fill_in 'Preço', with: '10'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Peso mínimo deve ser maior que 0')
    expect(page).to have_content('Peso máximo deve ser maior que 0')
    expect(page).to have_content('Não foi possível cadastrar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_link('Voltar', href: sedexes_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_content('Peso | Valor por km')
    expect(current_path).to eq second_price_weights_path
  end
end