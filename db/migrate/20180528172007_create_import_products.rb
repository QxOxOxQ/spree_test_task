class CreateImportProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :import_products do |t|
      t.string :state

      t.timestamps
    end
  end
end
