defmodule CSharpCodeGeneratorTest do
  use ExUnit.Case
  doctest CSharpCodeGenerator

  test "greets the world" do
    assert CSharpCodeGenerator.hello() == :world
  end
end
