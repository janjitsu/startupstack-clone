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
end
