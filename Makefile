.PHONY: debug tests

debug:
	@./scripts/debug.sh $(ARGS)

tests:
	@./script/test.sh
