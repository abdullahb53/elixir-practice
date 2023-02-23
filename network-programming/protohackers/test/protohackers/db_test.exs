defmodule Protohackers.DbTest do
  alias Protohackers.PricesServer.Db
  use ExUnit.Case , astync: true

  test "adding new elements and getting the avarege" do

    db = Db.new()

    assert Db.query(db, 0, 100) == 0

    db =
      db
      |> Db.add(1, 10)
      |> Db.add(2, 20)
      |> Db.add(3, 30)

      assert Db.query(db, 0, 100) == 20
      assert Db.query(db, 0, 2) == 15
      assert Db.query(db, 2, 3) == 25
      assert Db.query(db, 4, 100) == 0
    end
end

# db = Enum.reduce(0..500_000, Protohackers.PricesServer.Db.new(), fn i, acc -> Protohackers.PricesServer.Db.add(acc, i * 1000, i) end)
# .      .
# . DATA .
# .      .
# length(db)
# -> 500001
# :timer.tc(fn -> Protohackers.PricesServer.Db.query(db, 0, 1_000_000) end)
# -> {24064, 500}
# :timer.tc(fn -> Protohackers.PricesServer.Db.query(db, 500_000, 1_000_000) end)
# {13926, 750}
