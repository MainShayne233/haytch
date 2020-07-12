Definitions.

% Helper Regexes (non-token)

% Core HTML tokens
TAG_NAME = [A-Za-z][A-Za-z0-9]+
LT = \<
GT = \>
CLT = \<\/
CGT = \s*\/\>

% Useful tokens
NEW_LINE  = [\r\n]\s*

Rules.

{NEW_LINE}  : skip_token.
{TAG_NAME} : {token, {tag_name, TokenLine, TokenChars}}.
{LT} : {token, {lt, TokenLine, TokenChars}}.
{GT} : {token, {gt, TokenLine, TokenChars}}.
{CLT} : {token, {clt, TokenLine, TokenChars}}.
{CGT} : {token, {cgt, TokenLine, TokenChars}}.

Erlang code.
