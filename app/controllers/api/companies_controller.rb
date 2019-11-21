require 'api/company_json'
class Api::CompaniesController < ApplicationController
  def index
    @companies =  Company.all
    if @companies.size > 0
      @result = Array.new
      @companies.each do |company|
        if company.banner.present?
          @companyJson = CompanyJson.new(company.name, company.banner.url)
          @result << @companyJson
        end
      end
      result = {companies: @result}
      render json: @result
    else
      msg = {status: 400, message: "No company"}
      render json: msg
    end
  end
end
