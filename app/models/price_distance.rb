class PriceDistance < ApplicationRecord
  belongs_to :shipping_method
  after_save :update_min_distance
  validates :min_distance, :max_distance, :price, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :min_distance, :max_distance, :price, numericality: { greater_than: 0, only_integer: true }
  validate :check_distance_boundaries
  validate :invalid_range?

  def invalid_range?  
    model = PriceDistance.all
    if model.count > 1
      model.each_with_index do |pd,i|
        if (pd.id > model[i-1].id) && (pd.price <= model[i-1].price || 
            pd.min_distance <= model[i-1].min_distance || 
            pd.min_distance <= model[i-1].max_distance) 
          errors.add(:base, "Intervalo inválido.")
        end
      end
    end
  end

  def check_distance_boundaries  
    association =  ShippingMethod.includes(:price_distances)
                   .where(price_distances: 
                    { shipping_method_id: nil })
                    
    if !association.empty?
      shipping_method_min_distance = association.first.min_distance
      shipping_method_max_distance = association.first.max_distance
      shipping_method_min_price = association.first.min_price
      shipping_method_max_price = association.first.max_price

      if !min_distance.nil? && min_distance < shipping_method_min_distance  
        errors.add(:min_distance, "abaixo do valor mínimo estipulado da modalidade de entrega")
      elsif !max_distance.nil? && max_distance > shipping_method_max_distance
        errors.add(:max_distance, "acima do valor máximo estipulado da modalidade de entrega")
      elsif !price.nil? && price > shipping_method_max_price
        errors.add(:price, "acima do valor máximo estipulado da modalidade de entrega")
      elsif !price.nil? && price < shipping_method_min_price
        errors.add(:price, "abaixo do valor mínimo estipulado da modalidade de entrega")
      end
    end
  end    

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
