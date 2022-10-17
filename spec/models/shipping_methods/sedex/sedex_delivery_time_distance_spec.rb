require 'rails_helper'

RSpec.describe SedexDeliveryTimeDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando prazo está vazio' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:nil)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando prazo é igual a 0' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'falso quando prazo é negativo' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando prazo é positivo' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:239)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors[:min_distance]).not_to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é negativa' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:-1)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:0)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:499)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 500' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:501)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 500")
      end
      it 'verdadeiro quando distância máxima é igual a 500' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:500)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando prazo é maior que 240' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:241)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser menor ou igual a 240")
      end
      it 'verdadeiro quando prazo é igual a 240' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:240)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:2, max_distance:1)
                                                         
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima é igual a distância máxima' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:2, max_distance:2)
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 2")
      end
      it 'falso quando distância mínima não é um número inteiro' do
        
        shipping_method = SedexDeliveryTimeDistance.new(min_distance:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        
        shipping_method = SedexDeliveryTimeDistance.new(max_distance:'a')
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando prazo não é um número inteiro' do
        
        shipping_method = SedexDeliveryTimeDistance.new(delivery_time:'b') 
                                                         
        
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não é um número")
      end
      it 'falso quando distância mínima do intervalo atual é menor que distância máxima do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                             delivery_time:2, sedex_id:sedex.id)
        second_shipping_method = SedexDeliveryTimeDistance.create!(min_distance:29, max_distance:31, 
                                                                    delivery_time:3, 
                                                                    sedex_id:sedex.id)
        
        
        
        expect(SedexDeliveryTimeDistance.where(id: second_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é menor que prazo do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                             delivery_time:2, sedex_id:sedex.id)
        second_shipping_method = SedexDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                    delivery_time:1, 
                                                                    sedex_id:sedex.id)
        
        
        
        expect(SedexDeliveryTimeDistance.where(id: second_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é igual a prazo do anterior' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                             delivery_time:1, sedex_id:sedex.id)
        sedex_shipping_method = SedexDeliveryTimeDistance.new(min_distance:31, max_distance:40, 
                                                                delivery_time:1, sedex_id:sedex.id)
        
        
        
        expect(SedexDeliveryTimeDistance.where(id: sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SedexDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                             delivery_time:1, sedex_id:sedex.id)
        sedex_shipping_method = SedexDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                delivery_time:2, sedex_id:sedex.id)
        
        shipping_method.update(max_distance:32)                                                        
        
        expect(SedexDeliveryTimeDistance.where(id: sedex_shipping_method.id)).not_to exist
      end
    end
  end
end

