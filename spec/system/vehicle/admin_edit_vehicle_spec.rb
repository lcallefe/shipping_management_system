require 'rails_helper'

describe 'Usuáro altera status da modalidade de entrega' do
  it 'a partir da tela inicial' do
    # Arrange 
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                    sedex_id: sm.id, status:1)
  
    # Act
    login_as(user)
    visit root_path 
    click_on 'Busca por veículo'
    fill_in 'Buscar veículo', with: 'EFJ'
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Alterar status'
    select 'em_manutenção', from: 'Status'
    click_on 'Salvar'

         
    # Assert
    expect(page).to have_content('Ford - Fiesta')
    expect(page).to have_content('Status:')
    expect(page).to have_content('em_manutenção')
    expect(current_path).to eq vehicles_path
  end
  it 'e volta para a tela de detalhes do veículo' do
    # Arrange 
    user = User.create!(name: 'João', email: 'joão@sistemadefrete.com.br', password: '12345678', admin:true)  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    Vehicle.delete_all
    vehicle = Vehicle.create!(brand_name:'Renault', model:'Sedan', fabrication_year:'2001', full_capacity:100, license_plate:'EFJ-1234', 
                              sedex_id: sm.id, status:1)

    # Act
    login_as(user)
    visit root_path 
    click_on 'Busca por veículo' 
    fill_in 'Buscar veículo', with: 'EFJ'
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Alterar status'
    click_on 'Voltar'
         
    # Assert
    expect(page).to have_content('Renault - Sedan')
    expect(page).to have_content('Status:')
    expect(page).to have_content('ativo')
    expect(page).not_to have_button('Salvar')
    expect(current_path).to eq vehicle_path(vehicle.id)
  end
  
end