class StartNumbersController < ApplicationController
  before_action :set_start_number, only: [:show, :edit, :update, :destroy]
  before_action :only_admin

  # GET /start_numbers
  # GET /start_numbers.json
  def index
    @start_numbers = StartNumber.all
  end

  # GET /start_numbers/1
  # GET /start_numbers/1.json
  def show
  end

  # GET /start_numbers/new
  def new
    @start_number = StartNumber.new
  end

  # GET /start_numbers/1/edit
  def edit
  end

  # POST /start_numbers
  # POST /start_numbers.json
  def create
    @start_number = StartNumber.new(start_number_params)

    respond_to do |format|
      if @start_number.save
        format.html { redirect_to @start_number, notice: 'Start number was successfully created.' }
        format.json { render :show, status: :created, location: @start_number }
      else
        format.html { render :new }
        format.json { render json: @start_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /start_numbers/1
  # PATCH/PUT /start_numbers/1.json
  def update
    respond_to do |format|
      if @start_number.update(start_number_params)
        format.html { redirect_to @start_number, notice: 'Start number was successfully updated.' }
        format.json { render :show, status: :ok, location: @start_number }
      else
        format.html { render :edit }
        format.json { render json: @start_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /start_numbers/1
  # DELETE /start_numbers/1.json
  def destroy
    @start_number.destroy
    respond_to do |format|
      format.html { redirect_to start_numbers_url, notice: 'Start number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_start_number
      @start_number = StartNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def start_number_params
      params.require(:start_number).permit(:value, :tag_id, :signal_strength, :racer_id)
    end
end
