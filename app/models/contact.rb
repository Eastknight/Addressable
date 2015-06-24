class Contact < ActiveRecord::Base
  belongs_to :user

  default_scope {order('name ASC')}
end
