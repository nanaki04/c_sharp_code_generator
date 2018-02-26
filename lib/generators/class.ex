defmodule CSharpCodeGenerator.Class do
  alias CodeParserState.Namespace, as: Namespace
  alias CodeParserState.Class, as: Class
  alias CSharpCodeGenerator.ClassProperty, as: PropertyGenerator
  alias CSharpCodeGenerator.ClassMethod, as: MethodGenerator

  @type state :: CSharpCodeGenerator.state
  @type namespace :: %Namespace{}
  @type class :: %Class{}
  @type ok :: CSharpCodeGenerator.Exporter.ok
  @type error :: CSharpCodeGenerator.Exporter.error

  @template File.read! "templates/class.tmpl"

  @spec generate(state, namespace, class) :: ok | error
  def generate(state, namespace, class) do
    CSharpCodeGenerator.find_template(state, :class_template, @template)
    |> String.replace(~r/<\{namespace\}>/, Namespace.name namespace)
    |> String.replace(~r/<\{name\}>/, Class.name class)
    |> String.replace(~r/<\{description\}>/, Class.description class)
    |> String.replace(~r/<\{properties\}>/, Enum.reduce(Class.properties(class), "", fn
      property, acc -> acc <> PropertyGenerator.generate(state, property)
    end))
    |> String.replace(~r/<\{methods\}>/, Enum.reduce(Class.methods(class), "", fn
      method, acc -> acc <> MethodGenerator.generate(state, method)
    end))
    |> CSharpCodeGenerator.Exporter.export(namespace
      |> Namespace.name
      |> String.split(".")
      |> (&[state.root_dir | &1]).()
      |> (&(&1 ++ [Class.name(class) <> ".cs"])).()
      |> Path.join
    )
  end
end
