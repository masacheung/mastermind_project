class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(array)
    array.each do |char|
      return false if !POSSIBLE_PEGS.has_key?(char.upcase)
    end
    true
  end

  def initialize(pegs)
    raise_error if !Code.valid_pegs?(pegs)
    @pegs = pegs.map(&:upcase)
  end

  def self.random(length)
    pegs = Array.new(length) {POSSIBLE_PEGS.keys.sample}
    Code.new(pegs)
  end

  def self.from_string(string)
    Code.new(string.split(""))
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code)
    count = 0
    (0...length).each do |i| 
      count += 1 if @pegs[i] == code[i]
    end
    count
  end

  def num_near_matches(code)
    p_hash = Hash.new(0)
    c_hash = Hash.new(0)
    (0...length).each do |i|
      if @pegs[i] != code[i]
        p_hash[@pegs[i]] += 1
        c_hash[code[i]] += 1
      end
    end

    count = 0
    p_hash.each do |k, v|
      if c_hash.has_key?(k)
        if c_hash[k] > p_hash[k]
          count += p_hash[k]
        else
          count += c_hash[k]
        end
      end
    end
    count
  end

  def ==(code)
    code == @pegs
  end
end