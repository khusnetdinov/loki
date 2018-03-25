defmodule Loki.ShellTest do
  use ExUnit.Case, async: false

  import Loki.Shell
  import ExUnit.CaptureIO


  describe "Shell" do
    test "#ask input" do
      assert capture_io("answer", fn ->
        awnser = ask("Test question?")
        send self(), awnser
      end) == "Test question?"

      assert_received {[], ["answer"], []}
    end

    test "#ask sensitive input" do
      assert capture_io("AnSwEr", fn ->
        awnser = ask("Test question?", sensitive: true)
        send self(), awnser
      end) == "Test question?"

      assert_received {[], ["AnSwEr"], []}
    end

    test "#yes? yes input" do
      assert capture_io("yes", fn ->
        awnser = yes?("Test question?")
        send self(), awnser
      end) == "Test question?"

      assert_received true
    end

    test "#yes? y input" do
      assert capture_io("y", fn ->
        awnser = yes?("Test question?")
        send self(), awnser
      end) == "Test question?"

      assert_received true
    end

    test "#no? no input" do
      assert capture_io("no", fn ->
        awnser = no?("Test question?")
        send self(), awnser
      end) == "Test question?"

      assert_received true
    end

    test "#no? n input" do
      assert capture_io("n", fn ->
        awnser = no?("Test question?")
        send self(), awnser
      end) == "Test question?"

      assert_received true
    end

    test "#say to shell" do
      assert capture_io(fn ->
        say "Saying to shell"
      end) == "Saying to shell" <> "\n"
    end

    test "#say_create" do
      assert capture_io(fn ->
        say_create "file"
      end) == "\e[32m *  creating \e[0mfile\e[0m\n"
    end

    test "#say_force" do
      assert capture_io(fn ->
        say_force "file"
      end) == "\e[33m *     force \e[0mfile\e[0m\n"
    end

    test "#say_identical" do
      assert capture_io(fn ->
        say_identical "file"
      end) == "\e[34m\e[1m * identical \e[0mfile\e[0m\n"
    end

    test "#say_skip" do
      assert capture_io(fn ->
        say_skip "file"
      end) == "\e[33m *      skip \e[0mfile\e[0m\n"
    end

    test "#say_error" do
      assert capture_io(fn ->
        say_error "file"
      end) == "\e[31m *     error \e[0mfile\e[0m\n"
    end

    test "#say_conflict" do
      assert capture_io(fn ->
        say_conflict "file"
      end) == "\e[33m *  conflict \e[0mfile\e[0m\n"
    end

    test "#say_exists" do
      assert capture_io(fn ->
        say_exists "file"
      end) == "\e[34m\e[1m *    exists \e[0mfile\e[0m\n"
    end

    test "#say_rename" do
      assert capture_io(fn ->
        say_rename "file", "new_file"
      end) == "\e[32m *    rename \e[0mfile\e[32m to \e[0mnew_file\e[0m\n"
    end

    test "#say_copy" do
      assert capture_io(fn ->
        say_copy "file", "new_file"
      end) == "\e[32m *      copy \e[0mfile\e[32m to \e[0mnew_file\e[0m\n"
    end

    test "#say_remove" do
      assert capture_io(fn ->
        say_remove "file"
      end) == "\e[32m *    remove \e[0mfile\e[0m\n"
    end
  end
end

