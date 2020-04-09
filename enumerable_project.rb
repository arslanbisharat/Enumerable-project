# rubocop: disable Metrics/ModuleLength 
# rubocop: enable Metrics/ModuleLength 
module Enumerable
  def my_each
    if self.class == Array
      0.upto(self.length - 1) do |i|
        yield(self[i])
      end
    elsif self.class == Hash
      for key in self
        yield(key[0].to_s, key[1])
      end
    end
  end

  def my_each_with_index
    if self.class == Array
      0.upto(self.length - 1) do |i|
        yield(self[i], i)
      end
    elsif self.class == Hash
      i = 0
      for key in self
        yield([key[0].to_s, key[1]], i)
        i+=1
      end
    end
  end

  def my_select
    if self.class == Array
      arr = []
      0.upto(self.length-1) do |i|
        arr << self[i] if yield(self[i])
      end
      return arr
    elsif self.class == Hash
      hash = Hash.new
      for key in self
        hash[key[0]] = key[1] if yield(key[0], key[1])
      end
      return hash
    end
  end

  def my_all?
    if self.class == Array
      0.upto(self.length-1) do |i|
        return false unless yield(self[i])
      end
      return true
    elsif self.class == Hash
      for key in self
        return false unless yield(key[0], key[1])
      end
      return true
    end
  end

  def my_none?
    if self.class == Array
      0.upto(self.length-1) do |i|
        return false if yield(self[i])
      end
      return true
    elsif self.class == Hash
      for key in self
        return false if yield(key[0], key[1])
      end
      return true
    end
  end

  def my_count
    count = 0
    if self.class == Array
      0.upto(self.length-1) do |i|
        count += 1 if yield(self[i])
      end
    elsif self.class == Hash
      for key in self
        count += 1 if yield(key[0], key[1])
      end
    end
    return count
  end

  def my_map my_proc=nil
    arr = []
    if self.class == Array
      0.upto(self.length - 1) do |i|
        my_proc ? arr << my_proc.call(i) : arr << yield(self[i])
      end
    elsif self.class == Hash
      for key in self
        my_proc ? arr << my_proc.call(key[0], key[1]) : arr << yield(key[0], key[1])
      end
    end
    return arr
  end

  def my_inject initial=nil
    unless initial
      initial = 0 if self.first.class == Integer || self.first.class == Float
      initial = "" if self.first.class == String
      initial = [] if self.first.class == Array
      initial = {} if self.first.class == Hash
    end
    total = initial
    if self.class == Array
      0.upto(self.length-1) do |i|
        total = yield(total, self[i])
      end
    elsif self.class == Hash
      for key in self
        total = yield(total, [key[0], key[1]])
      end
    end
    return total
  end
end

def multiply_els(arr)
  arr.my_inject(1){|a, b| a *= b}
end

p multiply_els([2,4,5])

