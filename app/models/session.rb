class Session < ActiveRecord::Base
  validates_presence_of :name, :limit
  validates_numericality_of :limit
  has_and_belongs_to_many :volunteers
  
  default_scope order(:name)
  
  def filled?
    volunteers.count >= limit
  end
end
