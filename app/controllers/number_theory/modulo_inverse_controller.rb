class NumberTheory::ModuloInverseController < ApplicationController
  include ExtendedGcd

  def create
    gcd, x, _ = ExtendedGcd.extended_gcd(params[:modulo_inverse_a].to_i, params[:modulo_inverse_mod].to_i)
    @modulo_inverse_result = if gcd != 1
      "DNE"
    else
      x % params[:modulo_inverse_mod].to_i
    end

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
