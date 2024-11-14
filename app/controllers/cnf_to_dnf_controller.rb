class CnfToDnfController < ApplicationController
  def index; end

  def create
    expression = params[:cnf].strip.gsub("~", "!").gsub("-", "!").gsub("+", "||").gsub(")(", ") && (").gsub(") (", ") && (").upcase

    @variables = expression.scan(/[A-Z]+/).uniq
    num_rows = 2 ** @variables.size

    @table = num_rows.times.map do |i|
      values = i.to_s(2).rjust(@variables.size, "0").chars.map { |bit| bit == "1" }
      Hash[@variables.zip(values)].merge("result" => evaluate_expression(expression, Hash[@variables.zip(values)]))
    end.map { |h| h.transform_keys { |k| k.downcase } }

    @dnf_terms = @table.select { |row| row["result"] == true }.map do |row|
      @variables.map(&:downcase).map { |var| row[var] ? var : "~#{var}" }.join
    end.join("+")

    respond_to do |format|
      format.html { render :index, status: :ok }
    end
  rescue
    respond_to do |format|
      flash[:error] = "Invalid expression"
      format.html { render :index, status: :bad_request }
    end
  end

  private

  def evaluate_expression(expression, values)
    values.each do |variable, value|
      expression = expression.gsub(variable, value.to_s)
    end
    eval(expression)
  end
end
