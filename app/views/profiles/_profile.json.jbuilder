json.extract! profile, :id, :role, :balance, :name, :pic_profile, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
