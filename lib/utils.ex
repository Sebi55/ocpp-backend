defmodule Utils do
  use Timex

  @spec time_as_string() :: String.t()
  def time_as_string do
    {hh, mm, ss} = :erlang.time()
    :io_lib.format("~2.10.0B:~2.10.0B:~2.10.0B", [hh, mm, ss])
    |> :erlang.list_to_binary()
  end

  @spec datetime_as_string() :: String.t()
  def datetime_as_string do
    {:ok, result} = Timex.now 
                    |> Timex.format("{ISO:Extended}")
    result 
  end

  @spec datetime_as_string(integer) :: String.t()
  def datetime_as_string(shift_minutes) do
    {:ok, result} = Timex.now 
                    |> Timex.shift(minutes: shift_minutes)
                    |> Timex.format("{ISO:Extended}")
  	result
  end

  @spec default(any, any) :: any
  def default(value, default_value) do
    case value do
      nil -> default_value
      _ -> value
    end
  end

  def renderPage(filename, title, bindings) do
    basedir = "#{Path.expand(__DIR__)}/../priv/templates/"
    content = EEx.eval_file("#{basedir}#{filename}.eex", bindings)

    EEx.eval_file("#{basedir}page.html.eex", [
      title: title,
      content: content
      ])
  end 

  def renderFragment(filename, bindings) do
    basedir = "#{Path.expand(__DIR__)}/../priv/templates/"
    EEx.eval_file("#{basedir}#{filename}.eex", bindings)    
  end
end