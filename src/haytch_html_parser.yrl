Terminals tag_name lt gt clt cgt.
Nonterminals tag start_tag singleton_tag close_tag.
Rootsymbol tag.

tag -> start_tag close_tag : elem('$1', '$2').
tag -> singleton_tag : elem('$1').

start_tag -> lt tag_name gt : {unwrap('$2'), []}.
% start_tag -> lt tag_name tag_attributes gt : {'$1', '$2'}.

close_tag -> clt tag_name gt : unwrap('$2').

singleton_tag -> lt tag_name cgt : {unwrap('$2'), []}.
% singleton_tag -> lt tag_name tag_attributes cgt : {'$2', '$3', []}.

Erlang code.

unwrap({_, _, V}) -> V.

elem({Name, Attrs}, Name) ->
  do_elem(Name, Attrs, []).

elem({Name, Attrs}) -> do_elem(Name, Attrs, []).

do_elem(Name, Attrs, Children) ->
  {element, list_to_binary(Name), Attrs, Children}.
