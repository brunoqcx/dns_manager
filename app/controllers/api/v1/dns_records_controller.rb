module Api
  module V1
    class DnsRecordsController < ApplicationController

      def create
        dns_record = DnsRecordForm.new(dns_record_params)
        
        if dns_record.save
          render json: { dns_record_id: dns_record.id }, status: :created
        else
          render json: { errors: dns_record.errors }, status: :unprocessable_entity
        end
      end

      def search
        search_result = DnsRecordSearcher.new(params)

        render json: { 
                        total_result: search_result.total_size,
                        dns_records: search_result.paginated_collection
                     }, status: :ok
      end

      private

      def dns_record_params
        params.permit(:address, hostnames: [])
      end
    end
  end
end
