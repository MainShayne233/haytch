Definitions.

% Helper Regexes (non-token)

% Core HTML tokens
IDENTIFIER = [A-Za-z][A-Za-z0-9-]+
INTEGER = -?[0-9]+
% QUOTED_STRING = "(\?:[^"\\]|\\.)*"
EQ = \=
LT = \<
GT = \>
CLT = \<\/
CGT = \s*\/\>
WHITESPACE = \s+

% Useful tokens
NEW_LINE  = [\r\n]\s*

Rules.

{NEW_LINE}  : skip_token.
{IDENTIFIER} : {token, {identifier, TokenLine, TokenChars}}.
{INTEGER} : {token, {integer, TokenLine, TokenChars}}.
{WHITESPACE} : {token, {whitespace, TokenLine, TokenChars}}.
{LT} : {token, {lt, TokenLine, TokenChars}}.
{GT} : {token, {gt, TokenLine, TokenChars}}.
{CLT} : {token, {clt, TokenLine, TokenChars}}.
{CGT} : {token, {cgt, TokenLine, TokenChars}}.
{EQ} : {token, {eq, TokenLine, TokenChars}}.
% {QUOTED_STRING} : {token, {quoted_string, TokenLine, TokenChars}}.

Erlang code.
