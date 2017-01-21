defmodule Loki.FileManipulation do
  import Loki.Shell
  import Loki.File


  @moduledoc """
  Helpers for content manipulation injecting, appending, and other.
  """


  @doc """
  Helper appends lines to file.
  """
  @spec append_to_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def append_to_file(path, content) when is_bitstring(path), do: append_to_file(path, content, [])

  @spec append_to_file(any) :: none()
  def append_to_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"

  @spec append_to_file(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def append_to_file(path, content, opts) do
    edit_exists_file(path, fn ->
      file = File.open(path, [:append])

      case file do
        {:ok, file_pid} ->
          say(IO.ANSI.format([:green, " *    append ", :reset, path]), opts)
          IO.write(file_pid, content)
        {:error, reason} ->
          say_error(reason, opts)
          {:error, reason}
      end
    end)
  end


  @doc """
  Helper prepends lines to file.
  """
  @spec prepend_to_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def prepend_to_file(path, content) when is_bitstring(path), do: prepend_to_file(path, content, [])

  @spec prepend_to_file(any) :: none()
  def prepend_to_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"

  @spec prepend_to_file(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def prepend_to_file(path, content, opts) do
    edit_exists_file(path, fn ->
      file = File.read(path)
      case file do
        {:ok, file_content} ->
          say(IO.ANSI.format([:green, " *   prepend ", :reset, path]), opts)
          File.write(path, content <> file_content)
        {:error, reason} ->
          say_error(reason, opts)
          {:error, reason}
      end
    end)
  end


  @doc """
  Helper removes lines from file.
  """
  @spec remove_from_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def remove_from_file(path, content) when is_bitstring(path), do: remove_from_file(path, content, [])

  @spec remove_from_file(any) :: none()
  def remove_from_file(_any), do: raise ArgumentError, message: "invalid argument, accept path, string!"

  @spec remove_from_file(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def remove_from_file(path, content, opts) do
    edit_exists_file(path, fn ->
      lines = List.delete(read_to_list(path), content)
      case write_file(path, lines) do
        :ok ->
        say_remove(path, opts)
          :ok
        {:error, reason} ->
          say_error(reason, opts)
          {:error, reason}
      end
    end)
  end


  @doc """
  Helper injecting lines to file with `before` and `after` options.
  """
  @spec inject_into_file(Path.t, String.t, Atom.t, String.t) :: :ok | {:error, Atom.t}
  def inject_into_file(path, injection, order, ancor) when is_bitstring(path) do
    inject_into_file(path, injection, order, ancor, [])
  end

  @spec inject_into_file(any) :: none()
  def inject_into_file(_any), do: raise ArgumentError, message: "Invalid argumtn, accept String, String, Keyword!"

  @spec inject_into_file(Path.t, String.t, Atom.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def inject_into_file(path, injection, order, ancor, opts) do
    edit_exists_file(path, fn ->
      case split_list(read_to_list(path), ancor) do
        {:ok, head, elem, tail} ->
          message = IO.ANSI.format([:green, " *    inject ", :reset, path])

          case order do
            :before ->
              case write_file(path, head ++ [injection] ++ [elem] ++ tail) do
                :ok ->
                  say(message, opts)
                  :ok
                {:error, reason} ->
                  say_error(reason, opts)
                  {:error, reason}
              end
            :after ->
              case write_file(path, head ++ [elem] ++ [injection] ++ tail) do
                :ok ->
                  say(message, opts)
                  :ok
                {:error, reason} ->
                  say_error(reason, opts)
                  {:error, reason}
              end
              _ ->
                {:error, :eopts}
            end
        {:error, _} ->
          say_error(:enofnd, opts)
          {:error, :enofnd}
      end
    end)
  end


  @doc """
  Helper replaces lines in file.
  """
  @spec replace_in_file(String.t, String.t, String.t) :: :ok | {:error, Atom.t}
  def replace_in_file(path, content, remove) when is_bitstring(path) do
    replace_in_file(path, content, remove, [])
  end

  @spec replace_in_file(any) :: none()
  def replace_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accpet String, String, String!"

  @spec replace_in_file(String.t, String.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def replace_in_file(path, content, remove, opts) do
    edit_exists_file(path, fn ->
      case split_list(read_to_list(path), remove) do
        {:ok, head, _, tail} ->
          case write_file(path, head ++ [content] ++ tail) do
            :ok ->
              say(IO.ANSI.format([:green, " *   replace ", :reset, path]), opts)
              :ok
            {:error, reason} ->
              say_error(reason, opts)
              {:error, reason}
          end
        {:error, _} ->
          say_error(:enofnd)
          {:error, :enofnd}
      end
    end)
  end


  @doc """
  Helper comments line in file.
  """
  @spec comment_in_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def comment_in_file(path, content) when is_bitstring(path), do: comment_in_file(path, content, [])

  @spec comment_in_file(any) :: none()
  def comment_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"

  @spec comment_in_file(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def comment_in_file(path, content, opts) do
    edit_exists_file(path, fn ->
      case split_list(read_to_list(path), content) do
        {:ok, head, _, tail} ->
          case write_file(path, head ++ ["# #{content}"] ++ tail) do
            :ok ->
              say(IO.ANSI.format([:green, " *  comment ", :reset, path]), opts)
              :ok
            {:error, reason} ->
              say_error(reason, opts)
              {:error, reason}
          end
        {:error, _} ->
          say_error(:enofnd, opts)
          {:error, :enofnd}
      end
    end)
  end


  @doc """
  Helper uncomments lines in file.
  """
  @spec uncomment_in_file(Path.t, String.t) :: :ok | {:error, Atom.t}
  def uncomment_in_file(path, content) when is_bitstring(path), do: uncomment_in_file(path, content, [])

  @spec uncomment_in_file(any) :: none()
  def uncomment_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path, String!"

  @spec uncomment_in_file(Path.t, String.t, Keyword.t) :: :ok | {:error, Atom.t}
  def uncomment_in_file(path, content, opts) do
    edit_exists_file(path, fn ->
      case split_list(read_to_list(path), content) do
        {:ok, head, _, tail} ->
          case write_file(path, head ++ [String.replace(content, "# ", "")] ++ tail) do
            :ok ->
              say(IO.ANSI.format([:green, " * uncomment ", :reset, path]), opts)
              :ok
            {:error, reason} ->
              say_error(reason, opts)
              {:error, reason}
          end
        {:error, _} ->
          say_error(:enofnd, opts)
          {:error, :enofnd}
      end
    end)
  end


  @doc """
  Helper removes all commented lines.
  """
  @spec remove_comments_in_file(Path.t) :: none()
  def remove_comments_in_file(path) when is_bitstring(path), do: remove_comments_in_file(path, [])

  @spec remove_comments_in_file(any) :: none()
  def remove_comments_in_file(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec remove_comments_in_file(Path.t, Keyword.t) :: none()
  def remove_comments_in_file(path, opts) do
    edit_exists_file(path, fn ->
      lines = Enum.reject(read_to_list(path), fn (line) ->
        Regex.match?(~r/^\s*#+[\s,\w,\d]*$/, line)
      end)

      case write_file(path, lines) do
        :ok ->
          say(IO.ANSI.format([:green, " * uncomment ", :reset, " in file #{path}"]), opts)
          :ok
        {:error, reason} ->
          say_error(reason, opts)
          {:error, reason}
      end
    end)
  end


  @spec read_to_list(Path.t) :: List.t
  defp read_to_list(path) when is_bitstring(path), do: read_to_list(File.open!(path, [:read]), path, [])

  @spec read_to_list(any) :: none()
  defp read_to_list(_any), do: raise ArgumentError, message: "Invalid argument, accept Path!"

  @spec read_to_list(iolist(), Path.t, List.t) :: List.t
  defp read_to_list(file_io, path, file_lines) when is_bitstring(path) do
    line = IO.read(file_io, :line)
    if line != :eof do
      read_to_list(file_io, path,[remove_trailing_spaces(line) | file_lines])
    else
      File.close(path)
      Enum.reverse(file_lines)
    end
  end


  @spec split_list(List.t, String.t) :: List.t | none()
  defp split_list(list, value), do: split_list([], value, list)

  @spec split_list(List.t, String.t, List.t) :: List.t
  defp split_list(head_list, value, [elem | tail_list]) do
    if value == elem do
      {:ok, head_list, elem, tail_list}
    else
      split_list(head_list ++ [elem], value, tail_list)
    end
  end

  @spec split_list(List.t, String.t, List.t) :: List.t
  defp split_list(head_list, _, []), do: {:error, head_list}


  @spec edit_exists_file(Path.t, (Path.t, Path.t -> {:ok, Pid.t} | {:error, Atom.t})) :: {:ok, Pid.t} | {:error, Atom.t}
  defp edit_exists_file(path, callback) when is_bitstring(path) do
    if exists_file?(path) do
      callback.()
    else
      say_error(:eexist)
      {:error, :eexist}
    end
  end

  @spec write_file(Path.t, List.t) :: :ok | {:error, Atom.t}
  defp write_file(path, lines) when is_bitstring(path) do
    new_file_string = Enum.join(lines, "\n")
    File.write(path, new_file_string, [])
  end

  @spec remove_trailing_spaces(String.t) :: String.t
  defp remove_trailing_spaces(string) do
    Regex.replace(~r/\r?\n\z|\r\z/, string, "", [{:global, false}])
  end
end
