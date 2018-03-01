defmodule CSharpCodeGenerator do

  @type code_parser_state :: CodeParserState.state
  @type options :: [any]

  @class_template File.read! "templates/class.tmpl"
  @enum_template File.read! "templates/enum.tmpl"
  @enum_property_template File.read! "templates/enum_property.tmpl"
  @interface_template File.read! "templates/interface.tmpl"
  @interface_method_template File.read! "templates/interface_method.tmpl"
  @interface_property_template File.read! "templates/interface_property.tmpl"
  @method_template File.read! "templates/method.tmpl"
  @public_property_template File.read! "templates/public_property.tmpl"
  @private_property_template File.read! "templates/private_property.tmpl"

  @spec generate(code_parser_state, options) :: :ok
  def generate(code_parser_state, _options \\ []) do
    BoilerplateGenerator.generate(code_parser_state,
      extension: ".cs",
      class_template: @class_template,
      enum_template: @enum_template,
      enum_property_template: @enum_property_template,
      interface_template: @interface_template,
      interface_method_template: @interface_method_template,
      interface_property_template: @interface_property_template,
      method_template: @method_template,
      public_property_template: @public_property_template,
      private_property_template: @private_property_template
    )
  end

end
