class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:timesync]

  before_action :only_admin, only: [:index]

  def timesync
    ts = {"jsonrpc": "2.0", "id": params[:id], "result": (DateTime.now.to_f*1000).to_i}
    render json: ts
  end
end
