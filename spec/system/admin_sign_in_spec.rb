require 'rails_helper'

feature 'Administrador faz login' do
  scenario 'a partir da tela inicial' do
    # Arrange 

    # Act 
    visit root_path

    # Assert
    expect(page).to have_link ('Entrar')
  end

  scenario 'com sucesso' do
    # Arrange
    User.create!(name: 'Maria da Silva', email: 'mariadasilva@gmail.com', password: '12345678', admin:true)
    # Act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'mariadasilva@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    # Assert
    expect(page).to have_content 'Maria da Silva'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'e faz logout' do
    User.create!(name: 'João Santos', email: 'joãosantos@gmail.com', password: '12345678', admin:true)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joãosantos@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content 'João Santos'
    expect(page).not_to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Sair'
    expect(page).to have_link 'Entrar'
    expect(page).to have_content 'Logout efetuado com sucesso'
  end

end