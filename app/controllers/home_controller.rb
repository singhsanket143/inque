class HomeController < ApplicationController
    before_action :authenticate_user!
  def index
      respond_to do |format|
        format.html{
          @question = Question.new
          @feed=current_user.feed
        }
        format.js{  }
      end
  end
end
