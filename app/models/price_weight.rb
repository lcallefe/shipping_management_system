class PriceWeight < ApplicationRecord
  belongs_to :shipping_method
  validates :min_weight, :max_weight, :price, :presence => true
  before_create :update_min_weight
  validates :min_weight, :max_weight, :price, :presence => true
  validates :min_weight, comparison: { less_than: :max_weight}
  validates :min_weight, :max_weight, numericality: { greater_than: 0, only_integer: true }
  validates :price, numericality: { greater_than: 0 }
  validate :check_weight_boundaries

  def invalid_range?  
    model = PriceWeight.all
    if model.count > 1
      model.each_with_index do |pw,i|
        if (pw.id > model[i-1].id) && (pw.price <= model[i-1].price || 
            pw.min_weight <= model[i-1].min_weight || 
            pw.min_weight <= model[i-1].max_weight) 
          pw.destroy 
          errors.add(:base, "Intervalo inválido.")
        end
      end
    end
  end

  def check_weight_boundaries  
    association = ShippingMethod.includes(:price_weights)
                                .where(price_weights: 
                                { shipping_method_id: nil })

    if !association.empty?
      shipping_method_min_weight = association.first.min_weight
      shipping_method_max_weight = association.first.max_weight
      shipping_method_max_price = association.first.max_price
      shipping_method_min_price = association.first.min_price

      if !min_weight.nil? && min_weight < shipping_method_min_weight  
        errors.add(:min_weight, "abaixo do valor mínimo estipulado da modalidade de entrega")
      elsif !max_weight.nil? && max_weight > shipping_method_max_weight
        errors.add(:max_weight, "acima do valor máximo estipulado da modalidade de entrega")
      elsif !price.nil? && price > shipping_method_max_price
        errors.add(:price, "acima do valor máximo estipulado da modalidade de entrega")
      elsif !price.nil? && price < shipping_method_min_price
        errors.add(:price, "abaixo do valor mínimo estipulado da modalidade de entrega")
      end
    end
  end

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
