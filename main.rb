require 'set'
require './rpn'

# read line one, allocate the two dimensional array
width, height = ARGF.readline().split(' ').map(&:to_i)
$spreadsheet = Array.new(height){ Array.new(width) }

# read the rest from STDIN and fill in the content of the 2D array
row = 0
column = 0
ARGF.each do |input|
  $spreadsheet[row][column] = input.strip()

  column = column + 1
  if column == width
    column = 0
    row = row + 1
  end
end

# recursive cell evaluation function
def evaluate(content, row, col, visits=nil)
  # return actual value if content already evaluated
  return content if content.is_a?(Float)

  # token has three cases, reference, number or operator
  # evaulate each token indvidually and return new array without references
  postfix_tokens = content.split(' ').map do |token|
     # if token is a reference
    if token =~ (/[A-Z][0-9]/)
      target_row = token.chars[0].ord - 'A'.ord
      target_col = token.chars[1].to_i - 1

      # cycle detection
      visits ||= Set.new
      cordinate = "#{target_row}-#{target_col}"
      if visits.include?(cordinate)
        raise 'Cyclic dependencies, program exiting..'
      else
        visits.add(cordinate)
      end

      $spreadsheet[target_row][target_col] = evaluate($spreadsheet[target_row][target_col], target_row, target_col, visits)
    else 
      # if token is number? other wise operator
      begin
        Float(token)
      rescue ArgumentError
        token
      end
    end
  end

  # evaluate postfix tokenks and set value
  $spreadsheet[row][col] = RPNExpression.new(postfix_tokens).evaluate
end

# evaluate each cell one by one
$spreadsheet.each_with_index do |row, row_num|
  row.each_with_index do |content, col_num|
    evaluate(content, row_num, col_num)
  end
end

# print result
puts  "#{width} #{height}"

$spreadsheet.each_with_index do |row, row_num|
  row.each_with_index do |content, col_num|
    puts '%.5f' % content
  end
end
