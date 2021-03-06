# encoding: utf-8
# frozen_string_literal: true

module MessageBroker
  # SortedArray extends functionality of general purpose
  # array and keeps its content sorted. Only required
  # methods implemented.
  class SortedArray < Array
    def initialize(*args, &sort_by)
      @sort_by = sort_by || proc { |x, y| x <=> y }
      super(*args)
      sort!(&sort_by)
    end

    def <<(v)
      #insert(0, v)

      self.push(v)
      return if self.length == 1

      i = self.length-1
      while (i -= 1) >= 0 do
        break unless @sort_by.call(self[i], self[i+1]) > 0
        self[i], self[i+1] = self[i+1], self[i]
      end
    end

    def delete_first
      shift
    end

    private

    # def insert(_i, v)
    #   insert_before = bsearch_index { |x| @sort_by.call(x, v) >= 0 }
    #   super(insert_before ? insert_before : -1, v)
    # end

  end
end
