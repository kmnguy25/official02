class RemoveCarFromInvoice < ActiveRecord::Migration[6.0]
  def change
    remove_reference :invoices, :car, null: false, foreign_key: true
  end
end
