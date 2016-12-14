defmodule Loki.FileManipulation do
  import Loki.Shell, only: [say: 1, say_error: 1]
  import Loki.File, only: [exists_file?: 1]

  @moduledoc """
  """

  @doc """
  """
  @spec append_to_file(Path.t, String.t) :: :ok | {:error, String.t}
  def append_to_file(path, content) when is_bitstring(path) do
    edit_exists_file(path, fn ->
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
  def prepend_to_file(path, content) when is_bitstring(path) do
    edit_exists_file(path, fn ->
      file = File.read(path)
      case file do
        {:ok, file_content} ->
          File.write(path, content <> file_content)
          say IO.ANSI.format [:green, " *  prepend ", :reset, path]
          :ok
        {:error, reason} ->
          say_error(reason)
          {:error, reason}
      end
    end)
  end

  @doc false
  @spec prepend_to_file(any) :: none()
  def prepend_to_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"


  @doc """
  """
  @spec remove_from_file(Path.t, String.t) :: :ok | {:error, String.t}
  def remove_from_file(path, content) when is_bitstring(path) do
    edit_exists_file(path, fn ->
      lines = List.delete(read_to_list(path), content)
      write_file(path, lines)
    end)
  end

  @doc false
  @spec remove_from_file(any) :: none()
  def remove_from_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"


  @doc """
  """
  @spec inject_into_file(String.t, String.t, Keyword.t) :: :ok | {:error, String.t}
  def inject_into_file(path, injection, state) when is_bitstring(path) do
    lines = read_to_list(path)
    [order, value] = state
    [head, elem, tail] = split_list(lines, value)

    message = IO.ANSI.format [:green, " *   inject ", :reset, path]

    case order do
      :before ->
        say message
        write_file(path, head ++ [injection] ++ [elem] ++ tail)
      :after ->
        say message
        write_file(path, head ++ [elem] ++ [injection] ++ tail)
      _ ->
        say_error("Wrong option, should: [:before, :after]!")
        nil
    end
  end

  @doc false
  @spec inject_into_file(any) :: none()
  def inject_into_file(_any), do: raise ArgumentError, message: "Invalid argumtn, accept String, String, Keyword!"


  @doc """
  """
  @spec replace_in_file(String.t, String.t, String.t) :: :ok | {:error, String.t}
  def replace_in_file(path, content, remove) when is_bitstring(path) do
    lines = read_to_list(path)
    [head, _, tail] = split_list(lines, remove)
    state = write_file(path, head ++ [content] ++ tail)
    say IO.ANSI.format [:green, " *  replace ", :reset, path]
    state
  end

  @doc false
  @spec replace_in_file(any) :: none()
  def replace_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accpet String, String, String!"


  @doc """
  """
  @spec comment_in_file(Path.t, String.t) :: :ok | {:error, String.t}
  def comment_in_file(path, content) do
    lines = read_to_list(path)
    [head, _, tail] = split_list(lines, content)
    state = write_file(path, head ++ ["# #{content}"] ++ tail)
    say IO.ANSI.format [:green, " *  comment ", :reset, path]
    state
  end

  @doc false
  @spec comment_in_file(any) :: none()
  def comment_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"


  @doc """
  """
  @spec uncomment_in_file(Path.t, String.t) :: :ok | {:error, String.t}
  def uncomment_in_file(path, content) do
    lines = read_to_list(path)
    [head, _, tail] = split_list(lines, content)
    state = write_file(path, head ++ [String.replace(content, "# ", "")] ++ tail)
    say IO.ANSI.format [:green, " * uncomment ", :reset, path]
    state
  end

  @doc false
  @spec uncomment_in_file(any) :: none()
  def uncomment_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"


  @doc """
  """
  @spec read_to_list(Path.t) :: List.t
  def read_to_list(path) when is_bitstring(path), do: read_to_list(File.open!(path, [:read]), path, [])

  @doc false
  @spec read_to_list(any) :: none()
  def read_to_list(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @doc false
  @spec read_to_list(iolist(), Path.t, List.t) :: List.t
  def read_to_list(file_io, path, file_lines) when is_bitstring(path) do
    line = IO.read(file_io, :line)
    if line != :eof do
      read_to_list(file_io, path,[remove_trailing_spaces(line) | file_lines])
    else
      File.close(path)
      Enum.reverse(file_lines)
    end
  end


  @doc false
  @spec split_list(List.t, String.t) :: List.t | none()
  defp split_list(list, value), do: split_list([], value, list)

  @doc false
  @spec split_list(List.t, String.t, List.t) :: List.t
  defp split_list(head_list, value, [elem | tail_list]) do
    if value == elem do
      [head_list, elem, tail_list]
    else
      split_list(head_list ++ [elem], value, tail_list)
    end
  end


  @doc false
  @spec edit_exists_file(Path.t, (Path.t, Path.t -> {:ok, Pid.t} | {:error, String.t})) :: {:ok, Pid.t} | {:error, String.t | Atom.t}
  defp edit_exists_file(path, callback) when is_bitstring(path) do
    if exists_file?(path) do
      callback.()
    else
      say_error("File doesn't exists: #{path}")
      {:error, :eexist}
    end
  end

  @doc false
  @spec write_file(Path.t, List.t) :: :ok | {:error, Atom.t}
  defp write_file(path, lines) when is_bitstring(path) do
    new_file_string = Enum.join(lines, "\n")
    File.write(path, new_file_string, [])
  end

  @doc false
  @spec remove_trailing_spaces(String.t) :: String.t
  defp remove_trailing_spaces(string) do
    Regex.replace(~r/\r?\n\z|\r\z/, string, "", [{:global, false}])
  end
end
