defmodule Bugsnex.Worker do
  @moduledoc false

  use GenServer

  # client API

  @spec start_link :: GenServer.on_start
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  @spec notify(Exception.t | Bugsnex.Event.t | Bugsnex.Exception.t) :: :ok
  def notify(exception = %{}), do: exception |> Bugsnex.Event.new |> notify
  def notify(exception = %Bugsnex.Exception{}), do: exception |> Bugsnex.Event.new |> notify
  def notify(exception = %Bugsnex.Event{}) do
    GenServer.cast(__MODULE__, {:notify, exception})
  end

  # server callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  @callback handle_cast({:notify, Exception.t}, term) :: {:noreply, term}
  def handle_cast({:notify, _exception}, state) do
    {:noreply, state}
  end
end
