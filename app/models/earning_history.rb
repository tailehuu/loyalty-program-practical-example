# frozen_string_literal: true

class EarningHistory < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :point, presence: true
  validates :point, numericality: { greater_than_or_equal_to: 0 }
end
