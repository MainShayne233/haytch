import haytch.{Doctype, Element}
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

pub fn parse_html_fragment_test() {
  // let empty_element = "<h1></h1>"
  // empty_element
  // |> haytch.parse_html_fragment()
  // |> should.equal(Ok(Element("h1", [], [])))
  let singleton_element = "<input/>"
  let singleton_with_space_element = "<input   />"

  singleton_element
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [], [])))

  singleton_with_space_element
  |> haytch.parse_html_fragment()
  |> should.equal(Ok(Element("input", [], [])))
}
