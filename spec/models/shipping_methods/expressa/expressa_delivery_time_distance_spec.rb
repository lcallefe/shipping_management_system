require 'rails_helper'

RSpec.describe ExpressaDeliveryTimeDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando prazo está vazio' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando prazo é igual a 0' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'falso quando prazo é negativo' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando prazo é positivo' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:47)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:1, max_distance:3, 
                                                           delivery_time:24)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be false 
      end
      it 'falso quando distância máxima é negativa' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:49)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 50' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:51)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando distância máxima é igual a 50' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:50)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando prazo é maior que 48' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:49)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser menor ou igual a 48")
      end
      it 'verdadeiro quando prazo é igual a 48' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:48)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:2, max_distance:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima é igual a distância máxima' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:2, max_distance:2)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 2")
      end
      it 'falso quando distância mínima não é um número inteiro' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(min_distance:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(max_distance:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando prazo não é um número inteiro' do
        
        shipping_method = ExpressaDeliveryTimeDistance.new(delivery_time:'b')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não é um número")
      end
      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:2, expressa_id:expressa.id)
        sedex_shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:29, max_distance:31, 
                                                               delivery_time:3, expressa_id:expressa.id)
        

        
        expect(ExpressaDeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é menor que prazo do anterior' do
        
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:2, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                   delivery_time:1, 
                                                                   expressa_id:expressa.id)
        

        
        expect(ExpressaDeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é igual a prazo do anterior' do
        
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:1, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                   delivery_time:1, 
                                                                   expressa_id:expressa.id)
        
        
        
        expect(ExpressaDeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:1, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                   delivery_time:2, 
                                                                   expressa_id: expressa.id)
        shipping_method.update(max_distance:32)                                                        
        
        
        
        expect(ExpressaDeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
    end
  end
end

