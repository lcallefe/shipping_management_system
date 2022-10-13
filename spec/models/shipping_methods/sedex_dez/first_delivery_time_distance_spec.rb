require 'rails_helper'

RSpec.describe FirstDeliveryTimeDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando prazo está vazio' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                        delivery_time:nil)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:nil, max_distance:20, 
                                                        delivery_time:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:5, max_distance:nil, 
                                                        delivery_time:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando prazo é igual a 0' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                        delivery_time:0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'falso quando prazo é negativo' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                        delivery_time:-1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando prazo é positivo' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                        delivery_time:1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:-1, max_distance:20, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:0, max_distance:20, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:20, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be false 
      end
      it 'falso quando distância máxima é negativa' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:-1, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:0, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:999, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 1000' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:1001, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 1000")
      end
      it 'verdadeiro quando distância máxima é igual a 1000' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:1000, 
                                                        delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando prazo é maior que 120' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:100, 
                                                        delivery_time:121)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser menor ou igual a 120")
      end
      it 'verdadeiro quando prazo é igual a 120' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:100, 
                                                        delivery_time:120)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:2, max_distance:1, 
                                                        delivery_time:119)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima é igual a distância máxima' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:2, max_distance:2, 
                                                        delivery_time:119)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 2")
      end
      it 'falso quando distância mínima não é um número inteiro' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:'a', max_distance:10, 
                                                        delivery_time:120)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:'a', 
                                                        delivery_time:120)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando prazo não é um número inteiro' do
        # Arrange
        shipping_method = FirstDeliveryTimeDistance.new(min_distance:1, max_distance:10, 
                                                        delivery_time:'b')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não é um número")
      end
      it 'falso quando distância mínima do intervalo atual é menor que distância máxima do anterior' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = FirstDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:2, sedex_dez_id:sedex_dez.id)
        second_shipping_method = FirstDeliveryTimeDistance.new(min_distance:29, max_distance:31, 
                                                               delivery_time:3)
        # Act

        # Assert
        expect(FirstDeliveryTimeDistance.where(id:second_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é menor que prazo do anterior' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = FirstDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:2, sedex_dez_id: sedex_dez.id)
        second_shipping_method = FirstDeliveryTimeDistance.new(min_distance:31, max_distance:40, 
                                                               delivery_time:1)
        # Act

        # Assert
        expect(FirstDeliveryTimeDistance.where(id:second_shipping_method.id)).not_to exist
      end
      it 'falso quando prazo do intervalo atual é igual a prazo do anterior' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = FirstDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:1, sedex_dez_id: sedex_dez.id)
        second_shipping_method = FirstDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                   delivery_time:1, 
                                                                   sedex_dez_id: sedex_dez.id)
        # Act

        # Assert
        expect(FirstDeliveryTimeDistance.where(id:second_shipping_method.id)).not_to exist
      end
      it 'falso quando distância máxima é atualizada para valor superior à distância mínima do pŕoximo intervalo' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = FirstDeliveryTimeDistance.create!(min_distance:20, max_distance:30, 
                                                            delivery_time:1, 
                                                            sedex_dez_id:sedex_dez.id)
        second_shipping_method = FirstDeliveryTimeDistance.create!(min_distance:31, max_distance:40, 
                                                                   delivery_time:2, sedex_dez_id:1)
                                                    
        # Act
        shipping_method.update(max_distance:32)

        # Assert
        expect(FirstDeliveryTimeDistance.where(id:second_shipping_method.id)).not_to exist
      end
    end
  end
end

