-module(git).

-include("git.hrl").

-export([head/0, ref_or_sha/1, sha/1, object/1]).

head() ->
	{ok, RefOrSHA} = file:read_file(".git/HEAD"), 
	ref_or_sha(RefOrSHA).

ref_or_sha(<<"ref: ", Ref/binary>>) ->
	{ok, SHA} = file:read_file(ref_to_file(Ref)),
	sha(rtrim(SHA));
ref_or_sha(<<CommitSHA/binary>>) -> sha(CommitSHA).

sha(<<SHAHead:2/binary, SHATail:38/binary>>) ->
    inflate_file([".git/objects/", binary_to_list(SHAHead), "/" ++ binary_to_list(SHATail)]).

inflate_file(File) ->
	% this could pose a memory problem for large blob objects
    {ok, Binary} = file:read_file(File),
    inflate(Binary).

inflate(Binary) ->
    Z = zlib:open(),
    ok = zlib:inflateInit(Z),
    iolist_to_binary(zlib:inflate(Z, Binary)).

ref_to_file(<<Ref/binary>>) -> [".git/", binary_to_list(rtrim(Ref))].

%% produce Erlang records from Git objects
object(ObjectData) when is_binary(ObjectData) ->
    {Type, SizeData} = space_split(ObjectData),
    {SizeBin, Data} = null_split(SizeData),
    {Size, ""} = string:to_integer(binary_to_list(SizeBin)),
    represent(#object{type = binary_to_existing_atom(Type, utf8), size = Size, data = Data}).

%% branch to produce record representation
represent(#object{type = tree, data = Entries}) -> #tree{entries = tree_entries(Entries)};
represent(#object{type = commit, data = Rest}) -> commit_tree(#commit{}, Rest);
represent(#object{type = blob, data = Content}) -> #blob{content = Content}.

%% commit object handling
commit_tree(C = #commit{}, <<"tree ", Tree:40/bytes, $\n, Rest/bits>>) ->
	commit_parent(C#commit{tree = Tree}, Rest).
commit_parent(C = #commit{}, <<"parent ", Parent:40/bytes, $\n, Rest/bits>>) ->
	commit_author(C#commit{parent = Parent}, line_split(Rest)).
commit_author(C = #commit{}, {<<"author ", Author/bits>>, Rest}) ->
	commit_committer(C#commit{author = Author}, line_split(Rest)).
commit_committer(C = #commit{}, {<<"committer ", Committer/bits>>, Rest}) ->
	commit_comment(C#commit{committer = Committer}, Rest).
commit_comment(C = #commit{}, Comment) ->
	C#commit{comment = Comment}.

%% tree object handling
tree_entries(<<Mode:6/bytes, " ", PathSHA1Rest/binary>>) ->
    {Path, <<SHA1:160/bits, Rest/bits>>} = null_split(PathSHA1Rest),
    [#tree_entry{mode=Mode, path=Path, sha1=SHA1} | tree_entries(Rest)];
tree_entries(<<_Rest/binary>>) -> [].

%% binary string utility functions
null_split(Binary) -> split(0, <<>>, Binary).

space_split(Binary) -> split($\s, <<>>, Binary).

line_split(Binary) -> split($\n, <<>>, Binary).

split(S, H, <<T:1/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:2/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:3/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:4/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:5/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:6/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:7/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:8/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:9/bytes,  S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:10/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:11/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:12/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:13/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:14/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:15/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:16/bytes, S, Rest/bits>>) -> {<<H/bits, T/bits>>, Rest};
split(S, H, <<T:16/bytes, Rest/bits>>) -> split(S, <<H/bits, T/bits>>, Rest);
split(_S, H, <<T/bits>>) -> {<<H/bits, T/bits>>, <<>>}.

rtrim(String) ->
	Size = byte_size(String) - 1,
	<<Trimmed:Size/bytes, "\n">> = String,
	Trimmed.
