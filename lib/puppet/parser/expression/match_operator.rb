require 'puppet'
require 'puppet/parser/expression/branch'

class Puppet::Parser::Expression
  class MatchOperator < Expression::Branch

    attr_accessor :lval, :rval, :operator

    # Iterate across all of our children.
    def each
      [@lval,@rval].each { |child| yield child }
    end

    # Returns a boolean which is the result of the boolean operation
    # of lval and rval operands
    def compute_denotation(scope)
      lval = @lval.denotation(scope)

      return(rval.evaluate_match(lval, scope) ? @operator == "=~" : @operator == "!~")
    end

    def initialize(hash)
      super

      raise ArgumentError, "Invalid regexp operator #{@operator}" unless %w{!~ =~}.include?(@operator)
    end
  end
end
