require 'rails_helper'

RSpec.describe SedexDez, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando taxa fixa é negativa' do
        # Arrange
        shipping_method = SedexDez.new(flat_fee: -1)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end
      it 'falso quando taxa fixa não é um número inteiro' do
        # Arrange
        shipping_method = SedexDez.new(flat_fee: 'goiaba')
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("não é um número")
      end
      it 'falso quando taxa fixa é igual a 0' do
        # Arrange
        shipping_method = SedexDez.new(flat_fee: 0)
        # Act
        shipping_method.valid?
        # Assert
        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end
    end
    it 'verdadeiro quando taxa fixa é positiva' do
      # Arrange
      shipping_method = SedexDez.new(flat_fee: 1)
      # Act
      shipping_method.valid?
      # Assert
      expect(shipping_method.errors.include?(:flat_fee)).to be false  
    end
    it 'status deve ser ativo por padrão' do 
      # Arrange
      shipping_method = SedexDez.new(flat_fee:10)
      status = SedexDez.human_enum_name(:status, shipping_method.status)
      # Act
      shipping_method.valid?
      # Assert
      expect(status).to eq 'Ativo' 
    end
  end
end