require 'rails_helper'

RSpec.describe PriceDistance, type: :model do
  describe '#válido?' do
    context 'presença' do    
      it 'falso quando preço está vazio' do
        range = PriceDistance.new(price:nil)
                                            
        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("não pode ficar em branco")
      end

      it 'falso quando distância mínima está vazia' do
        range = PriceDistance.new(min_distance:nil)

        range.valid?
      
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("não pode ficar em branco")
      end

      it 'falso quando distância máxima está vazia' do
        range = PriceDistance.new(max_distance:nil)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("não pode ficar em branco")
      end
    end

    context 'valores inválidos' do    
      it 'falso quando preço é igual a 0' do
        range = PriceDistance.new(price:0)

        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("deve ser maior que 0")
      end

      it 'falso quando preço é negativo' do
        range = PriceDistance.new(price:-1)
                                                 
        range.valid?

        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando preço é positivo' do
        range = PriceDistance.new(price:49)

        range.valid?

        expect(range.errors.include?(:price)).to be false  
      end

      it 'falso quando distância mínima é negativa' do
        range = PriceDistance.new(min_distance:-1)

        range.valid?

        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser maior que 0")
      end

      it 'falso quando distância mínima é igual a 0' do
        range = PriceDistance.new(min_distance:0)
        
        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando distância mínima é positiva' do
        range = PriceDistance.new(min_distance:1)

        range.valid?
        
        
        expect(range.errors[:min_distance]).not_to include("deve ser maior que 0") 
      end

      it 'falso quando distância máxima é negativa' do
        range = PriceDistance.new(max_distance:-1)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("deve ser maior que 0")
      end

      it 'falso quando distância máxima é igual a 0' do
        range = PriceDistance.new(max_distance:0)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("deve ser maior que 0")
      end

      it 'verdadeiro quando distância máxima é positiva' do
        range = PriceDistance.new(max_distance:49)

        range.valid?

        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'falso quando distância máxima é maior que 50' do
        range = PriceDistance.new(max_distance:51)
        
        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("deve ser menor ou igual a 50")
      end

      it 'verdadeiro quando distância máxima é igual a 50' do
        range = PriceDistance.new(max_distance:50)

        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'falso quando preço é maior que 50' do
        range = PriceDistance.new(price:51)
                                                 
        range.valid?
        
        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("deve ser menor ou igual a 50")
      end

      it 'verdadeiro quando preço é igual a 50' do
        range = PriceDistance.new(price:50)

        range.valid?
        
        expect(range.errors.include?(:price)).to be false  
      end

      it 'falso quando distância mínima é maior que distância máxima' do
        range = PriceDistance.new(min_distance:2, max_distance:1) 
                                                 
        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser menor que 1")
      end

      it 'falso quando distância mínima é igual a distância máxima' do
        range = PriceDistance.new(min_distance:2, max_distance:2) 
                                                 
        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser menor que 2")
      end

      it 'falso quando distância mínima não é um número inteiro' do
        range = PriceDistance.new(min_distance:'a') 

        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("não é um número")
      end

      it 'falso quando distância máxima não é um número inteiro' do
        range = PriceDistance.new(max_distance:'o') 
                                                
        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("não é um número")
      end

      it 'falso quando preço não é um número inteiro' do
        range = PriceDistance.new(price:'a') 
        
        range.valid?
        
        expect(range.errors.include?(:price)).to be true  
        expect(range.errors[:price]).to include("não é um número")
      end

      it 'falso quando distância mínima do intervalo atual é menor que distância máxima do anterior' do
        shipping_method = ShippingMethod.create!(flat_fee: 1, name: 'Nome')
        range = PriceDistance.create!(min_distance:10, max_distance:21, 
                                      price:10, 
                                      shipping_method_id:shipping_method.id)
        sedex_range = PriceDistance.new(min_distance:20, max_distance:30, 
                                        price:11, 
                                        shipping_method_id:shipping_method.id)
        
        
        
        expect(PriceDistance.where(id:sedex_range.id)).not_to exist
      end

      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        shipping_method = ShippingMethod.create!(flat_fee: 1, name: 'Nome')
        range = PriceDistance.create!(min_distance:20, max_distance:30, 
                                      price:2, shipping_method_id:shipping_method.id)
        sedex_range = PriceDistance.new(min_distance:31, max_distance:40, 
                                        price:1, 
                                        shipping_method_id:shipping_method.id)
        
        
        
        
        expect(PriceDistance.where(id:sedex_range.id)).not_to exist
      end

      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        shipping_method = ShippingMethod.create!(flat_fee: 1, name:'Correios')
        range = PriceDistance.create!(min_distance:20, max_distance:30, 
                                      price:1, shipping_method_id: shipping_method.id)
        sedex_range = PriceDistance.create!(min_distance:31, max_distance:40, 
                                            price:1, shipping_method_id: shipping_method.id) 
                                                        
        
        
        
        expect(PriceDistance.where(id:sedex_range.id)).not_to exist
      end

      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        shipping_method = ShippingMethod.create!(flat_fee: 1, name:'Correios')
        range = PriceDistance.create!(min_distance:20, max_distance:30, 
                                      price:1, shipping_method_id: shipping_method.id)
        sedex_range = PriceDistance.create!(min_distance:31, max_distance:40, 
                                            price:2, shipping_method_id: shipping_method.id) 
        range.update(max_distance:32) 
                                                      
        

        
        expect(PriceDistance.where(id:sedex_range.id)).not_to exist
      end
    end
  end
end

