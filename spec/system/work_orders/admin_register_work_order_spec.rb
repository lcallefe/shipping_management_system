require 'rails_helper'

describe 'Administrador cria uma ordem de serviço' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Criar nova ordem de serviço'
    fill_in 'Endereço', with: 'Rua Dr Nogueira Martins'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Número', with: '680'
    fill_in 'Nome do cliente', with: 'Francisca'
    fill_in 'CPF', with: '88899966677'
    fill_in 'Telefone', with: '11916031367'
    fill_in 'Código do produto', with: 'GPA178652'
    fill_in 'Nome do produto', with: 'Geladeira'
    fill_in 'Peso do produto', with: '54'
    fill_in 'Endereço (remetente)', with: 'Av Paulista'
    fill_in 'Cidade (remetente)', with: 'São Paulo'
    fill_in 'Estado (remetente)', with: 'São Paulo'
    fill_in 'Número (remetente)', with: 'São Paulo'
    fill_in 'Distância remetente x destinatário', with: '12'
    click_on 'Salvar'

    # Assert
    expect(page).to have_content 'Ordem de serviço registrada com sucesso.'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq root_path
  end

  it 'com dados inválidos' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Criar nova ordem de serviço'
    fill_in 'Endereço', with: 'Rua Dr Nogueira Martins'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Número', with: '680'
    fill_in 'Nome do cliente', with: 'Francisca'
    fill_in 'CPF', with: '222'
    fill_in 'Telefone', with: '11916031367'
    fill_in 'Código do produto', with: 'GPA178652'
    fill_in 'Nome do produto', with: 'Geladeira'
    fill_in 'Peso do produto', with: -1
    fill_in 'Endereço (remetente)', with: 'Av Paulista'
    fill_in 'Cidade (remetente)', with: 'São Paulo'
    fill_in 'Estado (remetente)', with: 'São Paulo'
    fill_in 'Número (remetente)', with: 'São Paulo'
    fill_in 'Distância remetente x destinatário', with: 0
    click_on 'Salvar'
 
    # Assert
    expect(page).to have_content 'CPF não possui o tamanho esperado (11 caracteres)'
    expect(page).to have_content 'Distância remetente x destinatário deve ser maior que 0'
    expect(page).to have_content 'Peso do produto deve ser maior que 0'
    expect(page).to have_link('Voltar', href: root_path)
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq work_orders_path
  end
  it 'e mantém campos obrigatórios' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)

    # Act
    login_as(user)
    visit root_path
    click_on 'Criar nova ordem de serviço'
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Número', with: '680'
    fill_in 'Nome do cliente', with: 'Francisca'
    fill_in 'CPF', with: ''
    fill_in 'Telefone', with: '11916031367'
    fill_in 'Código do produto', with: ''
    fill_in 'Nome do produto', with: 'Geladeira'
    fill_in 'Peso do produto', with: ''
    fill_in 'Endereço (remetente)', with: 'Av Paulista'
    fill_in 'Cidade (remetente)', with: 'São Paulo'
    fill_in 'Estado (remetente)', with: 'SP'
    fill_in 'Número (remetente)', with: '1000'
    fill_in 'Distância remetente x destinatário', with: ''
    click_on 'Salvar'
 
    # Assert
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'Código do produto não pode ficar em branco'
    expect(page).to have_content 'Peso do produto não pode ficar em branco'
    expect(page).to have_content 'Distância remetente x destinatário não pode ficar em branco'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq work_orders_path
  end
end