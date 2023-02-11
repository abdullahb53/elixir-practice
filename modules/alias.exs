defmodule Saying.Greetings do
  def basic(name), do: "Hi, #{name}"
end

defmodule Example do
  alias Saying.Greetings

  def func1(name), do: Greetings.basic(name)
end

# import filtering.
import List, only: [last: 1] # work only last
import List, except: [last: 1] # not work last

import List, only: :functions
import List, only: :macros

#
#
#

defmodule Hello2 do
  defmacro __using__(opts) do
    greeting = Keyword.get(opts, :greeting, "Hi")

    quote do
      def hello(name), do: unquote(greeting) <> ", " <> name
    end
  end
end

defmodule Example2 do
  use Hello2, greeting: "Hola"
end

IO.puts(Example2.hello("Sean")) # "Hola, Sean"
