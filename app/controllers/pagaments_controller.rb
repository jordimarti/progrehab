class PagamentsController < ApplicationController
  # Posem skip pq vindrà d'un servidor extern i no hi haurà authenticity token
  skip_before_filter :verify_authenticity_token
  before_action :set_pagament, only: [:show, :edit, :update, :destroy]
  before_action :set_edifici, only: [:index, :show, :new, :edit, :create, :destroy]

  # GET /pagaments
  # GET /pagaments.json
  def index
    @pagaments = Pagament.where(pagat: true)
  end

  # GET /pagaments/1
  # GET /pagaments/1.json
  def show
  end

  # GET /pagaments/new
  def new
    @pagament = Pagament.new
  end

  # GET /pagaments/1/edit
  def edit
  end

  def validar_dades
    @edifici = Edifici.find(params[:edifici_id])
    @usuari_factura = UsuariFactura.new
    @empresa_factura = EmpresaFactura.new
    @nif_usuari = current_user.nif

  end

  #def crear_pagament_old
  #  @pagament = Pagament.new()
  #  @pagament.user_id = current_user.id
  #  @pagament.edifici_id = params[:edifici_id]
  #  @pagament.numorder = numorder(params[:edifici_id])
  #  @pagament.import = "42,96"
  #  @pagament.pagat = false
  #  titular = current_user.name
  #  url_pagament = 'http://isis.apabcn.cat/LibroEdificio/pagoVisa.aspx?titular=' + titular + '&importe=' + @pagament.import + '&numorder=' + @pagament.numorder.to_s + '&descripcion=llibreedifici&urlresponse=http://llibreedifici.apabcn.cat/pagaments/update_pagament'
  #  #http://isis.apabcn.cat/LibroEdificio/pagoVisa.aspx?titular=Titular&importe=42,96&numorden=110000000101&descripcion=llibreedifici&urlresponse=http://llibreedifici.apabcn.cat/pagaments/update_pagament
  #  respond_to do |format|
  #    if @pagament.save
  #      format.html { redirect_to url_pagament }
  #      format.json { render :show, status: :created, location: @pagament }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @pagament.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  def crear_pagament
    @pagament = Pagament.new()
    @pagament.user_id = current_user.id
    @pagament.edifici_id = params[:edifici_id]
    @pagament.numorder = numorder(params[:edifici_id])
    #Comprovem si és col·legiat per decidir preu
    factura = UsuariFactura.where(edifici_id: params[:edifici_id]).last
    if factura != nil
      if factura.colegiat == true
        @pagament.import = "18.15"
      else
        @pagament.import = "24.2"
      end
    else
      @pagament.import = "24.2"
    end
    @pagament.pagat = false
    titular = current_user.name
    #endpoint = 'https://partial-caateebcn-partial.cs82.force.com/bookpurchase/apex/creditcardservice?importe=' + @pagament.import + '&titular=' + URI.escape(titular) + '&descripcion=llibreedifici&idProducto=' + params[:edifici_id] + '&urlresponse=http%3A%2F%2Flocalhost:3000%2Fpagaments%2Fupdate_pagament%3FpagoVisaResult%3Dvalue1%26numorder%3Dvalue2&urlresponseko=http%3A%2F%2Flocalhost:3000%2Fpagaments%2Ferror_factura'
    #url = URI.parse('https://partial-caateebcn-partial.cs82.force.com/bookpurchase/services/apexrest/creditcard')
    #url = URI.parse('https://enngarvpspmm.x.pipedream.net')
    url_resposta_correcta = "http%3A%2F%2Fprogramarehabilitacio.apabcn.cat%2Fpagaments%2Fupdate_pagament%3FpagoVisaResult%3Dvalue1%26numorder%3D" + @pagament.numorder
    url_resposta_error = "http%3A%2F%2Fprogramarehabilitacio.apabcn.cat%2Fpagaments%2Ferror_pagament"
    args = {"importe" => @pagament.import, "titular" => URI.escape(titular), "descripcion" => "progrehab", "idProducto" => params[:edifici_id], "urlresponse" => url_resposta_correcta, "urlresponseint" => url_resposta_error}
    
    urlstring = 'https://apabcn.secure.force.com/bookpurchase/services/apexrest/creditcard'
    #urlstring = URI.parse('https://enngarvpspmm.x.pipedream.net')
    #uri = URI.parse("https://partial-caateebcn-partial.cs82.force.com/bookpurchase/services/apexrest/creditcard")

    if @pagament.save
      #resposta = Net::HTTP.post_form(url, args, initheader = {'Content-Type' =>'application/json'})

      #uri = URI.parse("https://enngarvpspmm.x.pipedream.net")
      #header = {'Content-Type': 'text/json'}
      #http = Net::HTTP.new(uri.host, uri.port)
      #request = Net::HTTP::Post.new(uri.request_uri, header)
      #request.body = args.to_json
      #resposta = http.request(request)

      
      
      resposta = HTTParty.post(urlstring, body: args.to_json, headers: { 'Content-Type' => 'application/json' })
      #resposta = Net::HTTP.post_form(uri, {"importe" => @pagament.import, "titular" => URI.escape(titular), "descripcion" => "llibreedifici", "idProducto" => params[:edifici_id], "urlresponse" => "http%3A%2F%2Flocalhost:3000%2Fpagaments%2Fupdate_pagament%3FpagoVisaResult%3Dvalue1%26numorder%3Dvalue2", "urlresponseko" => "http%3A%2F%2Flocalhost:3000%2Fpagaments%2Ferror_factura"})
      puts '-----------------'
      puts resposta.code
      puts '-----------------'
      puts resposta.body
      puts '-----------------'
      puts resposta.message
      puts '-----------------'
      #puts resposta.headers.inspect
      puts '-----------------'
      dades = resposta.to_hash
      @pagament.numorden = dades['numorden']
      @pagament.save
      htmlstring = dades['pagoVisaResult']
      htmlstring.slice!(0, 9)
      htmlstring = 3.times do htmlstring.chop! end
      render html: dades['pagoVisaResult'].html_safe

    end
  end


  def numorder(edifici_id)
    codi_factura = '058'
    projecte = edifici_id
    numero_projecte = sprintf '%07d', projecte
    intent = Pagament.where(edifici_id: edifici_id).count + 1
    numero_intent = sprintf '%02d', intent
    final = codi_factura + numero_projecte + numero_intent
    return final
  end

  # PATCH/PUT /pagaments/1
  # PATCH/PUT /pagaments/1.json
  #def update
  #  pagament = Pagament.where(:numorder => params[:numorder])
  #  respond_to do |format|
  #    if pagament.update(pagament_params)
  #      format.html { redirect_to @pagament, notice: 'Pagament was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @pagament }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @pagament.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  #Comprovem si el resultat del pagament és entre 0000 i 0099
  def comprovar_resultat(resultat)
    #Primer comprovem els dos dígits inicials, han de ser 00 per a que sigui correcte
    numero_caracters = resultat.length
    primer_valor = resultat.split(//).first(2).join
    segon_valor = resultat.split(//).last(2).join
    if numero_caracters == 4 && primer_valor == '00' && segon_valor.to_i < 100
      return true
    else
      return false
    end
  end

  def update_pagament                  
    pagament = Pagament.where(:numorder => params[:numorder]).last
    if pagament != nil
      if pagament.numorder != nil
        pagament.pagat = true
        if pagament.factura_enviada != true
          # Especifiquem que s'ha enviat una factura per evitar duplicats de factures si s'executa de nou update_pagament
          pagament.factura_enviada = true
          pagament.save
          # Enviem la factura
          @resultat_enviament = envia_factura(pagament) 
          @info_pagament = pagament
        end
      end
    end
  end

  def envia_factura(pagament)
    # Comprovem si l'última factura d'aquest edifici és d'usuari o d'empresa
    factura_usuari = UsuariFactura.where(edifici_id: pagament.edifici_id).last
    factura_empresa = EmpresaFactura.where(edifici_id: pagament.edifici_id).last
    #client = Savon.client(wsdl: "http://isis.apabcn.cat/LibroEdificio/wsfacturasSap.asmx?wsdl")
    #client = Savon.client(wsdl: "https://partial-caateebcn-partial.cs82.force.com/bookpurchase/services/Soap/class/BookPurchaseService")
    urlstring = 'https://apabcn.secure.force.com/bookpurchase/services/apexrest/books'

    if factura_usuari != nil && factura_empresa != nil
      if factura_usuari.updated_at > factura_empresa.updated_at
        factura = factura_usuari
      else
        factura = factura_empresa
      end
    end
    if factura_usuari != nil && factura_empresa == nil
      factura = factura_usuari
    end
    if factura_usuari == nil && factura_empresa != nil
      factura = factura_empresa
    end  

    if factura == factura_usuari
      puts "Seleccionat: factura usuari"
      args = {"ParamUsuario" => { nombre: factura.nom, nif: factura.nif, poblacion: '19', provincia: '08', codpostal: factura.codi_postal, direccion: factura.adreca, pais: 'ES', email: factura.email, numcliente: factura.num_client, escolegiado: factura.colegiat, solicitante: '' }, 'ParamOtrosDatos' => { referenciapago: pagament.numorden }}
      resposta = HTTParty.post(urlstring, body: args.to_json, headers: { 'Content-Type' => 'application/json' })
      dades = resposta.to_hash
      resultat = dades['resultado']
      numfactura = dades['numfactura']
    else 
      puts "Seleccionat: factura empresa"
      puts "NombreJuridico: #{factura.nom_juridic}"
      puts "CIF: #{factura.nif}"
      puts "email: #{factura.email}"
      #resposta = client.call(:create_factura_empresa, message: { 'ParamEmpresa' => { 'NombreJuridico' => factura.nom_juridic, 'CIF' => factura.nif, poblacion: '19', provincia: '08', codpostal: factura.codi_postal, direccion: factura.adreca, email: factura.email, pais: 'ES', tipocliente: '' }, 'ParamOtrosDatos' => { referenciapago: pagament.numorder }})
      args = {"ParamEmpresa" => { codpostal: factura.codi_postal, direccion: factura.adreca, cif: factura.nif, nombrejuridico: factura.nom_juridic, pais: 'ES', poblacion: '19', provincia: '08', solicitante: '', email: factura.email, tipocliente: ''}, 'ParamOtrosDatos' => { referenciapago: pagament.numorden }}
      resposta = HTTParty.post(urlstring, body: args.to_json, headers: { 'Content-Type' => 'application/json' })
      dades = resposta.to_hash
      resultat = dades['resultado']
      numfactura = dades['numfactura']
    end

    grava_resposta_factura(pagament.id, resultat, numfactura)

    if resultat == "0"
      #redirect_to edificis_path
      return true
    else 
      #redirect_to error_factura_path
      return false
    end
  end

  def grava_resposta_factura(pagament_id, resultat, numfactura)
    pagament = Pagament.find(pagament_id)
    pagament.resposta_factura = resultat
    pagament.num_factura_sap = numfactura
    pagament.save
  end

  def error_factura
  end

  def error_pagament
  end

  def llistat_pagaments
    if user_signed_in?
      if current_user.id == 1 || current_user.id == 1608
        @pagaments = Pagament.order(created_at: :desc).first(100)
      else
        redirect_to home_permisos_path
      end
    else
      redirect_to home_permisos_path
    end
  end

  def detall_pagament
    @pagament = Pagament.find(params[:id])
    @usuari_factura = UsuariFactura.where(edifici_id: @pagament.edifici_id).last
    @empresa_factura = EmpresaFactura.where(edifici_id: @pagament.edifici_id).last
  end

  def cambra_projects
    @mesos = [['Gener', '01'], ['Febrer', '02'], ['Març', '03'], ['Abril', '04'], ['Maig', '05'], ['Juny', '06'], ['Juliol', '07'], ['Agost', '08'], ['Setembre', '09'], ['Octubre', '10'], ['Novembre', '11'], ['Desembre', '12']]
    @edificis = []
    for i in 0..11
      any = params[:any]
      mes_nom = @mesos[i][0]
      mes_nombre = @mesos[i][1]
      @edificis.push consulta_edificis_cambra(any, mes_nombre)
    end
  end

  def consulta_edificis_cambra(any, mes)
    edificis = Edifici.where(creador: 'cambra')
    edificis_any = edificis.where('extract(year from created_at) = ?', any)
    edificis_mes = edificis_any.where('extract(month from created_at) = ?', mes)
    return edificis_mes
  end

  # DELETE /pagaments/1
  # DELETE /pagaments/1.json
  def destroy
    @pagament.destroy
    respond_to do |format|
      format.html { redirect_to pagaments_url, notice: 'Pagament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pagament
      @pagament = Pagament.find(params[:id])
    end

    def set_edifici
      @edifici = Edifici.find(params[:edifici_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pagament_params
      params.require(:pagament).permit(:user_id, :edifici_id, :numorder, :numorden, :import, :resultado, :autorizacion, :pagat, :factura_enviada, :resposta_factura, :num_factura_sap)
    end
end