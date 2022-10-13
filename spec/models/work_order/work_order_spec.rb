require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'falso quando rua do destinatário está vazia' do
        # Arrange
        work_order = WorkOrder.new(street: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:street)).to be true  
        expect(work_order.errors[:street]).to include("não pode ficar em branco")
      end
      it 'falso quando cidade do destinatário está vazia' do
        # Arrange
        work_order = WorkOrder.new(city: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:city)).to be true  
        expect(work_order.errors[:city]).to include("não pode ficar em branco")
      end
      it 'falso quando estado do destinatário está vazio' do
        # Arrange
        work_order = WorkOrder.new(state: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:state)).to be true  
        expect(work_order.errors[:state]).to include("não pode ficar em branco")
      end
      it 'falso quando número da residência do destinatário está vazia' do
        # Arrange
        work_order = WorkOrder.new(number: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:number)).to be true  
        expect(work_order.errors[:number]).to include("não pode ficar em branco")
      end
      it 'falso quando nome do destinatário está vazio' do 
        # Arrange
        work_order = WorkOrder.new(customer_name: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:customer_name)).to be true  
        expect(work_order.errors[:customer_name]).to include("não pode ficar em branco")
      end
      it 'falso quando CPF do destinatário está vazio' do 
        # Arrange
        work_order = WorkOrder.new(customer_cpf:nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:customer_cpf)).to be true  
        expect(work_order.errors[:customer_cpf]).to include("não pode ficar em branco")
      end
      it 'falso quando telefone do destinatário está vazio' do 
        # Arrange
        work_order = WorkOrder.new(customer_phone_numer:nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:customer_phone_numer)).to be true  
        expect(work_order.errors[:customer_phone_numer]).to include("não pode ficar em branco")
      end
      it 'falso quando nome do produto está vazio' do 
        # Arrange
        work_order = WorkOrder.new(product_name: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:product_name)).to be true  
        expect(work_order.errors[:product_name]).to include("não pode ficar em branco")
      end
      it 'falso quando peso do produto está vazio' do 
        # Arrange
        work_order = WorkOrder.new(product_weight: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:product_weight)).to be true  
        expect(work_order.errors[:product_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando sku está vazio' do 
        # Arrange
        work_order = WorkOrder.new(sku: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:sku)).to be true  
        expect(work_order.errors[:sku]).to include("não pode ficar em branco")
      end
      it 'falso quando rua do remetente está vazio' do 
        # Arrange
        work_order = WorkOrder.new(warehouse_street: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:warehouse_street)).to be true  
        expect(work_order.errors[:warehouse_street]).to include("não pode ficar em branco")
      end
      it 'falso quando cidade do remetente está vazia' do 
        # Arrange
        work_order = WorkOrder.new(warehouse_city: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:warehouse_city)).to be true  
        expect(work_order.errors[:warehouse_city]).to include("não pode ficar em branco")
      end
      it 'falso quando estado do remetente está vazio' do 
        # Arrange
        work_order = WorkOrder.new(warehouse_state: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:warehouse_state)).to be true  
        expect(work_order.errors[:warehouse_state]).to include("não pode ficar em branco") 
      end
      it 'falso quando número do remetente está vazio' do 
        # Arrange
        work_order = WorkOrder.new(warehouse_number: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:warehouse_number)).to be true  
        expect(work_order.errors[:warehouse_number]).to include("não pode ficar em branco")
      end
      it 'falso quando distância está vazia' do 
        # Arrange
        work_order = WorkOrder.new(distance: nil)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:distance)).to be true  
        expect(work_order.errors[:distance]).to include("não pode ficar em branco")
      end
    end
    context 'numericality' do
      it 'falso quando peso do produto é menor do que 0' do 
        # Arrange
        work_order = WorkOrder.new(product_weight:-1)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:product_weight)).to be true  
        expect(work_order.errors[:product_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso do produto é igual a 0' do 
        # Arrange
        work_order = WorkOrder.new(product_weight:0)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:product_weight)).to be true  
        expect(work_order.errors[:product_weight]).to include("deve ser maior que 0") 
      end
      it 'verdadeiro quando peso do produto é maior do que 0' do 
       # Arrange
       work_order = WorkOrder.new(product_weight:1)
       # Act
       work_order.valid?
       # Assert
       expect(work_order.errors.include?(:product_weight)).to be false  
      end
      it 'falso quando distância é menor do que 0' do 
         # Arrange
        work_order = WorkOrder.new(distance:-1)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:distance)).to be true  
        expect(work_order.errors[:distance]).to include("deve ser maior que 0") 
      end
      it 'falso quando distância é igual a 0' do 
        # Arrange
        work_order = WorkOrder.new(distance:0)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:distance)).to be true  
        expect(work_order.errors[:distance]).to include("deve ser maior que 0") 
      end
      it 'verdadeiro quando distância é maior do que 0' do 
        # Arrange
        work_order = WorkOrder.new(distance:1)
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:distance)).to be false  
      end
      it 'falso quando CPF possui menos de 11 caracteres' do 
        # Arrange
        work_order = WorkOrder.new(customer_cpf:'1234567890')
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:customer_cpf)).to be true  
        expect(work_order.errors[:customer_cpf]).to include("não possui o tamanho esperado (11 caracteres)") 
      end
      it 'falso quando CPF possui mais de 11 caracteres' do 
         # Arrange
         work_order = WorkOrder.new(customer_cpf:'123456789012')
         # Act
         work_order.valid?
         # Assert
         expect(work_order.errors.include?(:customer_cpf)).to be true  
         expect(work_order.errors[:customer_cpf]).to include("não possui o tamanho esperado (11 caracteres)") 
      end
      it 'verdadeiro quando CPF possui 11 caracteres' do 
        # Arrange
        work_order = WorkOrder.new(customer_cpf:'12345678901')
        # Act
        work_order.valid?
        # Assert
        expect(work_order.errors.include?(:customer_cpf)).to be false  
      end
    end
    context 'correctness' do
      it 'verdadeiro quando cálculo do preço é realizado corretamente' do 
        # Arrange
        SecondPriceDistance.delete_all 
        SecondPriceWeight.delete_all
        SecondDeliveryTimeDistance.delete_all
        Sedex.delete_all
        work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                       customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Bicicleta', 
                                       product_weight:10, sku:'123', departure_date:2.days.ago, warehouse_state:'SP', 
                                       warehouse_street:'Rua dos Vianas', warehouse_city:'São Bernardo do Campo',  
                                       warehouse_number:'234', distance:10)
        s = Sedex.create!(name:'Sedex', flat_fee: 50)
        sedex_distance_price = SecondPriceDistance.create!(min_distance:5, max_distance:40, price:30, sedex_id:s.id)
        sedex_price_weight = SecondPriceWeight.create!(min_weight:1, max_weight:30, price:1, sedex_id:s.id)
        SecondDeliveryTimeDistance.create!(min_distance:5, max_distance:40, delivery_time:30, sedex_id:s.id)
        Vehicle.create!(brand_name:'Chevrolet', model:'Chevette', fabrication_year:'1995', full_capacity:100, license_plate:'ABC-1235', 
                        sedex_id: s.id, status:1, work_order_id: work_order.id)


        # Act
        s.update(work_order_id: work_order.id)
        # Cálculo = s.flat_fee + sedex_price_weight.price * work_order.distance + sedex_distance_price
        work_order.update(shipping_method:s.name)
      
        # Assert
        expect(work_order.total_price).to eq 90 
      end
    #   it 'falso quando cálculo do preço não está correto' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'verdadeiro quando data prevista para entrega está correta' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'falso quando data prevista para entrega não está correta' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'falso quando status não corresponde à entrega em atraso' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'verdadeiro quando status corresponde à entrega em atraso' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'falso quando status não corresponde à entrega dentro do prazo' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'verdadeiro quando status corresponde à entrega em atraso' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'falso quando ordem de serviço é iniciada e não há 
    #       métodos de entrega disponíveis' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'falso quando ordem de serviço é iniciada e não há 
    #       veículos disponíveis para realizar a entrega' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'verdadeiro quando ordem de serviço é iniciada e há 
    #       ao menos um método de entrega disponível' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    #   it 'verdadeiro quando ordem de serviço é iniciada e há 
    #       ao menos um veículo disponível para realizar a entrega' do 
    #     # Arrange
    #     work_order = WorkOrder.new(flat_fee:1)
    #     # Act
    #     work_order.valid?
    #     # Assert
    #     expect(work_order.status).to eq 'ativo' 
    #   end
    end
  end
end