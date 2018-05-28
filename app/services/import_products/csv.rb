# frozen_string_literal: true

require 'csv'

module ImportProducts
  class CSV
    def self.call(file:)
      new(file).call
    end

    def initialize(file)
      @file = file
    end

    def call
      import
    end

    private

      def import
        ::CSV.foreach(@file.path, headers: true, skip_blanks: true, col_sep: ';') do |row|
          next if row.to_h.compact.empty?
          product_hash = prepare_product(row.to_hash)
          ::Spree::Product.create!(product_hash)
        end
      end

      def prepare_product(product_hash)
        product_hash['price'].gsub!(',', '.')
        product_hash['shipping_category'] = Spree::ShippingCategory.find_or_create_by!(name: product_hash.delete('category'))
        product_hash['available_on'] = DateTime.parse(product_hash.delete('availability_date'))
        product_hash.compact!
        product_hash.select! { |column| Spree::Product.attribute_method?(column.to_s) }
      end
  end
end
