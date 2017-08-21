class EsIndexWorker 
	include Sidekiq::Worker
	def perform(name, id)
		case name.to_s
		when "index"
		 	begin
				record = Post.find(id)
				record.__elasticsearch__.index_document
		 	rescue ActiveRecord::RecordNotFound
		 		puts "record #{id} not found"
			end	
		when "delete"
		 	client = Post.__elasticsearch__.client
			client.delete index: Post.index_name, type: Post.model_name.to_s.downcase, id: id
			puts "deleted index #{id}"
		end
	end
end