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
  def ask(input) when is_input(input) do
    args = format(input)
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
  @spec say_create(String.t) :: none()
  def say_create(message) when is_input(message), do: say IO.ANSI.format([:green, " *   create ", :reset, message])

  @doc false
  @spec say_create(any) :: none()
  def say_create(_any), do: raise ArgumentError, message: "Invalid argument, accept String"


  @doc """
  """
  @spec say_error(String.t) :: none()
  def say_error(message) when is_input(message), do: say IO.ANSI.format([:red, " *    error ", :reset, message])

  @doc false
  @spec say_error(String.t) :: none()
  def say_error(_any), do: raise ArgumentError, message: "Invalid argument, accept String"


  @doc """
  """
  @spec say_conflict(String.t) :: none()
  def say_conflict(message) when is_input(message), do: say IO.ANSI.format([:yellow, " * conflict ", :reset, message])

  @doc false
  @spec say_conflict(String.t) :: none()
  def say_conflict(_any), do: raise ArgumentError, message: "Invalid argument, accept String"


  @doc """
  """
  @spec say_exists(String.t) :: none()
  def say_exists(message) when is_input(message), do: say IO.ANSI.format([:blue, :bright, " *   exists ", :reset, message])

  @doc false
  @spec say_exists(String.t) :: none()
  def say_exists(_any), do: raise ArgumentError, message: "Invalid argument, accept String"


  @doc false
  @spec format(String.t) :: String.t
  defp format(input) do
    String.replace(input, "\n", "") |> String.downcase
  end
end

