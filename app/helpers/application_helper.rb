module ApplicationHelper
  def format_date(date)
    date.strftime("%Y-%b-%d")
  end
end
