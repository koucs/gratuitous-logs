class HomeController < ApplicationController
  def index
    prepare_meta_tags( title: "HOME" )
  end

  def profile
    prepare_meta_tags( title: "PROFILE" )
  end
end
