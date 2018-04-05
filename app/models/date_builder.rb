class DateBuilder
  def self.build_date(params)
    year = params[:year] || Date.current.year
    month = params[:month] || Date.current.month
    day = params[:day] || Date.current.day
    Date.new(year.to_i, month.to_i, day.to_i)
  end
end
