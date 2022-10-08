class SecondPriceWeight < ApplicationRecord
  belongs_to :sedex 
  after_initialize :set_defaults
  validates :min_weight, :max_weight, :price, :presence => true
  after_save :update_min_weight
  validates :min_weight, :max_weight, :price, :presence => true
  validates :min_weight, comparison: { less_than: :max_weight }
  validates :price, numericality: { less_than_or_equal_to: 40 }
  validates :max_weight, numericality: { less_than_or_equal_to: 50 }
  validates :min_weight, :max_weight, :price, numericality: { greater_than: 0 }
  validates :min_weight, :max_weight, numericality: { only_integer: true }

  private
  def set_defaults
    self.sedex_id ||= 1
  end  
  
  def update_min_weight
    if SecondPriceWeight.count > 1
      last_max_weight = SecondPriceWeight.order(:id).limit(1).offset(SecondPriceWeight.count-2).take.max_weight 
      self.min_weight = last_max_weight + 1
    end
  end 
end
