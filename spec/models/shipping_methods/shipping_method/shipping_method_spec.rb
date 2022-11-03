require 'rails_helper'

RSpec.describe ShippingMethod, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando taxa fixa é negativa' do
        shipping_method = ShippingMethod.new(flat_fee: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end

      it 'falso quando taxa fixa é igual a 0' do
        shipping_method = ShippingMethod.new(flat_fee: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando taxa fixa é positiva' do
        shipping_method = ShippingMethod.new(flat_fee: 1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be false  
      end

      it 'falso quando taxa fixa não é um número inteiro' do
        shipping_method = ShippingMethod.new(flat_fee: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("não é um número")
      end

      it 'falso quando preço mínimo é negativo' do
        shipping_method = ShippingMethod.new(min_price: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_price)).to be true  
        expect(shipping_method.errors[:min_price]).to include("deve ser maior que 0")
      end

      it 'falso quando preço mínimo é igual a 0' do
        shipping_method = ShippingMethod.new(min_price: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_price)).to be true  
        expect(shipping_method.errors[:min_price]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando preço mínimo é positivo' do
        shipping_method = ShippingMethod.new(min_price: 1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_price)).to be false  
      end

      it 'falso quando preço mínimo não é um número inteiro' do
        shipping_method = ShippingMethod.new(min_price: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_price)).to be true  
        expect(shipping_method.errors[:min_price]).to include("não é um número")
      end

      it 'falso quando preço máximo é negativo' do
        shipping_method = ShippingMethod.new(max_price: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_price)).to be true  
        expect(shipping_method.errors[:max_price]).to include("deve ser maior que 0")
      end

      it 'falso quando preço máximo é igual a 0' do
        shipping_method = ShippingMethod.new(max_price: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_price)).to be true  
        expect(shipping_method.errors[:max_price]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando preço máximo é positivo' do
        shipping_method = ShippingMethod.new(max_price: 1)

        shipping_method.valid?

        expect(shipping_method.errors[:max_price]).not_to include("deve ser maior que 0")
      end

      it 'falso quando preço máximo não é um número inteiro' do
        shipping_method = ShippingMethod.new(max_price: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_price)).to be true  
        expect(shipping_method.errors[:max_price]).to include("não é um número")
      end

      it 'verdadeiro quando distância mínima é positiva' do
        shipping_method = ShippingMethod.new(min_distance: 1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_distance)).to be false  
      end

      it 'falso quando distância mínima não é um número inteiro' do
        shipping_method = ShippingMethod.new(min_distance: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end

      it 'falso quando distância mínima é negativa' do
        shipping_method = ShippingMethod.new(min_distance: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end

      it 'falso quando distância mínima é igual a 0' do
        shipping_method = ShippingMethod.new(min_distance: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando distância máxima é positiva' do
        shipping_method = ShippingMethod.new(max_distance: 1)

        shipping_method.valid?
        
        expect(shipping_method.errors[:max_distance]).not_to include("deve ser maior que 0") 
      end

      it 'falso quando distância máxima não é um número inteiro' do
        shipping_method = ShippingMethod.new(max_distance: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end

      it 'falso quando distância máxima é negativa' do
        shipping_method = ShippingMethod.new(max_distance: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end

      it 'falso quando distância máxima é igual a 0' do
        shipping_method = ShippingMethod.new(max_distance: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando prazo mínimo é positivo' do
        shipping_method = ShippingMethod.new(min_delivery_time: 1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_delivery_time)).to be false  
      end

      it 'falso quando prazo mínimo não é um número inteiro' do
        shipping_method = ShippingMethod.new(min_delivery_time: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_delivery_time)).to be true  
        expect(shipping_method.errors[:min_delivery_time]).to include("não é um número")
      end

      it 'falso quando prazo mínimo é negativo' do
        shipping_method = ShippingMethod.new(min_delivery_time: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_delivery_time)).to be true  
        expect(shipping_method.errors[:min_delivery_time]).to include("deve ser maior que 0")
      end

      it 'falso quando prazo mínimo é igual a 0' do
        shipping_method = ShippingMethod.new(min_delivery_time: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_delivery_time)).to be true  
        expect(shipping_method.errors[:min_delivery_time]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando prazo máximo é positivo' do
        shipping_method = ShippingMethod.new(max_delivery_time: 1)

        shipping_method.valid?

        expect(shipping_method.errors[:max_delivery_time]).not_to include("deve ser maior que 0") 
      end

      it 'falso quando prazo máximo não é um número inteiro' do
        shipping_method = ShippingMethod.new(max_delivery_time: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_delivery_time)).to be true  
        expect(shipping_method.errors[:max_delivery_time]).to include("não é um número")
      end

      it 'falso quando prazo máximo é negativo' do
        shipping_method = ShippingMethod.new(max_delivery_time: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_delivery_time)).to be true  
        expect(shipping_method.errors[:max_delivery_time]).to include("deve ser maior que 0")
      end

      it 'falso quando prazo máximo é igual a 0' do
        shipping_method = ShippingMethod.new(max_delivery_time: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_delivery_time)).to be true  
        expect(shipping_method.errors[:max_delivery_time]).to include("deve ser maior que 0")
      end

      it 'falso quando peso mínimo é maior que peso máximo atendido' do
        shipping_method = ShippingMethod.new(min_weight:2, max_weight:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 2")
      end

      it 'falso quando distância mínima é maior que distância máxima atendida' do
        shipping_method = ShippingMethod.new(min_distance:2, max_distance:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 2")
      end

      it 'falso quando preço mínimo é maior que preço máximo' do
        shipping_method = ShippingMethod.new(min_price:2, max_price:1)

        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_price)).to be true  
        expect(shipping_method.errors[:max_price]).to include("deve ser maior que 2")
      end

      it 'falso quando prazo mínimo é maior que prazo máximo' do
        shipping_method = ShippingMethod.new(min_delivery_time:2, max_delivery_time:1)

        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_delivery_time)).to be true  
        expect(shipping_method.errors[:max_delivery_time]).to include("deve ser maior que 2")
      end
    end
  end
end