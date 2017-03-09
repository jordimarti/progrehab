class HomeController < ApplicationController
  include CheckUser
  before_action :set_edifici, only: [:document]

  def index
  end

  def contacta
  end

  private
  	def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end
end
