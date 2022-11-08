class PriceWeight < ApplicationRecord
  belongs_to :shipping_method
  validates :min_weight, :max_weight, :price, :presence => true
  before_create :update_min_weight
  validates :min_weight, comparison: { less_than: :max_weight}
  validates :min_weight, :max_weight, numericality: { greater_than: 0, only_integer: true }
  validates :price, numericality: { greater_than: 0 }

  private
  def update_min_weight
    pw = PriceWeight.joins(:shipping_method)
    if pw.count > 1
      last_record = pw.where("price_weights.created_at < ?", 
                          self.created_at).order("id DESC")
      if !last_record.empty?
        last_max_weight = last_record.first.max_weight 
        self.min_weight = last_max_weight + 1
      end
    end
  end
end
