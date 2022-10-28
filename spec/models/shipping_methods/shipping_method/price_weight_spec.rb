require 'rails_helper'

RSpec.describe PriceWeight, type: :model do
  describe '#válido?' do
    context 'presença' do    
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
      it 'falso quando peso máximo é maior que 30' do
        range = PriceWeight.new(max_weight:31)

        range.valid?

        expect(range.errors.include?(:max_weight)).to be true  
        expect(range.errors[:max_weight]).to include("deve ser menor ou igual a 30")
      end
      it 'verdadeiro quando peso máximo é igual a 30' do
        range = PriceWeight.new(max_weight:30)

        range.valid?

        expect(range.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando preço é maior que 50' do
        range = PriceWeight.new(price:51)
    
        range.valid? 
        
        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando preço é igual a 50' do
        range = PriceWeight.new(price:50)

        range.valid?

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
        sm = ShippingMethod.create!(flat_fee: 1)
        range = PriceWeight.create!(min_weight:15, max_weight:17, 
                                                   price:2, shipping_method_id: sm.id)
        second_range = PriceWeight.create!(min_weight:16, max_weight:29, 
                                                          price:3, 
                                                          shipping_method_id: sm.id)


        
        expect(PriceWeight.where(id:second_range.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        sm = ShippingMethod.create!(flat_fee: 1)
        range = PriceWeight.create!(min_weight:10, max_weight:20, 
                                                   price:2, shipping_method_id: sm.id)
        second_range = PriceWeight.create!(min_weight:21, max_weight:22, 
                                                          price:1, 
                                                          shipping_method_id: sm.id)
        


        expect(PriceWeight.where(id:second_range.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        sm = ShippingMethod.create!(flat_fee: 1)
        range = PriceWeight.create!(min_weight:20, max_weight:28, 
                                                   price:1, shipping_method_id:sm.id)
        second_range = PriceWeight.create!(min_weight:20, max_weight:28, 
                                                      price:1, shipping_method_id: sm.id)
        


        expect(PriceWeight.where(id:second_range.id)).not_to exist
      end
      it 'falso quando peso máximo é atualizado para valor superior ao peso mínimo do pŕoximo intervalo' do
        sm = ShippingMethod.create!(flat_fee: 1)
        range = PriceWeight.create!(min_weight:10, max_weight:20, 
                                                   price:1, shipping_method_id:sm.id)
        second_range = PriceWeight.create!(min_weight:21, max_weight:30, 
                                                          price:2, shipping_method_id:sm.id)
        range.update(max_weight:22)                                                  
         


        expect(PriceWeight.where(id:second_range.id)).not_to exist
      end
    end
  end
end

