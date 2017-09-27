class Admin::AdminController < ApplicationController
  helper_method :is_admin?
  def is_admin?
    unless current_user && current_user.admin?
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end