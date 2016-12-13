defmodule Loki.FileManipulation do
  import Loki.Shell
  import Loki.File, only: [exists_file?: 1]

  @moduledoc """
  """

  @doc """
  """
  @spec append_to_file(Path.t, String.t) :: :ok | {:error, String.t}
  def append_to_file(path, content) do
    edit_exists_file(path, content, fn ->
      file = File.open(path, [:append])
      case file do
        {:ok, file_pid} ->
          IO.write(file_pid, content)
          say IO.ANSI.format [:green, " *   append ", :reset, path]
          :ok
        {:error, reason} ->
          say_error(reason)
          {:error, reason}
      end
    end)
  end

  @doc false
  @spec append_to_file(any) :: none()
  def append_to_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"


  @doc """
  """
  @spec prepend_to_file(Path.t, String.t) :: :ok | {:error, String.t}
  def prepend_to_file(path, content) do
    edit_exists_file(path, content, fn ->
      file = File.read(path)
      case file do
        {:ok, file_content} ->
          File.write(path, content <> file_content)
          say IO.ANSI.format [:green, " *  prepend ", :reset, path]
          :ok
        {:error, reason} ->
          say_error(reason)
      end
    end)
  end

  @doc false
  @spec prepend_to_file(any) :: none()
  def prepend_to_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"

  # @doc false
  # @spec false
  # def remove_from_file(path, content, opts // []) do
    # process_file(path, content, opts, fn -> nil end)
  # end

  # @doc false
  # @spec false
  # def inject_into_file(path, content, opts // []) do
    # process_file(path, content, opts, fn -> nil end)
  # end

  # @doc false
  # @spec false
  # def replace_in_file(path, content, opts // []) do
    # process_file(path, content, opts, fn -> nil end)
  # end

  # @doc false
  # @spec false
  # def comment_in_file(path, content, opts // []) do
    # process_file(path, content, opts, fn -> nil end)
  # end

  # @doc false
  # @spec false
  # def uncomment_in_file(path, content, opts // []) do
    # process_file(path, content, opts, fn -> nil end)
  # end

  @doc false
  @spec edit_exists_file(Path.t, String.t, (Path.t, Path.t -> {:ok, Pid.t} | {:error, String.t})) :: {:ok, Pid.t} | {:error, String.t | Atom.t}
  def edit_exists_file(path, _content, callback) do
    if exists_file?(path) do
      callback.()
    else
      say_error("File doesn't exists: #{path}")
      {:error, :eexist}
    end
  end

  # @doc false
  # @spec read_to_list(Path.t) :: List.t
  # def readt_to_list(path) do
  # end


  # @doc false
  # @spec false
  # defp process_file(path, content, opts, callback) do
    # # :before, :after, :global, :lines -> OptionParser
  # end
end
