class AddErrorsToImportProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :import_products, :error_text, :text
  end
end
