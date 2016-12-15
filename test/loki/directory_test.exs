defmodule Loki.DirectoryTest do
  use ExUnit.Case, async: true

  import Loki.Directory
  import ExUnit.CaptureIO


  describe "Directory" do
    test "#create_directory command in shell" do
      assert capture_io(fn ->
        create_directory("../../temp/test")
      end) == "\e[32m *  creating \e[0mdirectory ../../temp/test\e[0m\n"
    end

    @tag :pending
    test "#crate_directory return result" do
      assert create_directory("../../temp/test") == :ok
    end

    test "#exists_directory? command in shell" do
      assert exists_directory?("fake") == false
    end

    test "#copy_directory command in shell" do
      assert capture_io(fn ->
        copy_directory("temp/copy_test", "temp/copy")
      end) == "\e[32m *      copy \e[0mtemp/copy_test\e[32m to \e[0mtemp/copy\e[0m\n"
    end

    @tag :pending
    test "#copy_directory return error" do
      assert copy_directory("temp/copy_test", "temp/copy") == {:error, :enoent, "temp/copy_test"}
    end

    test "#remove_directory command in shell" do
      assert capture_io(fn ->
        remove_directory("temp/copy_test")
      end)
    end

    @tag :pending
    test "#remove_directory return result" do
      create_directory("temp/remove_test")
      assert remove_directory("temp/remove_test") == {:ok, ["temp/remove_test"]}
    end
  end
end
