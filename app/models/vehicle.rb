class Vehicle < ApplicationRecord
  belongs_to :shipping_method
  belongs_to :work_order, optional: true
  validates :license_plate, uniqueness: true
  validates :license_plate, format: { with: /\A[A-Z]{3}-\d{4}\z/,
    message: "não possui o formato esperado" }
  validates :fabrication_year, format: { with: /\A\d{4}\z/,
    message: "não possui o formato esperado" }
  validates :model, :brand_name, length: { minimum: 4 }
  validates :full_capacity, numericality: { greater_than: 0 }
  validates :model, :brand_name, :fabrication_year, :full_capacity, :license_plate, presence: true
  enum status: { in_progress: 2, active: 1, repair: 0 } 

  def brand_name_and_model 
    "#{brand_name} - #{model}"
  end

end


