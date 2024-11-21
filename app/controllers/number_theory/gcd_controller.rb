class NumberTheory::GcdController < ApplicationController
  def create
    @gcd_result = params[:gcd_a].to_i.gcd(params[:gcd_b].to_i)

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
