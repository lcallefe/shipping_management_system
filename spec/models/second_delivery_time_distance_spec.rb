require 'rails_helper'

RSpec.describe SecondDeliveryTimeDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando prazo está vazio' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                         delivery_time:nil)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:nil, max_distance:20, 
                                                         delivery_time:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:5, max_distance:nil, 
                                                         delivery_time:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando prazo é igual a 0' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                         delivery_time:0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'falso quando prazo é negativo' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                         delivery_time:-1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando prazo é positivo' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:10, max_distance:20, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:-1, max_distance:20, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:0, max_distance:20, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:20, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be false 
      end
      it 'falso quando distância máxima é negativa' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:-1, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:0, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:0, max_distance:1, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 500' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:501, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 500")
      end
      it 'verdadeiro quando distância máxima é igual a 500' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:500, 
                                                         delivery_time:48)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando prazo é maior que 240' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:100, 
                                                         delivery_time:241)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("deve ser menor ou igual a 240")
      end
      it 'verdadeiro quando prazo é igual a 240' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:100, 
                                                         delivery_time:240)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:2, max_distance:1, 
                                                         delivery_time:120)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima não é um número inteiro' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:'a', max_distance:10, 
                                                         delivery_time:120)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:'a', 
                                                         delivery_time:120)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando prazo não é um número inteiro' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:10, 
                                                         delivery_time:'b')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:delivery_time)).to be true  
        expect(shipping_method.errors[:delivery_time]).to include("não é um número")
      end
      it 'falso quando distância máxima do intervalo atual é maior que distância mínima do pŕoximo' do
        # Arrange
        shipping_method = SecondDeliveryTimeDistance.new(min_distance:20, max_distance:50, 
                                              delivery_time:'b')
        second_shipping_method = SecondDeliveryTimeDistance.new(min_distance:1, max_distance:21, 
                                              delivery_time:'b')
        # Act
        second_shipping_method.valid?
        # Assert
        expect(second_shipping_method).not_to be_valid
      end
    end
  end
end

