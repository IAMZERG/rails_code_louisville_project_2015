json.array!(@cards) do |card|
  json.extract! card, :id, :quantity, :name
  json.url card_url(card, format: :json)
end
