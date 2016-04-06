#!/bin/sh -f

TOP_DIR="../../.."
EXEC="$TOP_DIR/src/run_ann.rb"
INCLUDE_DIR="$TOP_DIR/src"
DATA_DIR="$TOP_DIR/data"

TEST_DIR="."
TEST_EXEC="$TEST_DIR/test_exec.rb"
TEST_INCLUDE_DIR="$TEST_DIR/src"

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
rm_exec="rm -rf $TEST_EXEC"
rm_src="rm -rf $TEST_INCLUDE_DIR"
cp_exec="cp $EXEC $TEST_EXEC"
cp_src="cp -R $INCLUDE_DIR $TEST_INCLUDE_DIR"

echo "In `pwd` ..."
echo $rm_exec
echo $rm_src
echo $cp_exec
echo $cp_src

eval $rm_exec
eval $rm_src
eval $cp_exec
eval $cp_src

#for c in example
#for c in example example2 car crx iris kidney mushroom
#for c in example example2 iris liver kidney mushroom abalone car crx
#for c in example example2 iris liver abalone kidney crx
#for c in tae abalone
#for c in iris liver tae crx kidney
#for c in car crx example example2 iris kidney mushroom liver tae abalone wine adult
for c in example example2 iris wine crx kidney liver tae car abalone adult mushroom
do
    DATA_FILE="$DATA_DIR/$c/$c.data"
    ATTR_FILE="$DATA_DIR/$c/$c.attribute"
    SETUP_FILE="$TEST_DIR/ann.setup"

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
        run_str="$TEST_EXEC $DATA_FILE $ATTR_FILE $SETUP_FILE > $RESULT_FILE"
        #run_str="$TEST_EXEC -t $c > $RESULT_FILE"
        #echo $run_str
        eval $run_str

        diff $OUT_FILE $RESULT_FILE > $DIFF_FILE
        cat $DIFF_FILE
        echo ">>> finish $c ..."
    fi
done

