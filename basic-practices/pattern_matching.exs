# Pattern matching.
handle_result = fn
  {:ok, result} -> IO.puts("Handle req. Result: #{result}")
  {:ok,_} -> IO.puts("Any matching to force true statemant(Erlang information.)")
  {:error} -> IO.puts("Error catched.")

end

result1 = 123
handle_result.({:ok,result1})
handle_result.({:error})


defmodule PatternMatchModule do

  def hello(%{name: person_name}) do
    IO.puts "Hello, " <> person_name
  end

end

fred = %{
  name: "Fred",
  age: "95",
  favorite_color: "Taupe"
  }

bob = %{
  age: "33",
  name: "Bob",
}

PatternMatchModule.hello(fred)
# PatternMatchModule.hello(%{age: "95", favorite_color: "Taupe"}) # ** (FunctionClauseError) no function clause matching in PatternMatchModule.hello/1
PatternMatchModule.hello(bob)

defmodule Greeter2 do
  def hello(%{name: person_name} = person) do
    IO.puts "Greeter2 Hello, " <> person_name
    IO.inspect person
  end
end

Greeter2.hello(bob)

defmodule Greeter3 do
  def hello(%{name: person_name}= person ) do
    IO.puts person_name
    IO.inspect person
  end
end

abc = %{
  yuser: "eewqes",
  name: "asdqwe",
}
Greeter3.hello(abc)
