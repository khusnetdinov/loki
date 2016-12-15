defmodule Loki.ShellTest do
  use ExUnit.Case, async: true

  import Loki.Shell
  import ExUnit.CaptureIO


  describe "Shell" do
    test "asking user input" do
      assert capture_io("answer", fn ->
        ask("Test question?")
        send self(), "answer"
      end) == "Test question?"

      assert_received "answer"
    end

    test "asking yes?" do
      assert capture_io("yes", fn ->
        yes?("Test question?")
        send self(), "yes"
      end) == "Test question?"
    end

    test "asking no?" do
      assert capture_io("no", fn ->
        yes?("Test question?")
        send self(), "no"
      end) == "Test question?"
    end

    test "saying to shell" do
      assert capture_io(fn ->
        say "Saying to shell"
      end) == "Saying to shell" <> "\n"
    end

    test "saying create" do
      assert capture_io(fn ->
        say_create "file"
      end) == "\e[32m *  creating \e[0mfile\e[0m\n"
    end

    test "saying force" do
      assert capture_io(fn ->
        say_force "file"
      end) == "\e[33m *     force \e[0mfile\e[0m\n"
    end

    test "saying if identic" do
      assert capture_io(fn ->
        say_identical "file"
      end) == "\e[34m\e[1m * identical \e[0mfile\e[0m\n"
    end

    test "saying about skip" do
      assert capture_io(fn ->
        say_skip "file"
      end) == "\e[33m *      skip \e[0mfile\e[0m\n"
    end

    test "saying error" do
      assert capture_io(fn ->
        say_error "file"
      end) == "\e[31m *     error \e[0mfile\e[0m\n"
    end

    test "saying conflict" do
      assert capture_io(fn ->
        say_conflict "file"
      end) == "\e[33m *  conflict \e[0mfile\e[0m\n"
    end

    test "saying exists" do
      assert capture_io(fn ->
        say_exists "file"
      end) == "\e[34m\e[1m *    exists \e[0mfile\e[0m\n"
    end

    test "saying rename" do
      assert capture_io(fn ->
        say_rename "file", "new_file"
      end) == "\e[32m *    rename \e[0mfile\e[32m to \e[0mnew_file\e[0m\n"
    end

    test "saying copy" do
      assert capture_io(fn ->
        say_copy "file", "new_file"
      end) == "\e[32m *      copy \e[0mfile\e[32m to \e[0mnew_file\e[0m\n"
    end

    test "saying remove" do
      assert capture_io(fn ->
        say_remove "file"
      end) == "\e[32m *    remove \e[0mfile\e[0m\n"
    end
  end
end

