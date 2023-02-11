defmodule LoggerExample do
  defmacro log(msg) do

      quote do
        IO.puts("[LOGGER]- #{Time.utc_now()} : #{unquote(msg)}")
      end

  end
end

defmodule Example do
  require LoggerExample

  def test(text \\ "DEACTIVE") do
    LoggerExample.log("#{text}")
  end
end


Example.test("This")
