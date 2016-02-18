class Company
  include Mongoid::Document
  field :_id,         type: Integer
  field :name,        type: String
  field :short_pitch, type: String
  field :description, type: String
  field :logo_url,    type: String
  field :website_url, type: String
  field :created_at,  type: Date
  field :updated_at,  type: Date

  has_many :offers, class_name: "Offer", inverse_of: :company

  def self.with_tags(tags)
    self.collection.find(
      {'_id':{"$in":Offer.with_tags(tags).distinct('company_id')}}
    )
  end
end
