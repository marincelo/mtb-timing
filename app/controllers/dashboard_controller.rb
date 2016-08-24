class DashboardController < ApplicationController
  before_action :set_race, only: [:show]

  def index
    render  component: 'Dashboard', tag: 'div', class: 'dashboard'
  end

  def show
    render component: 'Dashboard', tag: 'div', class: 'dashboard'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end
end
