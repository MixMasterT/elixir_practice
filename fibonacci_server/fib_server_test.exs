Code.require_file("fibonacci_server/scheduler.exs")
Code.require_file("fibonacci_server/fib_solver.exs")
to_process = List.duplicate(35, 20)
Enum.each(
  1..10,
  fn num_processes ->
    { time, result } = :timer.tc(
      Scheduler, :run, [num_processes, FibSolver, :fib, to_process]
    )
    if num_processes == 1 do
      IO.puts inspect result
      IO.puts "\n #(processes)   time (s)"
    end
    :io.format "   ~2B             ~.2f~n", [num_processes, time/1000000.0]
  end
)
