class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :cid
      t.float :wallet

      t.timestamps
    end
  end
end
