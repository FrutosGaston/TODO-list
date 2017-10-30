class Task < ApplicationRecord
  belongs_to :user

  validates_length_of :description, minimum: 5
  validates_presence_of :user
end
