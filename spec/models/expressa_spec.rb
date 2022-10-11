require 'rails_helper'

RSpec.describe Expressa, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando taxa fixa é negativa' do
        # Arrange
        shipping_method = Expressa.new(flat_fee: -10)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end
      it 'falso quando taxa fixa é igual a 0' do
        # Arrange
        shipping_method = Expressa.new(flat_fee: 0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end
      it 'falso quando taxa fixa não é um número inteiro' do
        # Arrange
        shipping_method = Expressa.new(flat_fee: 'goiaba')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("não é um número")
      end
    end
    it 'status deve ser ativo por padrão' do 
      # Arrange
      shipping_method = Expressa.new(flat_fee:10)
      # Act
      shipping_method.valid?
      # Assert
      expect(shipping_method.status).to eq 'ativo' 
    end
  end
end