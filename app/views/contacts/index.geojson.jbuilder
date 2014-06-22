json.array!(@contacts) do |contact|
  json.type "Feature"
  json.geometry do
    json.type "Point"
    json.coordinates [contact.lng, contact.lat]
  end
  json.properties do
    json.title "#{contact.first_name} #{contact.last_name}"
    json.set! 'marker-color', '#fc4353'
    json.set! 'marker-size', 'large'
    json.set! 'marker-symbol', 'suitcase'
  end
end
