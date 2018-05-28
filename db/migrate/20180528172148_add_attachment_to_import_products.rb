class AddAttachmentToImportProducts < ActiveRecord::Migration[5.1]
  def change
    add_attachment :import_products, :import
  end
end
