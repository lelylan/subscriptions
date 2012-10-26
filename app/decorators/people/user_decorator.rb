class UserDecorator < ApplicationDecorator
  decorates :User

  def uri
    "#{h.request.protocol}#{people_host}/users/#{model.id}"
  end
end
