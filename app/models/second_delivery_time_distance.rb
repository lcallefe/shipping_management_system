class SecondDeliveryTimeDistance < ApplicationRecord
  belongs_to :sedex
  after_initialize :set_defaults
  after_save :update_min_distance
  validates :min_distance, :max_distance, :delivery_time, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :min_distance, :max_distance, :delivery_time, numericality: { greater_than: 0 }
  validates :delivery_time, numericality: { less_than_or_equal_to: 240 }
  validates :max_distance, numericality: { less_than_or_equal_to: 500 }
  validates :min_distance, :max_distance, :delivery_time, numericality: { only_integer: true }
 
  private
  def set_defaults
    self.sedex_id ||= 1
  end 

  def update_min_distance
    if SecondDeliveryTimeDistance.count > 1
      last_max_distance = SecondDeliveryTimeDistance.order(:id).limit(1).offset(SecondDeliveryTimeDistance.count-2).take.max_distance 
      self.min_distance = last_max_distance + 1
    end
  end 
end


