class ShipmentsController < ApplicationController
  def create
    shipment = Shipments::CreateCommand.call(courier: params[:courier], tracking_reference: params[:tracking_reference])
    if shipment.errors.blank?
      json_response shipment.response, :ok
    else
      json_response shipment.errors, :bad_request
    end
  end
end