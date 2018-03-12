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
  @method_parameter_doc_template File.read! "templates/method_parameter_doc.tmpl"
  @public_property_template File.read! "templates/public_property.tmpl"
  @private_property_template File.read! "templates/private_property.tmpl"

  @unity_private_property_template File.read! "templates/custom/unity_private_property.tmpl"
  @unity_class_template File.read! "templates/custom/unity_class.tmpl"

  @spec generate(code_parser_state, options) :: :ok
  def generate(code_parser_state, options \\ []) do
    BoilerplateGenerator.generate(code_parser_state, options
      |> Keyword.put_new(:extension, ".cs")
      |> Keyword.put_new(:class_template, @class_template)
      |> Keyword.put_new(:enum_template, @enum_template)
      |> Keyword.put_new(:enum_property_template, @enum_property_template)
      |> Keyword.put_new(:interface_template, @interface_template)
      |> Keyword.put_new(:interface_method_template, @interface_method_template)
      |> Keyword.put_new(:interface_property_template, @interface_property_template)
      |> Keyword.put_new(:method_template, @method_template)
      |> Keyword.put_new(:method_parameter_doc_template, @method_parameter_doc_template)
      |> Keyword.put_new(:public_property_template, @public_property_template)
      |> Keyword.put_new(:private_property_template, @private_property_template)
    )
  end

  @spec generate_for_unity(code_parser_state, options) :: :ok
  def generate_for_unity(code_parser_state, options \\ []) do
    BoilerplateGenerator.generate(code_parser_state, options
      |> Keyword.put_new(:extension, ".cs")
      |> Keyword.put_new(:class_template, @unity_class_template)
      |> Keyword.put_new(:enum_template, @enum_template)
      |> Keyword.put_new(:enum_property_template, @enum_property_template)
      |> Keyword.put_new(:interface_template, @interface_template)
      |> Keyword.put_new(:interface_method_template, @interface_method_template)
      |> Keyword.put_new(:interface_property_template, @interface_property_template)
      |> Keyword.put_new(:method_template, @method_template)
      |> Keyword.put_new(:method_parameter_doc_template, @method_parameter_doc_template)
      |> Keyword.put_new(:public_property_template, @public_property_template)
      |> Keyword.put_new(:private_property_template, @unity_private_property_template)
    )
  end

end
