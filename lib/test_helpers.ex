defmodule Loki.TestHelpers do
  import ExUnit.CaptureIO
  import Loki.Directory
  import Loki.File

  @tests_directory "temp"

  def prepare_tests() do
    if exists_directory?(@tests_directory) do
      capture_io(fn -> remove_directory(@tests_directory) end)
    end

    create_directory_silently(@tests_directory)
  end

  def create_directory_silently(dir_name) do
    capture_io(fn -> create_directory("#{@tests_directory}/#{dir_name}") end)
  end

  def create_file_silently(file_name) do
    capture_io(fn -> create_file("#{@tests_directory}/#{file_name}") end)
  end

  def create_file_silently(file_name, content) do
    capture_io(fn -> create_file("#{@tests_directory}/#{file_name}", content) end)
  end
end
