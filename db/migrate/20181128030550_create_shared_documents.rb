class CreateSharedDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :shared_documents do |t|
      t.references :user, foreign_key: true
      t.references :appointment, foreign_key: true
      t.string :name
      t.string :type
      t.string :file
      t.boolean :owned_by_client

      t.timestamps
    end
  end
end
