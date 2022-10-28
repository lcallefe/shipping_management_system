require 'rails_helper'

RSpec.describe ShippingMethod, type: :model do
  describe '#valid?' do
    context 'numericality' do    
      it 'falso quando taxa fixa é negativa' do
        shipping_method = ShippingMethod.new(flat_fee: -1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end
      it 'falso quando taxa fixa é igual a 0' do
        shipping_method = ShippingMethod.new(flat_fee: 0)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("deve ser maior que 0")
      end
      it 'falso quando taxa fixa é positiva' do
        shipping_method = ShippingMethod.new(flat_fee: 1)

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be false  
      end
      it 'falso quando taxa fixa não é um número inteiro' do
        shipping_method = ShippingMethod.new(flat_fee: 'goiaba')

        shipping_method.valid?

        expect(shipping_method.errors.include?(:flat_fee)).to be true  
        expect(shipping_method.errors[:flat_fee]).to include("não é um número")
      end
      it 'status deve ser ativo por padrão' do 
        shipping_method = ShippingMethod.new(flat_fee:1)
        status = ShippingMethod.human_enum_name(:status, shipping_method.status)

        shipping_method.valid?

        expect(status).to eq 'Ativo'
      end
    end
  end
end