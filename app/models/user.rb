class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable
  before_validation :check_email_format

  def description
    "Olá #{name}"
  end

  private
  def check_email_format
    if !self.email.end_with? '@sistemadefrete.com.br' || self.email.length <= 22
      errors.add(:base, "Domínio inválido, por favor verifique seu e-mail de registro.")
    end
  end


end
