require 'rails_helper'

describe 'Usuáro cadastra modalidade de transporte' do
  it 'a partir da tela inicial' do
    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
  
    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Cadastrar modalidade de transporte' 
    fill_in 'Nome', with:'Entrega 24h'
    fill_in 'Distância mínima atendida', with: '10'
    fill_in 'Peso mínimo atendido', with: '20'
    fill_in 'Distância máxima atendida', with: '100'
    fill_in 'Peso máximo atendido', with: '40'
    fill_in 'Taxa fixa', with: '150'
    fill_in 'Preço mínimo', with: '5'
    fill_in 'Preço máximo', with: '45'
    fill_in 'Prazo mínimo', with: '10'
    fill_in 'Prazo máximo', with: '30'
    click_on 'Salvar'
         
    expect(page).to have_content('Modalidade de transporte cadastrada com sucesso')
    expect(page).to have_content('Taxa fixa: R$ 150,00')
    expect(page).to have_link('Editar')
    expect(page).to have_link('Voltar')
    expect(page).to have_link('Sair')
    expect(page).to have_link('Cadastrar intervalo', count:3)
    expect(page).to have_content("Modalidade de transporte Entrega 24h")
  end
  
  it 'e mantém campos obrigatórios' do
    user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)

    login_as(user)
    visit root_path 
    click_on 'Modalidades de transporte' 
    click_on 'Cadastrar modalidade de transporte' 
    fill_in 'Nome', with:''
    fill_in 'Distância máxima atendida', with: ''
    fill_in 'Peso máximo atendido', with: ''
    fill_in 'Distância mínima atendida', with: ''
    fill_in 'Peso mínimo atendido', with: ''
    fill_in 'Preço mínimo', with: ''
    fill_in 'Preço máximo', with: ''
    fill_in 'Taxa fixa', with: ''
    click_on 'Salvar' 

         
    expect(page).not_to have_link('Cadastrar intervalo')
    expect(page).to have_content('Taxa fixa não pode ficar em branco')
    expect(page).to have_content('Distância máxima atendida não pode ficar em branco')
    expect(page).to have_content('Peso máximo atendido não pode ficar em branco')
    expect(page).to have_content('Distância mínima atendida não pode ficar em branco')
    expect(page).to have_content('Peso mínimo atendido não pode ficar em branco')
    expect(page).to have_content('Preço máximo não pode ficar em branco')
    expect(page).to have_content('Preço mínimo não pode ficar em branco')
    expect(page).to have_content('Prazo máximo não pode ficar em branco')
    expect(page).to have_content('Prazo mínimo não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Prazo mínimo não é um número')
    expect(page).to have_content('Prazo máximo não é um número')
    expect(page).to have_content('Distância mínima atendida não é um número')
    expect(page).to have_content('Distância máxima atendida não é um número') 
    expect(page).to have_content('Preço mínimo não é um número') 
    expect(page).to have_content('Preço máximo não é um número')
    expect(page).to have_content('Prazo máximo não é um número')
    expect(page).to have_content('Prazo mínimo não é um número')
    expect(current_path).to eq shipping_methods_path
  end
end