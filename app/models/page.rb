class Page < ActiveRecord::Base

	#uncomment if it doesn't follow the naming convention
	belongs_to :subject#, {:foreign_key => "subject_id"}
	has_many :sections
	has_and_belongs_to_many :editors, :class_name => "AdminUser"

end
