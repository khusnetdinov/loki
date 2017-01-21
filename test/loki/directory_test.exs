defmodule Loki.DirectoryTest do
  use ExUnit.Case, async: false

  import Loki.Directory
  import ExUnit.CaptureIO


  describe "Directory" do
    test "#create_directory" do
      assert capture_io(fn ->
        create_directory("temp/test")
      end) == "\e[32m *  creating \e[0mdirectory temp/test\e[0m\n"
    end

    test "#exists_directory?" do
      assert exists_directory?("fake") == false
    end

    test "#copy_directory" do
      create_directory("temp/copy_dir", silent: true)

      assert capture_io(fn ->
        copy_directory("temp/copy_dir", "temp/copied_dir")
      end) == "\e[32m *      copy \e[0mtemp/copy_dir\e[32m to \e[0mtemp/copied_dir\e[0m\n"
    end

    test "#remove_directory" do
      create_directory("temp/remove", silent: true)

      assert capture_io(fn ->
        remove_directory("temp/remove")
      end)
    end
  end
end
