class Session < ActiveRecord::Base
  MaxVolunteers = 7

  validates_presence_of :name
  has_and_belongs_to_many :volunteers
  
  def filled?
    volunteers.count >= MaxVolunteers
  end
end
