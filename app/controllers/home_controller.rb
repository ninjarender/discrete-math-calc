class HomeController < ApplicationController
  layout "empty", only: %i[health_and_fitness]

  def index; end

  def health_and_fitness; end
end
