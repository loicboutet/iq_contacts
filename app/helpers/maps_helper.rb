module MapsHelper

  def geo_location
    if session["geo_location"].present?
      loc = session["geo_location"]
      return [loc.lat, loc.lng].to_s.html_safe
    else
      return ["48.856614", "2.3522219"].to_s.html_safe # Paris localization
    end
  end
end
