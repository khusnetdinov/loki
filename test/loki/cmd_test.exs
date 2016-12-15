defmodule Loki.CmdTest do
  use ExUnit.Case, async: true

  import Loki.Cmd
  import ExUnit.CaptureIO


  describe "Cmd" do
    test "#execute command in shell" do
      assert capture_io(fn ->
        execute "pwd"
      end) == "\e[32m *   execute \e[0mpwd\e[0m\n"
    end

    @tag :pending
    test "#execute return result => " do
      assert execute("pwd") == System.cmd("pwd", [])
    end


    test "#execute_in_path command in shell" do
      assert capture_io(fn ->
        execute_in_path("pwd", "..")
      end) == "\e[32m *   execute \e[0mpwd in path ..\e[0m\n"
    end

    @tag :pending
    test "#execute_in_path return result => " do
      assert execute_in_path("pwd", "..") == System.cmd("pwd", [], cd: "..")
    end


    test "#format_output command in shell" do
      {test_user, _} = System.cmd("whoami", [])
      assert capture_io(fn ->
        format_output(System.cmd("whoami", []))
      end) == "\n\e[33m#{test_user}\e[0m\n"
    end

    @tag :pending
    test "#format_outout return result => " do
      assert format_output(System.cmd("whoami", [])) == :ok
    end
  end
end

