-module(git_tree).

-include("git_object.hrl").

-export([parse/1]).

parse(#object{type = tree, data = Rest}) -> #tree{entries = entries(Rest)}.

entries(<<Mode:6/bytes, " ", PathSHA1Rest/binary>>) ->
    {Path, <<SHA1:160/bits, Rest/bits>>} = git_string:null_split(PathSHA1Rest),
    [#tree_entry{mode=Mode, path=Path, sha1=SHA1}| entries(Rest)];
entries(<<_Rest/binary>>) -> [].
