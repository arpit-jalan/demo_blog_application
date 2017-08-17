class PostMailer < ActionMailer::Base
	default from: "no-reply@blogspot.com"

  def post_create(post)
  	@post = post
  	@user = User.find(@post.user_id)
  	mail(to: @user.email, subject: 'Congratulations!! You just created a new post.')
  end

  def post_update(post)
  	@post = post
  	mail(to: User.find(@post.user_id).email, subject: 'Your post has been updated')
  end
end