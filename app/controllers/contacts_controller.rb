class ContactsController < ApplicationController
  respond_to :json, :html

  def index
    set_contacts
  end

  def create
    @user = current_user
    @contact = @user.contacts.build(contact_params)
    if @contact.save
      redirect_to contacts_path
    end
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(contact_params)
    respond_with @contact
  end

  def destroy
    set_contacts
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.js
    end
  end

  def check_email
    email = params[:contact][:email]
    @user = current_user

    record = @user.contacts.where("email = ?", email).first
    if record.present?
      render :json => false
    else
      render :json => true
    end
  end

  def check_phone
    phone = params[:contact][:phone]
    @user = current_user

    record = @user.contacts.where("phone = ?", phone.to_s).first
    if record.present?
      render :json => false
    else
      render :json => true
    end
  end

  private

  def set_contacts
    @user = current_user
    @showFriends = params[:showFriends]
    @contacts = @user.contacts
    if @showFriends == "true"
      @contacts = @contacts.where(friend: true)
    end
    if params[:search].present?  
      search = params[:search]
      @contacts = @contacts.where('name LIKE ?', "%#{search}%")     
    end
    @contacts = @contacts.paginate(:per_page => 10, :page => params[:page])    
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :friend)
  end
end
