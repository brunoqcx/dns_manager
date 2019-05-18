class DnsRecordSearcher

  def initialize(params)
    @params = params
  end

  def paginated_collection
    Kaminari.paginate_array(collection).page(params[:page])
  end

  def total_size
    collection.size
  end

  private

  attr_reader :params

  def collection
    @collection ||= search_result.map do |dns_record| 
      {
        dns_record: dns_record,
        host_names: dns_record.hostnames
      }
    end
  end

  def search_result
    (dns_records - excluded_dns_records)
  end

  def dns_records
    return DnsRecord.includes(:hostnames) unless included_hostnames.to_a.any?

    DnsRecord.joins(:hostnames)
              .preload(:hostnames)
              .group(:id)
              .merge(Hostname.where(id: included_hostnames))
              .having(DnsRecord.arel_attribute(:id).count.gteq(included_hostnames.size))
  end

  def excluded_dns_records
    return [] unless excluded_hostnames.to_a.any?
    
    DnsRecord.includes(:hostnames).joins(:hostnames).merge(excluded_hostnames)
  end

  def hostname_from_param(name_param)
    name_param ? Hostname.where(name: name_param) : []
  end  

  def included_hostnames
    hostname_from_param(params[:include_hostnames])
  end

  def excluded_hostnames
    hostname_from_param(params[:exclude_hostnames])
  end
end