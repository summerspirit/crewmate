class Project

  validates_length_of :name, :minimum => 3
  validates_uniqueness_of :permalink, :case_sensitive => false
  validates_format_of :permalink, :with => /^[a-z0-9_\-]{5,}$/

  validates_presence_of :user         # A project _needs_ an owner
  validates_associated :people        # And will only accept valid people
  
  validates_each :user, :on => :update do |record, attr, value|
    record.errors.add attr, "doesn't even belong to the project!" unless record.users.collect{ |u| u.id }.include? record.user.id
  end

end