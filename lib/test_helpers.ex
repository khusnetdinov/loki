defmodule Loki.TestHelpers do
  import Loki.Directory

  @tests_directory "temp"

  def prepare_tests() do
    if exists_directory?(@tests_directory) do
      remove_directory(@tests_directory, silent: true)
    end

    create_directory(@tests_directory, silent: true)
  end
end
