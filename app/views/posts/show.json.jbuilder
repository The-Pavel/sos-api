json.extract! @post, :id, :description, :capacity, :location, :contact_number, :is_full, :user_id, :language
json.date @post.created_at.strftime("%m/%d/%y")
json.comments @post.comments do |comment|
  json.extract! comment, :id, :nickname, :comment, :post_id
  json.date comment.created_at.strftime("%m/%d/%y")
end
