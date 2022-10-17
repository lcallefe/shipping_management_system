require 'rails_helper'

RSpec.describe SedexPriceWeight, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        
        shipping_method = SedexPriceWeight.new(price:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando peso mínimo está vazio' do
        
        shipping_method = SedexPriceWeight.new(min_weight:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando peso máximo está vazio' do
        
        shipping_method = SedexPriceWeight.new(max_weight:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        
        shipping_method = SedexPriceWeight.new(price:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        
        shipping_method = SedexPriceWeight.new(price:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        
        shipping_method = SedexPriceWeight.new(price:39)
        
        shipping_method.valid?
        
        expect(shipping_method.errors[:price]).not_to include("deve ser maior que 0")  
      end
      it 'falso quando peso mínimo é negativo' do
        
        shipping_method = SedexPriceWeight.new(min_weight:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso mínimo é igual a 0' do
        
        shipping_method = SedexPriceWeight.new(min_weight:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso mínimo é positivo' do
        
        shipping_method = SedexPriceWeight.new(min_weight:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors[:min_weight]).not_to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é negativo' do
        
        shipping_method = SedexPriceWeight.new(max_weight:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é igual a 0' do
        
        shipping_method = SedexPriceWeight.new(max_weight:0)
                                                
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso máximo é positivo' do
        
        shipping_method = SedexPriceWeight.new(price:20)
        
        shipping_method.valid?
        
        expect(shipping_method.errors[:max_weight]).not_to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é maior que 50' do
        
        shipping_method = SedexPriceWeight.new(max_weight:51)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando peso máximo é igual a 50' do
        
        shipping_method = SedexPriceWeight.new(max_weight:50)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando preço é maior que 40' do
        
        shipping_method = SedexPriceWeight.new(price:41)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 40")
      end
      it 'verdadeiro quando preço é igual a 40' do
        
        shipping_method = SedexPriceWeight.new(price:40)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é maior que peso máximo' do
        
        shipping_method = SedexPriceWeight.new(min_weight:3, max_weight:2)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 2")
      end
      it 'falso quando peso mínimo é igual a peso máximo' do
        
        shipping_method = SedexPriceWeight.new(min_weight:2, max_weight:2)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 2")
      end
      it 'falso quando peso mínimo não é um número inteiro' do
        
        shipping_method = SedexPriceWeight.new(min_weight:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não é um número")
      end
      it 'falso quando peso máximo não é um número inteiro' do
        
        shipping_method = SedexPriceWeight.new(max_weight:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        
        shipping_method = SedexPriceWeight.new(price:'b')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:2, sedex_id:sedex.id)
        sedex_shipping_method = SedexPriceWeight.new(min_weight:29, max_weight:31, 
                                                       price:3, sedex_id:sedex.id)
        
        
        
        expect(SedexPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:2, sedex_id:sedex.id)
        sedex_shipping_method = SedexPriceWeight.new(min_weight:31, max_weight:40, 
                                                       price:1, sedex_id:sedex.id)
        
        
        
        expect(SedexPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:1, sedex_id: sedex.id)
        sedex_shipping_method = SedexPriceWeight.create!(min_weight:31, max_weight:40, 
                                                           price:1, 
                                                           sedex_id: sedex.id)
        

        
        expect(SedexPriceWeight.where(id:sedex_shipping_method.id )).not_to exist
      end
      it 'falso quando peso máximo é atualizado para valor superior ao peso mínimo do pŕoximo intervalo' do
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:1, sedex_id: sedex.id)
        sedex_shipping_method = SedexPriceWeight.create!(min_weight:31, max_weight:40, 
                                                           price:2, sedex_id:sedex.id)
        shipping_method.update(max_weight:32)                                                        

        
        expect(SedexPriceWeight.where(id:sedex_shipping_method.id )).not_to exist
      end
   end
  end
end

