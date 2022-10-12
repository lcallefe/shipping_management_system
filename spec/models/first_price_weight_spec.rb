require 'rails_helper'

RSpec.describe FirstPriceWeight, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:nil)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando peso mínimo está vazio' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:nil, max_weight:20, 
                                                price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando peso máximo está vazio' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:5, max_weight:nil, 
                                               price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:-1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:69)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é negativo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:-1, max_weight:20, 
                                               price:15)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso mínimo é igual a 0' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:0, max_weight:20, 
                                               price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso mínimo é positivo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:20, 
                                               price:5)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be false 
      end
      it 'falso quando peso máximo é negativo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:-1, 
                                               price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é igual a 0' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:0, 
                                               price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso máximo é positivo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:0, max_weight:99, 
                                               price:20)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando peso máximo é maior que 100' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:101, 
                                               price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser menor ou igual a 100")
      end
      it 'verdadeiro quando peso máximo é igual a 100' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:100, 
                                               price:45)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando preço é maior que 70' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:99, 
                                               price:71)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 70")
      end
      it 'verdadeiro quando preço é igual a 70' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:100, 
                                               price:70)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é maior que peso máximo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:2, max_weight:1, 
                                               price:69)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 1")
      end
      it 'falso quando peso mínimo não é um número inteiro' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:'a', max_weight:10, 
                                               price:45)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não é um número")
      end
      it 'falso quando peso máximo não é um número inteiro' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:'a', 
                                               price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:10, 
                                               price:'b')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando peso máximo do intervalo atual é maior que peso mínimo do pŕoximo' do
        # Arrange
        shipping_method = FirstPriceWeight.new(min_weight:25, max_weight:30, 
                                                price:69)
        second_shipping_method = FirstPriceWeight.new(min_weight:1, max_weight:26, 
                                                       price:70)
        # Act
        second_shipping_method.valid?
        # Assert
        expect(second_shipping_method).not_to be_valid
      end
    end
  end
end

