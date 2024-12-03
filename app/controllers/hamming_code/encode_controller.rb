class HammingCode::EncodeController < ApplicationController
  def create
    d_0, d_1, d_2, d_3 = params[:encode_number].split("").map(&:to_i)

    p_0 = d_0 ^ d_1 ^ d_3
    p_1 = d_1 ^ d_2 ^ d_3
    p_2 = d_0 ^ d_2 ^ d_3

    @encode_result = "#{p_0}#{p_1}#{d_0}#{p_2}#{d_1}#{d_2}#{d_3}"

    respond_to do |format|
      format.html { render "hamming_code/hamming_codes/show" }
    end
  end
end
