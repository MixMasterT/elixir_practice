defmodule Validator do
  def ok!({ :ok, data }), do: data
  def ok!({ not_ok, unknown }) do
    raise "Function call did not return OK, instead #{
      not_ok
      } was returned with data: #{
        IO.inspect unknown
      }"
  end
end
