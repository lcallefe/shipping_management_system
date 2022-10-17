require 'rails_helper'

RSpec.describe SedexDezPriceWeight, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando preço está vazio' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:nil)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não pode ficar em branco")
      end
      it 'falso quando peso mínimo está vazio' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:nil)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando peso máximo está vazio' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(max_weight:nil)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não pode ficar em branco")
      end
      it 'falso quando preço é igual a 0' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:0)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'falso quando preço é negativo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:-1)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando preço é positivo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:69)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é negativo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:-1)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso mínimo é igual a 0' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:0)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso mínimo é positivo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:1)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be false 
      end
      it 'falso quando peso máximo é negativo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new( max_weight:-1)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'falso quando peso máximo é igual a 0' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(max_weight:0)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser maior que 0")
      end
      it 'verdadeiro quando peso máximo é positivo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(max_weight:99)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando peso máximo é maior que 100' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(max_weight:101)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("deve ser menor ou igual a 100")
      end
      it 'verdadeiro quando peso máximo é igual a 100' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(max_weight:100)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be false  
      end
      it 'falso quando preço é maior que 70' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:71)
                                               
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("deve ser menor ou igual a 70")
      end
      it 'verdadeiro quando preço é igual a 70' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:70)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be false  
      end
      it 'falso quando peso mínimo é maior que peso máximo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:2, max_weight:1)
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 1")
      end
      it 'falso quando peso mínimo é igual a peso máximo' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:2, max_weight:2) 
                                               
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("deve ser menor que 2")
      end
      it 'falso quando peso mínimo não é um número inteiro' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(min_weight:'a')
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:min_weight)).to be true  
        expect(shipping_method.errors[:min_weight]).to include("não é um número")
      end
      it 'falso quando peso máximo não é um número inteiro' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(max_weight:'a')
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:max_weight)).to be true  
        expect(shipping_method.errors[:max_weight]).to include("não é um número")
      end
      it 'falso quando preço não é um número inteiro' do
        # Arrange
        shipping_method = SedexDezPriceWeight.new(price:'b')
        # Act
        shipping_method.valid?
        
        expect(shipping_method.errors.include?(:price)).to be true  
        expect(shipping_method.errors[:price]).to include("não é um número")
      end
      it 'falso quando peso mínimo do intervalo atual é menor que peso máximo do anterior' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = SedexDezPriceWeight.create!(min_weight:20, max_weight:30, 
                                                   price:2, sedex_dez_id: sedex_dez.id)
        sedex_shipping_method = SedexDezPriceWeight.create!(min_weight:29, max_weight:31, 
                                                      price:3, sedex_dez_id: sedex_dez.id)
        # Act
        
        
        expect(SedexDezPriceWeight.where(id: sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é menor que preço do anterior' do
        # Arranges = 
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = SedexDezPriceWeight.create!(min_weight:20, max_weight:30, 
                                                   price:2, sedex_dez_id:sedex_dez.id)
        sedex_shipping_method = SedexDezPriceWeight.new(min_weight:31, max_weight:40, 
                                                      price:1, sedex_dez_id:sedex_dez.id)
        # Act
        
        
        expect(SedexDezPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando preço do intervalo atual é igual a preço do anterior' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = SedexDezPriceWeight.create!(min_weight:20, max_weight:30, 
                                                   price:1, sedex_dez_id: sedex_dez.id)
        sedex_shipping_method = SedexDezPriceWeight.create!(min_weight:31, max_weight:40, 
                                                    price:1, sedex_dez_id: sedex_dez.id)
        # Act
        
        
        expect(SedexDezPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
      it 'falso quando peso máximo é atualizado para valor superior à peso mínimo do pŕoximo intervalo' do
        # Arrange
        sedex_dez = SedexDez.create!(flat_fee:1)
        shipping_method = SedexDezPriceWeight.create!(min_weight:10, max_weight:20, 
                                                   price:1, sedex_dez_id:sedex_dez.id)
        sedex_shipping_method = SedexDezPriceWeight.create!(min_weight:21, max_weight:30, 
                                                      price:2, sedex_dez_id:sedex_dez.id)
        shipping_method.update(max_weight:22)                                                      
        
        expect(SedexDezPriceWeight.where(id:sedex_shipping_method.id)).not_to exist
      end
    end
  end
end

