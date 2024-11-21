class PrimeNumbersService
  def self.calculate(from: 2, n: 100)
    validate_inputs!(from, n)

    primes = Array.new(n + 1, true)

    (2..Math.sqrt(n)).each do |i|
      (i * i..n).step(i) { |j| primes[j] = false } if primes[i]
    end

    primes.each_index.select { |i| primes[i] && i >= from }
  end

  private

  def self.validate_inputs!(from, to)
    raise ArgumentError, "to is 0" if to == 0
    raise ArgumentError, "from is greater than to" if from > to
    raise ArgumentError, "range is too large" if (to - from) > 1000
  end
end
