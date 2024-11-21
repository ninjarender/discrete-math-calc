class NumberTheory::ModularArithmetic::LinearCongruenceController < ApplicationController
  include ExtendedGcd
  def create
    a = params[:linear_congruence_a].to_i
    b = params[:linear_congruence_b].to_i
    n = params[:linear_congruence_mod].to_i

    gcd, _ = ExtendedGcd.extended_gcd(a, n)

    if b % gcd != 0
      return respond_to do |format|
        flash[:error] = "DNE"
        format.html { render :index, status: :bad_request }
      end
    end

    a_prime = a / gcd
    b_prime = b / gcd
    n_prime = n / gcd

    gcd, inv_a_prime, _ = ExtendedGcd.extended_gcd(a_prime, n_prime)
    x0 = (inv_a_prime * b_prime) % n_prime
    x0 += n_prime if x0 < 0

    @linear_congruence_result = (0..10).map { |i| x0 + i * n_prime }

    respond_to do |format|
      format.html { render "number_theory/number_theories/show" }
    end
  end
end
