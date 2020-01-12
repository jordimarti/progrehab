json.extract! empresa_factura, :id, :user_id, :edifici_id, :nom_juridic, :adreca, :poblacio, :provincia, :pais, :codi_postal, :email, :tipus_client, :nif, :created_at, :updated_at
json.url empresa_factura_url(empresa_factura, format: :json)
