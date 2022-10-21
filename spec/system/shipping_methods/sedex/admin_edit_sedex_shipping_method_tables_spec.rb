require 'rails_helper'

describe 'Usuáro altera configuração para modalidade de transporte Sedex' do
  it 'de distância x preço' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    s = Sedex.create!(flat_fee:45)
    pd = SedexPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_id:s.id)
                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Editar intervalo', href: edit_sedex_price_distance_path(pd.id))
    fill_in 'Distância mínima', with: 5
    fill_in 'Preço', with: 35
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo alterado com sucesso.')
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('5km')
    expect(page).to have_content('30km')
    expect(page).to have_content('R$ 45,00')
    expect(page).to have_content('Configuração de preços por distância')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Preço')
    expect(page).to have_link('Editar intervalo', count:1)
  end
  it 'de distância x prazo' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    s = Sedex.create!(flat_fee:45)
    dt = SedexDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_id:s.id)
                
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Editar intervalo', href: edit_sedex_delivery_time_distance_path(dt.id))
    fill_in 'Distância máxima', with: 25
    fill_in 'Prazo', with: 25
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo alterado com sucesso.')
    expect(page).to have_content('Olá Carla')
    expect(page).to have_content('10km')
    expect(page).to have_content('25km')
    expect(page).to have_content('25h')
    expect(page).to have_content('Configuração de prazo por distância')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Prazo')
    expect(page).to have_link('Editar intervalo', count:1)
  end
  it 'de peso x preço' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    s = Sedex.create!(flat_fee:80)
    pw = SedexPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_id:s.id)
                
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Editar intervalo', href: edit_sedex_price_weight_path(pw.id))
    fill_in 'Peso mínimo', with: 8
    fill_in 'Peso máximo', with: 20
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo alterado com sucesso.')
    expect(page).to have_content('8kg')
    expect(page).to have_content('20kg')
    expect(page).to have_content('R$ 25,00')
    expect(page).to have_content('Peso | Valor por km')
    expect(page).to have_content('Peso mínimo')
    expect(page).to have_content('Peso máximo')
    expect(page).to have_content('Valor por km')
    expect(current_path).to eq sedexes_path
  end
  it 'e atualiza com dados inválidos para distância x prazo' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    s = Sedex.create!(flat_fee:45)
    dt = SedexDeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, sedex_id:s.id)
    SedexDeliveryTimeDistance.create!(min_distance: 21, max_distance: 30, delivery_time: 25, sedex_id:s.id)
    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Editar intervalo', href: edit_sedex_delivery_time_distance_path(dt.id))
    fill_in 'Distância máxima', with: 22
    fill_in 'Prazo', with: 20
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Intervalo inválido.')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Prazo')
    expect(page).not_to have_link('Voltar', href: sedexes_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_link('Editar intervalo')
    expect(current_path).to eq sedexes_path
  end
  it 'e atualiza com dados inválidos para peso x valor por km' do
        # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    s = Sedex.create!(flat_fee:45)
    pw = SedexPriceWeight.create!(min_weight:5, max_weight:15, price:25, sedex_id:s.id)

                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Editar intervalo', href: edit_sedex_price_weight_path(pw.id))
    fill_in 'Peso mínimo', with: 5
    fill_in 'Peso máximo', with: 'a'
    fill_in 'Preço', with: 30
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Não foi possível alterar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_content('Peso máximo não é um número')
    expect(page).to have_content('Olá Mariana')
    expect(page).to have_link('Voltar', href: sedexes_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Editar intervalo')
    expect(current_path).not_to eq sedexes_path
  end
  it 'e atualiza com dados inválidos para distância x preço' do
        # Arrange 
    user = User.create!(email:'susanasousa@sistemadefrete.com.br', name:'Susana', password:'C3n0ur4$', admin:true)
    s = Sedex.create!(flat_fee:45)
    pd = SedexPriceDistance.create!(min_distance:10, max_distance:30, price:40, sedex_id:s.id)

                    
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Editar intervalo', href: edit_sedex_price_distance_path(pd.id))
    fill_in 'Distância mínima', with: 10
    fill_in 'Distância máxima', with: 25
    fill_in 'Preço', with: 0
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Preço deve ser maior que 0')
    expect(page).to have_content('Não foi possível alterar intervalo, por favor verifique e tente novamente.')
    expect(page).to have_link('Voltar', href: sedexes_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Editar intervalo')
    expect(current_path).not_to eq sedexes_path
  end
end