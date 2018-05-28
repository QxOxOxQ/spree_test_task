# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportProduct, type: :model do
  let!(:csv) { File.open(File.join(Rails.root, 'spec', 'files', 'sample.csv')) }
  describe 'saving new record' do
    context 'with valid attr' do
      it 'create one new ImportProduct' do
        expect { ImportProduct.create(import: csv) }.to change { ImportProduct.count }.by(1)
      end
    end
    context 'with invalid attr' do
      let!(:pdf) { File.open(File.join(Rails.root, 'spec', 'files', 'sample.pdf')) }
      it 'does not create any new ImportProduct' do
        expect { ImportProduct.create(import: pdf) }.to_not change { ImportProduct.count }
      end
    end
  end
end
