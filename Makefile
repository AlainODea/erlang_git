ERL          ?= erl
EBIN_DIRS    := $(wildcard deps/*/ebin)
APP          := git

all: erl

erl:
	@mkdir -p ebin
	@$(ERL) -pa $(EBIN_DIRS) -noinput +B \
	  -eval 'case make:all() of up_to_date -> halt(0); error -> halt(1) end.'

docs:
	@erl -noshell -run edoc_run application '$(APP)' '"."' '[]'

clean:
	@echo "removing:"
	@(cd ebin;find . -type f ! -name ${APP}.app -execdir rm -v {} +)

run:
	./start-dev.sh