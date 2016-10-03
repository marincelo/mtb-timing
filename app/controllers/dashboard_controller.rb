class DashboardController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:timesync]

  def timesync
    ts = {"jsonrpc": "2.0", "id": params[:id], "result": (DateTime.now.to_f*1000).to_i}
    render json: ts
  end
end
