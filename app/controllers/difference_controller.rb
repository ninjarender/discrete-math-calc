class DifferenceController < ApplicationController
  def create
    params[:difference_a] = params[:difference_a].split(/,\s*/).uniq.sort.join(", ")
    params[:difference_b] = params[:difference_b].split(/,\s*/).uniq.sort.join(", ")

    @difference_result = (params[:difference_a].split(", ") - params[:difference_b].split(", ")).uniq.sort.join(", ")

    respond_to do |format|
      format.html { render "sets/show" }
    end
  end
end
