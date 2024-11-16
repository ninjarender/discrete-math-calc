class RecurrenceRelationsController < ApplicationController
  def index; end

  def create
    @recurrence_relation = params[:recurrence_relation]
    @a_1 = params[:a_1].to_i
    @a_2 = params[:a_2].to_i
    @a_3 = params[:a_3].to_i

    (4..10).each do |i_n|
      a = @recurrence_relation.gsub(/a\(n\s*[\+\-]\s*\d+\)/) do |match|
        operator = match.match(/[\+\-]/)[0]
        number = match.match(/\d+/)[0].to_i

        result = operator == '+' ? i_n + number : i_n - number

        "@a_#{result}"
      end
      instance_variable_set("@a_#{i_n}", eval(a))
    end

    respond_to do |format|
      format.html { render :index, status: :ok }
    end
  end
end
