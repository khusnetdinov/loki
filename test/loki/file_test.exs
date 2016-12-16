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
      assert capture_io(fn ->
        create_file_force("temp/create")
      end) == "\e[33m *     force \e[0mtemp/create\e[0m\n"
    end

    test "#copy_file" do
      assert capture_io(fn ->
        copy_file("temp/create", "temp/copy")
      end) == "\e[32m *      copy \e[0mtemp/create\e[32m to \e[0mtemp/copy\e[0m\n"
    end

    test "#create_link" do
      assert capture_io(fn ->
        create_link("temp/create", "temp/link")
      end) == "\e[32m *      link \e[0mtemp/create\e[32m to \e[0mtemp/link\e[0m\n"
    end

    test "#remove_file" do
      assert capture_io(fn ->
        remove_file("temp/copy")
      end) == "\e[32m *    remove \e[0mtemp/copy\e[0m\n"
    end

    test "#rename_file" do
      assert capture_io(fn ->
        rename("temp/create", "temp/create")
      end)
    end
  end
end
