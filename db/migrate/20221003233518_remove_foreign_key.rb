class RemoveForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_reference :shipping_methods, :vehicle, index: true, foreign_key: true
  end
end
