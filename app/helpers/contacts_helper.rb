module ContactsHelper

  def cache_key_with_format(model, format)
    return "" if model.blank?
    return model.cache_key.to_s + format.to_s + I18n.locale
  end

end
