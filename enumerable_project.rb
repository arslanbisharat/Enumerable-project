# frozen_string_literal: true

module Enumerable
  def my_each
    return self unless block_given?

    (0..length - 1).each do |i|
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    return self unless block_given?

    (0..length - 1).each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    return self unless block_given?

    arr = []
    my_each do |x|
      arr << x if yield(x) == true
    end
    arr
  end

  def my_all?
    return self unless block_given?

    my_each do |x|
      return false if yield(x) == false
    end
    true
  end

  def my_any?
    return self unless block_given?

    my_each do |x|
      return true if yield(x) == true
    end
    false
  end

  def my_none?
    return self unless block_given?

    my_each do |x|
      return false if yield(x) == true
    end
    true
  end

  def my_count(*args)
    if args.empty?
      return length unless block_given?

      i = 0
      my_each do |x|
        i += 1 if yield(x) == true
      end
      i
    else
      i = 0
      my_each do |x|
        i += 1 if args[0] == x
      end
      i
    end
  end

  def my_map
    return self if proc.nil? && !block_given?

    arr = []
    my_each do |x|
      val = proc.nil? ? yield(x) : proc.call(x)
      arr << val
    end
    arr
  end

  def my_inject(acc = self[0])
    return self unless block_given?

    my_each do |x|
      if x == acc
        next
      else
        acc = yield(acc, x)
      end
    end
    acc
  end
end

def multiply_els(arr)
  mult = arr.my_inject { |x, y| x * y }
  mult
end

puts multiply_els([1, 2, 3])

# ****************************************************************
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>TESTS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#
# arr = [1, 3, 5]
# arr.my_each { |x| puts x*2}
#
# arr = [1, 3, 5]
# arr.my_each_with_index { |x, y| puts "#{y}. #{x}"}
#
# rnd = [1, 3, 5, 2, 4]
# rnd.my_select { |x| x.even?}
#
# ar = [2, 4, 6]
# ar.my_all? { |x| x.even?}
#
# ar = [2, 4, 6, 3]
# ar.my_any? { |x| x.even?}
#
# ar = [3, 1, 1, 3]
# ar.my_none? { |x| x.even?}
#
# ar = [3, 1, 1, 2]
# ar.my_count { |x| x.even?}
#
# ar = [3, 1, 1, 2]
# nar=ar.my_map{ |x| x.even?}
#
# ar = [3, 2, 1]
# ar.my_inject{|x, y| x + y}
#
# ****************************************************************