require 'rails_helper'

RSpec.describe DeliveryTimeDistance, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'falso quando prazo está vazio' do
        range = DeliveryTimeDistance.new(delivery_time:nil)

        range.valid?

        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("não pode ficar em branco")
      end

      it 'falso quando distância mínima está vazia' do
        range = DeliveryTimeDistance.new(min_distance:nil)

        range.valid?

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("não pode ficar em branco")
      end

      it 'falso quando distância máxima está vazia' do
        range = DeliveryTimeDistance.new(max_distance:nil)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("não pode ficar em branco")
      end
    end

    context 'numericality' do    
      it 'falso quando prazo é igual a 0' do
        range = DeliveryTimeDistance.new(delivery_time:0)

        range.valid?

        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("deve ser maior que 0")
      end

      it 'falso quando prazo é negativo' do
        range = DeliveryTimeDistance.new(delivery_time:-1)
        
        range.valid?

        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando prazo é positivo' do
        range = DeliveryTimeDistance.new(delivery_time:1)

        range.valid?

        expect(range.errors.include?(:delivery_time)).to be false  
      end

      it 'falso quando distância mínima é negativa' do
        range = DeliveryTimeDistance.new(min_distance:-1)

        range.valid?

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser maior que 0")
      end

      it 'falso quando distância mínima é igual a 0' do
        range = DeliveryTimeDistance.new(min_distance:0)

        range.valid?

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando distância mínima é positiva' do
        range = DeliveryTimeDistance.new(min_distance:1)

        range.valid?

        expect(range.errors[:min_distance]).not_to include("deve ser maior que 0")
      end

      it 'falso quando distância máxima é negativa' do
        range = DeliveryTimeDistance.new(max_distance:-1)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("deve ser maior que 0")
      end

      it 'falso quando distância máxima é igual a 0' do
        range = DeliveryTimeDistance.new(max_distance:0)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando distância máxima é positiva' do
        range = DeliveryTimeDistance.new(max_distance:1)
      
        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'falso quando distância máxima é maior que distância máxima da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = DeliveryTimeDistance.new(max_distance:52, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("acima do valor máximo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando distância máxima é igual a distância máxima da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:52, min_weight:5, 
                                    max_weight:52, min_price:5, max_price:40, min_delivery_time:1, 
                                    max_delivery_time:240)
        range = DeliveryTimeDistance.new(max_distance:52, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'verdadeiro quando distância máxima é menor do que distância máxima da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:19, 
                                    min_price:5, max_price:40, min_delivery_time:10, max_delivery_time:200)
        range = DeliveryTimeDistance.new(max_distance:50, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'falso quando distância mínima é menor que distância mínima da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:30, 
                                    min_price:5, max_price:35, min_delivery_time:1, max_delivery_time:240)
        range = DeliveryTimeDistance.new(min_distance:4, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("abaixo do valor mínimo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando distância mínima é igual a distância mínima da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, 
                                    max_weight:33, min_delivery_time:5, max_delivery_time:40, min_price:1, 
                                    max_price:15)
        range = DeliveryTimeDistance.new(min_distance:5, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:min_distance)).to be false  
      end

      it 'verdadeiro quando distância mínima é maior do que o distância mínima da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_delivery_time:5, max_delivery_time:40, min_price:1, max_price:20)
        range = DeliveryTimeDistance.new(min_distance:6, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:min_distance)).to be false
      end

      it 'falso quando prazo é maior que prazo máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:40, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:40)
        range = DeliveryTimeDistance.new(delivery_time:41, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("acima do valor máximo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando prazo é igual ao prazo máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, 
                                    max_weight:20, min_delivery_time:5, max_delivery_time:40, min_price:1, 
                                    max_price:10)
        range = DeliveryTimeDistance.new(delivery_time:40, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:delivery_time)).to be false  
      end

      it 'verdadeiro quando prazo é menor do que prazo máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:10, 
                                    max_weight:51, min_delivery_time:5, max_delivery_time:40, min_price:1, 
                                    max_price:40)
        range = DeliveryTimeDistance.new(delivery_time:40, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:delivery_time)).to be false  
      end

      it 'falso quando prazo é menor que prazo mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:10, max_price:34, min_delivery_time:11, max_delivery_time:100)
        range = DeliveryTimeDistance.new(delivery_time:10, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("abaixo do valor mínimo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando prazo é igual ao prazo mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:30, 
                                    min_delivery_time:10, max_delivery_time:40, min_price:1, max_price:15)
        range = DeliveryTimeDistance.new(delivery_time:10, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:delivery_time)).to be false  
      end

      it 'verdadeiro quando prazo é maior do que prazo mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:10, 
                                    max_weight:49, min_price:5, max_price:40, min_delivery_time:1, 
                                    max_delivery_time:100)
        range = DeliveryTimeDistance.new(delivery_time:6, shipping_method_id:sm.id)

        range.check_distance_boundaries

        expect(range.errors.include?(:delivery_time)).to be false  
      end

      it 'falso quando distância mínima é maior que distância máxima' do
        range = DeliveryTimeDistance.new(min_distance:2, max_distance:1)

        range.valid?

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser menor que 1")
      end

      it 'falso quando distância mínima é igual a distância máxima' do
        range = DeliveryTimeDistance.new(min_distance:2, max_distance:2, delivery_time:25)
        
        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser menor que 2")
      end

      it 'falso quando distância mínima não é um número inteiro' do
        range = DeliveryTimeDistance.new(min_distance:'a')

        range.valid?

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("não é um número")
      end

      it 'falso quando distância máxima não é um número inteiro' do
        range = DeliveryTimeDistance.new(max_distance:'a')

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("não é um número")
      end

      it 'falso quando prazo não é um número inteiro' do
        range = DeliveryTimeDistance.new(delivery_time:"kk")

        range.valid?

        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("não é um número")
      end

      it 'falso quando distância mínima do intervalo atual é menor que distância máxima do anterior' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:32, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = DeliveryTimeDistance.create!(min_distance:15, max_distance:17, 
                                    delivery_time:5, shipping_method_id: sm.id)
        second_range = DeliveryTimeDistance.create!(min_distance:16, max_distance:29, 
                                           delivery_time:6, shipping_method_id: sm.id)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end

      it 'falso quando prazo do intervalo atual é menor que prazo do anterior' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:15, 
                                    max_weight:51, min_delivery_time:5, max_delivery_time:40, min_price:1, 
                                    max_price:240)
        range = DeliveryTimeDistance.create!(min_distance:15, max_distance:17, 
                                    delivery_time:5, shipping_method_id: sm.id)
        second_range = DeliveryTimeDistance.create!(min_distance:16, max_distance:29, 
                                           delivery_time:7, shipping_method_id: sm.id)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end

      it 'falso quando prazo do intervalo atual é igual a prazo do anterior' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:40, 
                                    min_delivery_time:5, max_delivery_time:40, min_price:1, max_price:240)
        range = DeliveryTimeDistance.create!(min_distance:15, max_distance:17, 
                                      delivery_time:6, shipping_method_id: sm.id)
        second_range = DeliveryTimeDistance.create!(min_distance:16, max_distance:29, 
                                           delivery_time:6, shipping_method_id: sm.id)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end

      it 'falso quando distância máxima é atualizada para valor superior ao da distância mínima do pŕoximo intervalo' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = DeliveryTimeDistance.create!(min_distance:15, max_distance:17, 
                                      delivery_time:5, shipping_method_id: sm.id)
        second_range = DeliveryTimeDistance.create!(min_distance:18, max_distance:20, 
                                             delivery_time:6, shipping_method_id: sm.id)
        range.update(max_distance:19)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end
    end
  end
end

