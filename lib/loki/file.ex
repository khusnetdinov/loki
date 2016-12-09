defmodule Loki.File do
  import Loki.Shell

  @moduledoc false

  @doc """
  """
  @spec create_file(Path.t) :: Boolean.t
  def create_file(path) when is_bitstring(path) do
    create_file(path, "")
  end

  @doc false
  @spec create_file(any) :: none()
  def create_file(_any), do: raise ArgumentError, message: "Invalid argument, accept String, [String]!"

  @doc false
  @spec create_file(Path.t, String.t) :: Boolean.t
  def create_file(path, content) do
    case File.write(path, content, []) do
      :ok ->
        say_create("#{path}")
        :ok
      {:error, reason} ->
        say_error("Can't create: #{path}: #{reason}!")
    end
  end


  @doc """
  """
  @spec create_file_force(Path.t, String.t) :: Boolean.t
  def create_file_force(path, content) do
    case File.write(path, content, []) do
      :ok ->
        say_force("#{path}")
        :ok
      {:error, reason} ->
        say_error("Can't create: #{path}: #{reason}!")
    end
  end


  @doc """
  """
  @spec create_file_force_or_skip(Path.t, String.t) :: Boolean.t | none()
  def create_file_force_or_skip(path, content) do
     if yes?(" Do you want to force create file? [Yn] ") do
       create_file_force(path, content)
     else
       say_skip("#{path}")
     end
  end


  @doc """
  """
  @spec exists_file?(Path.t) :: Boolean.t
  def exists_file?(path) when is_bitstring(path), do: File.exists? path

  @doc false
  @spec exists_file?(any) :: none()
  def exists_file?(_any), do: raise ArgumentError, message: "Invalid argument, accept String!"


  @doc """
  """
  @spec identical_file?(Path.t, Path.t) :: Boolean.t
  def identical_file?(path, renderer) do
    {:ok, content} = File.read(path)
    content == renderer
  end


  @doc """
  """
  @spec copy_file(Path.t, Path.t) :: {:ok, non_neg_integer} | {:error, posix}
  def copy_file(source, target), do: File.copy(source, target)

end
