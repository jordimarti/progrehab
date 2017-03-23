class IngressosController < ApplicationController
  before_action :set_ingres, only: [:show, :edit, :update, :destroy]

  # GET /ingressos
  # GET /ingressos.json
  def index
    @ingressos = Ingres.all
  end

  # GET /ingressos/1
  # GET /ingressos/1.json
  def show
  end

  # GET /ingressos/new
  def new
    @ingres = Ingres.new
  end

  # GET /ingressos/1/edit
  def edit
  end

  # POST /ingressos
  # POST /ingressos.json
  def create
    @ingres = Ingres.new(ingres_params)

    respond_to do |format|
      if @ingres.save
        format.html { redirect_to @ingres, notice: 'Ingres was successfully created.' }
        format.json { render :show, status: :created, location: @ingres }
      else
        format.html { render :new }
        format.json { render json: @ingres.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingressos/1
  # PATCH/PUT /ingressos/1.json
  def update
    respond_to do |format|
      if @ingres.update(ingres_params)
        format.html { redirect_to @ingres, notice: 'Ingres was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingres }
      else
        format.html { render :edit }
        format.json { render json: @ingres.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingressos/1
  # DELETE /ingressos/1.json
  def destroy
    @ingres.destroy
    respond_to do |format|
      format.html { redirect_to ingressos_url, notice: 'Ingres was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingres
      @ingres = Ingres.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingres_params
      params.require(:ingres).permit(:edifici_id, :import, :data_mes, :data_any, :creat_usuari)
    end
end
