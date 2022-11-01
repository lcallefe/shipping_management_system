require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço' do
  it 'com sucesso' do
        
    work_order = WorkOrder.create!(street: 'Av Marechal Floriano', city: 'Florianópolis', state:'SC', number:'20', customer_name:'Mario Filho', 
                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Geladeira', 
                  product_weight:10, sku:'123', departure_date:Date.today, warehouse_state:'SC', 
                  warehouse_street:'Rua Lomba do Sabão', warehouse_city:'Florianópolis',  
                  warehouse_number:'234', distance:5)
    sd = ShippingMethod.create!(name:'Sedex Dez', flat_fee: 50, work_order_id: work_order.id, min_price: 1, max_price:71, min_distance:5, max_distance:20,
                                min_weight:1, max_weight:500, min_delivery_time:1, max_delivery_time:240)
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    DeliveryTimeDistance.create!(min_distance:5, max_distance:15, delivery_time:72, shipping_method_id:sd.id) 
    PriceWeight.create!(min_weight:5, max_weight:15, price:1, shipping_method_id:sd.id) 
    PriceDistance.create!(min_distance:5, max_distance:15, price:70, shipping_method_id:sd.id) 
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                    status:1, shipping_method_id:sd.id)
    
    login_as(user) 
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Inicializar ordem de serviço'
    choose 'Sedex Dez'
    click_on 'Salvar'
    
    expect(page).to have_content 'Ordem de serviço iniciada com sucesso.'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_content "#{work_order.code}"
    expect(current_path).to eq pending_work_orders_path
  end

  it 'e não há modalidades de entrega disponíveis' do

    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    work_order = WorkOrder.create!(street: 'Av Marechal Floriano', city: 'Florianópolis', state:'SC', number:'20', customer_name:'Mario Filho', 
                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Geladeira', 
                  product_weight:100, sku:'123', departure_date:Date.today, warehouse_state:'SC', 
                  warehouse_street:'Rua Lomba do Sabão', warehouse_city:'Florianópolis',  
                  warehouse_number:'234', distance:67)
    ShippingMethod.create!(flat_fee:10, name:'Rapida', min_distance:5, max_distance:22, min_weight:5, max_weight:28, work_order_id:work_order.id, 
                           min_price:5, max_price:50, min_delivery_time:10, max_delivery_time:30)
    ShippingMethod.create!(flat_fee:10, name:'Ultra Rapida', min_distance:5, max_distance:20, min_weight:5, max_weight:30, work_order_id:work_order.id, 
                           min_price:5, max_price:50, min_delivery_time:10, max_delivery_time:30)
    ShippingMethod.create!(flat_fee:15, name:'Mega Rapida', min_distance:5, max_distance:20, min_weight:5, max_weight:30, work_order_id:work_order.id, 
                           min_price:5, max_price:50, min_delivery_time:10, max_delivery_time:30)

    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Inicializar ordem de serviço'
 
    expect(page).to have_content 'Não há modalidades de entrega disponíveis.'
    expect(page).not_to have_content 'Preço'
    expect(page).not_to have_content 'Prazo'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq edit_work_order_path(work_order.id)
  end

  it 'e volta para a tela de ordens de serviço' do
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    work_order = WorkOrder.create!(street: 'Av Marechal Floriano', city: 'Florianópolis', state:'SC', number:'20', customer_name:'Mario Filho', 
                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Geladeira', 
                  product_weight:100, sku:'123', departure_date:Date.today, warehouse_state:'SC', 
                  warehouse_street:'Rua Lomba do Sabão', warehouse_city:'Florianópolis',  
                  warehouse_number:'234', distance:67)
    ShippingMethod.create!(flat_fee:10, name:'Rapida', min_distance:5, max_distance:22, min_weight:5, max_weight:28, 
                           work_order_id:work_order.id, min_price:5, max_price:50, min_delivery_time:5, max_delivery_time:120)
    ShippingMethod.create!(flat_fee:10, name:'Ultra Rapida', min_distance:5, max_distance:20, min_weight:5, max_weight:30, 
                           work_order_id:work_order.id, min_price:5, max_price:50, min_delivery_time:5, max_delivery_time:120)
    ShippingMethod.create!(flat_fee:15, name:'Mega Rapida', min_distance:5, max_distance:20, min_weight:5, max_weight:30,
                           work_order_id:work_order.id, min_price:5, max_price:50, min_delivery_time:5, max_delivery_time:120)

    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Inicializar ordem de serviço'
    click_on 'Voltar'
 
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content 'Em Progresso'
    expect(page).to have_content "#{work_order.code}"
    expect(page).to have_link('Inicializar ordem de serviço')
  end
end