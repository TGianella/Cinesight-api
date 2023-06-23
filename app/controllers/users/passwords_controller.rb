class Users::PasswordsController < Devise::PasswordsController
  include RackSessionFix
end
