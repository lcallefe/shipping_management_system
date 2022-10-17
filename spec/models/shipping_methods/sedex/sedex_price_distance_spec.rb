require 'rails_helper'

RSpec.describe SedexPriceDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        
        shipping_method = SedexPriceDistance.new(price:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        
        shipping_method = SedexPriceDistance.new(min_distance:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        
        shipping_method = SedexPriceDistance.new(max_distance:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        
        shipping_method = SedexPriceDistance.new(price:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        
        shipping_method = SedexPriceDistance.new(price:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        
        shipping_method = SedexPriceDistance.new(price:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        
        shipping_method = SedexPriceDistance.new(min_distance:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        
        shipping_method = SedexPriceDistance.new(min_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        
        shipping_method = SedexPriceDistance.new(min_distance:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors[:min_distance]).not_to include("deve ser maior que 0") 
      end
      it 'falso quando distância máxima é negativa' do
        
        shipping_method = SedexPriceDistance.new(max_distance:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        
        shipping_method = SedexPriceDistance.new(max_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        
        shipping_method = SedexPriceDistance.new(max_distance:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 500' do
        
        shipping_method = SedexPriceDistance.new(max_distance:501)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 500")
      end
      it 'verdadeiro quando distância máxima é igual a 500' do
        
        shipping_method = SedexPriceDistance.new(max_distance:500)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando preço é maior que 40' do
        
        shipping_method = SedexPriceDistance.new(price:41)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 40")
      end
      it 'verdadeiro quando preço é igual a 40' do
        
        shipping_method = SedexPriceDistance.new(price:40)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        
        shipping_method = SedexPriceDistance.new(min_distance:2, max_distance:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima é igual a distância máxima' do
        
        shipping_method = SedexPriceDistance.new(min_distance:2, max_distance:2)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 2")
      end
      it 'falso quando distância mínima não é um número inteiro' do
        
        shipping_method = SedexPriceDistance.new(min_distance:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        
        shipping_method = SedexPriceDistance.new(max_distance:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        
        shipping_method = SedexPriceDistance.new(price:'b')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando distância mínima do intervalo atual é menor que distância máxima do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceDistance.create!(min_distance:10, max_distance:21, 
                                                      price:10, sedex_id:sedex.id)
        sedex_shipping_method = SedexPriceDistance.create!(min_distance:20, max_distance:30, 
                                                             price:11, sedex_id:sedex.id)
        
      
        
        expect(SedexPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceDistance.create!(min_distance:20, max_distance:30, 
                                                      price:2, sedex_id:sedex.id)
        sedex_shipping_method = SedexPriceDistance.create!(min_distance:31, max_distance:40, 
                                                             price:1, sedex_id:sedex.id)
        
        
        
        expect(SedexPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceDistance.create!(min_distance:20, max_distance:30, 
                                                      price:1, sedex_id:sedex.id)
        sedex_shipping_method = SedexPriceDistance.create!(min_distance:1, max_distance:21, 
                                                             price:1, sedex_id:sedex.id)
        
        
        
        expect(SedexPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexPriceDistance.create!(min_distance:20, max_distance:30, 
                                                      price:1, sedex_id:sedex.id)
        sedex_shipping_method = SedexPriceDistance.create!(min_distance:31, max_distance:40, 
                                                             price:2, sedex_id:sedex.id)                                                  
        
        shipping_method.update(max_distance:32)   
        
        expect(SedexPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
    end
  end
end

