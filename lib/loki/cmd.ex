defmodule Loki.Cmd do
  import Loki.Shell

  @moduledoc """
  """

  @doc """
  """
  @spec execute(String.t) :: none()
  def execute(string) when is_bitstring(string) do
    execute(string, [])
  end

  @doc false
  @spec execute(any) :: none()
  def execute(_any), do: raise ArgumentError, message:  "Invalid argument, accept String, [List]"

  @doc false
  @spec execute(String.t, list(Keyword.t)) :: none()
  def execute(string, opts) when is_bitstring(string) and is_list(opts) do
    [command | args] = String.split(string)
    System.cmd(command, args, env: opts)
  end


  @doc """
  """
  @spec execute_in_path(String.t, String.t) :: none()
  def execute_in_path(string, path) when is_bitstring(string) and is_bitstring(path) do
     execute_in_path(string, path, [])
  end

  @doc false
  @spec execute_in_path(any) :: none()
  def execute_in_path(_any), do: raise ArgumentError, message: "Invalid argument, accept String, String, [List]"

  @doc false
  @spec execute_in_path(String.t, String.t, list(Keyword.t)) :: none()
  def execute_in_path(string, path, opts) when is_bitstring(string) and is_bitstring(path) and is_list(opts) do
    [command | args] = String.split(string)
    System.cmd(command, args, env: opts, cd: path)
  end


  @doc """
  """
  @spec format_output(Tuple.t) :: String.t
  def format_output({output, _}) do
    say ""
    say IO.ANSI.format([:yellow, output])
  end
end
