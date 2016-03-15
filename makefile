.PHONY: run
run:
	@#cd ./test/test_id3; ./run_all.sh
	@@./run_ann.rb

.PHONY: test_id3
test_id3:
	@cd ./test/test_id3; ./run_all.sh
