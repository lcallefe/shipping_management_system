class WorkOrder < ApplicationRecord
  has_one :expressa
  has_one :sedex_dez
  has_one :sedex
  has_one :vehicle
  validates :street, :city, :state, :number, :customer_name, :customer_cpf, presence: true
  validates :customer_phone_numer, :product_name,:product_weight, :sku, presence: true
  validates :warehouse_city, :warehouse_number,:warehouse_state, :warehouse_street, :distance, presence: true
  validates :customer_cpf, length: { is: 11 }
  validates :product_weight, :distance, numericality: { greater_than: 0 }
  validate :check_address
  validates :delay_reason, presence: true, if: :check_delay_reason?
  enum status: { pendente: 0, em_progresso: 1, encerrada_no_prazo: 3, encerrada_em_atraso: 4 }
  before_create :generate_code

  
  private
  def generate_code
    self.code = SecureRandom.alphanumeric(15).upcase
  end

  def full_warehouse_address  
    "#{warehouse_street}, #{warehouse_number}, #{warehouse_city} - #{warehouse_state}"
  end  

  def full_customer_address  
    "#{street}, #{number}, #{city} - #{state}"
  end 

  def check_address  
    if street == warehouse_street && number == warehouse_number && city == warehouse_city && state == warehouse_state
      errors.add(:street, " do cliente deve ser diferente do destinatário")
    end
  end 
  def check_delay_reason? 
    !self.id.nil? && !self.shipping_expected_date.nil? && Date.today > self.shipping_expected_date
  end
end
