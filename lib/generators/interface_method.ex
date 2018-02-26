defmodule CSharpCodeGenerator.InterfaceMethod do
  alias CodeParserState.Method, as: Method

  @type state :: CSharpCodeGenerator.state
  @type method :: Method.method

  @template File.read! "templates/interface_method.tmpl"

  @spec generate(state, method) :: String.t
  def generate(state, method) do
    CSharpCodeGenerator.find_template(state, :interface_method_template, @template)
    |> String.replace(~r/<\{description\}>/, Method.description method)
    |> String.replace(~r/<\{type\}>/, Method.type method)
    |> String.replace(~r/<\{name\}>/, Method.name method)
    |> String.replace(~r/<\{parameters\}>/, Enum.map(Method.parameters(method), fn
      parameter -> parameter.type <> " " <> parameter.name
    end) |> Enum.join(", "))
    |> String.replace(~r/<\{property docs\}>/, Enum.reduce(Method.parameters(method), "", fn
      parameter, acc -> acc <> "\n        /// <param name=\"" <> parameter.name <> "\"></param>"
    end))
  end
end
