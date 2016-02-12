# This service will load the database with information from 
# Landing Jobs Service
#
require 'landing_jobs_service'

class CompanyService
  
  def initialize
    @landing_jobs = LandingJobsService.new
  end

  def load_companies
    page = 0
    loop do 
      page+=1
      companies = @landing_jobs.get_companies(page)
      break if companies.empty?
      companies.reject! do |company|
        Company.where(id:company['id']).exists?
      end
      Company.create(companies)
    end
  end
end
