defmodule CSharpCodeGenerator.EnumProperty do
  alias CodeParserState.Property, as: Property

  @type state :: CSharpCodeGenerator.state
  @type property :: Property.property

  @template File.read! "templates/enum_property.tmpl"

  @spec generate(state, property) :: String.t
  def generate(state, property) do
    CSharpCodeGenerator.find_template(state, :enum_property_template, @template)
    |> String.replace(~r/<\{name\}>/, Property.name property)
  end
end
