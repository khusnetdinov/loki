defmodule Loki.FileTest do
  use ExUnit.Case, async: true

  import Loki.File
  import ExUnit.CaptureIO

  describe "File" do
    test "#create_file command in shell" do
      assert capture_io(fn ->
        create_file("temp/create")
      end) == "\e[32m *  creating \e[0mtemp/create\e[0m\n"
    end

    @tag :pending
    test "#create_file return result" do
      file_name = "temp/create_file"

      if exists_file?(file_name) do
        remove_file(file_name)
      end
      assert create_file(file_name) == :ok
      assert create_file(file_name) == {:error, :eexist}
    end

    test "#create_file_force command in shell" do
      assert capture_io(fn ->
        create_file_force("temp/force")
      end) == "\e[33m *     force \e[0mtemp/force\e[0m\n"
    end

    @tag :pending
    test "#create_file_force return result" do
      assert create_file_force("temp/force_file") == :ok
    end

    @tag :pending
    test "#exists_file?" do
      create_file("temp/exists")
      assert exists_file?("temp/exists") == true
    end

    @tag :pending
    test "#identical_file?" do
      create_file("temp/identical")
      assert identical_file?("temp/identical", "") == true
    end

    test "#copy_file command in shell" do
      assert capture_io(fn ->
        copy_file("temp/create_file", "temp/copy_file")
      end) == "\e[32m *      copy \e[0mtemp/create_file\e[32m to \e[0mtemp/copy_file\e[0m\n"
    end

    @tag :pending
    test "#copy_file return result" do
      create_file("temp/copy_file")
      assert copy_file("temp/copy_file", "temp/result_copy_file") == {:ok, 0}
    end

    test "#create_link command in shell" do
      assert capture_io(fn ->
        create_link("temp/result_file", "temp/link_command_link")
      end) == "\e[32m *      link \e[0mtemp/result_file\e[32m to \e[0mtemp/link_command_link\e[0m\n"
    end

    @tag :pending
    test "#create_link return result" do
      assert create_link("temp/result_file", "temp/link_file")
    end

    test "#remove_file command in shell" do
      assert capture_io(fn ->
        remove_file("temp/result_file")
      end) == "\e[32m *    remove \e[0mtemp/result_file\e[0m\n"
    end

    @tag :pending
    test "#remove_file return result" do
      create_file("temp/remove_file")
      assert remove_file("temp/remove_file") == :ok
    end

    test "#rename_file command in shell" do
      assert capture_io(fn ->
        rename("temp/link_file", "temp/renamed_link_file")
      end)
    end

    @tag :pending
    test "#rename_file return result" do
      create_file("temp/rename_file")
      assert rename("temp/rename_file", "temp/renamed_file") == :ok
    end
  end
end
