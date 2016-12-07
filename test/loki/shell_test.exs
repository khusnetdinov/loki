defmodule Loki.ShellTest do
  use ExUnit.Case, async: true

  import Loki.Shell

  @tag :skip
  test "asking user input" do
    given = nil
    expected = true

    assert given == expected
  end

  @tag :skip
  test "saying to terminal" do
    given = nil
    expected = true

    assert given == expected
  end

  @tag :skip
  test "saying success message" do
    given = nil
    expected = true

    assert given == expected
  end

  @tag :skip
  test "saying error message" do
    given = nil
    expected = true

    assert given == expected
  end

  @tag :skip
  test "saying conflict message" do
    given = nil
    expected = true

    assert given == expected
  end

  @tag :skip
  test "saying force message" do
    given = nil
    expected = true

    assert given == expected
  end
end
