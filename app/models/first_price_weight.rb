class FirstPriceWeight < ApplicationRecord
  belongs_to :sedex_dez 
  after_initialize :set_defaults
  validates :min_weight, :max_weight, :price, :presence => true
  after_save :update_min_weight
  validates :min_weight, :max_weight, :price, :presence => true
  validates :min_weight, comparison: { less_than: :max_weight }
  validates :price, numericality: { less_than_or_equal_to: 70 }
  validates :max_weight, numericality: { less_than_or_equal_to: 100 }
  validates :min_weight, :max_weight, :price, numericality: { greater_than: 0 }
  validates :min_weight, :max_weight, numericality: { only_integer: true }

  private
  def set_defaults
    self.sedex_dez_id ||= 1
  end  
  
  def update_min_weight
    if FirstPriceWeight.count > 1
      last_max_weight = FirstPriceWeight.order(:id).limit(1).offset(FirstPriceWeight.count-2).take.max_weight 
      self.min_weight = last_max_weight + 1
    end
  end 
end
