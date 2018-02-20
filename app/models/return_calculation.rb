class ReturnCalculation
  RETURN_START = Date.parse('14/08/2013')

  attr_reader :items_count, :using_years, :last_date, :beginning_date, :total_items_count, :total_overall_years, :end_date, :total_price_to_pay, :total_price

  def initialize(**params)
    @items_count = params.fetch(:items_count)
    @using_years = params[:using_years].to_i
    @last_date = params[:last_date]&.to_date
    @beginning_date = params[:beginning_date]&.to_date
    @end_date = params[:end_date]&.to_date
    @price = params[:price].to_f
    @total_items_count = 0
    @total_overall_years = 0
  end

  def all_years
    return [] unless beginning_date
    (index_of_first_year_of_work..index_of_last_year_of_work).step(using_years).map do |year_index|
      year = years_range[year_index]

      if year[:year] < end_date
        @total_overall_years += items_count.to_i
        year[:year]
      end
    end.compact
  end

  def usable_date
    if last_date && last_date > beginning_date
      last_date
    else
      beginning_date
    end
  end

  def total_price
    @price * @total_overall_years.to_f
  end

  def total_price_to_pay
    @price * total_items_count.to_f
  end

  def years_with_money
    all_years.select { |year| year > RETURN_START && year < end_date }.map do |date|
      @total_items_count += items_count.to_i
      status = date.year == last_date.year ? 'отримав' : 'не отримав'

      { date: date, status: status }
    end
  end

  def index_of_first_year_of_work
    years_range.first[:index]
  end

  def index_of_last_year_of_work
    years_range.last[:index]
  end

  def years_range
    (beginning_date..end_date).group_by(&:beginning_of_year).map.with_index do |(y, _), index|
      { year: Date.parse("#{beginning_date.day}/#{beginning_date.month}/#{y.year}"), index: index }
    end
  end
end
