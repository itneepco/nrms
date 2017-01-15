class AddMitigationPlanToRiskRegister < ActiveRecord::Migration
  def change
    add_column :risk_registers, :mitigation_plan, :text
  end
end
