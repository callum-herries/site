# Piping Python

Today I was writing some Python code where I needed to pipe data through a sequence of steps.
You can do this in R with the pipe operator `%>%`, and in Clojure with the threading macro `->` but Python only has plain old function calls.
Luckily I came across [pipetools](https://github.com/0101/pipetools), a library that adds this functionality in Python.

Piping values through functions is best suited to problems where:
- You calculate a value from a sequence of steps
- You do not need to name intermediate values

Let's take some code from a respected Python programmer, and try to implement it with pipetools. Here's Peter Norvig's solution to 2018 Advent of Code, Day 11:

The power level in a given fuel cell can be found through the following process:
1. Find the fuel cell's rack ID, which is its X coordinate plus 10.
2. Begin with a power level of the rack ID times the Y coordinate.
3. Increase the power level by the value of the grid serial number (your puzzle input).
4. Set the power level to itself multiplied by the rack ID.
5. Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
6. Subtract 5 from the power level.

Here is Norvig's Python code:
```
def power_level(point):
    rack_id = point[0] + 10
    level = (rack_id * point[1] + serial) * rack_id
    return (level // 100) % 10 - 5
```

And here's my code, written with pipetools:
```
def power_level(point):
    rack_id = point[0] + 10 # Find the fuel cell's rack ID, which is its X coordinate plus 10.
    return rack_id > (pipe
        | X * point[1]    # Begin with a power level of the rack ID times the Y coordinate.
        | X + serial      # Increase the power level by the value of the grid serial number (your puzzle input).
        | X * rack_id     # Set the power level to itself multiplied by the rack ID.
        | (X // 100) % 10 # Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
        | X - 5           # Subtract 5 from the power level.
    )
```

Norig's solution is dense, and it's not so easy to see how the code translates to the instructions.
It's also not clear why he created a 'level' variable, only to perform some more operations on it.
It would be worse if the problem was 10 times longer. Sure, my piped solution has more lines, but once you understand that it's just a pipeline, it's easier to break down and read. Every step in the written instructions has a corresponding line in the code.

By the way, this is the Clojure version, with the threading macro:

```
(defn power-level [[x y]]
  (let [rack-id (+ x 10)] ; Find the fuel cell's rack ID, which is its X coordinate plus 10.
    (-> rack-id
      (* y)               ; Begin with a power level of the rack ID times the Y coordinate.
      (+ serial)          ; Increase the power level by the value of the grid serial number (your puzzle input).
      (* rack-id)         ; Set the power level to itself multiplied by the rack ID.
      (quot 100)          ; Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
      (mod 10)
      (- 5))))            ; Subtract 5 from the power level.
```
