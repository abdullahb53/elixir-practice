defmodule Protohackers.UdpServerTest do
  use ExUnit.Case, async: true

  test "insert and retrieve requests" do
    {:ok, socket} = :gen_udp.open(0,[:binary, active: false, recbuf: 1000])

    :gen_udp.send(socket, {127,0,0,1}, 5005, "foo=1")
    :gen_udp.send(socket, {127,0,0,1}, 5005, "foo")
    assert {:ok,{_address, _port, "foo=1"}} = :gen_tcp.recv(socket, 0)

    :gen_udp.send(socket, {127,0,0,1}, 5005, "foo=2")
    :gen_udp.send(socket, {127,0,0,1}, 5005, "foo")
    assert {:ok,{_address, _port, "foo=2"}} = :gen_tcp.recv(socket, 0)
  end

  test "version" do
    {:ok, socket} = :gen_udp.open(0,[:binary, active: false, recbuf: 1000])

    :gen_udp.send(socket, {127,0,0,1}, 5005, "version=foo")
    :gen_udp.send(socket, {127,0,0,1}, 5005, "version")
    assert {:ok,{_address, _port, "version=Protohackers in Elixir v1"}} = :gen_tcp.recv(socket, 0)
  end

end
