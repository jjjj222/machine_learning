#!/bin/sh -f

TOP_DIR="../../.."

#------------------------------------------------------------------------------
#   
#------------------------------------------------------------------------------
EXEC="$TOP_DIR/src/run_knn.rb"
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


#for c in car crx example example2 iris kidney mushroom liver tae
#for c in car crx example example2 iris kidney mushroom liver tae abalone wine adult
#for c in car crx example example2 iris kidney liver tae wine abalone
#for c in car crx iris kidney liver tae wine abalone
for c in wine breast vehicle hill climate diabete glass car crx iris kidney liver tae
do
    if [ ! -d "$DATA_DIR/$c" ]; then
        echo "Error: invalid case \"$c\" !!"
        continue
    fi

    DATA_FILE="$DATA_DIR/$c/$c.data"
    ATTR_FILE="$DATA_DIR/$c/$c.attribute"
    #SETUP_FILE="$DATA_DIR/$c/$c.knn.setup"
    SETUP_FILE="$TEST_DIR/knn.setup"

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
        if [ ! -d "$RESULT_DIR" ]; then
            eval "mkdir $RESULT_DIR"
        fi

        run_str="$TEST_EXEC $DATA_FILE $ATTR_FILE $SETUP_FILE > $RESULT_FILE"
        #echo $run_str
        eval $run_str

        diff $OUT_FILE $RESULT_FILE > $DIFF_FILE
        cat $DIFF_FILE
        echo ">>> finish $c ..."
    fi
done

