class EdificisController < ApplicationController
  before_action :set_edifici, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /edificis
  # GET /edificis.json
  def index
    @edificis = Edifici.where(user_id: current_user.id).order(created_at: :desc)
  end

  # GET /edificis/1
  # GET /edificis/1.json
  def show
  end

  # GET /edificis/new
  def new
    @edifici = Edifici.new
  end

  # GET /edificis/1/edit
  def edit
  end

  # POST /edificis
  # POST /edificis.json
  def create
    @edifici = Edifici.new(edifici_params)
    if current_user.role == 'cambra'
      @edifici.creador = 'cambra'
    end
    respond_to do |format|
      if @edifici.save
        #Aquí creem els objectes complementaris a l'edifici (dades_edifici, checklist...)
        create_complements(@edifici.id)

        if current_user.role == 'cambra'
          format.html { redirect_to edificis_path }
        else
          format.html { redirect_to validar_dades_path(edifici_id: @edifici.id) }
          format.json { render :show, status: :created, location: @edifici }
        end
      else
        format.html { render :new }
        format.json { render json: @edifici.errors, status: :unprocessable_entity }
      end
    end
  end 

  # PATCH/PUT /edificis/1
  # PATCH/PUT /edificis/1.json
  def update
    respond_to do |format|
      if @edifici.update(edifici_params)
        format.html { redirect_to edificis_path, notice: t('.edifici_actualitzat') }
        format.json { render :show, status: :ok, location: @edifici }
      else
        format.html { render :edit }
        format.json { render json: @edifici.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /edificis/1
  # DELETE /edificis/1.json
  def destroy
    @edifici.destroy
    respond_to do |format|
      format.html { redirect_to edificis_url, notice: t('.edifici_eliminat') }
      format.json { head :no_content }
    end
  end

  def pdf_header
    render :layout => false
  end

  def pdf_footer
    render :layout => false
  end

  def create_complements(edifici_id)
    #Identificacio
    @identificacio = Identificacio.new
    @identificacio.edifici_id = edifici_id
    @identificacio.save
    #Qualificacio
    @qualificacio = Qualificacio.new
    @qualificacio.edifici_id = edifici_id
    @qualificacio.save
    #Planificacio
    @planificacio = Planificacio.new
    @planificacio.edifici_id = edifici_id
    @planificacio.fons_propis = 0
    @planificacio.subvencions_solicitades = 0
    @planificacio.subvencions_atorgades = 0
    @planificacio.import_financar = 0
    @planificacio.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edifici
      @edifici = Edifici.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edifici_params
      params.require(:edifici).permit(:user_id, :nom_edifici, :ref_cadastral)
    end
end
