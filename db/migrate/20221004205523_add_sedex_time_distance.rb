class AddSedexTimeDistance < ActiveRecord::Migration[7.0]
  def change
    add_reference :first_delivery_time_distances, :sedex_dez, index: true
    add_reference :second_delivery_time_distances, :sedex, index: true
    add_reference :third_delivery_time_distances, :expressa, index: true
    add_reference :first_price_distances, :sedex_dez, index: true
    add_reference :second_price_distances, :sedex, index: true
    add_reference :third_price_distances, :expressa, index: true
    add_reference :first_price_weights, :sedex_dez, index: true
    add_reference :second_price_weights, :sedex, index: true
    add_reference :third_price_weights, :expressa, index: true
    add_reference :vehicles, :sedex_dez, index: true
    add_reference :vehicles, :sedex, index: true
    add_reference :vehicles, :expressa, index: true
    add_reference :sedex_dezs, :work_order, index: true
    add_reference :sedexes, :work_order, index: true
    add_reference :expressas, :work_order, index: true
  end
end
