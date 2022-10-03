require 'rails_helper'

feature 'Usuário faz login' do
  scenario 'a partir da tela inicial' do
    # Arrange 

    # Act 
    visit root_path

    # Assert
    expect(page).to have_field ('E-mail')
    expect(page).to have_field ('Senha')
    expect(page).to have_button ('Entrar')
    expect(page).to have_content ('Criar uma conta')
  end

  scenario 'com sucesso' do
    # Arrange
    User.create!(name: 'Maria da Silva', email: 'mariadasilva@sistemadefrete.com.br', password: '12345678')
    # Act
    visit root_path
    fill_in 'E-mail', with: 'mariadasilva@sistemadefrete.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    # Assert
    expect(page).to have_content 'Olá Maria da Silva'
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_button 'Entrar'
    expect(page).not_to have_content 'Criar uma conta'
  end

  scenario 'e faz logout' do
    User.create!(name: 'João Santos', email: 'joãosantos@sistemadefrete.com.br', password: '12345678')

    visit root_path
    fill_in 'E-mail', with: 'joãosantos@sistemadefrete.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content 'Olá João Santos'
    expect(page).not_to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Sair'
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

end