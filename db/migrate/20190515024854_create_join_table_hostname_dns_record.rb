class CreateJoinTableHostnameDnsRecord < ActiveRecord::Migration[5.2]
  def change
    create_join_table :hostnames, :dns_records do |t|
      t.index [:hostname_id, :dns_record_id]
      t.index [:dns_record_id, :hostname_id]
    end
  end
end
