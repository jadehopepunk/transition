class UserMailer < ActionMailer::Base

  def pin_created_by_admin(pin)
    subject "You're on the map of local resources in #{pin.region.name}"
    recipients pin.user.email_address
    from "craig@craigambrose.com"
    
    body(:pin => pin, :user => pin.user)
  end
  

end
