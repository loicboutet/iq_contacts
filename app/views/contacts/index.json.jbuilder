json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :company, :address_street, :address_city
  json.url contact_url(contact, format: :json)
end
