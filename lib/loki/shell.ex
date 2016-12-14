defmodule Loki.Shell do
  @moduledoc """
  """

  @doc """
  """
  defmacro is_input(input) do
    quote do
      is_bitstring(unquote(input)) or is_list(unquote(input))
    end
  end


  @doc """
  """
  @spec ask(String.t | List.t) :: Tuple.t
  def ask(message) when is_input(message) do
    args = format(IO.gets message)
    OptionParser.parse([args])
  end

  @doc false
  @spec ask(any) :: none()
  def ask(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  """
  @spec yes?(String.t | List.t) :: Boolean.t
  def yes?(message) when is_input(message) do
    {_, [answer], _} = ask(message)
    positive_answers = ["yes", "y"]
    Enum.member? positive_answers, format(answer)
  end

  @doc false
  @spec yes?(any) :: none()
  def yes?(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  """
  @spec no?(String.t | List.t) :: Boolean.t
  def no?(message) when is_input(message) do
    {_, [answer], _} = ask(message)
    negative_answers = ["no", "n"]
    Enum.member? negative_answers, format(answer)
  end

  @doc false
  @spec no?(any) :: none()
  def no?(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  """
  @spec say(String.t | List.t) :: none()
  def say(message) when is_input(message), do: IO.puts message

  @doc false
  @spec say(any) :: none()
  def say(_any), do: raise ArgumentError, message: "Invalid argument, accept String or List!"


  @doc """
  """
  @spec say_create(Path.t) :: none()
  def say_create(message) when is_input(message), do: say IO.ANSI.format([:green, " *  creating ", :reset, message])

  @doc false
  @spec say_create(any) :: none()
  def say_create(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec say_force(Path.t) :: none()
  def say_force(message) when is_input(message), do: say IO.ANSI.format([:yellow, " *     force ", :reset, message])

  @doc false
  @spec say_force(any) :: none()
  def say_force(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec say_identic(Path.t) :: none()
  def say_identic(message) when is_input(message), do: say IO.ANSI.format([:blue, :bright, " * identical ", :reset, message])

  @doc false
  @spec say_identic(any) :: none()
  def say_identic(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec say_skip(Path.t) :: none()
  def say_skip(message) when is_input(message), do: say IO.ANSI.format([:yellow, " *      skip ", :reset, message])

  @doc false
  @spec say_skip(any) :: none()
  def say_skip(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec say_error(String.t) :: none()
  def say_error(message) when is_input(message), do: say IO.ANSI.format([:red, " *     error ", :reset, message])

  @doc false
  @spec say_error(any) :: none()
  def say_error(_any), do: raise ArgumentError, message: "Invalid argument, accept String!"


  @doc """
  """
  @spec say_conflict(Path.t) :: none()
  def say_conflict(message) when is_input(message), do: say IO.ANSI.format([:yellow, " *  conflict ", :reset, message])

  @doc false
  @spec say_conflict(any) :: none()
  def say_conflict(_any), do: raise ArgumentError, message: "Invalid argument, accept Path"


  @doc """
  """
  @spec say_exists(Path.t) :: none()
  def say_exists(message) when is_input(message), do: say IO.ANSI.format([:blue, :bright, " *    exists ", :reset, message])

  @doc false
  @spec say_exists(any) :: none()
  def say_exists(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec say_rename(Path.t, Path.t) :: none()
  def say_rename(source, target) when is_bitstring(source) and is_bitstring(target) do
    say IO.ANSI.format [:green, " *    rename ", :reset, "#{source}", :green, " to ", :reset, "#{target}"]
  end

  @doc false
  @spec say_rename(any) :: none()
  def say_rename(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"


  @doc """
  """
  @spec say_copy(Path.t, Path.t) :: none()
  def say_copy(source, target) when is_bitstring(source) and is_bitstring(target) do
    say IO.ANSI.format [:green, " *      copy ", :reset, "#{source}", :green, " to ", :reset, "#{target}"]
  end

  @doc false
  @spec say_copy(any) :: none()
  def say_copy(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"


  @doc """
  """
  @spec say_remove(Path.t) :: none()
  def say_remove(path) when is_bitstring(path), do: say IO.ANSI.format [:green, " *    remove ", :reset, "#{path}"]

  @doc false
  @spec say_remove(any) :: none()
  def say_remove(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc false
  @spec format(String.t) :: String.t
  defp format(input), do: String.replace(input, "\n", "") |> String.downcase
end

