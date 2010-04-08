-module(git_string).

-export([null_split/1, space_split/1, line_split/1]).

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
