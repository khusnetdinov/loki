defmodule Loki do
  @moduledoc """
  Loki provide additional helpers for building command line application without running additional process.

  It includes:

    * `Loki.Shell` - Helpers for interaction with user and printing message to shell.

    * `Loki.Cmd`   - Executing terminal commands helpers.

    * `Loki.Directory` - Working with folders helpers.

    * `Loki.File` - Helpers for working with files.

    * `Loki.FileManipulation` - Helpers for content manipulation injecting, appending and other.

  """

  @doc """
  Imports all aveliable modules
  """
  defmacro __using__(_) do
    quote do
      import Loki.Shell
      import Loki.Cmd
      import Loki.Directory
      import Loki.File
      import Loki.FileManipulation
    end
  end
end
