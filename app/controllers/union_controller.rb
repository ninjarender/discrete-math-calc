class UnionController < ApplicationController
  def create
    params[:union_a] = params[:union_a].split(", ").uniq.sort.join(", ")
    params[:union_b] = params[:union_b].split(", ").uniq.sort.join(", ")

    @union_result = (params[:union_a].split(", ") | params[:union_b].split(", ")).uniq.sort.join(", ")

    respond_to do |format|
      format.html { render "sets/show" }
    end
  end
end