=begin
puts "Testing my_each"
sample_arr.each{|v| print "#{v*2}, "}
puts ""
sample_arr.my_each{|v| print "#{v*2}, "}
puts ""
sample_hash.each{|k, v| print "#{k}: #{v}, "}
puts ""
sample_hash.my_each{|k, v| print "#{k}: #{v}, "}
puts ""
=end
=begin
puts "Testing my_each_with_index"
sample_arr.each_with_index{|v, i| print "#{v*i}, "}
puts ""
sample_arr.my_each_with_index{|v, i| print "#{v*i}, "}
puts ""
sample_hash.each_with_index{|(k, v), i| puts "#{k}, #{v}, and index is #{i}, "}
sample_hash.my_each_with_index{|(k, v), i| puts "#{k}, #{v}, and index is #{i}, "}
puts "Testing my_select"
p sample_arr.select{|v| v >= 3}
p sample_arr.my_select{|v| v >= 3}
p sample_hash.select{|k, v| v >= 3}
p sample_hash.my_select{|k, v| v >= 3}
p sample_hash.select{|k, v| k.length > 3}
p sample_hash.my_select{|k, v| k.length > 3}
p sample_hash.select{|k, v| k.length > v}
p sample_hash.my_select{|k, v| k.length > v}
puts "Testing my_all?"
p sample_arr.all?{|v| v <= 5}
p sample_arr.my_all?{|v| v <= 5}
p sample_arr.all?{|v| v < 5}
p sample_arr.my_all?{|v| v < 5}
p sample_hash.all?{|k, v| v >= 3}
p sample_hash.my_all?{|k, v| v >= 3}
p sample_hash.all?{|k, v| v <= 5}
p sample_hash.my_all?{|k, v| v <= 5}
p sample_hash.all?{|k, v| k.length >= 3}
p sample_hash.my_all?{|k, v| k.length >= 3}
p sample_hash.all?{|k, v| k.length > 3}
p sample_hash.my_all?{|k, v| k.length > 3}
p sample_hash.all?{|k, v| k.length > v}
p sample_hash.my_all?{|k, v| k.length > v}
puts "Testing my_none?"
p sample_arr.none?{|v| v >= 5}
p sample_arr.my_none?{|v| v >= 5}
p sample_arr.none?{|v| v > 5}
p sample_arr.my_none?{|v| v > 5}
p sample_hash.none?{|k, v| v > 5}
p sample_hash.my_none?{|k, v| v > 5}
p sample_hash.none?{|k, v| v >= 5}
p sample_hash.my_none?{|k, v| v >= 5}
p sample_hash.none?{|k, v| k.length >= 5}
p sample_hash.my_none?{|k, v| k.length >= 5}
p sample_hash.none?{|k, v| k.length > 5}
p sample_hash.my_none?{|k, v| k.length > 5}
p sample_hash.none?{|k, v| k.length > v}
p sample_hash.my_none?{|k, v| k.length > v}
puts "Testing count"
p sample_arr.count{|v| v >= 4}
p sample_arr.my_count{|v| v >= 4}
p sample_hash.count{|k, v| v >= 2}
p sample_hash.my_count{|k, v| v >= 2}
p sample_hash.count{|k, v| k.length > 3}
p sample_hash.my_count{|k, v| k.length > 3}
p sample_hash.count{|k, v| k.length >= v}
p sample_hash.my_count{|k, v| k.length >= v}
puts "Testing my_map"
p sample_arr.map{|v| v*2}
p sample_arr.my_map{|v| v*2}
p sample_hash.map{|k, v| {k.to_s => v*1.5}}
p sample_hash.my_map{|k, v| {k.to_s => v*1.5}}
puts "Testing my_map with proc"
sample_array_proc = Proc.new{|v| v*2}
sample_hash_proc = Proc.new{|k, v| {k.to_s => v*2.5}}
p sample_arr.my_map(sample_array_proc)
p sample_hash.my_map(sample_hash_proc)
puts "Testing my_inject"
p sample_arr.inject{|a, b| a += b}
p ["a", "b", "c"].inject{|a, b| a += b}
#p [[1], [3, 3], [2, 2, 2, 2]].inject{|a, b| a += b.length} TypeError
#p [[1], [3, 3], [2, 2, 2, 2]].my_inject{|a, b| a += b.length} TypeError
p sample_arr.my_inject{|a, b| a += b}
p ["a", "b", "c"].my_inject{|a, b| a += b}
p sample_arr.inject(2){|a, b| a += b}
p ["a", "b", "c"].inject("z"){|a, b| a += b}
p [[1], [3, 3], [2, 2, 2, 2]].inject(0){|a, b| a += b.length}
p [[1], [3, 3], [2, 2, 2, 2]].my_inject(0){|a, b| a += b.length}
p [[1], [3, 3], [2, 2, 2, 2]].inject(2){|a, b| a += b.length}
p [[1], [3, 3], [2, 2, 2, 2]].my_inject(2){|a, b| a += b.length}
p sample_arr.my_inject(2){|a, b| a += b}
p ["a", "b", "c"].my_inject("z"){|a, b| a += b}
p sample_hash.inject(""){|a, (k, v)| a += k.to_s + v.to_s}
p sample_hash.my_inject(""){|a, (k, v)| a += k.to_s + v.to_s}
=end
