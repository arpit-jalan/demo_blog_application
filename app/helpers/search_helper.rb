module SearchHelper
  def get_username(user_id)
    User.find(user_id).name
  end
end
