# frozen_string_literal: true

# Manages pages and actions for controllers
class NotificationsController < ApplicationController
  def index; end

  def create; end

  def destroy; end

  def read_one
    @notification = current_user.notifications.find_by_id(params[:notification_id])
    @notification.mark_read
    respond_to do |format|
      format.js
    end
  end

  def check_notification; end
end
