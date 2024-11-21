module ExtendedGcd
  def self.extended_gcd(a, b)
    if b == 0
      [ a, 1, 0 ]
    else
      gcd, x, y = extended_gcd(b, a % b)
      [ gcd, y, x - (a / b) * y ]
    end
  end
end
