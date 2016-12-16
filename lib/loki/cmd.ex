defmodule Loki.Cmd do
  import Loki.Shell, only: [say: 1]

  @moduledoc """
  Executing terminal commands helpers.
  """

  @doc """
  Execute shell command with Env variables as options.
  """
  @spec execute(String.t) :: {Collectable.t, exit_status :: non_neg_integer}
  def execute(string) when is_bitstring(string), do: execute(string, [])

  @doc false
  @spec execute(any) :: none()
  def execute(_any), do: raise ArgumentError, message:  "Invalid argument, accept String [, List(Keyword)]!"

  @doc false
  @spec execute(String.t, list(Keyword.t)) :: {Collectable.t, exit_status :: non_neg_integer}
  def execute(string, opts) when is_bitstring(string) and is_list(opts) do
    [command | args] = String.split(string)
    say IO.ANSI.format [:green, " *   execute ", :reset, string]
    System.cmd(command, args, env: opts)
  end


  @doc """
  Execute shell command with Env variables as options in given path.
  """
  @spec execute_in_path(String.t, Path.t) :: {Collectable.t, exit_status :: non_neg_integer}
  def execute_in_path(string, path) when is_bitstring(string) and is_bitstring(path), do: execute_in_path(string, path, [])

  @doc false
  @spec execute_in_path(String.t, Path.t, list(Keyword.t)) :: {Collectable.t, exit_status :: non_neg_integer}
  def execute_in_path(string, path, opts) when is_bitstring(string) and is_bitstring(path) and is_list(opts) do
    [command | args] = String.split(string)
    say IO.ANSI.format [:green, " *   execute ", :reset, string <> " in path " <> path]
    System.cmd(command, args, env: opts, cd: path)
  end

  @doc false
  @spec execute_in_path(any) :: none()
  def execute_in_path(_any), do: raise ArgumentError, message: "Invalid argument, accept String, Path [, List(Keyword)]!"


  @doc """
  Format execution output for reading in shell.
  """
  @spec format_output(Tuple.t) :: String.t
  def format_output({output, _}) do
    say ""
    say IO.ANSI.format([:yellow, output])
  end
end
