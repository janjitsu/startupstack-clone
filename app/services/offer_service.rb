# This service will load the database with information from 
# Landing Jobs Service
#
require 'landing_jobs_service'

class OfferService
  
  def initialize
    @landing_jobs = LandingJobsService.new
  end

  def load_offers
    page = 0
    loop do 
      page+=1
      offers = @landing_jobs.get_offers(page)
      break if offers.empty?
      offers.reject! do |offer|
        Offer.where(id:offer['id']).exists?
      end
      Offer.create(offers)
    end
  end
end
