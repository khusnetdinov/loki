defmodule Loki.FileManipulationTest do
  use ExUnit.Case, async: true

  import Loki.FileManipulation
  import Loki.TestHelpers
  import ExUnit.CaptureIO


  describe "FileManipulation" do
    test "#append_to_file" do
      create_file_silently("append")

      assert capture_io(fn ->
        append_to_file("temp/append", "appended")
      end) == "\e[32m *    append \e[0mtemp/append\e[0m\n"
    end

    test "#prepend_to_file" do
      create_file_silently("prepend")

      assert capture_io(fn ->
        prepend_to_file("temp/prepend", "prepended")
      end) == "\e[32m *   prepend \e[0mtemp/prepend\e[0m\n"
    end

    test "#remove_from_file" do
      create_file_silently("remove", "remove")

      assert capture_io(fn ->
        remove_from_file("temp/remove", "remove")
      end) == "\e[32m *    remove \e[0mtemp/remove\e[0m\n"
    end

    test "#inject_into_file" do
      create_file_silently("inject", "line")

      assert capture_io(fn ->
        inject_into_file("temp/inject", "injected", :after, "line")
      end) == "\e[32m *    inject \e[0mtemp/inject\e[0m\n"
    end

    test "#replace_in_file" do
      create_file_silently("replace", "replace")

      assert capture_io(fn ->
        replace_in_file("temp/replace", "replaced", "replace")
      end) == "\e[32m *   replace \e[0mtemp/replace\e[0m\n"
    end

    test "#comment_in_file" do
      create_file_silently("comment", "comment")

      assert capture_io(fn ->
        comment_in_file("temp/comment", "comment")
      end) == "\e[32m *  comment \e[0mtemp/comment\e[0m\n"
    end

    test "#uncomment_in_file" do
      create_file_silently("uncomment", "# uncomment")

      assert capture_io(fn ->
        comment_in_file("temp/uncomment", "# uncomment")
      end) == "\e[32m *  comment \e[0mtemp/uncomment\e[0m\n"
    end

    test "#remove_comments_in_file" do
      create_file_silently("remove_all_comments", "# comment\n # comment")

      assert capture_io(fn ->
        remove_comments_in_file("temp/remove_all_comments")
      end) == "\e[32m * uncomment \e[0m in file temp/remove_all_comments\e[0m\n"
    end
  end
end

