# This service is responsible for retrieving information from Landing Jobs Api
# See https://github.com/LandingJobs/LandingJobs-api for more info

class LandingJobsService

  DEFAULT_LIMIT = 50

  def initialize(token = nil,base_url = nil)
    @api_token = token ||= Rails.application.secrets.secret_api_token
    @api_base_url = base_url ||= Rails.application.config.api_base_url
    @conn = Faraday.new(:url => @api_base_url) do |faraday|
      faraday.token_auth @api_token
      if Rails.env == 'development'
        faraday.response :logger
      end
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_companies(page=nil)
    paging = self.get_paging(page)
    self.request_api('companies.json'+paging)
  end

  def get_offers(page=nil)
    paging = self.get_paging(page)
    self.request_api('offers.json'+paging)
  end

  #TODO test id parameters
  def get_company(id)
    self.request_api('companies/'+id.to_s)
  end
  
  #TODO test id parameters
  def get_offer(id)
    self.request_api('offers/'+id.to_s)
  end

  #TODO cache response to 1 request/hour
  #TODO Test response
  def request_api(verb)
    response = @conn.get(verb)
    JSON.parse(response.body)
  end

  def get_paging(page=nil)
    paging = ''
    if page
      paging='?offset=' + (DEFAULT_LIMIT * page).to_s
    end
    paging
  end
end
