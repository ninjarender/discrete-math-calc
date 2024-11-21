class NumberTheory::PrimeFactorizationController < ApplicationController
  def create
    prime_factors(params[:prime_factorization_number].to_i)

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end

  private

  def prime_factors(n)
    @prime_factors = []

    PrimeNumbersService.calculate(n:).each do |prime|
      while n % prime == 0
        @prime_factors << prime
        n /= prime
      end
    end
  end
end
