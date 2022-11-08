class PriceDistance < ApplicationRecord
  belongs_to :shipping_method
  after_save :update_min_distance
  validates :min_distance, :max_distance, :price, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :min_distance, :max_distance, :price, numericality: { greater_than: 0, only_integer: true }

  private
  def update_min_distance
    pd = PriceDistance.joins(:shipping_method)
    if pd.count > 1
      last_record = pd.where("price_distances.created_at < ?", 
                          self.created_at).order("id DESC")
      if !last_record.empty?
        last_max_distance = last_record.first.max_distance 
        self.min_distance = last_max_distance + 1
      end
    end
  end
end
