class Offer
  include Mongoid::Document
  field :_id,                 type: Integer
  field :city,                type: String
  field :company_id,          type: Integer
  field :country_code,        type: String
  field :country_name,        type: String
  field :currency_code,       type: String
  field :expires_at,          type: Date
  field :main_requirements,   type: String
  field :nice_to_have,        type: String
  field :perks,               type: String
  field :first_published_at,  type: Date
  field :referral_value,      type: String
  field :relocation_paid,     type: Mongoid::Boolean
  field :role_description,    type: String
  field :salary_low,          type: Integer
  field :salary_high,         type: Integer
  field :title,               type: String
  field :work_from_home,      type: Mongoid::Boolean
  field :created_at,          type: Date
  field :updated_at,          type: Date
  field :type,                type: String
  field :remote,              type: Mongoid::Boolean
  field :tags,                type: Array
  field :url,                 type: String

  belongs_to :company, class_name: "Company", inverse_of: :offers

  #common queries
  scope :with_tags, -> (tags) { all_in(:tags => tags) }

  def self.get_tags_count
    #self.collection.aggregate([
    #  {"$group"=>{"_id"=>"$tags","c"=>{"$sum"=>1}}},
    #  {"$unwind":"$_id"},
    #  {"$group":{"_id":"$_id","c":{"$sum":"$c"}}},{"$sort":{"c":-1}}
    #])
    self.collection.aggregate([ 
      {"$unwind":"$tags"}, 
      {"$group"=>{"_id"=>"$tags","c"=>{"$sum"=>1}}},
      {"$sort":{"c":-1}} 
    ])
  end
end


