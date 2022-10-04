class ShippingMethod < ApplicationRecord
  has_many :vehicles
  belongs_to :order
  enum status: { Ativo: 1, Inativo: 0 }  
  # before_save :concatenate_weight_and_distance
  # before_save :validate_weight_and_distance_price

  # def concatenate_weight_and_distance
  #   if !max_weight.nil?
  #     self.min_weight += "," + (max_weight.split(/,/).last.to_i+1).to_s  
  #   end
  #   if !max_distance.nil?
  #     self.min_distance += "," + (max_distance.split(/,/).last.to_i+1).to_s  
  #   end   
  # end

  # def validate_weight_and_distance_price
  #   if !weight_fee.nil?
  #     a_weight_fee = weight_fee.split(/,/)
  #     if self.weight_fee <= a_weight_fee.max
  #       # errors add
  #     else 
  #       self.weight_fee += "," + a_weight_fee.last 
  #     end  
  #   end
  #   if !distance_fee.nil?
  #     a_distance_fee = distance_fee.split(/,/)
  #     if self.distance_fee <= a_distance_fee.max
  #       # errors add
  #     else 
  #       self.distance_fee += "," + a_distance_fee.last 
  #     end  
  #   end
  # end
end

