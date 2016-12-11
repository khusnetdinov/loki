defmodule Loki.Directory do
  import Loki.Shell

  @moduledoc """
  """

  @doc """
  """
  @spec create_directory(Path.t) :: :ok | {:error, String.t}
  def create_directory(path) when is_bitstring(path) do
    case File.mkdir_p(path) do
      :ok ->
        say IO.ANSI.format [:green, " * creating ", :reset, "#{}"]
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
  def copy_directory(source, target), do: copy_directory(source, target, overwritting_callback: 2)

  @doc false
  @spec copy_directory(Path.t, Path.t, (Path.t, Path.t -> boolean)) :: {:ok, [binary]} | {:error, String.t, binary}
  def copy_directory(source, target, callback) when is_bitstring(source) and is_bitstring(target) do
    case File.cp_r(source, target, callback) do
      {:ok, data} ->
        say IO.ANSI.format [:green, " *     copy", "#{source}", :green, " to ", :reset, "#{target}"]
        {:ok, data}
      {:error, reason, data} ->
        say_error("")
        {:error, reason, data}
    end
  end

  @doc false
  @spec copy_directory(any) :: none()
  def copy_directory(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path [, Callback]!"


  @doc """
  """
  @spec remove_directory(Path.t) :: {:ok, [binary]} | {:error, String.t, binary}
  def remove_directory(path) do
    case File.rm_rf(path) do
      {:ok, data} ->
        say IO.ANSI.format [:green, " *   remove", :reset, "#{path}"]
        {:ok, data}
      {:error, reason, data} ->
        say_error("#{reason}")
        {:error, reason, data}
    end
  end


  @doc """
  """
  @spec overwritting_callback(Path.t, Path.t) :: Boolean.t
  def overwritting_callback(source, target) do
    answer = yes? " Overwrite #{target} by #{source}? [Yn] "
    if answer do
      say IO.ANSI.format [:green, " * overwrite ", :reset, "#{target}"]
    else
      say_skip("#{target}")
    end
    answer
  end
end
