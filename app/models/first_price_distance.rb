class FirstPriceDistance < ApplicationRecord
  belongs_to :sedex_dez 
  after_initialize :set_defaults
  after_create :update_min_distance
  after_save :validate_price_distance_values
  validates :min_distance, :max_distance, :price, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :max_distance, numericality: { less_than_or_equal_to: 1000 }
  validates :price, numericality: { less_than_or_equal_to: 70 }
  validates :min_distance, :max_distance, :price, numericality: { greater_than: 0 }
  validates :min_distance, :max_distance, :price, numericality: { only_integer: true }

  private
  def set_defaults
    self.sedex_dez_id ||= 1
  end   

  def update_min_distance
    if FirstPriceDistance.count > 1
      last_max_distance = FirstPriceDistance.where("created_at < ?", self.created_at).order("id DESC").first.max_distance
      self.min_distance = last_max_distance + 1
    end
  end  

  def validate_price_distance_values
    model = FirstPriceDistance.all
    if model.count > 1
      model.each_with_index do |pd,i|
        if (pd.id > model[i-1].id) && (pd.price <= model[i-1].price || pd.min_distance <= model[i-1].min_distance || pd.min_distance <= model[i-1].max_distance) 
          pd.destroy 
        end
      end
    end
  end
end
