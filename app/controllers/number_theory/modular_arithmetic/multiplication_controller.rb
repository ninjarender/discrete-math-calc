class NumberTheory::ModularArithmetic::MultiplicationController < ApplicationController
  def create
    if params[:multiplication_mod].to_i == 0
      return respond_to do |format|
        flash[:error] = "mod is 0"
        format.html { render :index, status: :bad_request }
      end
    end

    @multiplication_result = (
      (params[:multiplication_a].to_i % params[:multiplication_mod].to_i) *
      (params[:multiplication_b].to_i % params[:multiplication_mod].to_i)
    ) % params[:multiplication_mod].to_i

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
