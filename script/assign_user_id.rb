def script
	puts "CHeck"
	@posts = Post.all
	puts @posts
	@posts.each do |p|
		if (p.id.to_i % 3 == 0)
			p.user_id = 3
			p.save!
			puts "3"
		elsif (p.id.to_i % 3 == 2)
			p.user_id = 2
			p.save!
			puts "2"
		else
			p.user_id = 1
			p.save!
			puts "1"
		end
	end
end

script