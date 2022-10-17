require 'rails_helper'

RSpec.describe ExpressaPriceDistance, type: :model do
  describe '#válido?' do
    context 'presença' do    
      it 'falso quando preço está vazio' do
        shipping_method = ExpressaPriceDistance.new(price:nil)
                                            
        shipping_method.valid?

        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        shipping_method = ExpressaPriceDistance.new(min_distance:nil)

        shipping_method.valid?
      
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        shipping_method = ExpressaPriceDistance.new(max_distance:nil)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
    end
    context 'valores inválidos' do    
      it 'falso quando preço é igual a 0' do
        shipping_method = ExpressaPriceDistance.new(price:0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        shipping_method = ExpressaPriceDistance.new(price:-1)
                                                 
        shipping_method.valid?

        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        shipping_method = ExpressaPriceDistance.new(price:49)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        shipping_method = ExpressaPriceDistance.new(min_distance:-1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        shipping_method = ExpressaPriceDistance.new(min_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        shipping_method = ExpressaPriceDistance.new(min_distance:1)

        shipping_method.valid?
        
        
        expect(shipping_method.errors[:min_distance]).not_to include("deve ser maior que 0") 
      end
      it 'falso quando distância máxima é negativa' do
        shipping_method = ExpressaPriceDistance.new(max_distance:-1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        shipping_method = ExpressaPriceDistance.new(max_distance:0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        shipping_method = ExpressaPriceDistance.new(max_distance:49)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 50' do
        shipping_method = ExpressaPriceDistance.new(max_distance:51)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando distância máxima é igual a 50' do
        shipping_method = ExpressaPriceDistance.new(max_distance:50)

        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando preço é maior que 50' do
        shipping_method = ExpressaPriceDistance.new(price:51)
                                                 
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando preço é igual a 50' do
        shipping_method = ExpressaPriceDistance.new(price:50)

        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        
        shipping_method = ExpressaPriceDistance.new(min_distance:2, max_distance:1) 
                                                 
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima é igual a distância máxima' do
        shipping_method = ExpressaPriceDistance.new(min_distance:2, max_distance:2) 
                                                 
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 2")
      end

      it 'falso quando distância mínima não é um número inteiro' do
        shipping_method = ExpressaPriceDistance.new(min_distance:'a') 

        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        shipping_method = ExpressaPriceDistance.new(max_distance:'o') 
                                                
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        shipping_method = ExpressaPriceDistance.new(price:'a') 
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando distância mínima do intervalo atual é menor que distância máxima do anterior' do
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceDistance.create!(min_distance:10, max_distance:21, 
                                                        price:10, expressa_id:expressa.id)
        sedex_shipping_method = ExpressaPriceDistance.new(min_distance:20, max_distance:30, 
                                                          price:11, expressa_id:expressa.id)
        
        
        
        expect(ExpressaPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceDistance.create!(min_distance:20, max_distance:30, 
                                                     price:2, expressa_id:expressa.id)
        sedex_shipping_method = ExpressaPriceDistance.new(min_distance:31, max_distance:40, 
                                                        price:1, expressa_id:expressa.id)
        
        
        
        
        expect(ExpressaPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceDistance.create!(min_distance:20, max_distance:30, 
                                                     price:1, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaPriceDistance.create!(min_distance:31, max_distance:40, 
                                                              price:1, expressa_id: expressa.id) 
                                                        
        
        
        
        expect(ExpressaPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceDistance.create!(min_distance:20, max_distance:30, 
                                                     price:1, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaPriceDistance.create!(min_distance:31, max_distance:40, 
                                                            price:2, expressa_id: expressa.id) 
        shipping_method.update(max_distance:32) 
                                                      
        
        
        expect(ExpressaPriceDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
    end
  end
end

