class RiskRegistersController < ApplicationController
  before_action :authorize
  before_action :set_project
  before_action :all_except_risk_viewer
  before_action :check_current_user_project
  before_action :set_risk_register, only: [:show, :edit, :update, :destroy]

  # GET /risk_registers
  # GET /risk_registers.json
  def index
    @risk_registers = @project.risk_registers
  end

  # GET /risk_registers/1
  # GET /risk_registers/1.json
  def show
  end

  # GET /risk_registers/new
  def new
    @risk_register = @project.risk_registers.build
  end

  # GET /risk_registers/1/edit
  def edit
  end

  # POST /risk_registers
  # POST /risk_registers.json
  def create
    @risk_register = @project.risk_registers.build(risk_register_params)
    @risk_register.created_by = current_user.id
    
    respond_to do |format|
      if @risk_register.save
        RiskMailer.delay.send_risk_notification(@risk_register) #send email notification to mitigators
        RiskMailer.delay.send_notification_to_rm(@risk_register) if User.risk_manager_exist?(@project) #send email notification to project & corporate risk manager 
        
        format.html { redirect_to [@project, @risk_register], notice: 'Risk register was successfully created.' }
        format.json { render :show, status: :created, location: @risk_register }
      else
        format.html { render :new }
        format.json { render json: @risk_register.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /risk_registers/1
  # PATCH/PUT /risk_registers/1.json
  def update
    @risk_register.updated_by = current_user.id
    
    respond_to do |format|
      if @risk_register.update(risk_register_params)
        RiskMailer.delay.send_risk_reminder(@risk_register) #send email notification to mitigators
        
        format.html { redirect_to [@project, @risk_register], notice: 'Risk register was successfully updated.' }
        format.json { render :show, status: :ok, location: @risk_register }
      else
        format.html { render :edit }
        format.json { render json: @risk_register.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /risk_registers/1
  # DELETE /risk_registers/1.json
  def destroy
    @risk_register.destroy
    respond_to do |format|
      format.html { redirect_to project_risk_registers_url, notice: 'Risk register was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end
    
    def set_risk_register
      @risk_register = @project.risk_registers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def risk_register_params
      params.require(:risk_register).permit(:description, :probability, :impact, :target_date, :status, :mitigation_plan, :category_ids => [], :user_ids => [])
    end
    
    #verify the project to which the current user belongs to
    def check_current_user_project
      if current_user.project.id != params[:project_id].to_i && !sysadmin?
        flash[:danger] = "You do not belong to #{@project.name} and hence you cannot access its risk register"
        redirect_to dashboard_url 
      end
    end
end
