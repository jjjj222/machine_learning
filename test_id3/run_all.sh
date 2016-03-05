#!/bin/sh -f

EXEC="./src/id3.rb"
TEST_DIR="./test_id3"
TEST_EXEC="$TEST_DIR/id3_test.rb"

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
cp $EXEC $TEST_EXEC

for c in car crx example iris kidney mushroom
do
    RESULT_DIR="$TEST_DIR/$c"
    RESULT_FILE="$RESULT_DIR/$c.res"
    OUT_FILE="$RESULT_DIR/$c.out"
    DIFF_FILE="$RESULT_DIR/$c.diff"

    if [ "$1" = "update" ]; then
        run_str="cp $RESULT_FILE $OUT_FILE"
        echo $run_str
        eval $run_str
    else
        echo ">>> start $c ..."
        run_str="$TEST_EXEC -t $c > $RESULT_FILE"
        #echo $run_str
        eval $run_str

        diff $OUT_FILE $RESULT_FILE > $DIFF_FILE
        cat $DIFF_FILE
        echo ">>> finish $c ..."
    fi
done

