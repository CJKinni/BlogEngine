defmodule BlogEngineTest do
  use ExUnit.Case
  doctest BlogEngine

  test "greets the world" do
    assert BlogEngine.hello() == :world
  end
end
