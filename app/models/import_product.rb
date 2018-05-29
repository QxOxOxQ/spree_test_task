# frozen_string_literal: true

class ImportProduct < ApplicationRecord
  include AASM
  has_attached_file :import,
                    path: ':rails_root/public/:rails_env/:id/:filename'
  validates :import, attachment_presence: true
  validates_attachment_content_type :import,
                                    content_type: %w(text/plain text/csv application/vnd.ms-excel)

  aasm column: 'state' do
    state :waiting, initial: true
    state :running, :done, :done_with_errors

    event :run do
      transitions from: :waiting, to: :running
    end

    event :finish do
      transitions from: :running, to: :done
    end

    event :finish_with_errors do
      transitions from: :running, to: :done_with_errors
    end
  end
end
