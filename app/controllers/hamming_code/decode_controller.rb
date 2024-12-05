class HammingCode::DecodeController < ApplicationController
  def create
    @p_0, @p_1, @d_0, @p_2, @d_1, @d_2, @d_3 = params[:decode_number].split("").map(&:to_i)

    p_0_check = @p_0 ^ @d_0 ^ @d_1 ^ @d_3
    p_1_check = @p_1 ^ @d_1 ^ @d_2 ^ @d_3
    p_2_check = @p_2 ^ @d_0 ^ @d_2 ^ @d_3

    @syndrome = "#{p_2_check}#{p_1_check}#{p_0_check}"
    @decode_result = if @syndrome == "000"
      "#{@d_0}#{@d_1}#{@d_2}#{@d_3}"
    else
      syndrome_int = @syndrome.to_i(2) - 1
      instance_variable_set(
        "#{%w[ @p_0 @p_1 @d_0 @p_2 @d_1 @d_2 @d_3 ][syndrome_int]}",
        [ @p_0, @p_1, @d_0, @p_2, @d_1, @d_2, @d_3 ][syndrome_int] ^ 1
      )

      "#{@d_0}#{@d_1}#{@d_2}#{@d_3}"
    end

    respond_to do |format|
      format.html { render "hamming_code/hamming_codes/show" }
    end
  end
end
