json.extract! usuari_factura, :id, :user_id, :edifici_id, :nom, :adreca, :poblacio, :provincia, :pais, :codi_postal, :email, :num_client, :colegiat, :created_at, :updated_at
json.url usuari_factura_url(usuari_factura, format: :json)
