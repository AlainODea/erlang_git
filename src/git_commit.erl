-module(git_commit).

-include("git_object.hrl").

-export([parse/1]).

-compile(export_all).

parse(#object{type = commit, data = Rest}) -> tree(#commit{}, Rest).

tree(C = #commit{}, <<"tree ", Tree:40/bytes, $\n, Rest/bits>>) ->
	parent(C#commit{tree = Tree}, Rest).
parent(C = #commit{}, <<"parent ", Parent:40/bytes, $\n, Rest/bits>>) ->
	author(C#commit{parent = Parent}, git_string:line_split(Rest)).
author(C = #commit{}, {<<"author ", Author/bits>>, Rest}) ->
	committer(C#commit{author = Author}, git_string:line_split(Rest)).
committer(C = #commit{}, {<<"committer ", Committer/bits>>, Rest}) ->
	comment(C#commit{committer = Committer}, Rest).
comment(C = #commit{}, Comment) ->
	C#commit{comment = Comment}.
