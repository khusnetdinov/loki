defmodule Loki.Directory do
  import Loki.Shell, only: [
    yes?: 1,
    say_create: 1,
    say_error: 1,
    say_copy: 2,
    say_remove: 1,
    say_force: 1,
    say_skip: 1
  ]

  @moduledoc """
  """

  @doc """
  """
  @spec create_directory(Path.t) :: :ok | {:error, Atom.t}
  def create_directory(path) when is_bitstring(path) do
    say_create("directory " <> path)
    File.mkdir_p(path)
  end

  @doc false
  @spec create_directory(Path.t) :: none()
  def create_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec exists_directory?(Path.t) :: Boolean.t
  def exists_directory?(path) when is_bitstring(path), do: File.exists?(path)

  @doc false
  @spec exists_directory?(Path.t) :: none()
  def exists_directory?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  # @spec copy_directory(Path.t, Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def copy_directory(source, target) when is_bitstring(source) and is_bitstring(target) do
    say_copy(source, target)
    File.cp_r(source, target)
  end

  @doc false
  # @spec copy_directory(any) :: none()
  def copy_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"


  @doc """
  """
  # @spec remove_directory(Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def remove_directory(path) do
    say_remove(path)
    File.rm_rf(path)
  end
end
