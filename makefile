.PHONY: run
run:
	@./run_knn.rb -t iris

.PHONY: test_all
test_all: test_id3 test_ann
	#@cd ./test/test_id3; ./ruVn_all.sh
	#@cd ./test/test_ann/test_ann_unit; ./run_all.sh

.PHONY: test_id3
test_id3:
	@cd ./test/test_id3; ./run_all.sh

.PHONY: update_id3
update_id3:
	@cd ./test/test_id3; ./run_all.sh update

.PHONY: test_ann
test_ann:
	@cd ./test/test_ann/test_ann_unit; ./run_all.sh

.PHONY: update_ann
update_ann:
	@cd ./test/test_ann/test_ann_unit; ./run_all.sh update
