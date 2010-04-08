-module(cstring).

-export([from_binary/1, split/1]).

from_binary(Binary) -> from_binary(<<>>, Binary).

from_binary(H, <<T:1/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:2/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:3/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:4/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:5/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:6/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:7/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:8/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:9/bytes,  0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:10/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:11/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:12/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:13/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:14/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:15/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:16/bytes, 0, Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
from_binary(H, <<T:16/bytes, Rest/bits>>) ->
	% c-string has more characters in it, keep reading
	from_binary(<<H/bits, T/bits>>, Rest);
from_binary(H, <<T/bits>>) -> {<<H/bits, T/bits>>, <<>>}.

split(Binary) -> split(<<>>, Binary).

split(H, <<T:1/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:2/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:3/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:4/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:5/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:6/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:7/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:8/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:9/bytes,  " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:10/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:11/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:12/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:13/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:14/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:15/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:16/bytes, " ", Rest/bits>>) -> {<<H/bits,T/bits>>, Rest};
split(H, <<T:16/bytes, Rest/bits>>) ->
	% c-string has more characters in it, keep reading
	split(<<H/bits, T/bits>>, Rest);
split(H, <<T/bits>>) -> {<<H/bits, T/bits>>, <<>>}.
