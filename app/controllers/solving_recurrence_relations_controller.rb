require 'matrix'

class SolvingRecurrenceRelationsController < ApplicationController
  def index; end

  def create
    coefficients = []

    params[:recurrence_relation].scan(/(-?\s*\d*)\s*\*\s*a\(n\s*([\+\-]?\s*\d+)?\)/).each do |coef, offset|
      coef = coef.empty? ? 1 : coef.gsub(' ', '').to_i
      offset = offset.nil? ? 0 : offset.to_i

      if offset == 0
        coefficients[2] = coef
      elsif offset == -1
        coefficients[1] = coef
      elsif offset == -2
        coefficients[0] = coef
      end
    end

    coefficients.map! { |c| c.nil? ? 0 : c }

    terms = []
    terms << "#{coefficients[2]}k^2" if coefficients[2] != 0
    terms << "#{coefficients[1]}k" if coefficients[1] != 0
    terms << coefficients[0].to_s if coefficients[0] != 0

    quadratic = terms.join(" + ").gsub("+ -", "- ")

    match = quadratic.match(/([+-]?\d*)k\^2\s*([+-]\s*\d*)k\s*([+-]\s*\d+)/)

    if match
      a = match[1].strip.empty? ? 1 : match[1].to_i
      b = match[2].strip.empty? ? 1 : match[2].gsub(/\s+/, "").to_i
      c = match[3].strip.empty? ? 1 : match[3].gsub(/\s+/, "").to_i
    end

    discriminant = b**2 - 4 * a * c

    if discriminant > 0
      r1 = (-b + Math.sqrt(discriminant)) / (2 * a)
      r2 = (-b - Math.sqrt(discriminant)) / (2 * a)
    elsif discriminant == 0
      r1 = r2 = -b / (2 * a)
    else
      return respond_to do |format|
        flash[:error] = "The roots are complex numbers."
        format.html { render :index, status: :ok }
      end
    end

    a1 = params[:a_1].to_i
    a2 = params[:a_2].to_i
    system_matrix = Matrix[[r1, r2], [r1**2, r2**2]]
    results_vector = Vector[a1, a2]

    @solve = if system_matrix.regular?
      constants = system_matrix.inverse * results_vector
      c1, c2 = constants.to_a

      "#{c1.round(4)} * #{r1} ** n + #{c2.round(4)} * #{r2} ** n"
    else
      if r1 == r2
        "C1 * #{r1} ** n + C2 * n * #{r1} ** n"
      else
        "C1 * #{r1} ** n + C2 * #{r2} ** n"
      end
    end

    respond_to do |format|
      format.html { render :index, status: :ok }
    end
  end
end
