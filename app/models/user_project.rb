class UserProject < ApplicationRecord
	belongs_to :user
	belongs_to :project

	def self.create_action(project_id)
		project = Project.find_by_id(project_id)
		"Assigned You to " + project.name
	end
end
