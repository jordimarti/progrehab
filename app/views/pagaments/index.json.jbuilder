json.array!(@pagaments) do |pagament|
  json.extract! pagament, :id, :user_id, :edifici_id, :numorder, :import, :codi_retorn, :codi_autoritzacio
  json.url pagament_url(pagament, format: :json)
end
