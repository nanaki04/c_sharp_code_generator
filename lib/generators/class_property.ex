defmodule CSharpCodeGenerator.ClassProperty do
  alias CodeParserState.Property, as: Property

  @type state :: CSharpCodeGenerator.state
  @type property :: Property.property

  @public_template File.read! "templates/property_set_get.tmpl"
  @private_template File.read! "templates/property.tmpl"

  @spec generate(state, property) :: String.t
  def generate(state, property) do
    find_template(state, property)
    |> String.replace(~r/<\{description\}>/, Property.description property)
    |> String.replace(~r/<\{accessibility\}>/, Property.accessibility property)
    |> String.replace(~r/<\{type\}>/, Property.type property)
    |> String.replace(~r/<\{name\}>/, Property.name property)
  end

  @spec find_template(state, property) :: String.t
  defp find_template(state, %{accessibility: accessibility}) do
    case Regex.match?(~r/public/, accessibility) do
      true -> CSharpCodeGenerator.find_template(state, :class_public_property_template, @public_template)
      _ -> CSharpCodeGenerator.find_template(state, :class_private_property_template, @private_template)
    end
  end
end
