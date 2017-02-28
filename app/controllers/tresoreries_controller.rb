class TresoreriesController < ApplicationController
  before_action :set_tresoreria, only: [:show, :edit, :update, :destroy]

  # GET /tresoreries
  # GET /tresoreries.json
  def index
    @tresoreries = Tresoreria.all
  end

  # GET /tresoreries/1
  # GET /tresoreries/1.json
  def show
  end

  # GET /tresoreries/new
  def new
    @tresoreria = Tresoreria.new
  end

  # GET /tresoreries/1/edit
  def edit
  end

  # POST /tresoreries
  # POST /tresoreries.json
  def create
    @tresoreria = Tresoreria.new(tresoreria_params)

    respond_to do |format|
      if @tresoreria.save
        format.html { redirect_to @tresoreria, notice: 'Tresoreria was successfully created.' }
        format.json { render :show, status: :created, location: @tresoreria }
      else
        format.html { render :new }
        format.json { render json: @tresoreria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tresoreries/1
  # PATCH/PUT /tresoreries/1.json
  def update
    respond_to do |format|
      if @tresoreria.update(tresoreria_params)
        format.html { redirect_to @tresoreria, notice: 'Tresoreria was successfully updated.' }
        format.json { render :show, status: :ok, location: @tresoreria }
      else
        format.html { render :edit }
        format.json { render json: @tresoreria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tresoreries/1
  # DELETE /tresoreries/1.json
  def destroy
    @tresoreria.destroy
    respond_to do |format|
      format.html { redirect_to tresoreries_url, notice: 'Tresoreria was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tresoreria
      @tresoreria = Tresoreria.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tresoreria_params
      params.require(:tresoreria).permit(:edifici_id, :import, :data_mes, :data_any)
    end
end
