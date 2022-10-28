require 'rails_helper'

RSpec.describe DeliveryTimeDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
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
        range = DeliveryTimeDistance.new(delivery_time:47)
        
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
        range = DeliveryTimeDistance.new(min_distance:1, max_distance:3, 
                                         delivery_time:24)
        
        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be false 
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
        range = DeliveryTimeDistance.new(max_distance:49)
        
        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'falso quando distância máxima é maior que 50' do
        range = DeliveryTimeDistance.new(max_distance:51)
        
        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be true  
        expect(range.errors[:max_distance]).to include("deve ser menor ou igual a 50")
      end

      it 'verdadeiro quando distância máxima é igual a 50' do
        range = DeliveryTimeDistance.new(max_distance:50)
        
        range.valid?
        
        expect(range.errors.include?(:max_distance)).to be false  
      end

      it 'falso quando prazo é maior que 48' do
        range = DeliveryTimeDistance.new(delivery_time:49)
        
        range.valid?
        
        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("deve ser menor ou igual a 48")
      end

      it 'verdadeiro quando prazo é igual a 48' do
        range = DeliveryTimeDistance.new(delivery_time:48)
        
        range.valid?
        
        expect(range.errors.include?(:delivery_time)).to be false  
      end

      it 'falso quando distância mínima é maior que distância máxima' do
        range = DeliveryTimeDistance.new(min_distance:2, max_distance:1)
        
        range.valid?
        
        expect(range.errors.include?(:min_distance)).to be true  
        expect(range.errors[:min_distance]).to include("deve ser menor que 1")
      end

      it 'falso quando distância mínima é igual a distância máxima' do
        range = DeliveryTimeDistance.new(min_distance:2, max_distance:2)
        
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
        range = DeliveryTimeDistance.new(delivery_time:'b')
        
        range.valid?
        
        expect(range.errors.include?(:delivery_time)).to be true  
        expect(range.errors[:delivery_time]).to include("não é um número")
      end

      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        
        range = ShippingMethod.create!(flat_fee: 1, name:'Modalidade')
        range = DeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:2, shipping_method_id:range.id)
        sedex_shipping_method = DeliveryTimeDistance.create!(min_distance:29, max_distance:31, 
                                                               delivery_time:3, shipping_method_id:range.id)
        

        
        expect(DeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é menor que prazo do anterior' do
        
        range = ShippingMethod.create!(flat_fee: 1, name:'Modalidade')
        DeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                     delivery_time:2, shipping_method_id: range.id)
        sedex_shipping_method = DeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                             delivery_time:1, 
                                                             shipping_method_id:range.id)
        

        
        expect(DeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end

      it 'falso quando prazo do intervalo atual é igual a prazo do anterior' do
        
        range = ShippingMethod.create!(flat_fee: 1, name:'Nome da modalidade')
        DeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                     delivery_time:1, 
                                     shipping_method_id: range.id)
        sedex_shipping_method = DeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                             delivery_time:1, 
                                                             shipping_method_id:range.id)
        


        
        
        expect(DeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end

      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        
        range = ShippingMethod.create!(flat_fee: 1, name: "Sedex")
        DeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                     delivery_time:1, shipping_method_id: range.id)
        DeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                     delivery_time:2, 
                                     shipping_method_id: range.id)
        range.update(max_distance:32)                                                        
        
        
        
        expect(DeliveryTimeDistance.where(id:sedex_shipping_method.id)).not_to exist
      end
    end
  end
end

