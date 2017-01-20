defmodule Loki.CmdTest do
  use ExUnit.Case, async: true

  import Loki.Cmd
  import ExUnit.CaptureIO


  describe "Cmd" do
    test "#execute" do
      assert capture_io(fn ->
        execute "pwd"
      end) == "\e[32m *   execute \e[0mpwd\e[0m\n"
    end

    test "#execute_in_path" do
      assert capture_io(fn ->
        execute_in_path("pwd", "..")
      end) == "\e[32m *   execute \e[0mpwd in path ..\e[0m\n"
    end

    test "#format_output" do
      {test_user, _} = System.cmd("whoami", [])

      assert capture_io(fn ->
        format_output(System.cmd("whoami", []))
      end) == "\n\e[33m#{test_user}\e[0m\n"
    end
  end
end

