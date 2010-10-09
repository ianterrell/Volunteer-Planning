class Volunteer < ActiveRecord::Base
  validates_presence_of :name, :email, :phone
  has_and_belongs_to_many :sessions
end
