class RangeConfiguration 
  attr_accessor :min_weight, :max_weight, :min_distance, :max_distance, :price, :delivery_time
  
  def initialize(min_distance = nil, max_distance = nil, min_weight = nil, max_weight = nil, 
                 price = nil, delivery_time = nil)
    @min_distance = min_distance
    @max_distance = max_distance
    @min_weight = min_weight
    @max_weight = max_weight
    @price = price
    @delivery_time = delivery_time
  end

  def check_values
    if !@delivery_time.nil? 
      model = DeliveryTimeDistance.all
      if !invalid_range(@min_distance, @max_distance, @delivery_time, model)
        check_boundaries(model)
      end
    elsif !@min_weight.nil? 
      model = PriceWeight.all
      if !invalid_range(@min_weight, @max_weight, @price, model)
        check_boundaries(model)
      end
    else  
      model = PriceDistance.all
      if !invalid_range(@min_distance, @max_distance, @price, model)
        check_boundaries(model)
      end
    end
  end

  def invalid_range(min, max, price_or_delivery_time, model)
    if model.count > 1
      model.each_with_index do |row,index|
        if (row.id > model[index-1].id) && 
           (row.price_or_delivery_time <= model[index-1].price_or_delivery_time || 
            row.min <= model[index-1].min || 
            row.min <= model[index-1].max) 
            model.errors.add(:base, "Intervalo inválido")
          return true
        end
      end
    end
    false
  end

  def check_boundaries(model)  
    model_string = model.name.tableize
    model_sym = model_string.to_sym
    

      
      case model 
      when DeliveryTimeDistance
        association = ShippingMethod.includes(:delivery_time_distances)
                                .where(delivery_time_distances: 
                                { shipping_method_id: nil })

        shipping_method_min_delivery_time_price = association.first.min_delivery_time 
        shipping_method_max_delivery_time_price = association.first.max_delivery_time
      when PriceWeight
        shipping_method_min_delivery_time_price = association.first.min_price
        shipping_method_max_delivery_time_price = association.first.max_price

      else 
        
      end

      shipping_method_min = association.first.min
      shipping_method_max = association.first.max

      if !min.nil? && min < shipping_method_min
        model.errors.add(:min, "abaixo do valor mínimo estipulado da modalidade de entrega")
        return false
      elsif !max.nil? && max > shipping_method_max
        model.errors.add(:max, "acima do valor máximo estipulado da modalidade de entrega")
        return false
      elsif !price_or_delivery_time.nil? && price_or_delivery_time > shipping_method_min_delivery_time_price
        model.errors.add(:price_or_delivery_time, "acima do valor máximo estipulado da modalidade de entrega")
        return false
      elsif !price_or_delivery_time.nil? && price_or_delivery_time < shipping_method_max_delivery_time_price
        model.errors.add(:price_or_delivery_time, "abaixo do valor mínimo estipulado da modalidade de entrega")
        return false
      end
    end
    true
  end

  def update_min(model, model_instance, max, min)
    model_string = model.name
    model_sym = model_string.tableize.to_sym

    rows = model.joins(:shipping_method)
    if rows.count > 1
      last_record = rows.where("model_sym.created_at < ?", 
                         model_instance.created_at).order("id DESC")
      if !last_record.empty?
        last_max = last_record.first.max
        model_instance.min = last_max + 1
      end
    end
  end

  
end
