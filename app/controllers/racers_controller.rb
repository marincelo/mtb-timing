class RacersController < ApplicationController
  before_action :set_racer, only: [:show, :edit, :update, :destroy]
  protect_from_forgery unless: -> { action_name != 'login' && request.format.json? }

  # GET /racers
  # GET /racers.json
  def index
    if params[:category].present?
      @racers = Racer.includes(:race_results, :start_number, :club).where(category: params[:category].to_i)
    else
      @racers = Racer.includes(:race_results, :start_number, :club).all
    end
  end

  # GET /racers/1
  # GET /racers/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @racer, include: {race_results: { include: :race, methods: :finish_time }, start_number: {}, club: {}} }
    end
  end

  # GET /racers/new
  def new
    @racer = Racer.new
  end

  # GET /racers/1/edit
  def edit
  end

  # POST /racers
  # POST /racers.json
  def create
    unless verify_recaptcha
      redirect_to new_racer_url, notice: 'Recaptcha fail.'
      return
    end
    @racer = Racer.new(racer_params)

    respond_to do |format|
      if @racer.save
        @racer.update!(user: User.create!(email: @racer.email, password: 'mtb4life'))
        # RacerMailer.welcome_email(@racer).deliver_later
        if user_signed_in?
          format.html { redirect_to @racer, notice: 'Racer was successfully created.' }
          format.json { render :show, status: :created, location: @racer }
        else
          sign_in @racer.user
          format.html { redirect_to races_path }
          format.json { render :show, status: :created, location: @racer }
        end
      else
        format.html { render :new }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /racers/1
  # PATCH/PUT /racers/1.json
  def update
    respond_to do |format|
      if @racer.update(racer_params)
        format.html { redirect_to @racer, notice: 'Racer was successfully updated.' }
        format.json { render :show, status: :ok, location: @racer }
      else
        format.html { render :edit }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /racers/1
  # DELETE /racers/1.json
  def destroy
    @racer.destroy
    respond_to do |format|
      format.html { redirect_to racers_url, notice: 'Racer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
    filter = {email: racer_params[:email], phone_number: racer_params[:phone_number]}
    racer = Racer.where(filter).first

    if racer.present?
      sign_in racer.user

      respond_to do |format|
        format.html { redirect_to(params[:redirect] || races_path) }
        format.json { render json: racer }
      end
    else
      respond_to do |format|
        format.html { redirect_to login_racers_path, notice: 'Nije uspjelo. Pokusaj opet.' }
        format.json { render json: {}, status: 401 }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_racer
      if action_name == 'show'
        @racer = Racer.includes(:race_results, :start_number, :club).find(params[:id])
      else
        @racer = Racer.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def racer_params
      params.require(:racer).permit(:first_name, :last_name, :year_of_birth, :gender, :email, :phone_number, :club_id,
        :address, :zip_code, :town, :day_of_birth, :month_of_birth, :uci_id)
    end
end
