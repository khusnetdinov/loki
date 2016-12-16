defmodule Loki.File do
  import Loki.Shell, only: [
    yes?: 1,
    say: 1,
    say_error: 1,
    say_create: 1,
    say_force: 1,
    say_skip: 1,
    say_copy: 2,
    say_remove: 1,
    say_rename: 2
  ]

  @moduledoc false

  @doc """
  """
  @spec create_file(Path.t) :: :ok | {:error, Atom.t}
  def create_file(path) when is_bitstring(path), do: create_file(path, "")

  @doc false
  @spec create_file(any) :: none()
  def create_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"

  @doc false
  @spec create_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def create_file(path, content) do
    say_create(path)
    File.write(path, content, [:exclusive])
  end


  @doc """
  """
  @spec create_file_force(Path.t) :: :ok | {:error, Atom.t}
  def create_file_force(path), do: create_file_force(path, "")

  @doc false
  @spec create_file_force(Path.t, String.t) :: :ok | {:error, Atom.t}
  def create_file_force(path, content) do
    say_force(path)
    File.write(path, content, [])
  end

  @doc false
  @spec create_file_force(any) :: none()
  def create_file_force(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"


  @doc """
  """
  @spec exists_file?(Path.t) :: Boolean.t
  def exists_file?(path) when is_bitstring(path), do: File.exists?(path)

  @doc false
  @spec exists_file?(any) :: none()
  def exists_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec identical_file?(Path.t, Path.t) :: Boolean.t | {:error, Atom.t}
  def identical_file?(path, renderer) do
    {:ok, content} = File.read(path)
    content == renderer
  end


  @doc """
  """
  @spec copy_file(Path.t, Path.t) :: :ok | {:error, Atom.t}
  def copy_file(source, target) do
    say_copy(source, target)
    File.copy(source, target)
  end


  @doc """
  """
  @spec create_link(Path.t, Path.t) :: :ok | {:error, Atom.t}
  def create_link(source, link) do
    say IO.ANSI.format [:green, " *      link ", :reset, "#{source}", :green, " to ", :reset, "#{link}"]
    File.ln_s(source, link)
  end


  @doc """
  """
  @spec remove_file(Path.t) :: :ok | {:error, Atom.t}
  def remove_file(path) do
    say_remove(path)
    File.rm(path)
  end


  @doc """
  """
  @spec rename(Path.t, Path.t) :: :ok | {:error, String.t}
  def rename(source, target) do
    say_rename(source, target)
    File.rename(source, target)
  end
end
