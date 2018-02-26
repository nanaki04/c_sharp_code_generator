defmodule CSharpCodeGenerator.Enum do
  alias CodeParserState.Namespace, as: Namespace
  alias CodeParserState.Enum, as: EnumState
  alias CodeParserState.Class, as: Class
  alias CSharpCodeGenerator.EnumProperty, as: PropertyGenerator

  @type state :: CSharpCodeGenerator.state
  @type namespace :: %Namespace{}
  @type enum :: %EnumState{}
  @type ok :: CSharpCodeGenerator.Exporter.ok
  @type error :: CSharpCodeGenerator.Exporter.error

  @template File.read! "templates/enum.tmpl"

  @spec generate(state, namespace, enum) :: ok | error
  def generate(state, namespace, enum) do
    CSharpCodeGenerator.find_template(state, :enum_template, @template)
    |> String.replace(~r/<\{namespace\}>/, Namespace.name namespace)
    |> String.replace(~r/<\{name\}>/, Class.name enum)
    |> String.replace(~r/<\{description\}>/, Class.description enum)
    |> String.replace(~r/<\{properties\}>/, Enum.reduce(Class.properties(enum), "", fn
      property, acc -> acc <> PropertyGenerator.generate(state, property)
    end))
    |> CSharpCodeGenerator.Exporter.export(namespace
      |> Namespace.name
      |> String.split(".")
      |> (&[state.root_dir | &1]).()
      |> (&(&1 ++ [Class.name(enum) <> ".cs"])).()
      |> Path.join
    )
  end
end
