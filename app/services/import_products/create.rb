# frozen_string_literal: true

module ImportProducts
  class Create
    def self.call(import_product_id: import_product_id)
      new(import_product_id).call
    end

    def initialize(import_product_id)
      @import_product = ImportProduct.find(import_product_id)
    end

    def call
      @import_product.run!
      servis = ImportProducts::CSV.call(file: @import_product.import)
      if servis == :success
        @import_product.finish!
      else
        @import_product.finish_with_errors
        @import_product.update(error_text: servis)
      end
    end
  end
end
