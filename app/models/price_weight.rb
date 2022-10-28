class PriceWeight < ApplicationRecord
  belongs_to :shipping_method 
  validates :min_weight, :max_weight, :price, :presence => true
  after_create :update_min_weight
  after_save :validate_price_weight_values
  validates :min_weight, :max_weight, :price, :presence => true
  validates :min_weight, comparison: { less_than: :max_weight}
  validates :min_weight, :max_weight, :price, numericality: { greater_than: 0 }
  validates :min_weight, :max_weight, numericality: { only_integer: true }

  private

  def update_min_weight
    if PriceWeight.count > 1
      last_max_weight = PriceWeight.where("created_at < ?", self.created_at).order("id DESC").first.max_weight
      self.min_weight = last_max_weight + 1
    end
  end 

  def validate_price_weight_values
    model = PriceWeight.all
    if model.count > 1
      model.each_with_index do |pd,i|
        if (pd.id > model[i-1].id) && (pd.price <= model[i-1].price || pd.min_weight <= model[i-1].min_weight || pd.min_weight <= model[i-1].max_weight) 
          pd.destroy 
        end
      end
    end
  end
end
