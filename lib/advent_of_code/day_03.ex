defmodule AdventOfCode.Day03 do
  def parse(input) do
    input
    |> String.split(["\n", " ", "\r"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
  end

  def part1(input) do
    input
    |> parse()
    |> Enum.map(&Enum.sort/1)
    |> Enum.filter(fn [a, b, c] ->
      # IO.inspect([a, b, c, a + b > c])
      a + b > c
    end)
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.zip()
    |> Enum.flat_map(fn tuple ->
      tuple
      |> Tuple.to_list()
      |> Enum.chunk_every(3)
    end)
    |> Enum.filter(fn [a, b, c] ->
      Enum.all?([a + b > c, a + c > b, c + b > a])
    end)
    |> Enum.count()
  end
end
