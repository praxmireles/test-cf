class PagesController < ApplicationController
  def terms
    if current_user.type == 'Client'
      render template: 'pages/clients/terms'
    elsif current_user.type == 'Expert'
      render template: 'pages/experts/terms'
    end
  end

  def privacy; end
end
