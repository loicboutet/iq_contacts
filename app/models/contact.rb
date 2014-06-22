class Contact < ActiveRecord::Base
  include AlgoliaSearch
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable
  acts_as_mappable :default_units => :kms,
                   :auto_geocode=>{:field=>:address,
                                   :error_message=> I18n.t("errors.could_not_geocode")}

  validates_presence_of :first_name, :last_name
  after_save :algolia_index

  algoliasearch per_environment: true do
    attribute :first_name, :last_name, :company, :address_street, :address_city
    attribute :tag_string do
      tag_list.join(",")
    end

    attributesToIndex ['first_name', 'last_name',
      'unordered(company)', 'unordered(address_street)', 'unordered(address_city)',
       'unordered(tag_string)']

    customRanking ["desc(last_name)", "desc(first_name)"]
  end

  def address
    "#{address_street}, #{address_city}, France"
  end

  # small turn around because algolia didn't update correctly
  # when only the tags where updated
  def algolia_index
    self.tag_list # forcing tag_list reload
    self.index!
  end
end
