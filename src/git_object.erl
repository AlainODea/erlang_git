-module(git_object).

-include("git_object.hrl").

-export([parse/1]).

parse(TreeObject = #object{type = tree}) -> git_tree:parse(TreeObject);
parse(CommitObject = #object{type = commit}) -> git_commit:parse(CommitObject);
parse(ObjectData) when is_binary(ObjectData) ->
    {Type, SizeData} = git_string:space_split(ObjectData),
    {SizeBin, Data} = git_string:null_split(SizeData),
    {Size, ""} = string:to_integer(binary_to_list(SizeBin)),
    parse(#object{type = binary_to_existing_atom(Type, utf8), size = Size, data = Data}).
