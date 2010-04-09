-type sha1() :: <<_:24>>.

% I can almost definitely store the mode in less than 6 bytes
% it's in octal format and gets stored as an unigned long in git's C code
-type mode() :: <<_:6>>.

-record(object, {
	size :: integer(),
	data :: binary(),
	type :: object | commit | blob | tag
}).

-record(commit, {
	tree      :: sha1(),
	parent    :: sha1(),
	author    :: string(),
	committer :: string(),
	comment   :: binary()
}).

-record(blob, {
	content :: binary()
}).

-record(tag, {
	comment :: sha1()
}).

-record(tree_entry, {
	mode :: mode(),
	path :: binary(),
	sha1 :: sha1()
}).

-record(tree, {
	entries = [] :: [#tree_entry{}]
}).
