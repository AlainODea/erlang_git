-record(object, {size :: integer(), data :: binary(), type :: atom()}).
-record(commit, {tree :: binary(), parent :: binary(), author :: string(), committer :: string(), comment :: binary()}).
-record(blob, {content :: binary()}).

% I can almost definitely store the mode in less than 6 bytes
% it's in octal format and gets stored as an unigned long in git's C code
-type mode() :: <<_:6>>.
-record(tree_entry, {mode :: mode(), path, sha1}).
-record(tree, {entries = [] :: [#tree_entry{}]}).
