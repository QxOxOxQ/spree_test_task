# frozen_string_literal: true

class ProductImportsWorker
  include Sidekiq::Worker
  def perform(import_product_id)
    ImportProducts::Create.call(import_product_id: import_product_id)
  end
end
