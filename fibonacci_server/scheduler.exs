defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
      |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
      |> schedule_processes(to_calculate, [])
  end

  def schedule_processes(processes, [], results) do
    receive do
      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), [], results)
        else
          Enum.sort(
            results,
            fn { n1, _ }, { n2, _ } -> n1 <= n2 end
          )
        end
      { :answer, number, result, _pid } ->
        schedule_processes(
          processes,
          [],
          [ { number, result } | results ]
        )
    end
  end
  def schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } ->
        [ next | tail ] = queue
        send pid, { :fib, next, self() }
        schedule_processes(processes, tail, results)
      { :answer, number, result, _pid } ->
        schedule_processes(
          processes,
          queue,
          [ { number, result } | results ]
        )
    end
  end

end
