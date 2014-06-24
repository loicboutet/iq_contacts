class Contact < ActiveRecord::Base
  include AlgoliaSearch
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable
  acts_as_mappable :default_units => :kms

  belongs_to :user

  validates_presence_of :first_name, :last_name, :user_id

  after_save :algolia_index
  before_validation :geocode_address


  algoliasearch per_environment: true do
    attribute :first_name, :last_name, :company, :address_street, :address_city
    attribute :tag_string do
      tag_list.join(",")
    end

    attributesToIndex ['first_name', 'last_name', 'unordered(occupation)',
      'unordered(landline_phone)', 'unordered(mobile_phone)',
      'unordered(company)', 'unordered(address_street)', 'unordered(address_city)',
       'unordered(address_country)', 'unordered(tag_string)']

    customRanking ["desc(last_name)", "desc(first_name)"]
  end

  def address
    "#{address_street}, #{address_city}, #{address_country}"
  end

private

  # small turn around because algolia didn't update correctly
  # when only the tags where updated
  def algolia_index
    self.tag_list # forcing tag_list reload
    self.index!
  end

  def geocode_address
    return if self.lat.present? && self.lng.present?
    if address_country.present? && address_city.present?
      geo=Geokit::Geocoders::MultiGeocoder.geocode (address)
      errors.add(:address, I18n.t("errors.could_not_geocode")) if !geo.success
      self.lat, self.lng = geo.lat,geo.lng if geo.success
    end
  end



end
