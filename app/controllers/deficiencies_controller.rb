class DeficienciesController < ApplicationController
  before_action :set_deficiencia, only: [:show, :edit, :update, :destroy]

  # GET /deficiencies
  # GET /deficiencies.json
  def index
    @deficiencies = Deficiencia.all
  end

  # GET /deficiencies/1
  # GET /deficiencies/1.json
  def show
  end

  # GET /deficiencies/new
  def new
    @deficiencia = Deficiencia.new
  end

  # GET /deficiencies/1/edit
  def edit
  end

  # POST /deficiencies
  # POST /deficiencies.json
  def create
    @deficiencia = Deficiencia.new(deficiencia_params)

    respond_to do |format|
      if @deficiencia.save
        format.html { redirect_to @deficiencia, notice: 'Deficiencia was successfully created.' }
        format.json { render :show, status: :created, location: @deficiencia }
      else
        format.html { render :new }
        format.json { render json: @deficiencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deficiencies/1
  # PATCH/PUT /deficiencies/1.json
  def update
    respond_to do |format|
      if @deficiencia.update(deficiencia_params)
        format.html { redirect_to @deficiencia, notice: 'Deficiencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @deficiencia }
      else
        format.html { render :edit }
        format.json { render json: @deficiencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deficiencies/1
  # DELETE /deficiencies/1.json
  def destroy
    @deficiencia.destroy
    respond_to do |format|
      format.html { redirect_to deficiencies_url, notice: 'Deficiencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deficiencia
      @deficiencia = Deficiencia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deficiencia_params
      params.require(:deficiencia).permit(:edifici_id, :descripcio, :observacions, :sistema, :qualificacio)
    end
end
