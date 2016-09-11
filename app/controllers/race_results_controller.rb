class RaceResultsController < ApplicationController
  before_action :set_race_result, only: [:show, :edit, :update, :destroy]

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
    p race_result_params
    @race_result.racer = Racer.find_by(start_number: race_result_params[:racer_start_number])

    respond_to do |format|
      if @race_result.save
        format.html { redirect_to @race_result, notice: 'Race result was successfully created.' }
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
        format.html { redirect_to @race_result, notice: 'Race result was successfully updated.' }
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
    @race_result.destroy
    respond_to do |format|
      format.html { redirect_to race_results_url, notice: 'Race result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_result
      @race_result = RaceResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_result_params
      params.require(:race_result).permit(:racer_id, :racer_start_number, :race_id, :status, :lap_times)
    end
end
