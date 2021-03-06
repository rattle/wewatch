module IntentionsHelper

  def user_and_comment(intention)

    text = content_tag("span", intention.user.username, :class => :username)
    text += " " + intention.comment unless intention.comment.blank?
    text
  end

end
