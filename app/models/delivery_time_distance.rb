class DeliveryTimeDistance < ApplicationRecord
  belongs_to :shipping_method
  after_create :udtate_min_distance
  validates :min_distance, :max_distance, :delivery_time, :presence => true
  validates :min_distance, comparison: { less_than: :max_distance }
  validates :min_distance, :max_distance, :delivery_time, numericality: { greater_than: 0 }
  validates :min_distance, :max_distance, :delivery_time, numericality: { only_integer: true }
  validate :check_distance_boundaries
  validate :invalid_range?

  def invalid_range?  
    model = DeliveryTimeDistance.all
    if model.count > 1
      model.each_with_index do |dt,i|
        if (dt.id > model[i-1].id) && 
           (dt.delivery_time <= model[i-1].delivery_time || 
            dt.min_distance <= model[i-1].min_distance || 
            dt.min_distance <= model[i-1].max_distance) 
          errors.add(:base, "Intervalo inválido.")
        end
      end
    end
  end
  
  def check_distance_boundaries  
    association = ShippingMethod.includes(:delivery_time_distances)
                                .where(delivery_time_distances: 
                                { shipping_method_id: nil })
    if !association.empty?
      shipping_method_min_distance = association.first.min_distance
      shipping_method_max_distance = association.first.max_distance
      shipping_method_min_delivery_time = association.first.min_delivery_time
      shipping_method_max_delivery_time = association.first.max_delivery_time

      if !min_distance.nil? && min_distance < shipping_method_min_distance  
        errors.add(:min_distance, "abaixo do valor mínimo estipulado da modalidade de entrega")
      elsif !max_distance.nil? && max_distance > shipping_method_max_distance
        errors.add(:max_distance, "acima do valor máximo estipulado da modalidade de entrega")
      elsif !delivery_time.nil? && delivery_time > shipping_method_max_delivery_time
        errors.add(:delivery_time, "acima do valor máximo estipulado da modalidade de entrega")
      elsif !delivery_time.nil? && delivery_time < shipping_method_min_delivery_time
        errors.add(:delivery_time, "abaixo do valor mínimo estipulado da modalidade de entrega")
      end
    end
  end 

  private
  def udtate_min_distance
    dt = DeliveryTimeDistance.joins(:shipping_method)
    if dt.count > 1
      last_max_distance = dt.where("delivery_time_distances.created_at < ?", 
                                   self.created_at).order("id DESC")
                                  .first.max_distance
      self.min_distance = last_max_distance + 1
    end
  end 
end


