defmodule Loki.FileTest do
  use ExUnit.Case, async: false

  import Loki.File
  import ExUnit.CaptureIO


  describe "File" do
    test "#create_file" do
      assert capture_io(fn ->
        create_file("temp/create")
      end) == "\e[32m *  creating \e[0mtemp/create\e[0m\n"
    end

    test "#create_file_force" do
      capture_io(fn -> create_file("temp/force") end)

      assert capture_io(fn ->
        create_file_force("temp/force")
      end) == "\e[33m *     force \e[0mtemp/force\e[0m\n"
    end

    test "#copy_file" do
      capture_io(fn -> create_file("temp/copy") end)

      assert capture_io(fn ->
        copy_file("temp/copy", "temp/copied")
      end) == "\e[32m *      copy \e[0mtemp/copy\e[32m to \e[0mtemp/copied\e[0m\n"
    end

    test "#create_link" do
      capture_io(fn -> create_file("temp/link") end)

      assert capture_io(fn ->
        create_link("temp/link", "temp/linked")
      end) == "\e[32m *      link \e[0mtemp/link\e[32m to \e[0mtemp/linked\e[0m\n"
    end

    test "#remove_file" do
      capture_io(fn -> create_file("temp/remove") end)

      assert capture_io(fn ->
        remove_file("temp/remove")
      end) == "\e[32m *    remove \e[0mtemp/remove\e[0m\n"
    end

    test "#rename_file" do
      capture_io(fn -> create_file("temp/rename") end)

      assert capture_io(fn ->
        rename("temp/rename", "temp/renamed")
      end)
    end
  end
end
