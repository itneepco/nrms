class RiskMailer < ApplicationMailer
    add_template_helper( RiskRegistersHelper)
    
    default from: "itcellagbp@gmail.com"
    
    def send_risk_notification(risk) #sending mails on risk creation
        @risk = risk
        recipients = @risk.users.collect { |user| user.email } #collect mitigator emails.
        mail(to: recipients, subject: "Assigment as Risk mitigator for risk no #{@risk.risk_no}.")
    end
    
    def send_risk_reminder(risk) #sending mails on risk update
        @risk = risk
        recipients = @risk.users.collect { |user| user.email } #collect mitigator emails.
        mail(to: recipients, subject: "REMINDER: Assigment as Risk mitigator for risk no #{@risk.risk_no}.")
    end
    
    def send_notification_to_rm(risk)
        @risk = risk
        recipients = User.get_project_rm(@risk.project)
        recipients << User.get_corporate_rm
        mail(to: recipients, subject: "New Risk created for #{@risk.project.name}.")
    end
end
