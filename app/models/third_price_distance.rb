class ThirdPriceDistance < ApplicationRecord
  belongs_to :expressa 
  after_initialize :set_defaults
  after_save :update_min_distance
  validates :min_distance, :max_distance, :price, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :max_distance, numericality: { less_than_or_equal_to: 50 }
  validates :price, numericality: { less_than_or_equal_to: 50 }
  validates :min_distance, :max_distance, :price, numericality: { greater_than: 0 }
  validates :min_distance, :max_distance, :price, numericality: { only_integer: true }

  private
  def set_defaults
    self.expressa_id ||= 1
  end   

  def update_min_distance
    if ThirdPriceDistance.count > 1
      last_max_distance = ThirdPriceDistance.order(:id).limit(1).offset(ThirdPriceDistance.count-2).take.max_distance 
      self.min_distance = last_max_distance + 1
    end
  end  
end
