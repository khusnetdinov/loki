defmodule Loki do
  @moduledoc """
  """

  @doc """
  """

  def __using__() do
    quote do
      import Loki.Shell
      import Loki.Cmd
      import Loki.Directory
      import Loki.File
      import Loki.FileManipulation
    end
  end
end
