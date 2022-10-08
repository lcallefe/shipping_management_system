class ThirdPriceWeight < ApplicationRecord
  belongs_to :expressa 
  after_initialize :set_defaults
  validates :min_weight, :max_weight, :price, :presence => true
  after_save :update_min_weight
  validates :min_weight, :max_weight, :price, :presence => true
  validates :min_weight, comparison: { less_than: :max_weight}
  validates :price, numericality: { less_than_or_equal_to: 50 }
  validates :max_weight, numericality: { less_than_or_equal_to: 30 }
  validates :min_weight, :max_weight, :price, numericality: { greater_than: 0 }
  validates :min_weight, :max_weight, numericality: { only_integer: true }

  private
  def set_defaults
    self.expressa_id ||= 1
  end  
  
  def update_min_weight
    if ThirdPriceWeight.count > 1
      last_max_weight = ThirdPriceWeight.order(:id).limit(1).offset(ThirdPriceWeight.count-2).take.max_weight 
      self.min_weight = last_max_weight + 1
    end
  end 
end
