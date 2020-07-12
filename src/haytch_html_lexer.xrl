Definitions.

% Helper Regexes (non-token)

% Core HTML tokens
OPEN_TAG = \<[A-Za-z0-9]+
SELF_CLOSE_TAG = \/>

% Useful tokens
NEW_LINE  = [\r\n]\s*

Rules.

{OPEN_TAG}    : {token, {open_tag, TokenLine, TokenChars}}.
{SELF_CLOSE_TAG} : {token, {self_close_tag, nil, nil}}.
{NEW_LINE}  : skip_token.

Erlang code.
