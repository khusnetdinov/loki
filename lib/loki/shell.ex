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
  def ask(_any) do
    raise ArgumentError, message: "Invalid argument, ask/1 accept String.t or List.t!"
  end


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
  def yes?(_any) do
    raise ArgumentError, message: "Invalid argument, yes?/1 accept String.t or List.t!"
  end


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
  def no?(_any) do
    raise ArgumentError, message: "Invalid argument, no?/1 accept String.t or List.t!"
  end

  # TODO: say

  @doc false
  @spec format(String.t) :: String.t
  defp format(input) do
    String.replace(input, "\n", "") |> String.downcase
  end
end
