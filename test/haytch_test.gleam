import haytch.{
  AttrBool, AttrFloat, AttrInt, AttrString, Attribute, Doctype, Element
}
import gleam/should

pub fn parse_doctype_declaration_test() {
  let standard_input = "<!DOCTYPE html>"
  let spaces_input = "<!DOCTYPE   html  >"
  let switched_case_input = "<!doctype HTML>"
  let dtd_input = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"
  let more_input = "<!DOCTYPE html><html></html>"
  let none_input = "<h1>hi</h1>"

  standard_input
  |> haytch.parse_doctype_declaration()
  |> should.equal(Ok(tuple("", Doctype("html", ""))))

  spaces_input
  |> haytch.parse_doctype_declaration()
  |> should.equal(Ok(tuple("", Doctype("html", ""))))

  switched_case_input
  |> haytch.parse_doctype_declaration()
  |> should.equal(Ok(tuple("", Doctype("html", ""))))

  dtd_input
  |> haytch.parse_doctype_declaration()
  |> should.equal(
    Ok(
      tuple(
        "",
        Doctype(
          "html",
          "PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\"",
        ),
      ),
    ),
  )

  more_input
  |> haytch.parse_doctype_declaration()
  |> should.equal(Ok(tuple("<html></html>", Doctype("html", ""))))

  none_input
  |> haytch.parse_doctype_declaration()
  |> should.equal(Error("No match"))
}

pub fn parse_singleton_element_test() {
  "<input/>"
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [], [])))
}

pub fn parse_singleton_with_spaces_test() {
  "<input   />"
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [], [])))
}

pub fn parse_empty_element_test() {
  "<h1></h1>"
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("h1", [], [])))
}

pub fn parse_singleton_with_valueless_attribute_test() {
  "<input disabled />"
  |> haytch.parse_html_fragment()
  |> should.equal(
    Ok(Element("input", [Attribute("disabled", AttrBool(True))], [])),
  )
}

pub fn parse_singleton_with_identifier_attribute_value_test() {
  "<input type=checkbox />"
  |> haytch.parse_html_fragment()
  |> should.equal(
    Ok(Element("input", [Attribute("type", AttrString("checkbox"))], [])),
  )
}

pub fn parse_singleton_with_integer_attribute_value_test() {
  "<input min=0 />"
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [Attribute("min", AttrInt(0))], [])))

  "<input min=-10 />"
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [Attribute("min", AttrInt(-10))], [])))
}

pub fn parse_singleton_with_float_attribute_value_test() {
  "<input step=0.5 />"
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [Attribute("step", AttrFloat(0.5))], [])))

  "<input step=.05 />"
  |> haytch.parse_html_fragment()
  |> should.equal(
    Ok(Element("input", [Attribute("step", AttrFloat(0.05))], [])),
  )
}
