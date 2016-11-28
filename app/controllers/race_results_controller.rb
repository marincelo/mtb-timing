class RaceResultsController < ApplicationController
  before_action :set_race_result, only: [:show, :edit, :update, :destroy]
  before_action :only_admin, only: [:from_timing, :destroy_from_timing]

  # GET /race_results
  # GET /race_results.json
  def index
    @race_results = RaceResult.all
  end

  # GET /race_results/1
  # GET /race_results/1.json
  def show
  end

  # GET /race_results/new
  def new
    @race_result = RaceResult.new
  end

  # GET /race_results/1/edit
  def edit
  end

  # POST /race_results
  # POST /race_results.json
  def create
    @race_result = RaceResult.new(race_result_params)

    respond_to do |format|
      if @race_result.save
        format.html { redirect_to @race_result.race, notice: 'Prijava je zabiljezena.' }
        format.json { render :show, status: :created, location: @race_result }
      else
        format.html { render :new }
        format.json { render json: @race_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /race_results/1
  # PATCH/PUT /race_results/1.json
  def update
    respond_to do |format|
      if @race_result.update(race_result_params)
        format.html { redirect_to @race_result.race, notice: 'Uplata uspjesno zaprimljena.' }
        format.json { render :show, status: :ok, location: @race_result }
      else
        format.html { render :edit }
        format.json { render json: @race_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_results/1
  # DELETE /race_results/1.json
  def destroy
    race = @race_result.race
    @race_result.destroy
    respond_to do |format|
      format.html { redirect_to race, notice: 'Odjava je bila uspjesna.' }
      format.json { head :no_content }
    end
  end

  # POST /race_results/from_timing
  def from_timing
    race = Race.find(params[:race_id])
    racer = Racer.find_by(start_number: params[:start_number])
    race_result = RaceResult.where(race: race, racer: racer).first
    race_result.lap_times << params[:time].to_f/1000 if params[:time]
    race_result.status = params[:status]
    race_result.save!
    respond_to do |format|
      format.json { render json: race_result }
    end
  end

  # DELETE /race_results/destroy_from_timing
  def destroy_from_timing
    race = Race.find(params[:race_id])
    racer = Racer.find_by(start_number: params[:start_number])
    race_result = RaceResult.where(race: race, racer: racer).first
    race_result.lap_times -= ["#{params[:time].to_f/1000}"]
    race_result.save!
    respond_to do |format|
      format.json { render json: race_result }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_result
      @race_result = RaceResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_result_params
      params.require(:race_result).permit(:racer_id, :race_id, :status, :lap_times)
    end
end
