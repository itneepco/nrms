class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionHelper
  
  def authorize
    redirect_to login_url unless current_user
  end

  def only_sysadmin
    unless admin?
      flash[:danger] = "You are not authorized to access this page. Contact your Administrator"
      redirect_to dashboard_url
    end
  end
  
  def only_sysadmin_corporate_rm #only sysadmin and corporate risk manager
    unless sysadmin? || corporate_rm?
      flash[:danger] = "You are not authorized to access this page. Contact Corporate Risk Manager"
      redirect_to dashboard_url
    end
  end
  
  def only_sysadmin_and_risk_manager
    unless sysadmin? || corporate_rm? || project_rm?
      flash[:danger] = "You are not authorized to access this page. Contact Corporate Risk Manager"
      redirect_to dashboard_url
    end
  end
  
  def all_except_risk_viewer
    if risk_viewer?
      flash[:danger] = "You are not authorized to access this page. Contact Corporate Risk Manager"
      redirect_to dashboard_url
    end
  end
  
end
