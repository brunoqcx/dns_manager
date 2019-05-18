module Api
  module V1
    class DnsRecordsController < ApplicationController

      def create
        dns_record = ::DnsRecordForm.new(params)
        
        if dns_record.save
          render json: { dns_record_id: dns_record.id }, status: :created
        else
          render json: { errors: dns_record.errors }, status: :unprocessable_entity
        end
      end
    end
  end
end
