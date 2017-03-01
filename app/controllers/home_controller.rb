class HomeController < ApplicationController
  include CheckUser
  before_action :set_edifici

  def index
  end

  def contacta
  end

  def document
  	això està aquí per evitar que funcioni
  	check_user_edifici(params[:edifici_id])
    @subnavigation = true
    @submenu_actiu = 'document'
  end

  private
  	def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end
end
