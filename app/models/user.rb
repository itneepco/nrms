class User < ActiveRecord::Base
  before_destroy :check_user_references
  
  belongs_to :designation
  belongs_to :project
  
  has_many :risks, class_name: "RiskRegister", foreign_key: "created_by"
  has_and_belongs_to_many :risk_registers #risk mitigators
  
  has_secure_password

  USER_ROLES = [["SysAdmin", 1], ["Corporate Risk Manager", 2], ["Project Risk Manager", 3], ["Risk Creator", 4], ["Risk Viewer", 5]]

  validates :email, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }, uniqueness: {case_sensitive: false}
  validates :first_name, :last_name, :designation, :department, :project, :email, :role, presence: true
  validates :role, inclusion: USER_ROLES.map {|s| s[1]}
  
  def User.get_corporate_rm #get corporate risk managers
    User.where(role: 2).collect { |user| user.email }
  end
  
  def User.get_project_rm(project) #get specific project risk managers
    User.where("project_id = ? AND role = ?", project, 3).collect { |user| user.email }
  end
  
  def User.risk_manager_exist?(project) #check if any corporate or risk manager exists
    User.get_corporate_rm.any? || User.get_project_rm(project).any?
  end
  
  private
  def check_user_references
    if risk_registers.count > 0 || risks.count > 0
      return false
    end
  end
end
