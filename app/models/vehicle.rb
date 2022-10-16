class Vehicle < ApplicationRecord
  belongs_to :expressa, optional:true
  belongs_to :sedex_dez, optional:true
  belongs_to :sedex, optional: true
  belongs_to :work_order, optional: true
  validates :license_plate, uniqueness: true
  validates :license_plate, format: { with: /\A[A-Z]{3}-\d{4}\z/,
    message: "não possui o formato esperado" }
  validates :fabrication_year, format: { with: /\A\d{4}\z/,
    message: "não possui o formato esperado" }
  validates :model, :brand_name, length: { minimum: 4 }
  validates :full_capacity, numericality: { greater_than: 0 }
  validates :model, :brand_name, :fabrication_year, :full_capacity, :license_plate, presence: true
  enum status: { em_entrega: 2, ativo: 1, em_manutenção: 0 } 

  def brand_name_and_model 
    "#{brand_name} - #{model}"
  end
end


