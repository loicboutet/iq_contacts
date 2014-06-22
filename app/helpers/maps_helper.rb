module MapsHelper

  def geo_location
    default_loc = ["48.856614", "2.3522219"].to_s.html_safe # Paris localization
    if session["geo_location_string"].present?
      return session["geo_location_string"]
    elsif session["geo_location"].present?
      loc = session["geo_location"]
      if loc.respond_to?(:lat) && loc.respond_to?(:lng)
        # we store the array, because at the second call geo_location is just a string
        session["geo_location_string"] = [loc.lat, loc.lng].to_s.html_safe
        return session["geo_location_string"]
      else
        return default_loc
      end
    else
      return default_loc
    end
  end
end
