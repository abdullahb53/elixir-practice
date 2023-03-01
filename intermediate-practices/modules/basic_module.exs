defmodule ModuleName do # it should be start with Uppercase.
  def greeting(name) do
    IO.puts("Hello #{name}.")
  end
end

ModuleName.greeting("Bob")

# Nested modules.
defmodule ModuleNested do
  def morning(name) do
    IO.puts("Good MoRniNg.. #{name}.")
  end

  def evening(name) do
    IO.puts("Good night,,, #{name}.")
  end

end

ModuleNested.evening("Ashe")
ModuleNested.morning("Invoker")

##
## Module Attributes
##
defmodule Module3 do
  @attribute1 "Hello"

  def myNewFunction(name) do
    ~s(#{@attribute1} #{name}.)
  end
end

a = Module3.myNewFunction("Abdullah")
IO.puts(a) # Hello Abdullah.

##
## PIPE OPERATOR
##
a = "Hello world..."
|> String.upcase |> String.reverse

IO.puts(a) # ...DLROW OLLEH
