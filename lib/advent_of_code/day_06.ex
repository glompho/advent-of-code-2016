defmodule AdventOfCode.Day06 do
  def part1(input, sort_function \\ &>/2) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.trim() |> String.graphemes()
    end)
    |> Stream.zip()
    |> Enum.map(fn col ->
      col
      |> Tuple.to_list()
      |> Enum.frequencies()
      |> Enum.sort_by(&elem(&1, 1), sort_function)
      |> hd()
      |> elem(0)
    end)
    |> Enum.join("")
  end

  def part2(input) do
    part1(input, &</2)
  end
end
