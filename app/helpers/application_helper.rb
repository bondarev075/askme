module ApplicationHelper
  def user_avatar(user)
    if user.avatar_link.present?
      user.avatar_link
    else
      asset_path 'avatar.jpg'
    end
  end
end
