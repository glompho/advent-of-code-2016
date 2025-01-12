defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02

  test "part1" do
    input = "ULL
RRDDD
LURDL
UUUUD"
    result = part1(input)

    assert result == "1985"
  end

  test "part2" do
    input = "ULL
RRDDD
LURDL
UUUUD"
    result = part2(input)

    assert result == "5DB3"
  end
end
