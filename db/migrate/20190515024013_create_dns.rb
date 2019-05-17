class CreateDns < ActiveRecord::Migration[5.2]
  def change
    create_table :dns_records do |t|
      t.string :address

      t.timestamps
    end
  end
end
