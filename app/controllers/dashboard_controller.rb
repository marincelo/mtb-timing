class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:timesync]

  before_action :only_admin, only: [:index]

  def timesync
    render json: {jsonrpc: '2.0', id: params[:id], result: (DateTime.now.to_f*1000).to_i}
  end
end
