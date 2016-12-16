defmodule Loki.FileManipulationTest do
  use ExUnit.Case, async: false

  import Loki.File
  import Loki.FileManipulation
  import ExUnit.CaptureIO

  setup_all do
    :ok
  end


  describe "FileManipulation" do
    test "#append_to_file" do
      assert capture_io(fn ->
        append_to_file("temp/append", "appended")
      end) == "\e[32m *    append \e[0mtemp/append\e[0m\n"
    end

    test "#prepend_to_file" do
      assert capture_io(fn ->
        prepend_to_file("temp/prepend", "prepended")
      end) == "\e[32m *   prepend \e[0mtemp/prepend\e[0m\n"
    end

    test "#remove_from_file" do
      assert capture_io(fn ->
        remove_from_file("temp/prepend", "prepended")
      end) == "\e[32m *    remove \e[0mtemp/prepend\e[0m\n"
    end

    test "#inject_into_file" do
      assert capture_io(fn ->
        inject_into_file("temp/inject", "injected", [:after, "line"])
      end) == ""
    end

    test "#replace_in_file" do
      assert capture_io(fn ->
        replace_in_file("temp/replace", "replaced", "replace")
      end) == "\e[32m *   replace \e[0mtemp/replace\e[0m\n"
    end

    test "#comment_in_file" do
      assert capture_io(fn ->
        comment_in_file("temp/comment", "comment")
      end)
    end

    test "#uncomment_in_file" do
      assert capture_io(fn ->
        comment_in_file("temp/uncomment", "# uncomment")
      end)
    end
  end
end

