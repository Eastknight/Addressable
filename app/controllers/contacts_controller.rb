class ContactsController < ApplicationController
  before_action :authenticate_user!
  
  respond_to :json, :html

  def index
    set_contacts
  end

  def create
    @user = current_user
    @contact = @user.contacts.build(contact_params)
    if @contact.save
      redirect_to contacts_path
    else
      #TODO
    end
  end

  def update
    @contact = Contact.find(params[:id])
    
    respond_to do |format|
      if @contact.update_attributes(contact_params)
        format.json {render :json => true}
      else
        format.json  { render :json => "", :status => :unprocessable_entity }
        format.js  { render :js => "", :status => :unprocessable_entity }
      end
    end
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
    normalized_phone = normalize_phone_number(phone.to_s)
    if normalized_phone.length != 12
      render :json => true
    else
      @user = current_user
      record = @user.contacts.where("phone = ?", normalized_phone).first
      if record.present?
        render :json => false
      else
        render :json => true
      end
    end
  end

  private

  def normalize_phone_number(number)
    filtered_number = number.gsub(/[^0-9]/, "")
    if filtered_number.length == 10
      return  "+1" + filtered_number
    elsif filtered_number.length == 11
      return  "+" + filtered_number
    else
      return "not valid"
    end  
  end

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
