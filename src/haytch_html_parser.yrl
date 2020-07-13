Terminals identifier lt gt clt cgt whitespace eq quoted_string bool integer float.
Nonterminals tag start_tag singleton_tag close_tag tag_attributes tag_attribute attribute_value.
Rootsymbol tag.

tag -> start_tag close_tag : elem('$1', '$2').
tag -> singleton_tag : elem('$1').

start_tag -> lt identifier gt : {unwrap('$2'), []}.
% start_tag -> lt identifier tag_attributes gt : {'$1', '$2'}.

close_tag -> clt identifier gt : unwrap('$2').

singleton_tag -> lt identifier cgt : {unwrap('$2'), []}.
singleton_tag -> lt identifier whitespace tag_attributes cgt : {unwrap('$2'), '$4'}.

tag_attributes -> tag_attribute : ['$1'].
tag_attributes -> tag_attribute whitespace tag_attributes : ['$1' | '$3'].

tag_attribute -> identifier eq attribute_value : attr(unwrap('$1'), '$3').
tag_attribute -> identifier : attr(unwrap('$1'), attr_value(attr_bool, true)).

attribute_value -> bool : attr_value(attr_bool, unwrap('$1') == "true").
attribute_value -> identifier : attr_value(attr_string, unwrap('$1')).
attribute_value -> integer : attr_value(attr_int, unwrap('$1')).
attribute_value -> float : attr_value(attr_float, unwrap('$1')).
attribute_value -> quoted_string : attr_value(attr_string, dequote(unwrap('$1'))).
% maybe float?

Erlang code.

unwrap({_, _, V}) -> V.

attr(Key, Val) -> {attribute, list_to_binary(Key), Val}.

attr_value(attr_int, Val) -> {attr_int, list_to_integer(Val)};
attr_value(attr_float, "." ++ Rest) -> {attr_float, list_to_float("0." ++ Rest)};
attr_value(attr_float, Val) -> {attr_float, list_to_float(Val)};
attr_value(attr_string, Val) -> {attr_string, list_to_binary(Val)};
attr_value(Typ, Val) -> {Typ, Val}.

dequote(Val) -> string:slice(Val, 1, string:len(Val) - 2).

elem({Name, Attrs}, Name) ->
  do_elem(Name, Attrs, []).

elem({Name, Attrs}) -> do_elem(Name, Attrs, []).

do_elem(Name, Attrs, Children) ->
  {element, list_to_binary(Name), Attrs, Children}.
