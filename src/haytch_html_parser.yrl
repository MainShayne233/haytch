Terminals open_tag self_close_tag.
Nonterminals tag.
Rootsymbol tag.

tag -> open_tag self_close_tag : {parse_tag_name('$1'), [], []}.

Erlang code.

parse_tag_name({_, _, "<" ++ Rest}) -> Rest.
