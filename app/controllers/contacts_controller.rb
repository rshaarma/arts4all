class ContactsController < ApplicationController
  after_action :verify_authorized, except: [:new, :create], unless: :skip_pundit?

    def new
      @contact = Contact.new
      # authorize @contact
    end
  
    def create
      @contact = Contact.new(params[:contact])
      # authorize @contact
      @contact.request = request
      if @contact.deliver
        flash.now[:error] = 'Message sent!'
      else
        flash.now[:error] = 'Could not send message'
        render :new
      end
    end
end
