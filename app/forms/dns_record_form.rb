class DnsRecordForm
  include ActiveModel::Model

  attr_reader :id

  def initialize(params)
    @params = params
  end

  def save
    persist!
    errors.empty?
  end

  private

  attr_reader :dns_record, :params

  delegate :id, to: :dns_record

  def persist!
    begin
      ActiveRecord::Base.transaction do
        create_dns_record
        create_hosts
      end

    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.messages.each do |error, msgs|
        msgs.each {|msg| errors.add(error, msg) }
      end
    end
  end

  def create_dns_record
    @dns_record = DnsRecord.create!(dns_record_params)
  end

  def create_hosts
    hostnames.to_a.map { |name| dns_record.hostnames << HostnameFinderOrCreator.new(name).call }
  end

  def dns_record_params
    params.permit(:address)
  end

  def hostnames
    params[:hostnames]
  end
end