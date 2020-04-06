# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each
    self.length.times do |e|
      yield(self[e])
    end
  end
  
  def my_each_with_index
    self.length.times do |e|
      yield(self[e], e)
    end
  end
  
  def my_select
    self.length.times do |e|
      if yield(self[e])
        puts self[e]
      end
    end
  end
  
  def my_all?
    self.length.times do |e|
      if yield(self[e]) == false
        return false
      end
    end
    return true
  end
  
  def my_any?
    self.length.times do |e|
      if yield(self[e])
        return true
      end
    end
    return false
  end
  
  def my_none?
    self.length.times do |e|
      if yield(self[e])
        return false
      end
    end
    return true
  end
  
  def my_count
    counter = 0
    self.length.times do |e|
      if yield(self[e])
        counter += 1
      end
    end
    return counter
  end
  
    def my_map(proc=nil)
        newArr = []
            if proc
                self.length.times do |e|
                newArr[e] = proc.call(self[e])
                 end
            else
                self.length.times do |e|
                newArr[e] = yield(self[e])
                 end
                end
        puts newArr
    end
  
    def my_inject(go = 0)
        acum = go
        self.length.times do |e|
            acum = yield(acum, self[e])
        end
        return acum
    end
  
  def multiply_els
    self.my_inject(1) do |k, e|
      k *= e
    end
  end
end
  
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
