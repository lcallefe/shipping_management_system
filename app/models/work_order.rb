class WorkOrder < ApplicationRecord
  has_one :expressa
  has_one :sedex_dez
  has_one :sedex
  validates :street, :city, :state, :number, :customer_name, :customer_cpf, presence: true
  validates :customer_phone_numer, :product_name,:product_weight, :sku, presence: true
  validates :warehouse_city, :warehouse_number,:warehouse_state, :warehouse_street, :distance, presence: true
  validates :customer_cpf, length: { is: 11 }
  validates :product_weight, :distance, numericality: { greater_than: 0 }
  enum status: { pendente: 0, em_progesso: 1, encerrada_no_prazo: 2, encerrada_em_atraso: 3 }

  before_validation :generate_code

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end
 
end
