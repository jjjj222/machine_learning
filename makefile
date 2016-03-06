.PHONY: run
run:
	@./ann.rb


.PHONY: test_id3
test_id3:
	@cd ./test_id3; ./run_all.sh
