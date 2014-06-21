class Contact < ActiveRecord::Base
  include AlgoliaSearch
  validates_presence_of :first_name, :last_name

  algoliasearch per_environment: true do
    customRanking ['desc(last_name)', 'desc(first_name)']
  end

end
