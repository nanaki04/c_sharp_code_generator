defmodule CSharpCodeGeneratorTest do
  use ExUnit.Case
  doctest CSharpCodeGenerator

  test "generates cs files" do
    result = CodeParserState.Example.generate
    |> CSharpCodeGenerator.generate()
    assert :ok = result
    assert {:ok, _} = File.read "Dummy/Namespace/DummyClass.cs"
  end

  test "generate cs files for unity" do
    result = CodeParserState.Example.generate
    |> CSharpCodeGenerator.generate_for_unity()
    assert :ok = result
    assert {:ok, _} = File.read "Dummy/Namespace/DummyClass.cs"
  end
end
