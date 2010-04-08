-module(git_tree).

-include("git_object.hrl").

-export([parse/1]).

parse(#object{type = tree, data = Rest}) ->
	{Entries, _Rest} = parse_entries(Rest), 
	#tree{entries = Entries}.

parse_entries(<<Mode:6/bytes, " ", PathSHA1Rest/binary>>) ->
    {Path, <<SHA1:160/bits, Rest/bits>>} = git_string:null_split(PathSHA1Rest),
    [#tree_entry{mode=Mode, path=Path, sha1=SHA1}| parse_entries(Rest)];
parse_entries(<<_Rest/binary>>) -> [].