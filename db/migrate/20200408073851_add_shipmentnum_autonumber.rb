class AddShipmentnumAutonumber < ActiveRecord::Migration[6.0]
  def change
=begin     reversible do |dir|
      change_column :shipments, :shipmentnum, 'integer USING CAST(shipmentnum AS integer)'
      dir.up { execute "CREATE SEQUENCE shipmentnum_seq OWNED BY shipments.shipmentnum INCREMENT BY 633 START WITH 416574"
        execute "ALTER TABLE shipments ALTER COLUMN shipmentnum SET DEFAULT NEXTVAL('shipmentnum_seq');"
        }
    end
=end
  end
end
