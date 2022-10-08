class ThirdDeliveryTimeDistance < ApplicationRecord
  belongs_to :expressa
  after_initialize :set_defaults
  after_save :update_min_distance
  validates :min_distance, :max_distance, :delivery_time, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :min_distance, :max_distance, :delivery_time, numericality: { greater_than: 0 }
  validates :delivery_time, numericality: { less_than_or_equal_to: 48 }
  validates :max_distance, numericality: { less_than_or_equal_to: 50 }
  validates :min_distance, :max_distance, :delivery_time, numericality: { greater_than: 0 }
  validates :min_distance, :max_distance, :delivery_time, numericality: { only_integer: true }
 
  private
  def set_defaults
    self.expressa_id ||= 1
  end 

  def update_min_distance
    if ThirdDeliveryTimeDistance.count > 1
      last_max_distance = ThirdDeliveryTimeDistance.order(:id).limit(1).offset(ThirdDeliveryTimeDistance.count-2).take.max_distance 
      self.min_distance = last_max_distance + 1
    end
  end 
 
  # possui prazo menor dentre as três modalidades de entrega
  def validate_value_delivery_time
    if delivery_time > 72
      errors.add(:delivery_time, "deve ser menor ou igual .")


    end

  end
end


