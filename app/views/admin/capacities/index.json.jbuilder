json.array!(@admin_capacities) do |admin_capacity|
  json.extract! admin_capacity, :id
  json.url admin_capacity_url(admin_capacity, format: :json)
end
