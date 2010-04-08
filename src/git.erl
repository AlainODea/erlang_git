-module(git).

-compile(export_all).

show_head() -> show_ref(file:read_file(".git/HEAD")).

show_ref({ok, RefOrSHA}) -> show_sha(sha(RefOrSHA)).

show_sha(<<CommitSHAHead:2/binary, CommitSHATail:38/binary, "\n">>) ->
    show_commit(binary_to_list(CommitSHAHead), binary_to_list(CommitSHATail)).

show_commit(CommitSHAHead, CommitSHATail) ->
    inflate_file([".git/objects", "/" ++ CommitSHAHead, "/" ++ CommitSHATail]).

inflate_file(File) ->
    {ok, Binary} = file:read_file(File),
    inflate(Binary).

inflate(Binary) ->
    Z = zlib:open(),
    ok = zlib:inflateInit(Z),
    iolist_to_binary(zlib:inflate(Z, Binary)).

sha(<<"ref: ", Ref/binary>>) ->
    {ok, SHA} = file:read_file(filename(Ref)),
    SHA;
sha(<<CommitSHA/binary>>) -> drop_last(CommitSHA).

filename(<<Ref/binary>>) -> [".git/", drop_last(Ref)].

drop_last(String) -> lists:reverse(tl(lists:reverse(binary_to_list(String)))).
