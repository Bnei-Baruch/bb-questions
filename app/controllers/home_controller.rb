class HomeController < ApplicationController
  def default
  end

  def about
  end
  
  def contact_us
  end
  
  def loc_lang
    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    else
      redirect_to root_path
    end
  end
end
