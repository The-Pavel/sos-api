json.posts do
  json.array! @posts do |post|
    json.extract! post, :description, :capacity, :location, :contact_number, :is_full, :user_id, :language
  end
end
