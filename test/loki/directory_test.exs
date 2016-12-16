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
      assert capture_io(fn ->
        copy_directory("temp/test", "temp/copy")
      end) == "\e[32m *      copy \e[0mtemp/test\e[32m to \e[0mtemp/copy\e[0m\n"
    end

    test "#remove_directory" do
      assert capture_io(fn ->
        remove_directory("temp/copy")
      end)
    end
  end
end
