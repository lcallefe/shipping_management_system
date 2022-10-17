require 'rails_helper'

describe 'Usuáro altera detalhes da modalidade de entrega' do
  it 'a partir da tela inicial' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    Expressa.delete_all
    expressa = Expressa.create!(flat_fee:90)
  
    # Act
    login_as(user)
    visit root_path 
    click_on 'Expressa' 
    click_link('Editar', href: edit_expressa_path(expressa.id))
    select 'Desabilitado', from: 'Status'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
    expect(page).to have_content('Status: Desabilitado')
    expect(current_path).to eq expressas_path
  end
  it 'e volta para a tela de modalidade de entrega Expressa' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    Expressa.delete_all
    expressa = Expressa.create(flat_fee:80)

    # Act
    login_as(user)
    visit root_path 
    click_on 'Expressa' 
    click_link('Editar', href: edit_expressa_path(expressa.id))
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
    Expressa.delete_all
    expressa = Expressa.create(flat_fee:80)

    # Act
    login_as(user)
    visit root_path 
    click_on 'Expressa' 
    click_link('Editar', href: edit_expressa_path(expressa.id))
    fill_in 'Taxa fixa', with: ''
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_link('Cadastrar taxa fixa')
    expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
    expect(current_path).to eq expressas_path
  end
end