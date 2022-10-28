# require 'rails_helper'

# describe 'Usuáro altera detalhes da modalidade de entrega' do
#   it 'a partir da tela inicial' do
#     user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710', admin:true)
#     sm = ShippingMethod.create!(flat_fee:90, name: "Entrega rápida")
  
#     login_as(user)
#     visit root_path 
#     click_on '' 
#     click_link('Editar', href: edit_shipping_method_path(sm.id))
#     select 'Desabilitado', from: 'Status'
#     click_on 'Salvar'
         
#     expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
#     expect(page).to have_content('Status: Desabilitado')
#     expect(current_path).to eq shipping_methods_path
#   end
#   it 'e volta para a tela de modalidade de entregas' do
#     user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
#     sm = ShippingMethod.create(flat_fee:80)

#     login_as(user)
#     visit root_path 
#     click_on '' 
#     click_link('Editar', href: edit_shipping_method_path(shipping_method.id))
#     click_on 'Voltar'
         
#     expect(page).to have_link('Cadastrar intervalo', count:3)
#     expect(page).to have_content('Status: Ativo')
#     expect(page).not_to have_link('Cadastrar taxa fixa')
#     expect(page).to have_content('Taxa fixa: R$ 80,00')
#   end
#   it 'e mantém valores válidos' do
#     # Arrange 
#     user = User.create!(email:'carlasouza@sistemadefrete.com.br', name:'Carla', password:'abobrinha123', admin:true)
#     .delete_all
#     shipping_method = .create(flat_fee:80)

#     # Act
#     login_as(user)
#     visit root_path 
#     click_on '' 
#     click_link('Editar', href: edit_shipping_method_path(shipping_method.id))
#     fill_in 'Taxa fixa', with: ''
#     click_on 'Salvar'
         
#     # Assert
#     expect(page).to have_link('Cadastrar taxa fixa')
#     expect(page).to have_content('Modalidade de entrega alterada com sucesso.')
#     expect(current_path).to eq shipping_methods_path
#   end
# end