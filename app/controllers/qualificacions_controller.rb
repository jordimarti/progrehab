class QualificacionsController < ApplicationController
  before_action :set_qualificacio, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici

  # GET /qualificacions
  # GET /qualificacions.json
  def index
    @qualificacions = Qualificacio.all
  end

  # GET /qualificacions/1
  # GET /qualificacions/1.json
  def show
  end

  # GET /qualificacions/new
  def new
    @qualificacio = Qualificacio.new
  end

  # GET /qualificacions/1/edit
  def edit
    if @qualificacio.xml_file.exists?
      @file_uploaded = true
    else
      @file_uploaded = false
    end
  end

  # POST /qualificacions
  # POST /qualificacions.json
  def create
    @qualificacio = Qualificacio.new(qualificacio_params)

    respond_to do |format|
      if @qualificacio.save
        format.html { redirect_to @qualificacio, notice: 'Qualificacio was successfully created.' }
        format.json { render :show, status: :created, location: @qualificacio }
      else
        format.html { render :new }
        format.json { render json: @qualificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qualificacions/1
  # PATCH/PUT /qualificacions/1.json
  def update
    respond_to do |format|
      if @qualificacio.update(qualificacio_params)
        format.html { redirect_to @qualificacio, notice: 'Qualificacio was successfully updated.' }
        format.json { render :show, status: :ok, location: @qualificacio }
      else
        format.html { render :edit }
        format.json { render json: @qualificacio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qualificacions/1
  # DELETE /qualificacions/1.json
  def destroy
    @qualificacio.destroy
    respond_to do |format|
      format.html { redirect_to qualificacions_url, notice: 'Qualificacio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qualificacio
      @qualificacio = Qualificacio.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@qualificacio.edifici_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qualificacio_params
      params.require(:qualificacio).permit(:edifici_id, :xml, :xml_file)
    end
end
