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
  @spec create_directory(Path.t) :: :ok | {:error, String.t}
  def create_directory(path) when is_bitstring(path) do
    case File.mkdir_p(path) do
      :ok ->
        say_create("#{path}")
      {:error, :eacess} ->
        say_error("Don't have permission for removing: #{path}")
        {:error, :eacess}
      {:error, :noscp} ->
        say_error("There is a no space left on the device for creating: #{path}")
        {:error,:noscp}
      {:error, :enotdir} ->
        say_error("Component of path is not a directory: #{path}")
        {:error, :enotdir}
    end
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
  @spec copy_directory(Path.t, Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def copy_directory(source, target) when is_bitstring(source) and is_bitstring(target), do: copy_directory(source, target)

  @doc false
  @spec copy_directory(Path.t, Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def copy_directory(source, target) when is_bitstring(source) and is_bitstring(target) do
    case File.cp_r(source, target, fn(s, t) -> overwritting_callback(s, t) end) do
      {:ok, data} ->
        say_copy(source, target)
        {:ok, data}
      {:error, reason, data} ->
        say_error(reason)
        {:error, reason, data}
    end
  end

  @doc false
  @spec copy_directory(any) :: none()
  def copy_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"


  @doc """
  """
  @spec remove_directory(Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def remove_directory(path) do
    case File.rm_rf(path) do
      {:ok, data} ->
        say_remove(path)
        {:ok, data}
      {:error, reason, data} ->
        say_error(reason)
        {:error, reason, data}
    end
  end


  @doc false
  @spec overwritting_callback(Path.t, Path.t) :: Boolean.t
  defp overwritting_callback(source, target) do
    answer = yes? " Overwrite #{target} by #{source}? [Yn] "
    if answer do
      say_force(target)
    else
      say_skip(target)
    end
    answer
  end
end
