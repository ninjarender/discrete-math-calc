class NumberTheory::ModuloController < ApplicationController
  def create
    if params[:modulo_mod].to_i == 0
      return respond_to do |format|
        flash[:error] = "mod is 0"
        format.html { render :index, status: :bad_request }
      end
    end

    @modulo_result = params[:modulo_a].to_i % params[:modulo_mod].to_i

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
