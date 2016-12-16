defmodule Loki.File do
  import Loki.Shell, only: [
    say: 1,
    say_error: 1,
    say_create: 1,
    say_force: 1,
    say_copy: 2,
    say_remove: 1,
    say_rename: 2
  ]

  @moduledoc """
  Helpers for working with file.
  """

  @doc """
  Helper for create file.
  """
  @spec create_file(Path.t) :: :ok | {:error, Atom.t}
  def create_file(path) when is_bitstring(path), do: create_file(path, "")

  @doc false
  @spec create_file(any) :: none()
  def create_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"

  @doc false
  @spec create_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def create_file(path, content) do
    case File.write(path, content, [:exclusive]) do
      :ok ->
        say_create(path)
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  Helper for create file in force mode.
  """
  @spec create_file_force(Path.t) :: :ok | {:error, Atom.t}
  def create_file_force(path) when is_bitstring(path), do: create_file_force(path, "")

  @doc false
  @spec create_file_force(any) :: none()
  def create_file_force(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"

  @doc false
  @spec create_file_force(Path.t, String.t) :: :ok | {:error, Atom.t}
  def create_file_force(path, content) do
    case File.write(path, content, []) do
      :ok ->
        say_force(path)
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  Helper check if file exists.
  """
  @spec exists_file?(Path.t) :: Boolean.t
  def exists_file?(path) when is_bitstring(path), do: File.exists?(path)

  @doc false
  @spec exists_file?(any) :: none()
  def exists_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  Helper check if file identical.
  """
  @spec identical_file?(Path.t, Path.t) :: Boolean.t | {:error, Atom.t}
  def identical_file?(path, renderer) do
    {:ok, content} = File.read(path)
    content == renderer
  end


  @doc """
  Helper for copy files.
  """
  @spec copy_file(Path.t, Path.t) :: :ok | {:error, Atom.t}
  def copy_file(source, target) do
    case File.copy(source, target) do
      {:ok, status} ->
        say_copy(source, target)
        {:ok, status}
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  Helper for create link.
  """
  @spec create_link(Path.t, Path.t) :: :ok | {:error, Atom.t}
  def create_link(source, link) do
    case File.ln_s(source, link) do
      :ok ->
        say IO.ANSI.format [:green, " *      link ", :reset, "#{source}", :green, " to ", :reset, "#{link}"]
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  Helper for remove file.
  """
  @spec remove_file(Path.t) :: :ok | {:error, Atom.t}
  def remove_file(path) do
    case File.rm(path) do
      :ok ->
        say_remove(path)
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  Helper for rename files and dirs.
  """
  @spec rename(Path.t, Path.t) :: :ok | {:error, String.t}
  def rename(source, target) do
    case File.rename(source, target) do
      :ok ->
        say_rename(source, target)
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end
end
