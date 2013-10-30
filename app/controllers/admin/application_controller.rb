class Admin::ApplicationController < ApplicationController
  layout 'admin'
=begin
  before_filter :require_login
  before_filter :requires_admin
=end
end