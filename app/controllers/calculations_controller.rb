class CalculationsController < ApplicationController
  def index
    @report = ReturnCalculation.new(report_params)
  end

  private

  def report_params
    {
      items_count: params[:items_count],
      using_years: params[:using_years],
      last_date: params[:last_date],
      beginning_date: params[:beginning_date],
      end_date: params[:end_date],
      price: params[:price]
    }
  end
end
