class Project < ActiveRecord::Base
	before_destroy :check_users_risk_registers_count
	
	has_many :users
	has_many :risk_registers
	
	validates :name, presence: true
	validates :name, uniqueness: {case_sensitive: false}
	
	def name=(str)
		self[:name] = str.upcase
	end
	
	def full_name=(str)
		self[:full_name] = str.split().each { |s| s.capitalize! }.join(' ')
	end
	
	def get_mitigator_list
		users.where.not(role: 5).order(:email).map {|s| [s.email, s.id]}
	end
	
	private
	def check_users_risk_registers_count
		if users.count > 0 || risk_registers.count > 0
			return false
		end
	end
end
