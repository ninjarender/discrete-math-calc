class InterceptionController < ApplicationController
  def create
    params[:interception_a] = params[:interception_a].split(/,\s*/).uniq.sort.join(", ")
    params[:interception_b] = params[:interception_b].split(/,\s*/).uniq.sort.join(", ")

    @interception_result = (params[:interception_a].split(", ") & params[:interception_b].split(", ")).uniq.sort.join(", ")

    respond_to do |format|
      format.html { render "sets/show" }
    end
  end
end
