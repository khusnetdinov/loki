defmodule Loki.File do
  import Loki.Shell


  @moduledoc """
  Helpers for working with file.
  """


  @doc """
  Helper for create file.
  """
  @spec create_file(Path.t) :: :ok | {:error, Atom.t}
  def create_file(path) when is_bitstring(path), do: create_file(path, "", [])

  @spec create_file(any) :: none()
  def create_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"

  @spec create_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def create_file(path, content) when is_bitstring(path), do: create_file(path, content, [])

  @spec create_file(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def create_file(path, content, opts) do
    case File.write(path, content, [:exclusive]) do
      :ok ->
        say_create(path, opts)
        :ok
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end


  @doc """
  Helper for create file in force mode.
  """
  @spec create_file_force(Path.t) :: :ok | {:error, Atom.t}
  def create_file_force(path) when is_bitstring(path), do: create_file_force(path, "", [])

  @spec create_file_force(any) :: none()
  def create_file_force(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"

  @spec create_file_force(Path.t, String.t) :: :ok | {:error, Atom.t}
  def create_file_force(path, content), do: create_file_force(path, content, [])

  @spec create_file_force(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def create_file_force(path, content, opts) do
    case File.write(path, content, []) do
      :ok ->
        say_force(path, opts)
        :ok
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end


  @doc """
  Helper check if file exists.
  """
  @spec exists_file?(Path.t) :: Boolean.t
  def exists_file?(path) when is_bitstring(path), do: File.exists?(path)

  @spec exists_file?(any) :: none()
  def exists_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  Helper check if file identical.
  """
  @spec identical_file?(Path.t, Path.t) :: Boolean.t | {:error, Atom.t}
  def identical_file?(path, renderer), do: {:ok, renderer} == File.read(path)

  @spec identical_file?(any) :: none()
  def identical_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"


  @doc """
  Helper for copy files.
  """
  @spec copy_file(Path.t, Path.t) :: :ok | {:error, Atom.t}
  def copy_file(source, target), do: copy_file(source, target, [])

  @spec copy_file?(any) :: none()
  def copy_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"

  @spec copy_file(Path.t, Path.t, Keyword.t) :: :ok | {:error, Atom.t}
  def copy_file(source, target, opts) do
    case File.copy(source, target) do
      {:ok, status} ->
        say_copy(source, target, opts)
        {:ok, status}
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end


  @doc """
  Helper for create link.
  """
  @spec create_link(Path.t, Path.t) :: :ok | {:error, Atom.t}
  def create_link(source, link), do: create_link(source, link, [])

  @spec create_file?(any) :: none()
  def create_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"

  @spec create_link(Path.t, Path.t, Keyword.t) :: :ok | {:error, Atom.t}
  def create_link(source, link, opts) do
    case File.ln_s(source, link) do
      :ok ->
        say(IO.ANSI.format([:green, " *      link ", :reset, "#{source}", :green, " to ", :reset, "#{link}"]), opts)
        :ok
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end


  @doc """
  Helper for remove file.
  """
  @spec remove_file(Path.t) :: :ok | {:error, Atom.t}
  def remove_file(path), do: remove_file(path, [])

  @spec remove_file?(any) :: none()
  def remove_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec remove_file(Path.t, Keyword.t) :: :ok | {:error, Atom.t}
  def remove_file(path, opts) do
    case File.rm(path) do
      :ok ->
        say_remove(path, opts)
        :ok
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end


  @doc """
  Helper for rename files and dirs.
  """
  @spec rename(Path.t, Path.t) :: :ok | {:error, String.t}
  def rename(source, target), do: rename(source, target, [])

  @spec rename(any) :: none()
  def rename(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, Path!"

  @spec rename(Path.t, Path.t, Keyword.t) :: :ok | {:error, String.t}
  def rename(source, target, opts) do
    case File.rename(source, target) do
      :ok ->
        say_rename(source, target, opts)
        :ok
      {:error, reason} ->
        say_error(reason, opts)
        {:error, reason}
    end
  end
end
