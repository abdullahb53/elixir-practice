defmodule FastExponentiation do
  @moduledoc """
  Documentation for `FastExponentiation`.
  """

  @doc """
  Fast exponen.

  ## Examples

      iex> FastExponentiation.calc(2,3)
      8.0

  """
  def calc(n1,n2) do
    # IO.puts("#{inspect(self())}")
    # IO.puts("normal n1: #{n1}, normal n2: #{n2}")
    # IO.puts("binary n2: #{:erlang.integer_to_binary(n2,2)}")
    # val = :erlang.integer_to_binary(n2,2)
    # IO.puts("binary n2's ->#{:binary.part(val,0,length(:erlang.binary_to_list(val)))}")
    list = Enum.reverse(:erlang.binary_to_list(:erlang.integer_to_binary(n2,2)))
    IO.puts("n1:#{n1}, n2:#{n2}")
    IO.puts("n2_binary: #{inspect(list)}")
    fast_exponent(list,n1)
    # my_task = Task.async(fn -> fast_exponent(n1,n2) end)
    # Task.await(my_task)
  end



  defp fast_exponent(list,n1) do
    fast_exponent(list,0,n1,1) # index = 0, square = n1, multiply = 1

  end

  defp fast_exponent(list,index,_square,multiply) when length(list) == index do
    IO.puts("result: #{multiply}")

  end

  defp fast_exponent(list,index,square,multiply) do
    if Enum.at(list,index)-48 == 1 do
      fast_exponent(list,index+1,:math.pow(square,2), square*multiply)
    else
      fast_exponent(list,index+1,:math.pow(square,2), multiply)
    end
  end

end
