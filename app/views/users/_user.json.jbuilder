json.extract! user, :id, :name, :user_id, :credit_card_no, :address, :mobile, :email, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
