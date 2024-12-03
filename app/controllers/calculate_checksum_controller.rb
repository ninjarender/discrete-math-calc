class CalculateChecksumController < ApplicationController
  def index; end

  def create
    sum = params[:message_received].split(" ").map { |block| block.to_i(2) }.sum

    while sum > 0xFF
      carry = sum >> 8
      sum = (sum & 0xFF) + carry
    end

    @checksum_calculated = (~sum & 0xFF).to_s(2).rjust(8, "0")
    @checksum_verification = @checksum_calculated == params[:checksum_received] ? "Correct" : "Incorrect"

    respond_to do |format|
      format.html { render "calculate_checksum/index" }
    end
  end
end
