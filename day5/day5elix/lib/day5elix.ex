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

      # |> Enum.to_list()

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

    def moveOne(a, track_n_to, track_n_from, amount) do
      m_to = Kernel.elem(Enum.at(a, track_n_to), 1)
      m_from = Kernel.elem(Enum.at(a, track_n_from), 1)
      get_last_el = Enum.at(m_from, 0)
      # move slow way
      m_to = Enum.reverse(m_to) ++ [get_last_el]
      m_from = m_from -- [get_last_el]

      new_from = a |> Enum.at(track_n_from) |> Kernel.put_elem(1, m_from)
      new_to = a |> Enum.at(track_n_to) |> Kernel.put_elem(1, Enum.reverse(m_to))

      new_a =
        Map.put(a, track_n_from + 1, Kernel.elem(new_from, 1))
        |> Map.put(track_n_to + 1, Kernel.elem(new_to, 1))

      amount = amount - 1
      # IO.inspect(a)
      # IO.inspect(new_a)

      if(amount === 0) do
        new_a
      else
        # new_a
        moveOne(new_a, track_n_to, track_n_from, amount)
      end
    end

    def operate(data, movements1) do
      movements = Enum.at(movements1, 0)

      result =
        moveOne(
          data,
          Map.get(movements, :to) - 1,
          Map.get(movements, :from) - 1,
          Map.get(movements, :amount)
        )

      if(Enum.count(movements1) == 1) do
        result
      else
        new_m = List.delete_at(movements1, 0)
        # new_movements = Enum.at(new_m, 0)
        operate(result, new_m)
        # moveOne(
        #   result,
        #   Map.get(new_movements, :to) - 1,
        #   Map.get(new_movements, :from) - 1,
        #   Map.get(new_movements, :amount)
        # )

        # new_movements
      end
    end
  end

  a = Help.get_lines("input.txt")

  Help.moveOne(Map.get(a, :c), 0, 1, 2)
  result = Help.operate(Map.get(a, :c), Map.get(a, :m))

  message =
    Map.to_list(result)
    |> Enum.map(fn {_, x} -> x end)
    |> Enum.map_join(fn x -> Enum.at(x, 0) end)

  IO.inspect(message)

  def hello do
    :world
  end
end
