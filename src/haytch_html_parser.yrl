Terminals identifier lt gt clt cgt whitespace eq quoted_string bool integer.
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
% tag_attributes -> tag_attribute whitespace tag_attributes : ['$1' | '$2'].

% tag_attribute -> attribute_key eq attribute_value : attr('$1', '$3').
tag_attribute -> identifier : attr(unwrap('$1'), attr_value("true", bool)).

attribute_value -> quoted_string : attr_value(unwrap('$1'), string).
attribute_value -> bool : attr_value(unwrap('$1'), bool).
attribute_value -> integer : attr_value(unwrap('$1'), int).
% maybe float?

Erlang code.

unwrap({_, _, V}) -> V.

attr(Key, Val) -> {attribute, list_to_binary(Key), Val}.

attr_value(Val, Typ) -> {attribute_value, list_to_binary(Val), Typ}.

elem({Name, Attrs}, Name) ->
  do_elem(Name, Attrs, []).

elem({Name, Attrs}) -> do_elem(Name, Attrs, []).

do_elem(Name, Attrs, Children) ->
  {element, list_to_binary(Name), Attrs, Children}.
