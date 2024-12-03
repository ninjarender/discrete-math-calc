class GraphTheory::NumberOfVerticesController < ApplicationController
  def create
    sum_of_degrees = params[:edges].to_i * 2

    @number_of_vertices = (
      sum_of_degrees - (params[:vertices].to_i * (params[:degree].to_i - params[:other_degree].to_i))
    ) / params[:other_degree].to_i

    respond_to do |format|
      format.html { render "graph_theory/graph_theories/show" }
    end
  end
end
