json.array!(@decklists) do |decklist|
  json.extract! decklist, :id, :name, :description
  json.url decklist_url(decklist, format: :json)
end
