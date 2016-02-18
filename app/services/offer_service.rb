# This service will load the database with information from 
# Landing Jobs Service
#
require 'landing_jobs_service'

class OfferService
  
  def initialize
    @landing_jobs = LandingJobsService.new
  end

  def load_offers
    Offer.create(self.get_new_offers)
  end

  def get_new_offers
    offers = self.get_all_offers
    offers.reject! do |offer|
      Offer.where(id:offer['id']).exists?
    end
    offers
  end

  def get_all_offers
    page = 0
    offers = []
    loop do 
      offers_page = @landing_jobs.get_offers(page)
      page+=1
      break if offers_page.empty?
      offers += offers_page
    end
    offers
  end
end
