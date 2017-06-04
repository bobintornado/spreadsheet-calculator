# Breakdown

1. Reverse Polish Notation evaluation part.
2. Reference resolving. Translate reference such as A1,B1 into index of a two dimensional array. This also introduces a sub-problem of cyclic dependencies, so bookkeeping is required to solve it.

# Solution

Step 1. Construct raw 2 dimensional array

Step 2. Evaluate each row recursively when counter reference tokens

Step 3. Evaluate RPN

# Run 

`cat input_1 | ruby main.rb`

`cat input_2 | ruby main.rb`

# Extra

* support negative numbers 
* include increment and decrement operators (++ and --)
