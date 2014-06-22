module ApplicationHelper

  def logout_link(&block)
    content = capture(&block)
    link_to(content, destroy_user_session_path, :method => :delete)
  end
end
