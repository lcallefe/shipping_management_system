require 'rails_helper'

RSpec.describe SecondPriceDistance, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:10, max_distance:20, 
                                                  price:nil)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando distância mínima está vazia' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:nil, max_distance:20, 
                                                  price:13)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando distância máxima está vazia' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:5, max_distance:nil, 
                                                  price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:10, max_distance:20, 
                                                  price:0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:10, max_distance:20, 
                                                  price:-1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:10, max_distance:20, 
                                                  price:12)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando distância mínima é negativa' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:-1, max_distance:20, 
                                                  price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância mínima é igual a 0' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:0, max_distance:20, 
                                                  price:20)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância mínima é positiva' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:20, 
                                                  price:38)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be false 
      end
      it 'falso quando distância máxima é negativa' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:-1, 
                                                  price:33)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'falso quando distância máxima é igual a 0' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:0, 
                                                  price:33)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando distância máxima é positiva' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:0, max_distance:1, 
                                                  price:32)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando distância máxima é maior que 500' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:501, 
                                                  price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("deve ser menor ou igual a 500")
      end
      it 'verdadeiro quando distância máxima é igual a 500' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:500, 
                                                  price:30)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be false  
      end
      it 'falso quando preço é maior que 40' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:100, 
                                                  price:41)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 40")
      end
      it 'verdadeiro quando preço é igual a 40' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:100, 
                                                  price:40)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando distância mínima é maior que distância máxima' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:2, max_distance:1, 
                                                  price:32)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("deve ser menor que 1")
      end
      it 'falso quando distância mínima não é um número inteiro' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:'a', max_distance:10, 
                                                  price:45)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_distance)).to be true  
        expect(shipping_method.errors[:min_distance]).to include("não é um número")
      end
      it 'falso quando distância máxima não é um número inteiro' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:'a', 
                                                  price:39)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_distance)).to be true  
        expect(shipping_method.errors[:max_distance]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:10, 
                                                  price:'b')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando distância máxima do intervalo atual é maior que distância mínima do pŕoximo' do
        # Arrange
        shipping_method = SecondPriceDistance.new(min_distance:20, max_distance:50, 
                                                  price:'b')
        second_shipping_method = SecondPriceDistance.new(min_distance:1, max_distance:21, 
                                                         price:'b')
        # Act
        second_shipping_method.valid?
        # Assert
        expect(second_shipping_method).not_to be_valid
      end
    end
  end
end

