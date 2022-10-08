require 'rails_helper'

describe 'Usuáro altera status da modalidade de entrega' do
  it 'a partir da tela inicial' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    SedexDez.delete_all
    sedex_dez = SedexDez.create!(flat_fee:90)
  
    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex 10' 
    click_link('Editar', href: edit_sedex_dez_path(sedex_dez.id))
    select 'inativo', from: 'Status'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
    expect(page).to have_content('Status: Inativo')
    expect(current_path).to eq sedex_dezs_path
  end
  it 'e volta para a tela de modalidade de entrega SedexDez' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    SedexDez.delete_all
    sedex_dez = SedexDez.create(flat_fee:80)

    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex 10' 
    click_link('Editar', href: edit_sedex_dez_path(sedex_dez.id))
    click_on 'Voltar'
         
    # Assert
    expect(page).to have_link('Cadastrar intervalo', count:3)
    expect(page).to have_content('Status: Ativo')
    expect(page).not_to have_link('Cadastrar taxa fixa')
    expect(page).to have_content('Taxa fixa: R$ 80,00')
  end
  it 'e mantém valores válidos' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    SedexDez.delete_all
    sedex_dez = SedexDez.create(flat_fee:80)

    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex 10' 
    click_link('Editar', href: edit_sedex_dez_path(sedex_dez.id))
    fill_in 'Taxa fixa', with: ''
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_link('Cadastrar taxa fixa')
    expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
    expect(current_path).to eq sedex_dezs_path
  end
end