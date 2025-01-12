defmodule AdventOfCode.Day05 do
  def find_hashes(input) do
    Stream.iterate(
      {nil, 0},
      fn {_hash, n} ->
        next = n + 1

        nhash =
          :crypto.hash(:md5, String.trim(input) <> Integer.to_string(next))
          |> Base.encode16(case: :lower)

        {nhash, next}
      end
    )
  end

  def find_password(hash_stream, part) do
    hash_stream
    # |> Enum.take(5)
    |> Enum.reduce_while({[], []}, fn
      {_, _}, {index, pwd} when length(pwd) == 8 ->
        {:halt, {index, pwd}}

      {hash, _n}, {index, password} ->
        case hash do
          <<"00000"::binary, char1::utf8, char2::utf8, _rest::binary>> ->
            # IO.inspect({hash, List.to_string([char1])})
            # IO.inspect({char1, char1 <= 55})
            # dbg()

            cond do
              part == :part_one ->
                {:cont, {[char1 | index], [char2 | password]}}

              part == :part_two and char1 <= 55 and char1 not in index ->
                {:cont, {[char1 | index], [char2 | password]}}

              true ->
                {:cont, {index, password}}
            end

          _ ->
            {:cont, {index, password}}
        end
    end)
  end

  def part1(input) do
    input
    |> find_hashes()
    |> find_password(:part_one)
    |> elem(0)
    |> Enum.reverse()
    |> List.to_string()
  end

  def part2(input) do
    input
    |> find_hashes()
    |> find_password(:part_two)
    |> Tuple.to_list()
    |> Enum.zip()
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
    |> List.to_string()
  end
end
