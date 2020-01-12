class EmpresaFacturesController < ApplicationController
  before_action :set_empresa_factura, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici

  # GET /empresa_factures
  # GET /empresa_factures.json
  def index
    @empresa_factures = EmpresaFactura.all
  end

  # GET /empresa_factures/1
  # GET /empresa_factures/1.json
  def show
  end

  # GET /empresa_factures/new
  def new
    @empresa_factura = EmpresaFactura.new
  end

  # GET /empresa_factures/1/edit
  def edit
    @edifici = Edifici.find(@empresa_factura.edifici_id)
  end

  # POST /empresa_factures
  # POST /empresa_factures.json
  def create
    @empresa_factura = EmpresaFactura.new(empresa_factura_params)
    #De moment anul·lo la validació al crear les dades de factura. Això és perquè primer es va a la pàgina de validació de dades, on l'usuari només ha de posar el NIF. Si tinc una validació d'altres camps com email no puc passar a la següent pàgina. Quan es faci l'update, en la confirmació de dades, sí que hi haurà validació de tots els camps, inclòs el NIF.
    if @empresa_factura.save(validate: false)

    else
      redirect_to validar_dades_path(@edifici.id), flash: { error: @empresa_factura.errors.messages }
      return
    end
    # Guardem el NIF introduït
    nou_nif = @empresa_factura.nif
    # Comprovem si existeix l'empresa a la base de dades
    endpoint = 'https://apabcn.secure.force.com/bookpurchase/services/apexrest/books?document=' + nou_nif
    resposta = HTTParty.get(endpoint)
    dades = resposta.to_hash
    @empresa_factura.nom_juridic = dades['NombreJuridico']
    @empresa_factura.nif = dades['cif']
    @empresa_factura.poblacio = dades['poblacion']
    @empresa_factura.provincia = dades['provincia']
    @empresa_factura.codi_postal = dades['codpostal']
    @empresa_factura.adreca = dades['direccion']
    @empresa_factura.pais = dades['pais']
    #@empresa_factura.email = dades[:get_empresa_response][:param_empresa][:email]
    @empresa_factura.email = current_user.email
    @empresa_factura.tipus_client = dades['tipocliente']
    @empresa_factura.save(validate: false)
    if @empresa_factura.nif
      redirect_to empresa_factura_path(id: @empresa_factura.id)
    else
      @empresa_factura.nif = nou_nif
      @empresa_factura.save(validate: false)
      redirect_to edit_empresa_factura_path(id: @empresa_factura.id)
    end
  end

  # PATCH/PUT /empresa_factures/1
  # PATCH/PUT /empresa_factures/1.json
  def update
    respond_to do |format|
      if @empresa_factura.update(empresa_factura_params)
        format.html { redirect_to @empresa_factura, notice: 'Empresa factura was successfully updated.' }
        format.json { render :show, status: :ok, location: @empresa_factura }
      else
        format.html { render :edit }
        format.json { render json: @empresa_factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empresa_factures/1
  # DELETE /empresa_factures/1.json
  def destroy
    @empresa_factura.destroy
    respond_to do |format|
      format.html { redirect_to empresa_factures_url, notice: 'Empresa factura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa_factura
      @empresa_factura = EmpresaFactura.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(@empresa_factura.edifici_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_factura_params
      params.require(:empresa_factura).permit(:user_id, :edifici_id, :nom_juridic, :adreca, :poblacio, :provincia, :pais, :codi_postal, :email, :tipus_client, :nif)
    end
end
