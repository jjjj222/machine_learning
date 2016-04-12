#!/bin/sh -f

#for c in test_knn_basic test_knn_k5 test_knn_k5_weighted
#for c in test_knn_k3 test_knn_pca test_knn_pca_k5
#for c in test_knn_pca test_knn_pca_k5
for c in test_knn_pca test_knn_pca_k5 test_knn_k3 test_knn_pca test_knn_pca_k5 test_knn_basic test_knn_k5 test_knn_k5_weighted
do
    cd $c
    if [ "$1" = "update" ]; then
        eval ./run_all.sh update
    else
        eval ./run_all.sh
    fi
    cd ..
done

