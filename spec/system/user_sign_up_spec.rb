require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'José'
    fill_in 'E-mail', with: 'josé@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    click_on 'Criar sua conta'
  
    # Assert
    expect(page).to have_content('Cadastro realizado com sucesso')
    expect(page).to have_content('Olá José')
    expect(page).not_to have_content('Domínio inválido, por favor verifique seu e-mail de registro')


  end

  it 'com domínio inválido' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome:', with: 'Maria'
    fill_in 'E-mail', with: 'maria@maria.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Criar sua conta'
    # Assert
    expect(page).to have_content('Domínio inválido, por favor verifique seu e-mail de registro')
    expect(page).not_to have_content 'Login efetuado com sucesso'
    expect(page).not_to have_link 'Sair'
  end

end