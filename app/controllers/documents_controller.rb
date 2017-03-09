class DocumentsController < ApplicationController
  include CheckUser
  before_action :set_edifici, only: [:index]
  
  def index
  	@subnavigation = true
    @submenu_actiu = 'documents'
  end

  private
    def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end
end
