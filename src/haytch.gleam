pub type ParseResult(t) =
  Result(tuple(String, t), String)

pub type Node {
  Doctype(typ: String, meta: String)
}

pub external fn parse_doctype_declaration(input: String) -> ParseResult(Node) =
  "haytch_bridge" "parse_doctype_declaration"

pub fn hello_world() -> String {
  "Hello, from haytch!"
}
