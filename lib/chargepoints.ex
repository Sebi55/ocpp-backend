defmodule Chargepoints do
  use GenServer
  import Logger

  def start_link(_) do 
    {:ok, pid} = GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
    info "Started #{__MODULE__} #{inspect(pid)}"
    {:ok, pid}
  end

  def handle_call({:subscribe, serial, pid}, _from, chargepoints) do
    {:reply, :ok, Map.put(chargepoints, serial, %{pid: pid, status: "Unknown"})}
  end

  def handle_call({:unsubscribe, serial}, _from, chargepoints) do
    {:reply, :ok, Map.delete(chargepoints, serial)}
  end

  def handle_call(:subscribers, _from, chargepoints) do
    {:reply, {:ok, chargepoints}, chargepoints}
  end

  def handle_call({:status, status, serial}, _from, chargepoints) do
    {:reply, :ok, put_in(chargepoints[serial].status, status)}
  end
end