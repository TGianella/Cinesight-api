module Users
  class PasswordsController < Devise::PasswordsController
    include RackSessionFix
  end
end
