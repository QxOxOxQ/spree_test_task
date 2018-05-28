# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ImportProducts::CSV', type: :service do

  let!(:csv) { File.open(File.join(Rails.root, 'spec', 'files', 'sample.csv')) }

  describe '#call' do
    context 'with valid attributes' do
      before { ImportProducts::CSV.call(file: csv) }
      it('create 3 products') { expect(Spree::Product.count).to eq(3) }
    end
  end
end
