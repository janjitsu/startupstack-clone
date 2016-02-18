class OfferController < ApplicationController
  def search
    @companies = Company.with_tags(params[:tags].split(","))
  end

  def create
  end

  before_filter proc { |controller| 
    (controller.action_has_layout = false) if controller.request.xhr? 
  }
end
