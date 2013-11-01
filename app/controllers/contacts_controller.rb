class ContactsController < ApplicationController
   layout "home"
  def new
    @inquiry = Contact.new
  end

  def create
    #@inquiry = Contact.new(params[:inquiry])
    #if @inquiry.deliver
    #  render :thank_you
    #else
    #  render :new
    #end
    Pony.mail({
                  :from =>"noreply@atansolutions.com",
                  :to => params[:contact][:email],
                  :subject => "Contact to atansolutions.com",
                  :html_body => "<html><body><h1>Thank you for your contact</h1>
                            <h3>Your name: #{params[:contact][:first_name]} #{params[:contact][:last_name]}</h3>
                            <h3>Content is:</h3><p>#{params[:contact][:message]}</p>
                            <h3>Date: #{DateTime.now.to_s}</h3></body></html>",
                  :via => :smtp,
                  :via_options => {
                      :address              => 'smtp.gmail.com',
                      :port                 => '587',
                      :enable_starttls_auto => true,
                      :user_name            => 'hoangphuc50@gmail.com',
                      :password             => 'champions0',
                      :authentication       => :plain,
                      :domain               => "localhost.localdomain"
                  }
              })
     if
       render :thank_you
     else
       render :new
    end
  end

end