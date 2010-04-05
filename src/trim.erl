-module(trim).

-export([string_strip_right/1, reverse_tl_reverse/1, bench/0]).

bench() -> [nbench(N) || N <- [1,1000,1000000]].

nbench(N) -> {N, bench(["a" || _ <- lists:seq(1,N)])}.

bench(String) ->
    {{string_strip_right,
    lists:sum([
        element(1, timer:tc(trim, string_strip_right, [String]))
        || _ <- lists:seq(1,1000)])},
    {reverse_tl_reverse,
    lists:sum([
        element(1, timer:tc(trim, reverse_tl_reverse, [String]))
        || _ <- lists:seq(1,1000)])}}.

string_strip_right(String) -> string:strip(String, right, $\n).

reverse_tl_reverse(String) ->
    lists:reverse(tl(lists:reverse(String))).
