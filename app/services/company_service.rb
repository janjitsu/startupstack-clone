# This service will load the database with information from 
# Landing Jobs Service
#
require 'landing_jobs_service'

class CompanyService
  
  def initialize
    @landing_jobs = LandingJobsService.new
  end

  def load_companies
    Company.create(self.get_new_companies)
  end

  def get_new_companies
    companies = self.get_all_companies
    companies.reject! do |company|
      Company.where(id:company['id']).exists?
    end
    companies
  end

  def get_all_companies
    page = 0
    companies = []
    loop do 
      companies_page = @landing_jobs.get_companies(page)
      page+=1
      break if companies_page.empty?
      companies += companies_page
    end
    companies
  end
end
