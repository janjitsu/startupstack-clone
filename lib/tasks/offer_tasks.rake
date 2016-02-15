desc 'Load offers from LandingJobs Api'
task load_offers: :environment do
  offer_svc = OfferService.new
  offers = offer_svc.load_offers
  company_svc = CompanyService.new
  companies = company_svc.load_companies

  #TODO find offers with companies not loaded and load them
end
