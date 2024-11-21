class NumberTheory::ModularArithmetic::AdditionController < ApplicationController
  def create
    if params[:addition_mod].to_i == 0
      return respond_to do |format|
        flash[:error] = "mod is 0"
        format.html { render :index, status: :bad_request }
      end
    end

    @mod_add_result = (
      (params[:addition_a].to_i % params[:addition_mod].to_i) +
      (params[:addition_b].to_i % params[:addition_mod].to_i)
    ) % params[:addition_mod].to_i

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
