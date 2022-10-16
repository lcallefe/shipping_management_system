require 'rails_helper'

RSpec.describe ExpressaPriceWeight, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:nil)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando peso mínimo está vazio' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:nil, max_weight:20, 
                                               price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando peso máximo está vazio' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:5, max_weight:nil, 
                                               price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:-1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:10, max_weight:20, 
                                               price:49)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é negativo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:-1, max_weight:20, 
                                               price:15)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso mínimo é igual a 0' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:0, max_weight:20, 
                                               price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso mínimo é positivo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:20, 
                                               price:5)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be false 
      end
      it 'falso quando peso máximo é negativo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:-1, 
                                               price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é igual a 0' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:0, 
                                               price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso máximo é positivo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:0, max_weight:1, 
                                               price:20)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando peso máximo é maior que 30' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:31, 
                                               price:24)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser menor ou igual a 30")
      end
      it 'verdadeiro quando peso máximo é igual a 30' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:30, 
                                               price:30)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando preço é maior que 50' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:20, 
                                               price:51)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 50")
      end
      it 'verdadeiro quando preço é igual a 50' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:30, 
                                               price:50)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é maior que peso máximo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:2, max_weight:1, 
                                               price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 1")
      end
      it 'falso quando peso mínimo é igual a peso máximo' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:2, max_weight:2, 
                                               price:29)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 2")
      end
      it 'falso quando peso mínimo não é um número inteiro' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:'a', max_weight:10, 
                                                 price:45)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não é um número")
      end
      it 'falso quando peso máximo não é um número inteiro' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:'a', 
                                               price:10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        # Arrange
        shipping_method = ExpressaPriceWeight.new(min_weight:1, max_weight:10, 
                                               price:'b')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        # Arrange
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceWeight.create!(min_weight:15, max_weight:17, 
                                                   price:2, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaPriceWeight.create!(min_weight:16, max_weight:29, 
                                                          price:3, 
                                                          expressa_id: expressa.id)
        # Act

        # Assert
        expect(ExpressaPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        # Arrange
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceWeight.create!(min_weight:10, max_weight:20, 
                                                   price:2, expressa_id: expressa.id)
        sedex_shipping_method = ExpressaPriceWeight.create!(min_weight:21, max_weight:22, 
                                                          price:1, 
                                                          expressa_id: expressa.id)
        # Act
        
        # Assert
        expect(ExpressaPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        # Arrange
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceWeight.create!(min_weight:20, max_weight:28, 
                                                   price:1, expressa_id:expressa.id)
        sedex_shipping_method = ExpressaPriceWeight.create!(min_weight:20, max_weight:28, 
                                                      price:1, expressa_id: expressa.id)
        # Act
        
        # Assert
        expect(ExpressaPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando peso máximo é atualizado para valor superior ao peso mínimo do pŕoximo intervalo' do
        # Arrange
        expressa = Expressa.create!(flat_fee: 1)
        shipping_method = ExpressaPriceWeight.create!(min_weight:10, max_weight:20, 
                                                   price:1, expressa_id:expressa.id)
        sedex_shipping_method = ExpressaPriceWeight.create!(min_weight:21, max_weight:30, 
                                                          price:2, expressa_id:expressa.id)
        # Act
        shipping_method.update(max_weight:22) 

        # Assert
        expect(ExpressaPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
    end
  end
end
