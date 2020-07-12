-module(haytch_bridge).

-export([parse_doctype_declaration/1, parse_html_fragment/1]).

parse_doctype_declaration(Input) ->
    {ok, RegEx} = re:compile("^<!doctype +([A-Za-z]*)([^>;]*)>(.*)", [caseless]),
    case re:run(Input, RegEx, [{capture, all, binary}]) of
      {match, [_, Type, Meta, Rest]} ->
            {ok, {Rest, {doctype, string:lowercase(Type), string:trim(Meta)}}};
       nomatch ->
            {error, <<"No match">>}
    end.

parse_html_fragment(Input) ->
  Text = binary:bin_to_list(Input),
  {ok, Tokens, _} = haytch_html_lexer:string(Text),
  haytch_html_parser:parse(Tokens).

