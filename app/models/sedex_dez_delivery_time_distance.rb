class SedexDezDeliveryTimeDistance < ApplicationRecord
  belongs_to :sedex_dez
  after_initialize :set_defaults
  after_create :update_min_distance
  after_save :validate_price_distance_distance_values
  validates :min_distance, :max_distance, :delivery_time, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :delivery_time, numericality: { less_than_or_equal_to: 120}
  validates :max_distance, numericality:  { less_than_or_equal_to: 1000 }
  validates :min_distance, :max_distance, :delivery_time, numericality: { greater_than: 0 }
  validates :min_distance, :max_distance, :delivery_time, numericality: { only_integer: true }
 
  private
  def set_defaults
    self.sedex_dez_id ||= 1
  end 

  def update_min_distance
    if SedexDezDeliveryTimeDistance.count > 1
      last_max_distance = SedexDezDeliveryTimeDistance.where("created_at < ?", self.created_at).order("id DESC").first.max_distance
      self.min_distance = last_max_distance + 1
    end
  end 

  def validate_price_distance_distance_values
    model = SedexDezDeliveryTimeDistance.all
    if model.count > 1
      model.each_with_index do |pd,i|
        if (pd.id > model[i-1].id) && (pd.delivery_time <= model[i-1].delivery_time || pd.min_distance <= model[i-1].min_distance || pd.min_distance <= model[i-1].max_distance) 
          pd.destroy 
        end
      end
    end
  end
end


