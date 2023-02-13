{:ok, agent} = Agent.start_link(fn -> [1, 2, 3] end)
{:ok, #PID<0.65.0>}

Agent.update(agent, fn (state) -> state ++ [4, 5] end)
:ok

Agent.get(agent, &(&1))
[1, 2, 3, 4, 5]

#
#
#

Agent.start_link(fn -> [1, 2, 3] end, name: Numbers)
{:ok, #PID<0.74.0>}

Agent.get(Numbers, &(&1))
[1, 2, 3]
