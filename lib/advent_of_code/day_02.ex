defmodule AdventOfCode.Day02 do
  def draw_grid(grid) do
    {max_row, max_col} =
      grid
      |> Map.keys()
      |> Enum.reduce({0, 0}, fn {row, col}, {max_row, max_col} ->
        {max(row, max_row), max(col, max_col)}
      end)

    IO.puts("\n")

    for col <- 0..max_col do
      for row <- 0..max_row do
        case grid[{row, col}] do
          nil -> " "
          char -> char
        end
      end
      |> IO.puts()
    end

    grid
  end

  @part2_key_pad %{
    {1, 1} => "2",
    {2, 0} => "1",
    {2, 1} => "3",
    {3, 1} => "4",
    {0, 2} => "5",
    {1, 2} => "6",
    {2, 2} => "7",
    {3, 2} => "8",
    {4, 2} => "9",
    {1, 3} => "A",
    {2, 3} => "B",
    {3, 3} => "C",
    {2, 4} => "D"
  }

  def fix_num(n) do
    case n do
      3 -> 2
      -1 -> 0
      n -> n
    end
  end

  def fix_pos({x, y}) do
    {fix_num(x), fix_num(y)}
  end

  def do_step(char, {x, y}) do
    case char do
      "U" -> {x, y - 1}
      "D" -> {x, y + 1}
      "L" -> {x - 1, y}
      "R" -> {x + 1, y}
    end
  end

  def do_line(line, {x, y}, part \\ :part_one) do
    case part do
      :part_one -> do_line_part_one(line, {x, y})
      :part_two -> do_line_part_two(line, {x, y})
    end
  end

  def do_line_part_one(line, {x, y}) do
    line
    |> String.trim()
    |> String.graphemes()
    |> Enum.reduce({x, y}, fn char, {x, y} ->
      char
      |> do_step({x, y})
      |> fix_pos()
    end)
  end

  def do_line_part_two(line, {x, y}) do
    line
    |> String.trim()
    |> String.graphemes()
    |> Enum.reduce({x, y}, fn char, {x, y} ->
      new_pos = do_step(char, {x, y})

      if new_pos in Map.keys(@part2_key_pad) do
        new_pos
      else
        {x, y}
      end
    end)
  end

  def compute_num({x, y}, part \\ :part_one) do
    case part do
      :part_one -> x + 1 + y * 3
      :part_two -> @part2_key_pad[{x, y}]
    end
  end

  def compute_code(input, {sx, sy}, part \\ :part_one) do
    input
    |> String.split(["\n", "\r"], trim: true)
    |> Enum.reduce({{sx, sy}, []}, fn line, {{x, y}, code} ->
      new_pos =
        {nx, ny} = do_line(line, {x, y}, part)

      # IO.inspect({{x, y}, line, {nx, ny}, compute_num(new_pos, part)})
      {{nx, ny}, [compute_num(new_pos, part) | code]}
    end)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join("")
  end

  def part1(input) do
    compute_code(input, {1, 1})
  end

  def part2(input) do
    compute_code(input, {0, 2}, :part_two)
  end
end
