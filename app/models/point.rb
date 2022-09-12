# frozen_string_literal: true

class Point < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :point, presence: true
end
