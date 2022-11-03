require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  describe '#valid?' do
    context 'presence' do   

      it 'falso quando nome está vazio' do
        user = User.new(name: nil)

        user.valid?

        expect(user.errors.include?(:name)).to be true  
        expect(user.errors[:name]).to include("não pode ficar em branco")
      end

      it 'falso quando email está vazio' do
        user = User.new(email: nil)

        user.valid?

        expect(user.errors.include?(:email)).to be true  
        expect(user.errors[:email]).to include("não pode ficar em branco")
      end

      it 'falso quando senha está vazia' do
        user = User.new(password: nil)

        user.valid?

        expect(user.errors.include?(:password)).to be true  
        expect(user.errors[:password]).to include("não pode ficar em branco")
      end
    end

    context 'authentication' do
      it 'falso quando domínio de e-mail é inválido' do
        user = User.new(email: 'luciana@gmail.com')

        user.valid?

        expect(user.errors.include?(:base)).to be true  
        expect(user.errors[:base]).to include("Domínio inválido, por favor verifique seu e-mail de registro.")
      end

      it 'falso quando senha tem menos de 6 caracteres' do
        user = User.new(password: '23412')

        user.valid?

        expect(user.errors.include?(:password)).to be true  
        expect(user.errors[:password]).to include("é muito curto (mínimo: 6 caracteres)")
      end

      it 'falso quando e-mail já existe' do
        user = User.create(email: 'luciana@sistemadefrete.com.br', password:'12345678', 
                           name:'Luciana')
        second_user = User.new(email:'luciana@sistemadefrete.com.br')

        second_user.valid?

        expect(second_user.errors.include?(:email)).to be true  
        expect(second_user.errors[:email]).to include("já está em uso")
      end
    end
  end
end
