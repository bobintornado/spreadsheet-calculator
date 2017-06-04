class RPNExpression
  def initialize(tokens)
    @tokens = tokens
    @stack = []
  end

  def evaluate
    @tokens.each do |token|
      if token.is_a? Float
        @stack.push(token)
      elsif token == "+"
        rhs = @stack.pop
        lhs = @stack.pop
        @stack.push(lhs + rhs)
      elsif token == "*"
        rhs = @stack.pop
        lhs = @stack.pop
        @stack.push(lhs * rhs)
      elsif token == "-"
        rhs = @stack.pop
        lhs = @stack.pop
        @stack.push(lhs - rhs)
      elsif token == "/"
        rhs = @stack.pop
        lhs = @stack.pop
        @stack.push(lhs / rhs)
      elsif token == "++"
        val = @stack.pop
        @stack.push(val + 1)
      elsif token == "--"
        val = @stack.pop
        @stack.push(val - 1)
      else
        raise "Whaaaat I don't know this token?"
      end
    end

    @stack.pop
  end
end
