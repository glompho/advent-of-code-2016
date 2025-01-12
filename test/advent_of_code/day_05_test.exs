defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05

  @tag :skip
  test "part1" do
    input = "abc"
    result = part1(input)

    assert result == "18f47a30"
  end

  @tag :skip
  test "part2" do
    input = "abc"
    result = part2(input)

    assert result == "05ace8e3"
  end
end
