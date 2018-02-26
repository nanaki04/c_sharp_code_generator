defmodule CSharpCodeGenerator.InterfaceProperty do
  alias CodeParserState.Property, as: Property

  @type state :: CSharpCodeGenerator.state
  @type property :: Property.property

  @template File.read! "templates/interface_property.tmpl"

  @spec generate(state, property) :: String.t
  def generate(state, property) do
    CSharpCodeGenerator.find_template(state, :interface_property_template, @template)
    |> String.replace(~r/<\{description\}>/, Property.description property)
    |> String.replace(~r/<\{type\}>/, Property.type property)
    |> String.replace(~r/<\{name\}>/, Property.name property)
  end
end
