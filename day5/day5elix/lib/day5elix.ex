defmodule Day5elix do
  defmodule Help do
    def get_lines(file) do
      [c, m] =
        File.read!(file)
        |> String.split("\r\n\r\n")

      c =
        c
        |> String.split("\r\n")
        |> Enum.take_while(fn line -> String.contains?(line, "1") == false end)
        |> Enum.map(fn a ->
          a
          |> String.replace("    ", "[hodei]")
          |> String.replace("]", "")
          |> String.split("[", trim: true)
          |> Enum.map(&String.trim/1)
          |> Enum.with_index()
          |> Enum.filter(fn {c, _b} -> c != "hodei" end)
        end)
        |> List.flatten()
        |> Enum.group_by(fn {_hitz, index} -> index + 1 end, fn {hitz, _index} -> hitz end)

      m =
        m
        |> String.split("\r\n")
        |> Enum.map(fn line ->
          [box, fr] = String.split(line, " from ")

          amount =
            String.split(box, " ", trim: true)
            |> Enum.at(-1)
            |> String.to_integer()

          [from, to] =
            String.split(fr, " to ", trim: true)
            |> Enum.map(&String.to_integer/1)

          %{amount: amount, from: from, to: to}
        end)

      %{c: c, m: m}
    end

    def move(a, track_n_to, track_n_from) do
      m_to = Kernel.elem(Enum.at(Map.get(a, :c), track_n_to), 1)
      m_from = Kernel.elem(Enum.at(Map.get(a, :c), track_n_from), 1)
      get_last_el = Enum.at(m_from, Enum.count(m_from) - 1)
      IO.inspect(get_last_el)
      IO.inspect(m_to)
      # move slow way
      IO.inspect(m_to ++ [get_last_el])
    end
  end

  a = Help.get_lines("test.txt")

  IO.inspect(a)
  Help.move(a, 0, 1)

  def hello do
    :world
  end
end
