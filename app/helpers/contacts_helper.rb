module ContactsHelper

  def cache_key_with_format(model, format)
    return "" if model.blank?
    model.cache_key.to_s + format.to_s
  end

end
