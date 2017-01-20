class AddColumnsToRiskRegisters < ActiveRecord::Migration
  def change
    add_column :risk_registers, :approved, :boolean, default: false
    add_column :risk_registers, :approved_by, :integer
    add_column :risk_registers, :approved_date, :date
    add_column :risk_registers, :responsible_officer, :string
  end
end
