defmodule AdventOfCode.Day04 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.split(["[", "]"], trim: true)
    end)
    |> Enum.map(fn [name, checksum] ->
      [[id]] = Regex.scan(~r/\d+/, name)

      {result, _rest} =
        name
        |> String.replace("-", "")
        |> then(&Regex.replace(~r/\d+|-/, &1, ""))
        |> String.graphemes()
        |> Enum.frequencies()
        |> Enum.sort_by(fn {char, freq} -> {1000 - freq, char} end)
        |> Enum.map(fn {char, _freq} -> char end)
        |> Enum.join("")
        |> String.split_at(5)

      {name, result, checksum, id}
    end)
  end

  def part1(input) do
    input
    |> parse()
    |> Enum.reduce(0, fn {_name, result, checksum, id}, acc ->
      # IO.inspect({result, checksum, id, result == checksum})

      if result == checksum do
        acc + String.to_integer(id)
      else
        acc
      end
    end)
  end

  def decode(name, id) do
    name
    |> String.to_charlist()
    |> Enum.map(fn charcode ->
      case charcode do
        ?- ->
          32

        _ ->
          96 + rem(charcode - 96 + String.to_integer(id), 26)
      end
    end)
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(fn {name, _result, _checksum, id} ->
      # IO.inspect({result, checksum, id, result == checksum})
      {"#{decode(name, id)}", id}
    end)
    |> Enum.find(fn {decoded, _id} -> String.contains?(decoded, "northpole") end)
    |> elem(1)
  end
end
