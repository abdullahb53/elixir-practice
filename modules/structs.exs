defmodule Example.User do
  defstruct name: "Sean", roles: []
end

defmodule Main do
  def main do
    a = %Example.User{name: "Abdullah"}
    IO.puts(inspect(a))

  end
  def update do
    steve = %Example.User{name: "LifeStealer"}
    sean = %{steve | name: "Seann"}
    IO.puts(inspect(sean))
  end
end

Main.main()
Main.update()


## @@@ Derive @@@


defmodule Example.User2 do
  @derive {Inspect, only: [:name]}
  defstruct name: nil, roles: []

end

defmodule Main2 do
  def main do
    %Example.User2{ name: "ashe", roles: ["MICHAEL"]}

  end
end

a = Main2.main()
IO.puts(inspect(a)) # Example.User2<name: "ashe", ...> we cannot see there "MICHAEL".
