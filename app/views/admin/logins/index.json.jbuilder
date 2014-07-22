json.array!(@admin_logins) do |admin_login|
  json.extract! admin_login, :id
  json.url admin_login_url(admin_login, format: :json)
end
