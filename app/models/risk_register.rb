class RiskRegister < ActiveRecord::Base
  include RiskRegistersHelper
  before_create :generate_risk_no
  
  RISK_PROBABILITY = ["High", "Medium", "Low"]
  RISK_IMPACT = ["High", "Medium", "Low"]

  has_many :risk_mitigations, :dependent => :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users #risk mitigators
  belongs_to :project
  belongs_to :creator, class_name: "User", foreign_key: "created_by"
  belongs_to :updator, class_name: "User", foreign_key: "updated_by"

  validates :project, :description, :target_date, :category_ids, :user_ids, presence: true
  validates :probability, inclusion: RISK_PROBABILITY
  validates :impact, inclusion: RISK_IMPACT
  validates :risk_no, uniqueness: true
  
  private
  #generate unique risk no based on 2-digit project code, 2-digit year, and 4-digit autoincrement integer
  def generate_risk_no
    pro = Project.find(self[:project_id])
    if(pro.risk_registers.count == 0)
      last_risk_id = 1000;
    else
      last_risk_id = pro.risk_registers.last.risk_no.last(4).to_i
    end
    self[:risk_no] = two_digit(project.id) + get_year_yy + increment_by_one_s(last_risk_id)
  end
end
