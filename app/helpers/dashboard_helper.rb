module DashboardHelper
	def count_ticket(project)
		tickets = []
		project.headers.each do |header|
			tickets << header.tickets.count
		end
		tickets.sum()
	end
end
