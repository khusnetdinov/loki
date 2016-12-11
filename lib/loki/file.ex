defmodule Loki.File do
  import Loki.Shell

  @moduledoc false

  @doc """
  """
  @spec create_file(Path.t) :: :ok | {:error, String.t}
  def create_file(path) when is_bitstring(path), do: create_file(path, "")

  @doc false
  @spec create_file(any) :: none()
  def create_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"

  @doc false
  @spec create_file(Path.t, String.t) :: :ok | {:error, String.t}
  def create_file(path, content) do
    case File.write(path, content, []) do
      :ok ->
        say_create(path)
        :ok
      {:error, reason} ->
        say_error("Can't create: #{path}: #{reason}!")
        {:error, reason}
    end
  end


  @doc """
  """
  @spec create_file_force(Path.t, String.t) :: :force | {:error, String.t}
  def create_file_force(path, content) do
    case File.write(path, content, []) do
      :ok ->
        say_force(path)
        :force
      {:error, reason} ->
        say_error("Can't create: #{path}: #{reason}!")
    end
  end

  @doc false
  @spec create_file_force(any) :: none()
  def create_file_force(_any), do: raise ArgumentError, message: "Invalid argument, accept Path [, String]!"


  @doc """
  """
  @spec create_file_force_or_skip(Path.t, String.t) :: :force | :skip | {:error, String.t}
  def create_file_force_or_skip(path, content) do
     if yes?(" Do you want to force create file? [Yn] ") do
       create_file_force(path, content)
     else
       say_skip(path)
       :skip
     end
  end


  @doc """
  """
  @spec exists_file?(Path.t) :: Boolean.t
  def exists_file?(path) when is_bitstring(path), do: File.exists?(path)

  @doc false
  @spec exists_file?(any) :: none()
  def exists_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"


  @doc """
  """
  @spec identical_file?(Path.t, Path.t) :: Boolean.t
  def identical_file?(path, renderer) do
    {:ok, content} = File.read(path)
    content == renderer
  end


  @doc """
  """
  @spec copy_file(Path.t, Path.t) :: :ok | {:error, String.t}
  def copy_file(source, target) do
    case File.copy(source, target) do
      {:ok, _} ->
        say_copy(source, target)
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  """
  @spec create_link(Path.t, Path.t) :: :ok | {:error, String.t}
  def create_link(source, link) do
    case File.ln_s(source, link) do
      :ok ->
        say IO.ANSI.format [:green, " *     link ", :reset, "#{source}", :green, " to ", :reset, "#{link}"]
        :ok
      {:error, reason} ->
        say_error(reason)
        {:error, reason}
    end
  end


  @doc """
  """
  @spec remove_file(Path.t) :: :ok | {:error, Atom.t}
  def remove_file(path) do
    case File.rm(path) do
      :ok ->
        say_remove(path)
        :ok
      {:error, :enoent} ->
        say_error("File does not exist: #{path}")
        {:error, :enoent}
      {:error, :eacces} ->
        say_error("Don't have permission for removing: #{path}")
        {:error, :eacces}
      {:error, :eperm} ->
        say_error("File and user is not super-user: #{path}")
        {:error, :eperm}
      {:error, :enotdir} ->
        say_error("Component of filename is not directory: #{path}")
        {:error, :enotdir}
      {:error, :einval} ->
        say_error("Filename had an improper type: #{path}")
        {:error, :einval}
    end
  end


  @doc """
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
