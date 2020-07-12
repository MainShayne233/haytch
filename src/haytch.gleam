pub type ParseResult(t) =
  Result(tuple(String, t), String)

pub type AttributeValueType {
  String
}

pub type AttributeValue {
  AttributeValue(typ: AttributeValueType, value_: String)
}

pub type Attribute {
  Attribute(key: String, value: AttributeValue)
}

pub type Node {
  Doctype(typ: String, meta: String)
  Element(name: String, List(Attribute), List(Node))
}

pub external fn parse_doctype_declaration(
  input: String,
) -> Result(tuple(String, t), String) =
  "haytch_bridge" "parse_doctype_declaration"

pub external fn parse_html_fragment(input: String) -> Result(Node, String) =
  "haytch_bridge" "parse_html_fragment"
