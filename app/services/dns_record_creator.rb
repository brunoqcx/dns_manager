class DnsRecordCreator
  def initialize(params)
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      create_dns_record
      create_hosts
    end

    @dns_record
  end

  private

  attr_reader :params

  def create_dns_record
    @dns_record ||= DnsRecord.create!(params.except(:hostnames))    
  end

  def hostnames
    params[:hostnames]
  end

  def create_hosts
    @dns_record.hostnames << hostnames.to_a.map { |name| HostnameFinderOrCreator.new(name).call }
  end
end