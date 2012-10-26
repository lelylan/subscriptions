class ApplicationDecorator < Draper::Base
  def default_options
    { only_path: false, host: h.request.host }
  end

  def devices_host
    host = h.request.env['HTTP_X_HOST'] || ENV['LELYLAN_DEVICES_URL'] || h.request.host
  end

  def people_host
    host = h.request.env['HTTP_X_HOST'] || ENV['LELYLAN_PEOPLE_URL'] || h.request.host
  end
end
