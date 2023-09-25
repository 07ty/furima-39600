class CreateDeliveryDates < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_dates do |t|

      t.timestamps
    end
  end
end
