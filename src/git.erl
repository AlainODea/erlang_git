-module(git).

-compile(export_all).

show_head() -> show_ref(file:read_file(".git/HEAD")).

show_ref({ok, RefOrSHA}) -> show_sha(sha(RefOrSHA)).

show_sha(<<SHAHead:2/binary, SHATail:38/binary>>) ->
    inflate_file([".git/objects", "/" ++ binary_to_list(SHAHead), "/" ++ binary_to_list(SHATail)]).

inflate_file(File) ->
    {ok, Binary} = file:read_file(File),
    inflate(Binary).

inflate(Binary) ->
    Z = zlib:open(),
    ok = zlib:inflateInit(Z),
    iolist_to_binary(zlib:inflate(Z, Binary)).

sha(<<"ref: ", Ref/binary>>) ->
    {ok, SHA} = file:read_file(filename(Ref)),
    drop_last(SHA);
sha(<<CommitSHA/binary>>) -> drop_last(CommitSHA).

filename(<<Ref/binary>>) -> [".git/", binary_to_list(drop_last(Ref))].

drop_last(String) ->
	Size = byte_size(String) - 1,
	<<Trimmed:Size/bytes, "\n">> = String,
	Trimmed.
