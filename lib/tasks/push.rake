
task :push => :environment do
  begin

    require 'gcm_on_rails_tasks'

    puts "push started"

    puts configatron.gcm_on_rails.api_url
    puts configatron.gcm_on_rails.api_key
    puts configatron.gcm_on_rails.app_name
    puts configatron.gcm_on_rails.delivery_format

    device_token = "APA91bHrGaBsrD1RVCSwULqq1YMH4QpXCQC5l-uxyvZptYBnyPaIFWMOUmnlAFT6JZoYmzHvKHw9M_k-oonw2_Cgp8vCIdmGS8nD2MFmQ7khDyZ9zFuQqqrP7HKWK5RRoZ3BV_KoByH6g4H0pKQsDxwoVoNFSCl8iw"
    device = Gcm::Device.find_or_create_by_registration_id(:registration_id => "#{device_token}")
    notification = Gcm::Notification.new
    notification.device = device
    notification.collapse_key = "updates_available"
    notification.delay_while_idle = false
    notification.data = {:registration_ids => ["#{device_token}"], :data => {:message_text => "Message!!!!!"}}
    notification.save!
    Gcm::Notification.send_notifications
    #send_notifications

  rescue MissingSourceFile => e
    puts e.message
  end


end