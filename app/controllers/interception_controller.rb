class InterceptionController < ApplicationController
  def create
    params[:intersection_a] = params[:intersection_a].split(", ").uniq.sort.join(", ")
    params[:intersection_b] = params[:intersection_b].split(", ").uniq.sort.join(", ")

    @intersection_result = (params[:intersection_a].split(", ") & params[:intersection_b].split(", ")).uniq.sort.join(", ")

    respond_to do |format|
      format.html { render "sets/show" }
    end
  end
end
