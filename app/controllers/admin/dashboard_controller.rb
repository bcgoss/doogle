class Admin::DashboardController < Admin::AdminController
  def index
    @entries = Entry.all
    @definitions = Definition.all
  end
end