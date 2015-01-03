module ApplicationHelper
  def fix_url(str)
    if str.present?
      str.start_with?("http://") ? str : "http://#{str}"
    else
      "No url"
    end
  end
  
  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end


