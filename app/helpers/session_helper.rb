module SessionHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def sysadmin?
    return current_user.role == 1
  end
  
  def corporate_rm?
    return current_user.role == 2
  end
  
  def project_rm?
    return current_user.role == 3
  end
  
  def risk_creator?
    return current_user.role == 4
  end
  
  def risk_viewer?
    return current_user.role == 5
  end
  
  def admin_or_corporate_admin?
    sysadmin? || corporate_rm?
  end
  
  def admin_or_risk_manager?
    sysadmin? || corporate_rm? || project_rm?
  end  
    
  def user_name
    if current_user
      current_user.first_name + " " + current_user.last_name 
    end
  end
  
  def check_sysadmin_corporate_rm?(user)
    current_user == user || (current_user.role == 2 && user.role == 1)
  end
end
