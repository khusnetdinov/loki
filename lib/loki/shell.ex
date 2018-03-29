defmodule Loki.Shell do


  @moduledoc """
  Helpers for interaction with user and printing message to shell.
  """


  defmacro is_input(input) do
    quote do
      is_bitstring(unquote(input)) or is_list(unquote(input))
    end
  end


  @doc """
  Ask user input with given message. Returns tuple with parsed options.
  """
  @spec ask(String.t) :: {List.t, List.t, List.t}
  def ask(message, opts \\ [])
  def ask(message, opts) when is_input(message) do
    args = format(IO.gets(message), opts)
    OptionParser.parse([args])
  end

  @spec ask(any, any) :: none()
  def ask(_message, _ops), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  Ask about positive user input with given message.
  """
  @spec yes?(String.t) :: Boolean.t
  def yes?(message) when is_input(message) do
    {_, [answer], _} = ask(message)
    positive_answers = ["yes", "y"]
    Enum.member? positive_answers, format(answer)
  end

  @spec yes?(any) :: none()
  def yes?(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  Ask about negative user input with given message.
  """
  @spec no?(String.t) :: Boolean.t
  def no?(message) when is_input(message) do
    {_, [answer], _} = ask(message)
    negative_answers = ["no", "n"]
    Enum.member? negative_answers, format(answer)
  end

  @spec no?(any) :: none()
  def no?(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  Printing message to shell.
  """
  @spec say(String.t) :: none()
  def say(message) when is_input(message), do: say(message, [])

  @spec say(any) :: none()
  def say(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"

  @spec say(String.t, Keyword.t) :: none()
  def say(message, opts) do
    case Keyword.get(opts, :silent) do
      nil ->
        IO.puts message
      true ->
        nil
    end
  end


  @doc """
  Printing message about create file to shell.
  """
  @spec say_create(Path.t) :: none()
  def say_create(path) when is_input(path), do: say(IO.ANSI.format([:green, " *  creating ", :reset, path]), [])

  @spec say_create(any) :: none()
  def say_create(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec say_create(Path.t, Keyword.t) :: none()
  def say_create(path, opts) when is_input(path), do: say(IO.ANSI.format([:green, " *  creating ", :reset, path]), opts)


  @doc """
  Printing message about force action to shell.
  """
  @spec say_force(Path.t) :: none()
  def say_force(path) when is_input(path), do: say(IO.ANSI.format([:yellow, " *     force ", :reset, path]))

  @spec say_force(any) :: none()
  def say_force(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec say_force(Path.t, Keyword.t) :: none()
  def say_force(path, opts) when is_input(path), do: say(IO.ANSI.format([:yellow, " *     force ", :reset, path]), opts)


  @doc """
  Printing message about identical files content to shell.
  """
  @spec say_identical(Path.t) :: none()
  def say_identical(path) when is_input(path), do: say(IO.ANSI.format([:blue, :bright, " * identical ", :reset, path]))

  @spec say_identical(any) :: none()
  def say_identical(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec say_identical(Path.t, Keyword.t) :: none()
  def say_identical(path, opts) when is_input(path), do: say(IO.ANSI.format([:blue, :bright, " * identical ", :reset, path]), opts)


  @doc """
  Printing message about skipping action to shell.
  """
  @spec say_skip(Path.t) :: none()
  def say_skip(path) when is_input(path), do: say(IO.ANSI.format([:yellow, " *      skip ", :reset, path]))

  @spec say_skip(any) :: none()
  def say_skip(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec say_skip(Path.t, Keyword.t) :: none()
  def say_skip(path, opts) when is_input(path), do: say(IO.ANSI.format([:yellow, " *      skip ", :reset, path]), opts)


  @doc """
  Printing message about to shell.
  """
  @spec say_error(String.t) :: none()
  def say_error(message) when is_input(message), do: say(IO.ANSI.format([:red, " *     error ", :reset, message]))

  @spec say_error(Atom.t) :: none()
  def say_error(message) when is_atom(message), do: say(IO.ANSI.format([:red, " *     error ", :reset, "#{message}"]))

  @spec say_error(any) :: none()
  def say_error(_any), do: raise ArgumentError, message: "Invalid argument, accept String!"

  @spec say_error(String.t, Keyword.t) :: none()
  def say_error(message, opts) when is_input(message), do: say(IO.ANSI.format([:red, " *     error ", :reset, message]), opts)

  @spec say_error(Atom.t, Keyword.t) :: none()
  def say_error(message, opts) when is_atom(message), do: say(IO.ANSI.format([:red, " *     error ", :reset, "#{message}"]), opts)


  @doc """
  Printing message about conflict to shell.
  """
  @spec say_conflict(Path.t) :: none()
  def say_conflict(path) when is_input(path), do: say(IO.ANSI.format([:yellow, " *  conflict ", :reset, path]))

  @spec say_conflict(any) :: none()
  def say_conflict(_any), do: raise ArgumentError, message: "Invalid argument, accept Path"

  @spec say_conflict(Path.t, Keyword.t) :: none()
  def say_conflict(path, opts) when is_input(path), do: say(IO.ANSI.format([:yellow, " *  conflict ", :reset, path]), opts)


  @doc """
  Printing message about existance to shell.
  """
  @spec say_exists(Path.t) :: none()
  def say_exists(path) when is_input(path), do: say(IO.ANSI.format([:blue, :bright, " *    exists ", :reset, path]))

  @spec say_exists(any) :: none()
  def say_exists(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec say_exists(Path.t, Keyword.t) :: none()
  def say_exists(path, opts) when is_input(path), do: say(IO.ANSI.format([:blue, :bright, " *    exists ", :reset, path]), opts)


  @doc """
  Printing message about rename files to shell.
  """
  @spec say_rename(Path.t, Path.t) :: none()
  def say_rename(source, target) when is_bitstring(source) and is_bitstring(target) do
    say(IO.ANSI.format([:green, " *    rename ", :reset, "#{source}", :green, " to ", :reset, "#{target}"]))
  end

  @spec say_rename(any) :: none()
  def say_rename(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"

  @spec say_rename(Path.t, Path.t, Keyword.t) :: none()
  def say_rename(source, target, opts) when is_bitstring(source) and is_bitstring(target) do
    say(IO.ANSI.format([:green, " *    rename ", :reset, "#{source}", :green, " to ", :reset, "#{target}"]), opts)
  end


  @doc """
  Printing message about copy files to shell.
  """
  @spec say_copy(Path.t, Path.t) :: none()
  def say_copy(source, target) when is_bitstring(source) and is_bitstring(target) do
    say(IO.ANSI.format([:green, " *      copy ", :reset, "#{source}", :green, " to ", :reset, "#{target}"]))
  end

  @spec say_copy(any) :: none()
  def say_copy(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"

  @spec say_copy(Path.t, Path.t, Keyword.t) :: none()
  def say_copy(source, target, opts) when is_bitstring(source) and is_bitstring(target) do
    say(IO.ANSI.format([:green, " *      copy ", :reset, "#{source}", :green, " to ", :reset, "#{target}"]), opts)
  end


  @doc """
  Printing message about removing file to shell.
  """
  @spec say_remove(Path.t) :: none()
  def say_remove(path) when is_bitstring(path), do: say(IO.ANSI.format([:green, " *    remove ", :reset, "#{path}"]))

  @spec say_remove(any) :: none()
  def say_remove(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec say_remove(Path.t, Keyword.t) :: none()
  def say_remove(path, opts) when is_bitstring(path), do: say(IO.ANSI.format([:green, " *    remove ", :reset, "#{path}"]), opts)


  @spec format(String.t) :: String.t
  defp format(input, opts \\ [])
  defp format(input, [sensitive: true]), do: String.replace(input, "\n", "")
  defp format(input, _opts) do
    String.downcase(String.replace(input, "\n", ""))
  end
end
