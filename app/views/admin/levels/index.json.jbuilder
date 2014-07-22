json.array!(@admin_levels) do |admin_level|
  json.extract! admin_level, :id
  json.url admin_level_url(admin_level, format: :json)
end
