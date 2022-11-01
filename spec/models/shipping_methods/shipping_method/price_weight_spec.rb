require 'rails_helper'

RSpec.describe PriceWeight, type: :model do
  describe '#valid?' do
    context 'presence' do    
      it 'falso quando preço está vazio' do
        range = PriceWeight.new(price:nil)

        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("não pode ficar em branco")
      end

      it 'falso quando peso mínimo está vazio' do
        range = PriceWeight.new(min_weight:nil)

        range.valid?

        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("não pode ficar em branco")
      end

      it 'falso quando peso máximo está vazio' do
        range = PriceWeight.new(max_weight:nil)

        range.valid?

        expect(range.errors.include?(:max_weight)).to be true  
        expect(range.errors[:max_weight]).to include("não pode ficar em branco")
      end
    end

    context 'numericality' do    
      it 'falso quando preço é igual a 0' do
        range = PriceWeight.new(price:0)

        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("deve ser maior que 0")
      end

      it 'falso quando preço é negativo' do
        range = PriceWeight.new(price:-1)
        
        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando preço é positivo' do
        range = PriceWeight.new(price:1)

        range.valid?

        expect(range.errors.include?(:price)).to be false  
      end

      it 'falso quando peso mínimo é negativo' do
        range = PriceWeight.new(min_weight:-1)

        range.valid?

        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("deve ser maior que 0")
      end

      it 'falso quando peso mínimo é igual a 0' do
        range = PriceWeight.new(min_weight:0)

        range.valid?

        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando peso mínimo é positivo' do
        range = PriceWeight.new(min_weight:1)

        range.valid?

        expect(range.errors[:min_weight]).not_to include("deve ser maior que 0")
      end

      it 'falso quando peso máximo é negativo' do
        range = PriceWeight.new(max_weight:-1)

        range.valid?

        expect(range.errors.include?(:max_weight)).to be true  
        expect(range.errors[:max_weight]).to include("deve ser maior que 0")
      end

      it 'falso quando peso máximo é igual a 0' do
        range = PriceWeight.new(max_weight:0)

        range.valid?

        expect(range.errors.include?(:max_weight)).to be true  
        expect(range.errors[:max_weight]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando peso máximo é positivo' do
        range = PriceWeight.new(max_weight:1)
      
        range.valid?
        
        expect(range.errors.include?(:max_weight)).to be false  
      end

      it 'falso quando peso máximo é maior que peso máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(max_weight:52, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:max_weight)).to be true  
        expect(range.errors[:max_weight]).to include("acima do valor máximo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando peso máximo é igual a peso máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:52, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(max_weight:52, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:max_weight)).to be false  
      end

      it 'verdadeiro quando peso máximo é menor do que peso máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(max_weight:50, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:max_weight)).to be false  
      end

      it 'falso quando peso mínimo é menor que peso mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(min_weight:4, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("abaixo do valor mínimo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando peso mínimo é igual a peso mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(min_weight:5, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:min_weight)).to be false  
      end

      it 'verdadeiro quando peso mínimo é maior do que o peso mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(min_weight:6, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:min_weight)).to be false
      end

      it 'falso quando preço é maior que preço máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(price:41, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("acima do valor máximo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando preço é igual ao preço máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(price:40, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:price)).to be false  
      end

      it 'verdadeiro quando preço é menor do que preço máximo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(price:39, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:price)).to be false  
      end

      it 'falso quando preço é menor que preço mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(price:4, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("abaixo do valor mínimo estipulado da modalidade de entrega")
      end

      it 'verdadeiro quando preço é igual ao preço mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(price:5, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:price)).to be false  
      end

      it 'verdadeiro quando preço é maior do que preço mínimo da modalidade de entrega' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.new(price:6, shipping_method_id:sm.id)

        range.check_weight_boundaries

        expect(range.errors.include?(:price)).to be false  
      end

      it 'falso quando peso mínimo é maior que peso máximo' do
        range = PriceWeight.new(min_weight:2, max_weight:1)

        range.valid?

        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("deve ser menor que 1")
      end

      it 'falso quando peso mínimo é igual a peso máximo' do
        range = PriceWeight.new(min_weight:2, max_weight:2, price:25)
        
        range.valid?
        
        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("deve ser menor que 2")
      end

      it 'falso quando peso mínimo não é um número inteiro' do
        range = PriceWeight.new(min_weight:'a')

        range.valid?

        expect(range.errors.include?(:min_weight)).to be true  
        expect(range.errors[:min_weight]).to include("não é um número")
      end

      it 'falso quando peso máximo não é um número inteiro' do
        range = PriceWeight.new(max_weight:'a')

        range.valid?

        expect(range.errors.include?(:max_weight)).to be true  
        expect(range.errors[:max_weight]).to include("não é um número")
      end

      it 'falso quando preço não é um número inteiro' do
        range = PriceWeight.new(price:"kk")

        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("não é um número")
      end

      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.create!(min_weight:15, max_weight:17, 
                                    price:5, shipping_method_id: sm.id)
        second_range = PriceWeight.create!(min_weight:16, max_weight:29, 
                                           price:6, shipping_method_id: sm.id)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end

      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:15, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.create!(min_weight:15, max_weight:17, 
                                    price:5, shipping_method_id: sm.id)
        second_range = PriceWeight.create!(min_weight:16, max_weight:29, 
                                           price:7, shipping_method_id: sm.id)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end

      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.create!(min_weight:15, max_weight:17, 
                                    price:6, shipping_method_id: sm.id)
        second_range = PriceWeight.create!(min_weight:16, max_weight:29, 
                                           price:6, shipping_method_id: sm.id)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end

      it 'falso quando peso máximo é atualizado para valor superior ao peso mínimo do pŕoximo intervalo' do
        sm = ShippingMethod.create!(flat_fee:60, name:'rapida', min_distance:5, max_distance:50, min_weight:5, max_weight:51, 
                                    min_price:5, max_price:40, min_delivery_time:1, max_delivery_time:240)
        range = PriceWeight.create!(min_weight:15, max_weight:17, 
                                    price:5, shipping_method_id: sm.id)
        second_range = PriceWeight.create!(min_weight:18, max_weight:20, 
                                           price:6, shipping_method_id: sm.id)
        range.update(max_weight:19)
        
        second_range.invalid_range?

        expect(second_range.errors.include?(:base)).to be true  
        expect(second_range.errors[:base]).to include("Intervalo inválido.")
      end
    end
  end
end

