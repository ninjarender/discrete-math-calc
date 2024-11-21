class NumberTheory::PrimeNumbersController < ApplicationController
  def create
    @prime_numbers = PrimeNumbersService.calculate(
      from: params[:prime_number_from].to_i,
      n: params[:prime_number_to].to_i
    )

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  rescue ArgumentError => e
    respond_to do |format|
      flash[:error] = e.message
      format.html { render "number_theory/number_theories/show", status: :bad_request }
    end
  end
end
