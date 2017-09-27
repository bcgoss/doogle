class Admin::DashboardController < Admin::AdminController
  before_action :is_admin?

  def index
    @entries = Entry.all
    @definitions = Definition.all
  end
end