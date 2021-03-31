class ShipmentsController < ApplicationController
  def create
    shipment = Shipments::CreateCommand.call(courier: params[:courier], tracking_reference: params[:tracking_reference])
    json_response shipment, :ok
  end
end