defmodule Loki.FileTest do
  use ExUnit.Case, async: true

  import Loki.File
  import ExUnit.CaptureIO


  describe "File" do
    test "#create_file" do
      assert capture_io(fn ->
        create_file("temp/create")
      end) == "\e[32m *  creating \e[0mtemp/create\e[0m\n"
    end

    test "#create_file_force" do
      create_file("temp/force")

      assert capture_io(fn ->
        create_file_force("temp/force")
      end) == "\e[33m *     force \e[0mtemp/force\e[0m\n"
    end

    test "#copy_file" do
      create_file("temp/copy")

      assert capture_io(fn ->
        copy_file("temp/copy", "temp/copied")
      end) == "\e[32m *      copy \e[0mtemp/copy\e[32m to \e[0mtemp/copied\e[0m\n"
    end

    test "#create_link" do
      create_file("temp/link")

      assert capture_io(fn ->
        create_link("temp/link", "temp/linked")
      end) == "\e[32m *      link \e[0mtemp/link\e[32m to \e[0mtemp/linked\e[0m\n"
    end

    test "#remove_file" do
      create_file("temp/remove")

      assert capture_io(fn ->
        remove_file("temp/remove")
      end) == "\e[32m *    remove \e[0mtemp/remove\e[0m\n"
    end

    test "#rename_file" do
      create_file("temp/rename")

      assert capture_io(fn ->
        rename("temp/rename", "temp/renamed")
      end)
    end
  end
end
