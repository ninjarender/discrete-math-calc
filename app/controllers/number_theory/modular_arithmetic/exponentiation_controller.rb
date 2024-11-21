class NumberTheory::ModularArithmetic::ExponentiationController < ApplicationController
  def create
    b = eval(params[:b]).to_i
    e = eval(params[:e]).to_i

    if e > 1000
      return respond_to do |format|
        flash[:error] = "e is too large"
        format.html { render :index, status: :bad_request }
      end
    end

    if params[:mod_exp_mod].to_i == 0
      return respond_to do |format|
        flash[:error] = "mod is 0"
        format.html { render :index, status: :bad_request }
      end
    end

    @result = 1
    exp = 0

    while exp < e
      @mod_exp_result = @mod_exp_result * b % params[:mod_exp_mod].to_i
      exp += 1
    end

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
