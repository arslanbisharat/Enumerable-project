module Enumerable
  def my_each
    self.length.times do |x|
      yield(self[x])
    end
  end

  def my_each_with_index
    self.length.times do |x|
      yield(self[x], x)
    end
  end

    def my_select
        self.length.times do |x|
            if yield(self[x])
                puts self[x]
            end
        end
    end

    def my_all?
        self.length.times do |x|
            if yield(self[x]) == false
                return false
            end
        end
        return true
    end

    def my_any?
        self.length.times do |x|
            if yield(self[x])
                return true
            end
        end
        return false
    end

    def my_none?
        self.length.times do |x|
            if yield(self[x])
                return false
            end
        end
        return true
    end

    def my_count
        counter = 0
        self.length.times do |x|
            if yield(self[x])
                counter += 1
            end
        end
        return counter
    end

    def my_map(proc=nil)
        newArr = []
            if proc
                self.length.times do |x|
                newArr[x] = proc.call(self[x])
                 end
            else
                self.length.times do |x|
                newArr[x] = yield(self[x])
                 end
                end
        puts newArr
    end

  def my_inject(go = 0)
    acum = go
    self.length.times do |x|
        acum = yield(acum, self[x])
    end
    return acum
  end
    
  def multiply_els
    self.my_inject(1) do |k, x|
      k *= x
    end
  end
end
