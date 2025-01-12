defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03

  test "part1" do
    input = "5 10 25
    5 12 13"
    result = part1(input)

    assert result == 1
  end

  test "part2" do
    input = "5 10 25
    12 5 10
    13 12 5
    "
    result = part2(input)

    assert result == 2
  end
end
