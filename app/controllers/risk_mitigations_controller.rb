class RiskMitigationsController < ApplicationController
  before_action :authorize
  before_action :all_except_risk_viewer
  before_action :set_risk_register, except: [:get_risks]
  before_action :check_current_user_is_mitigator, except: [:get_risks]
  before_action :set_risk_mitigation, only: [:show, :edit, :update, :destroy]

  def get_risks
    #retrieve all risks which the current_user is responsible for its mitigation
    @risk_registers = @current_user.risk_registers
  end
  
  # GET /risk_mitigations
  # GET /risk_mitigations.json
  def index
    @risk_mitigations = @risk_register.risk_mitigations
  end

  # GET /risk_mitigations/1
  # GET /risk_mitigations/1.json
  def show
  end

  # GET /risk_mitigations/new
  def new
    @risk_mitigation = @risk_register.risk_mitigations.build
  end

  # GET /risk_mitigations/1/edit
  def edit
  end

  # POST /risk_mitigations
  # POST /risk_mitigations.json
  def create
    @risk_mitigation = @risk_register.risk_mitigations.build(risk_mitigation_params)

    respond_to do |format|
      if @risk_mitigation.save
        format.html { redirect_to risk_register_risk_mitigations_url, notice: 'Risk mitigation was successfully created.' }
        format.json { render :show, status: :created, location: @risk_mitigation }
      else
        format.html { render :new }
        format.json { render json: @risk_mitigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /risk_mitigations/1
  # PATCH/PUT /risk_mitigations/1.json
  def update
    respond_to do |format|
      if @risk_mitigation.update(risk_mitigation_params)
        format.html { redirect_to risk_register_risk_mitigations_url, notice: 'Risk mitigation was successfully updated.' }
        format.json { render :show, status: :ok, location: @risk_mitigation }
      else
        format.html { render :edit }
        format.json { render json: @risk_mitigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_mitigations/1
  # DELETE /risk_mitigations/1.json
  def destroy
    @risk_mitigation.destroy
    respond_to do |format|
      format.html { redirect_to risk_register_risk_mitigations_url, notice: 'Risk mitigation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risk_register
      @risk_register = RiskRegister.find(params[:risk_register_id])
    end
    
    def set_risk_mitigation
      @risk_mitigation = @risk_register.risk_mitigations.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_mitigation_params
      params.require(:risk_mitigation).permit(:mitigation_step)
    end
    
    def check_current_user_is_mitigator
      unless current_user.in? @risk_register.users.to_a
        flash[:danger] = "You are not the risk mitigator for this risk and hence you cannot access it"
        redirect_to get_risks_url
      end
    end
end
