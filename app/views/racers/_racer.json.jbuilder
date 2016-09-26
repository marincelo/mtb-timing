if user_signed_in? && current_user.admin
  json.extract! racer, :id, :first_name, :last_name, :year_of_birth, :gender, :email, :phone_number, :start_number, :created_at, :updated_at
  json.url racer_url(racer, format: :json)
else
  json.extract! racer, :id, :first_name, :last_name, :year_of_birth, :gender, :start_number, :created_at, :updated_at
  json.url racer_url(racer, format: :json)
end
