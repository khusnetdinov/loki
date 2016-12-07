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
  test "asking yes?" do
    given = nil
    expected = true

    assert given == expected
  end

  @tag :skip
  test "asking no?" do
    given = nil
    expected = true

    assert given == expected
  end

  #TODO: say
end
