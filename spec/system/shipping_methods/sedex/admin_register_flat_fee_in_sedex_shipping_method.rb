require 'rails_helper'

describe 'Usuáro cadastra taxa fixa' do
  it 'a partir da tela inicial' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    Sedex.delete_all
    sedex = Sedex.create!

    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar taxa fixa', href: edit_sedex_path(sedex.id))
    fill_in 'Taxa fixa', with: '150'
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
    expect(page).to have_content('Taxa fixa: R$ 150,00')
    expect(page).not_to have_link('Cadastrar taxa fixa')
    expect(current_path).to eq sedexes_path
  end
  it 'mas já foi feito o cadastro' do
    # Arrange 
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
    Sedex.delete_all
    sedex = Sedex.create!(flat_fee:40)

    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
         
    # Assert
    expect(page).to have_link('Cadastrar intervalo', count:3)
    expect(page).to have_content('Taxa fixa: R$ 40,00')
    expect(page).to have_link('Editar', href: edit_sedex_path(sedex.id))
    expect(page).not_to have_link('Cadastrar taxa fixa')
  end
  it 'e mantém valores válidos' do
    # Arrange 
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
    Sedex.delete_all 
    sedex = Sedex.create!

    # Act
    login_as(user)
    visit root_path 
    click_on 'Sedex' 
    click_link('Cadastrar taxa fixa', href: edit_sedex_path(sedex.id))
    fill_in 'Taxa fixa', with: 0
    click_on 'Salvar'
         
    # Assert
    expect(page).to have_content('Taxa fixa deve ser maior que 0')
    expect(page).to have_content('Não foi possível alterar modalidade de entrega')
    expect(current_path).to eq sedex_dez_path(sedex.id)
  end
end