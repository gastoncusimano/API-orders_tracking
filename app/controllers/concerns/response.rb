module Response
  def json_response(data, status)
    render json: { data: data }, status: status
  end
end
