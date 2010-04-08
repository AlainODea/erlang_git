-module(git_object).

-include("git_object.hrl").

-export([parse/1]).

parse(ObjectData) when is_binary(ObjectData) ->
	{TypeAndSize, Data} = cstring:from_binary(ObjectData),
	{Type, SizeBin} = cstring:split(TypeAndSize),
	{Size, ""} = string:to_integer(binary_to_list(SizeBin)),
	#object{type = Type, size = Size, data = Data}.
