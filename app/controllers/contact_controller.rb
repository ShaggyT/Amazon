class ContactController < ApplicationController

  def create
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

  end
end
