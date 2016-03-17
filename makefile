.PHONY: run
run:
	@#cd ./test/test_id3; ./run_all.sh
	@@./run_ann.rb -t iris

.PHONY: test_id3
test_id3:
	@cd ./test/test_id3; ./run_all.sh

.PHONY: test_ann
test_ann:
	@cd ./test/test_ann; ./run_all.sh
