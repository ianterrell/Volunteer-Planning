class Session < ActiveRecord::Base
  MaxVolunteers = 6

  validates_presence_of :name
  has_and_belongs_to_many :volunteers
  
  def filled?
    volunteers.count >= MaxVolunteers
  end
end
