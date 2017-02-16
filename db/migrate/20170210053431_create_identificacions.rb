class CreateIdentificacions < ActiveRecord::Migration[5.0]
  def change
    create_table :identificacions do |t|
      t.integer :edifici_id
      t.string :tipus_via
      t.string :nom_via
      t.string :numero_via
      t.string :bloc
      t.string :codi_postal
      t.string :poblacio
      t.string :provincia
      t.string :regim_juridic
      t.string :nom_titular
      t.string :nif_titular
      t.string :nom_representant
      t.string :nif_representant
      t.string :nom_tecnic
      t.string :nif_tecnic
      t.string :titulacio_tecnic
      t.string :colegi_tecnic
      t.string :num_colegiat_tecnic
      t.string :codi_ite
      t.string :data_emissio_ite
      t.string :nom_redactor_ite
      t.string :nif_redactor_ite
      t.string :titulacio_redactor_ite
      t.string :colegi_redactor_ite
      t.string :num_colegiat_redactor_ite
      t.string :num_expedient
      t.string :vigencia_limit_certificat
      t.string :qualificacio_certificat
      t.string :data_primera_verificacio
      t.string :data_recepcio_informe
      t.string :termini_aprovacio_programa

      t.timestamps
    end
  end
end
