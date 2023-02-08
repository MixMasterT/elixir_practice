defmodule TaxCalc do
  def process_orders_list(orders, tax_rates) do
    Enum.map(orders, fn(order) -> add_total_to_order(order, tax_rates) end)
  end

  defp add_total_to_order(order, tax_rates) do
    tax_rate = Keyword.get(tax_rates, order[:ship_to], 0)
    net = order[:net_amount]
    Keyword.put(order, :total_amount, net + net * tax_rate)
    Keyword.put(order, :has_tax, tax_rate !== 0)
  end
end
