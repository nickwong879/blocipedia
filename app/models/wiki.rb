class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators


#scope :visible_to, -> (user) { user.role == 'premium' ? all : where(private: false) }

def collaborators
	Collaborator.where(user_id: id)
end

#def users
#	collaborators.users
#end

def private?
	
	private == true

end

def public?

	private == false

end


end
