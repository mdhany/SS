json.array!(@admin_turns) do |admin_turn|
  json.extract! admin_turn, :id
  json.url admin_turn_url(admin_turn, format: :json)
end
