class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveModel::MassAssignmentSecurity::Error, with: :render_forbidden_params

  protect_from_forgery
  private
  def render_exception(exception)
    respond_to do |format|
      format.html { render status: 400, text: exception.message }
      format.json { render status: 400, json: {'message' => exception.message }}
    end
  end

  def render_not_found
    respond_to do |format|
      format.html { render status: 404, text: "Record not found" }
      format.json { render status: 404, json: {'message' => "Record not found"}}
    end
  end

  def render_forbidden_params
    respond_to do |format|
      format.html { render status: 400, text: "Forbidded parameters given" }
      format.json { render status: 404, json: {'message' => "Forbidden parameters given"}}
    end
  end

  def next_page()
    (params[:page].to_i+1).to_s
  end
end
