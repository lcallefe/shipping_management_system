require 'rails_helper'

RSpec.describe SecondPriceWeight, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:10, max_weight:20, 
                                                price:nil)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando peso mínimo está vazio' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:nil, max_weight:20, 
                                                price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando peso máximo está vazio' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:5, max_weight:nil, 
                                                price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:10, max_weight:20, 
                                                price:0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:10, max_weight:20, 
                                                price:-1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:20, 
                                                price:39)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é negativo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:-1, max_weight:20, 
                                                price:15)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso mínimo é igual a 0' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:0, max_weight:20, 
                                                price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso mínimo é positivo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:20, 
                                                price:5)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be false 
      end
      it 'falso quando peso máximo é negativo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:-1, 
                                                price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é igual a 0' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:0, 
                                                price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso máximo é positivo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:0, max_weight:49, 
                                                price:20)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando peso máximo é maior que 50' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:51, 
                                                price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando peso máximo é igual a 50' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:50, 
                                                price:30)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando preço é maior que 40' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:100, 
                                                price:41)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 40")
      end
      it 'verdadeiro quando preço é igual a 40' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:100, 
                                                price:40)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é maior que peso máximo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:2, max_weight:1, 
                                                price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 1")
      end
      it 'falso quando peso mínimo é igual a peso máximo' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:2, max_weight:2, 
                                                price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 2")
      end
      it 'falso quando peso mínimo não é um número inteiro' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:'a', max_weight:10, 
                                                price:45)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não é um número")
      end
      it 'falso quando peso máximo não é um número inteiro' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:'a', 
                                                price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        # Arrange
        shipping_method = SecondPriceWeight.new(min_weight:1, max_weight:10, 
                                                price:'b')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        # Arrange
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SecondPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:2, sedex_id:sedex.id)
        second_shipping_method = SecondPriceWeight.new(min_weight:29, max_weight:31, 
                                                       price:3, sedex_id:sedex.id)
        # Act
        
        # Assert
        expect(SecondPriceWeight.where(id:second_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        # Arrange
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SecondPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:2, sedex_id:sedex.id)
        second_shipping_method = SecondPriceWeight.new(min_weight:31, max_weight:40, 
                                                       price:1, sedex_id:sedex.id)
        # Act
        
        # Assert
        expect(SecondPriceWeight.where(id:second_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        # Arrange
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SecondPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:1, sedex_id: sedex.id)
        second_shipping_method = SecondPriceWeight.create!(min_weight:31, max_weight:40, 
                                                           price:1, 
                                                           sedex_id: sedex.id)
        # Act

        # Assert
        expect(SecondPriceWeight.where(id:second_shipping_method.id )).not_to exist
      end
      it 'falso quando peso máximo é atualizado para valor superior ao peso mínimo do pŕoximo intervalo' do
        # Arrange
        sedex = Sedex.create!(flat_fee:1)
        shipping_method = SecondPriceWeight.create!(min_weight:20, max_weight:30, 
                                                    price:1, sedex_id: sedex.id)
        second_shipping_method = SecondPriceWeight.create!(min_weight:31, max_weight:40, 
                                                           price:2, sedex_id:sedex.id)
        # Act
        shipping_method.update(max_weight:32)                                                        
        # Assert
        expect(SecondPriceWeight.where(id:second_shipping_method.id )).not_to exist
      end
    end
  end
end

