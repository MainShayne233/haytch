Definitions.

% Helper Regexes (non-token)

% Core HTML tokens
OPEN_TAG = \<[A-Za-z0-9]+
OPEN_TAG_END = \s*\>
CLOSE_TAG = \<\/[A-Za-z0-9]+>
SELF_CLOSE_TAG = \s*\/>

% Useful tokens
NEW_LINE  = [\r\n]\s*

Rules.

{OPEN_TAG}    : {token, {open_tag, TokenLine, TokenChars}}.
{OPEN_TAG_END}    : {token, {open_tag_end, TokenLine, TokenChars}}.
{CLOSE_TAG}    : {token, {close_tag, TokenLine, TokenChars}}.
{SELF_CLOSE_TAG} : {token, {self_close_tag, TokenLine, TokenChars}}.
{NEW_LINE}  : skip_token.

Erlang code.
