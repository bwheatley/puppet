require 'puppet/parser/expression/leaf'

class Puppet::Parser::Expression
  class HashConstructor < Leaf
    include Enumerable

    def [](index)
    end

    # Evaluate our children.
    def compute_denotation(scope)
      items = {}

      @value.each_pair do |k,v|
        items.merge!({ k => v.denotation(scope) })
      end

      return items
    end

    def merge(hash)
      case hash
      when HashConstructor
        @value = @value.merge(hash.value)
      when Hash
        @value = @value.merge(hash)
      end
    end

    def to_s
      "{" + @value.collect { |v| v.collect { |a| a.to_s }.join(' => ') }.join(', ') + "}"
    end
  end
end
