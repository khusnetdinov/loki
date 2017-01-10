defmodule Loki.Directory do
  import Loki.Shell, only: [
    say_create: 1,
    say_error: 1,
    say_copy: 2,
    say_remove: 1,
  ]


  @moduledoc """
  Working with folders helpers.
  """


  @doc """
  Helper for create directory.
  """
  @spec create_directory(Path.t) :: :ok | {:error, Atom.t}
  def create_directory(path) when is_bitstring(path) do
    case File.mkdir_p(path) do
      :ok ->
        say_create("directory " <> path)
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end

  @spec create_directory(Path.t) :: none()
  def create_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  Helper for checking if file exists.
  """
  @spec exists_directory?(Path.t) :: Boolean.t
  def exists_directory?(path) when is_bitstring(path), do: File.exists?(path)

  @spec exists_directory?(Path.t) :: none()
  def exists_directory?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  Helper for copy directory.
  """
  @spec copy_directory(Path.t, Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def copy_directory(source, target) when is_bitstring(source) and is_bitstring(target) do
    case File.cp_r(source, target) do
      {:ok, data} ->
        say_copy(source, target)
        {:ok, data}
      {:error, reason, data} ->
        say_error(reason)
        {:error, reason, data}
    end
  end

  @spec copy_directory(any) :: none()
  def copy_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"


  @doc """
  Helper for remove directory.
  """
  @spec remove_directory(Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def remove_directory(path) do
    say_remove(path)
    case File.rm_rf(path) do
      {:ok, data} ->
        say_remove(path)
        {:ok, data}
      {:error, reason, data} ->
        say_error(reason)
        {:error, reason, data}
    end
  end
end
