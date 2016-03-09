================================================================================
=                                   round 1                                    =
================================================================================
# of learning examples = 4874
# of pruning examples = 2437
# of test examples = 813
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2347 p, 2527 e]
     |- odor=n [63 p, 2047 e]
     |   |- spore-print-color=k, class=e [0 p, 767 e]
     |   |- spore-print-color=n, class=e [0 p, 807 e]
     |   |- spore-print-color=w [19 p, 360 e]
     |   |   |- habitat=w, class=e [0 p, 135 e]
     |   |   |- habitat=g, class=e [0 p, 168 e]
     |   |   |- habitat=l [7 p, 31 e]
     |   |   |   |- cap-color=c, class=e [0 p, 15 e]
     |   |   |   |- cap-color=n, class=e [0 p, 16 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 21 e]
     |   |   |- habitat=d [12 p, 5 e]
     |   |   |   |- gill-size=n, class=p [12 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 24 e]
     |   |- spore-print-color=h, class=e [0 p, 33 e]
     |   |- spore-print-color=b, class=e [0 p, 29 e]
     |   |- spore-print-color=r, class=p [44 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 27 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=c, class=p [113 p, 0 e]
     |- odor=p, class=p [146 p, 0 e]
     |- odor=f, class=p [1300 p, 0 e]
     |- odor=y, class=p [363 p, 0 e]
     |- odor=s, class=p [339 p, 0 e]
     |- odor=l, class=e [0 p, 246 e]
     |- odor=a, class=e [0 p, 234 e]
     `- odor=m, class=p [23 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2347 p, 2527 e]
     |- odor=n [63 p, 2047 e]
     |   |- spore-print-color=k, class=e [0 p, 767 e]
     |   |- spore-print-color=n, class=e [0 p, 807 e]
     |   |- spore-print-color=w [19 p, 360 e]
     |   |   |- habitat=w, class=e [0 p, 135 e]
     |   |   |- habitat=g, class=e [0 p, 168 e]
     |   |   |- habitat=l [7 p, 31 e]
     |   |   |   |- cap-color=c, class=e [0 p, 15 e]
     |   |   |   |- cap-color=n, class=e [0 p, 16 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 21 e]
     |   |   |- habitat=d [12 p, 5 e]
     |   |   |   |- gill-size=n, class=p [12 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 24 e]
     |   |- spore-print-color=h, class=e [0 p, 33 e]
     |   |- spore-print-color=b, class=e [0 p, 29 e]
     |   |- spore-print-color=r, class=p [44 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 27 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=c, class=p [113 p, 0 e]
     |- odor=p, class=p [146 p, 0 e]
     |- odor=f, class=p [1300 p, 0 e]
     |- odor=y, class=p [363 p, 0 e]
     |- odor=s, class=p [339 p, 0 e]
     |- odor=l, class=e [0 p, 246 e]
     |- odor=a, class=e [0 p, 234 e]
     `- odor=m, class=p [23 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 393
error rate = 0.4833948339483395
Majority (class = e)
================================================================================
=                                   round 2                                    =
================================================================================
# of learning examples = 4874
# of pruning examples = 2437
# of test examples = 813
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2320 p, 2554 e]
     |- odor=n [63 p, 2062 e]
     |   |- spore-print-color=k, class=e [0 p, 780 e]
     |   |- spore-print-color=n, class=e [0 p, 815 e]
     |   |- spore-print-color=w [19 p, 356 e]
     |   |   |- habitat=w, class=e [0 p, 129 e]
     |   |   |- habitat=g, class=e [0 p, 168 e]
     |   |   |- habitat=l [6 p, 30 e]
     |   |   |   |- cap-color=c, class=e [0 p, 13 e]
     |   |   |   |- cap-color=n, class=e [0 p, 17 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 24 e]
     |   |   |- habitat=d [13 p, 5 e]
     |   |   |   |- gill-size=n, class=p [13 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 24 e]
     |   |- spore-print-color=h, class=e [0 p, 32 e]
     |   |- spore-print-color=b, class=e [0 p, 26 e]
     |   |- spore-print-color=y, class=e [0 p, 29 e]
     |   |- spore-print-color=r, class=p [44 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=c, class=p [114 p, 0 e]
     |- odor=s, class=p [347 p, 0 e]
     |- odor=f, class=p [1291 p, 0 e]
     |- odor=y, class=p [336 p, 0 e]
     |- odor=l, class=e [0 p, 243 e]
     |- odor=a, class=e [0 p, 249 e]
     |- odor=p, class=p [147 p, 0 e]
     `- odor=m, class=p [22 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2320 p, 2554 e]
     |- odor=n [63 p, 2062 e]
     |   |- spore-print-color=k, class=e [0 p, 780 e]
     |   |- spore-print-color=n, class=e [0 p, 815 e]
     |   |- spore-print-color=w [19 p, 356 e]
     |   |   |- habitat=w, class=e [0 p, 129 e]
     |   |   |- habitat=g, class=e [0 p, 168 e]
     |   |   |- habitat=l [6 p, 30 e]
     |   |   |   |- cap-color=c, class=e [0 p, 13 e]
     |   |   |   |- cap-color=n, class=e [0 p, 17 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 24 e]
     |   |   |- habitat=d [13 p, 5 e]
     |   |   |   |- gill-size=n, class=p [13 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 24 e]
     |   |- spore-print-color=h, class=e [0 p, 32 e]
     |   |- spore-print-color=b, class=e [0 p, 26 e]
     |   |- spore-print-color=y, class=e [0 p, 29 e]
     |   |- spore-print-color=r, class=p [44 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=c, class=p [114 p, 0 e]
     |- odor=s, class=p [347 p, 0 e]
     |- odor=f, class=p [1291 p, 0 e]
     |- odor=y, class=p [336 p, 0 e]
     |- odor=l, class=e [0 p, 243 e]
     |- odor=a, class=e [0 p, 249 e]
     |- odor=p, class=p [147 p, 0 e]
     `- odor=m, class=p [22 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 418
error rate = 0.5141451414514145
Majority (class = e)
================================================================================
=                                   round 3                                    =
================================================================================
# of learning examples = 4874
# of pruning examples = 2437
# of test examples = 813
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2357 p, 2517 e]
     |- odor=n [64 p, 2033 e]
     |   |- spore-print-color=k, class=e [0 p, 763 e]
     |   |- spore-print-color=n, class=e [0 p, 794 e]
     |   |- spore-print-color=w [23 p, 364 e]
     |   |   |- habitat=w, class=e [0 p, 132 e]
     |   |   |- habitat=g, class=e [0 p, 170 e]
     |   |   |- habitat=l [7 p, 34 e]
     |   |   |   |- cap-color=c, class=e [0 p, 16 e]
     |   |   |   |- cap-color=n, class=e [0 p, 18 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 24 e]
     |   |   |- habitat=d [16 p, 4 e]
     |   |   |   |- gill-size=n, class=p [16 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 4 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 24 e]
     |   |- spore-print-color=h, class=e [0 p, 27 e]
     |   |- spore-print-color=b, class=e [0 p, 30 e]
     |   |- spore-print-color=y, class=e [0 p, 31 e]
     |   |- spore-print-color=r, class=p [41 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=c, class=p [118 p, 0 e]
     |- odor=s, class=p [352 p, 0 e]
     |- odor=f, class=p [1303 p, 0 e]
     |- odor=y, class=p [341 p, 0 e]
     |- odor=l, class=e [0 p, 249 e]
     |- odor=a, class=e [0 p, 235 e]
     |- odor=p, class=p [153 p, 0 e]
     `- odor=m, class=p [26 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2357 p, 2517 e]
     |- odor=n [64 p, 2033 e]
     |   |- spore-print-color=k, class=e [0 p, 763 e]
     |   |- spore-print-color=n, class=e [0 p, 794 e]
     |   |- spore-print-color=w [23 p, 364 e]
     |   |   |- habitat=w, class=e [0 p, 132 e]
     |   |   |- habitat=g, class=e [0 p, 170 e]
     |   |   |- habitat=l [7 p, 34 e]
     |   |   |   |- cap-color=c, class=e [0 p, 16 e]
     |   |   |   |- cap-color=n, class=e [0 p, 18 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 24 e]
     |   |   |- habitat=d [16 p, 4 e]
     |   |   |   |- gill-size=n, class=p [16 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 4 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 24 e]
     |   |- spore-print-color=h, class=e [0 p, 27 e]
     |   |- spore-print-color=b, class=e [0 p, 30 e]
     |   |- spore-print-color=y, class=e [0 p, 31 e]
     |   |- spore-print-color=r, class=p [41 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=c, class=p [118 p, 0 e]
     |- odor=s, class=p [352 p, 0 e]
     |- odor=f, class=p [1303 p, 0 e]
     |- odor=y, class=p [341 p, 0 e]
     |- odor=l, class=e [0 p, 249 e]
     |- odor=a, class=e [0 p, 235 e]
     |- odor=p, class=p [153 p, 0 e]
     `- odor=m, class=p [26 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 360
error rate = 0.44280442804428044
Majority (class = e)
================================================================================
=                                   round 4                                    =
================================================================================
# of learning examples = 4874
# of pruning examples = 2437
# of test examples = 813
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2329 p, 2545 e]
     |- odor=n [69 p, 2061 e]
     |   |- spore-print-color=k, class=e [0 p, 788 e]
     |   |- spore-print-color=n, class=e [0 p, 802 e]
     |   |- spore-print-color=w [23 p, 354 e]
     |   |   |- habitat=w, class=e [0 p, 128 e]
     |   |   |- habitat=g, class=e [0 p, 169 e]
     |   |   |- habitat=l [6 p, 29 e]
     |   |   |   |- cap-color=c, class=e [0 p, 14 e]
     |   |   |   |- cap-color=n, class=e [0 p, 15 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=w, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 23 e]
     |   |   |- habitat=d [17 p, 5 e]
     |   |   |   |- gill-size=n, class=p [17 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=h, class=e [0 p, 32 e]
     |   |- spore-print-color=b, class=e [0 p, 31 e]
     |   |- spore-print-color=o, class=e [0 p, 25 e]
     |   |- spore-print-color=y, class=e [0 p, 29 e]
     |   |- spore-print-color=r, class=p [46 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [354 p, 0 e]
     |- odor=c, class=p [112 p, 0 e]
     |- odor=f, class=p [1291 p, 0 e]
     |- odor=y, class=p [328 p, 0 e]
     |- odor=a, class=e [0 p, 239 e]
     |- odor=l, class=e [0 p, 245 e]
     |- odor=p, class=p [149 p, 0 e]
     `- odor=m, class=p [26 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2329 p, 2545 e]
     |- odor=n [69 p, 2061 e]
     |   |- spore-print-color=k, class=e [0 p, 788 e]
     |   |- spore-print-color=n, class=e [0 p, 802 e]
     |   |- spore-print-color=w [23 p, 354 e]
     |   |   |- habitat=w, class=e [0 p, 128 e]
     |   |   |- habitat=g, class=e [0 p, 169 e]
     |   |   |- habitat=l [6 p, 29 e]
     |   |   |   |- cap-color=c, class=e [0 p, 14 e]
     |   |   |   |- cap-color=n, class=e [0 p, 15 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=w, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=p, class=e [0 p, 23 e]
     |   |   |- habitat=d [17 p, 5 e]
     |   |   |   |- gill-size=n, class=p [17 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=h, class=e [0 p, 32 e]
     |   |- spore-print-color=b, class=e [0 p, 31 e]
     |   |- spore-print-color=o, class=e [0 p, 25 e]
     |   |- spore-print-color=y, class=e [0 p, 29 e]
     |   |- spore-print-color=r, class=p [46 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [354 p, 0 e]
     |- odor=c, class=p [112 p, 0 e]
     |- odor=f, class=p [1291 p, 0 e]
     |- odor=y, class=p [328 p, 0 e]
     |- odor=a, class=e [0 p, 239 e]
     |- odor=l, class=e [0 p, 245 e]
     |- odor=p, class=p [149 p, 0 e]
     `- odor=m, class=p [26 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 391
error rate = 0.48093480934809346
Majority (class = e)
================================================================================
=                                   round 5                                    =
================================================================================
# of learning examples = 4875
# of pruning examples = 2437
# of test examples = 812
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2374 p, 2501 e]
     |- odor=n [71 p, 2032 e]
     |   |- spore-print-color=k, class=e [0 p, 768 e]
     |   |- spore-print-color=n, class=e [0 p, 796 e]
     |   |- spore-print-color=w [32 p, 355 e]
     |   |   |- habitat=p, class=e [0 p, 20 e]
     |   |   |- habitat=g, class=e [0 p, 177 e]
     |   |   |- habitat=l [8 p, 27 e]
     |   |   |   |- cap-color=w, class=p [5 p, 0 e]
     |   |   |   |- cap-color=c, class=e [0 p, 15 e]
     |   |   |   |- cap-color=n, class=e [0 p, 12 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=d [24 p, 5 e]
     |   |   |   |- gill-size=n, class=p [24 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=w, class=e [0 p, 126 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 27 e]
     |   |- spore-print-color=h, class=e [0 p, 29 e]
     |   |- spore-print-color=o, class=e [0 p, 29 e]
     |   |- spore-print-color=b, class=e [0 p, 28 e]
     |   |- spore-print-color=r, class=p [39 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [350 p, 0 e]
     |- odor=c, class=p [118 p, 0 e]
     |- odor=f, class=p [1316 p, 0 e]
     |- odor=l, class=e [0 p, 237 e]
     |- odor=a, class=e [0 p, 232 e]
     |- odor=y, class=p [337 p, 0 e]
     |- odor=p, class=p [153 p, 0 e]
     `- odor=m, class=p [29 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2374 p, 2501 e]
     |- odor=n [71 p, 2032 e]
     |   |- spore-print-color=k, class=e [0 p, 768 e]
     |   |- spore-print-color=n, class=e [0 p, 796 e]
     |   |- spore-print-color=w [32 p, 355 e]
     |   |   |- habitat=p, class=e [0 p, 20 e]
     |   |   |- habitat=g, class=e [0 p, 177 e]
     |   |   |- habitat=l [8 p, 27 e]
     |   |   |   |- cap-color=w, class=p [5 p, 0 e]
     |   |   |   |- cap-color=c, class=e [0 p, 15 e]
     |   |   |   |- cap-color=n, class=e [0 p, 12 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=d [24 p, 5 e]
     |   |   |   |- gill-size=n, class=p [24 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=w, class=e [0 p, 126 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 27 e]
     |   |- spore-print-color=h, class=e [0 p, 29 e]
     |   |- spore-print-color=o, class=e [0 p, 29 e]
     |   |- spore-print-color=b, class=e [0 p, 28 e]
     |   |- spore-print-color=r, class=p [39 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [350 p, 0 e]
     |- odor=c, class=p [118 p, 0 e]
     |- odor=f, class=p [1316 p, 0 e]
     |- odor=l, class=e [0 p, 237 e]
     |- odor=a, class=e [0 p, 232 e]
     |- odor=y, class=p [337 p, 0 e]
     |- odor=p, class=p [153 p, 0 e]
     `- odor=m, class=p [29 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 368
error rate = 0.45320197044334976
Majority (class = e)
================================================================================
=                                   round 6                                    =
================================================================================
# of learning examples = 4875
# of pruning examples = 2437
# of test examples = 812
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2353 p, 2522 e]
     |- odor=n [71 p, 2049 e]
     |   |- spore-print-color=k, class=e [0 p, 777 e]
     |   |- spore-print-color=n, class=e [0 p, 796 e]
     |   |- spore-print-color=w [31 p, 363 e]
     |   |   |- habitat=p, class=e [0 p, 23 e]
     |   |   |- habitat=g, class=e [0 p, 181 e]
     |   |   |- habitat=l [8 p, 29 e]
     |   |   |   |- cap-color=w, class=p [5 p, 0 e]
     |   |   |   |- cap-color=c, class=e [0 p, 16 e]
     |   |   |   |- cap-color=n, class=e [0 p, 13 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 125 e]
     |   |   |- habitat=d [23 p, 5 e]
     |   |   |   |- gill-size=n, class=p [23 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 31 e]
     |   |- spore-print-color=h, class=e [0 p, 29 e]
     |   |- spore-print-color=o, class=e [0 p, 27 e]
     |   |- spore-print-color=b, class=e [0 p, 26 e]
     |   |- spore-print-color=r, class=p [40 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [351 p, 0 e]
     |- odor=c, class=p [126 p, 0 e]
     |- odor=f, class=p [1291 p, 0 e]
     |- odor=l, class=e [0 p, 242 e]
     |- odor=a, class=e [0 p, 231 e]
     |- odor=y, class=p [330 p, 0 e]
     |- odor=p, class=p [160 p, 0 e]
     `- odor=m, class=p [24 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2353 p, 2522 e]
     |- odor=n [71 p, 2049 e]
     |   |- spore-print-color=k, class=e [0 p, 777 e]
     |   |- spore-print-color=n, class=e [0 p, 796 e]
     |   |- spore-print-color=w [31 p, 363 e]
     |   |   |- habitat=p, class=e [0 p, 23 e]
     |   |   |- habitat=g, class=e [0 p, 181 e]
     |   |   |- habitat=l [8 p, 29 e]
     |   |   |   |- cap-color=w, class=p [5 p, 0 e]
     |   |   |   |- cap-color=c, class=e [0 p, 16 e]
     |   |   |   |- cap-color=n, class=e [0 p, 13 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 125 e]
     |   |   |- habitat=d [23 p, 5 e]
     |   |   |   |- gill-size=n, class=p [23 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 31 e]
     |   |- spore-print-color=h, class=e [0 p, 29 e]
     |   |- spore-print-color=o, class=e [0 p, 27 e]
     |   |- spore-print-color=b, class=e [0 p, 26 e]
     |   |- spore-print-color=r, class=p [40 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [351 p, 0 e]
     |- odor=c, class=p [126 p, 0 e]
     |- odor=f, class=p [1291 p, 0 e]
     |- odor=l, class=e [0 p, 242 e]
     |- odor=a, class=e [0 p, 231 e]
     |- odor=y, class=p [330 p, 0 e]
     |- odor=p, class=p [160 p, 0 e]
     `- odor=m, class=p [24 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 415
error rate = 0.5110837438423645
Majority (class = e)
================================================================================
=                                   round 7                                    =
================================================================================
# of learning examples = 4875
# of pruning examples = 2437
# of test examples = 812
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2374 p, 2501 e]
     |- odor=n [67 p, 2040 e]
     |   |- spore-print-color=k, class=e [0 p, 765 e]
     |   |- spore-print-color=n, class=e [0 p, 811 e]
     |   |- spore-print-color=w [28 p, 349 e]
     |   |   |- habitat=g, class=e [0 p, 175 e]
     |   |   |- habitat=l [6 p, 26 e]
     |   |   |   |- cap-color=c, class=e [0 p, 14 e]
     |   |   |   |- cap-color=n, class=e [0 p, 12 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=w, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 119 e]
     |   |   |- habitat=p, class=e [0 p, 23 e]
     |   |   |- habitat=d [22 p, 6 e]
     |   |   |   |- gill-size=n, class=p [22 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 6 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=h, class=e [0 p, 30 e]
     |   |- spore-print-color=o, class=e [0 p, 29 e]
     |   |- spore-print-color=b, class=e [0 p, 29 e]
     |   |- spore-print-color=y, class=e [0 p, 27 e]
     |   |- spore-print-color=r, class=p [39 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [358 p, 0 e]
     |- odor=c, class=p [122 p, 0 e]
     |- odor=f, class=p [1315 p, 0 e]
     |- odor=l, class=e [0 p, 229 e]
     |- odor=a, class=e [0 p, 232 e]
     |- odor=y, class=p [334 p, 0 e]
     |- odor=p, class=p [152 p, 0 e]
     `- odor=m, class=p [26 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2374 p, 2501 e]
     |- odor=n [67 p, 2040 e]
     |   |- spore-print-color=k, class=e [0 p, 765 e]
     |   |- spore-print-color=n, class=e [0 p, 811 e]
     |   |- spore-print-color=w [28 p, 349 e]
     |   |   |- habitat=g, class=e [0 p, 175 e]
     |   |   |- habitat=l [6 p, 26 e]
     |   |   |   |- cap-color=c, class=e [0 p, 14 e]
     |   |   |   |- cap-color=n, class=e [0 p, 12 e]
     |   |   |   |- cap-color=y, class=p [3 p, 0 e]
     |   |   |   |- cap-color=w, class=p [3 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 119 e]
     |   |   |- habitat=p, class=e [0 p, 23 e]
     |   |   |- habitat=d [22 p, 6 e]
     |   |   |   |- gill-size=n, class=p [22 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 6 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=h, class=e [0 p, 30 e]
     |   |- spore-print-color=o, class=e [0 p, 29 e]
     |   |- spore-print-color=b, class=e [0 p, 29 e]
     |   |- spore-print-color=y, class=e [0 p, 27 e]
     |   |- spore-print-color=r, class=p [39 p, 0 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [358 p, 0 e]
     |- odor=c, class=p [122 p, 0 e]
     |- odor=f, class=p [1315 p, 0 e]
     |- odor=l, class=e [0 p, 229 e]
     |- odor=a, class=e [0 p, 232 e]
     |- odor=y, class=p [334 p, 0 e]
     |- odor=p, class=p [152 p, 0 e]
     `- odor=m, class=p [26 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 375
error rate = 0.4618226600985222
Majority (class = e)
================================================================================
=                                   round 8                                    =
================================================================================
# of learning examples = 4875
# of pruning examples = 2437
# of test examples = 812
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2365 p, 2510 e]
     |- odor=n [67 p, 2042 e]
     |   |- spore-print-color=k, class=e [0 p, 792 e]
     |   |- spore-print-color=n, class=e [0 p, 791 e]
     |   |- spore-print-color=w [28 p, 347 e]
     |   |   |- habitat=g, class=e [0 p, 180 e]
     |   |   |- habitat=l [6 p, 25 e]
     |   |   |   |- cap-color=c, class=e [0 p, 13 e]
     |   |   |   |- cap-color=n, class=e [0 p, 12 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 114 e]
     |   |   |- habitat=d [22 p, 6 e]
     |   |   |   |- gill-size=n, class=p [22 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 6 e]
     |   |   |- habitat=p, class=e [0 p, 22 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 28 e]
     |   |- spore-print-color=b, class=e [0 p, 27 e]
     |   |- spore-print-color=h, class=e [0 p, 28 e]
     |   |- spore-print-color=r, class=p [39 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 29 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [350 p, 0 e]
     |- odor=c, class=p [116 p, 0 e]
     |- odor=f, class=p [1319 p, 0 e]
     |- odor=l, class=e [0 p, 230 e]
     |- odor=a, class=e [0 p, 238 e]
     |- odor=y, class=p [334 p, 0 e]
     |- odor=m, class=p [25 p, 0 e]
     `- odor=p, class=p [154 p, 0 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2365 p, 2510 e]
     |- odor=n [67 p, 2042 e]
     |   |- spore-print-color=k, class=e [0 p, 792 e]
     |   |- spore-print-color=n, class=e [0 p, 791 e]
     |   |- spore-print-color=w [28 p, 347 e]
     |   |   |- habitat=g, class=e [0 p, 180 e]
     |   |   |- habitat=l [6 p, 25 e]
     |   |   |   |- cap-color=c, class=e [0 p, 13 e]
     |   |   |   |- cap-color=n, class=e [0 p, 12 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 114 e]
     |   |   |- habitat=d [22 p, 6 e]
     |   |   |   |- gill-size=n, class=p [22 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 6 e]
     |   |   |- habitat=p, class=e [0 p, 22 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=o, class=e [0 p, 28 e]
     |   |- spore-print-color=b, class=e [0 p, 27 e]
     |   |- spore-print-color=h, class=e [0 p, 28 e]
     |   |- spore-print-color=r, class=p [39 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 29 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [350 p, 0 e]
     |- odor=c, class=p [116 p, 0 e]
     |- odor=f, class=p [1319 p, 0 e]
     |- odor=l, class=e [0 p, 230 e]
     |- odor=a, class=e [0 p, 238 e]
     |- odor=y, class=p [334 p, 0 e]
     |- odor=m, class=p [25 p, 0 e]
     `- odor=p, class=p [154 p, 0 e]
----------------------------- majority classifier ------------------------------
# of error = 382
error rate = 0.47044334975369456
Majority (class = e)
================================================================================
=                                   round 9                                    =
================================================================================
# of learning examples = 4875
# of pruning examples = 2437
# of test examples = 812
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2350 p, 2525 e]
     |- odor=n [74 p, 2047 e]
     |   |- spore-print-color=w [30 p, 343 e]
     |   |   |- habitat=d [24 p, 6 e]
     |   |   |   |- gill-size=n, class=p [24 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 6 e]
     |   |   |- habitat=g, class=e [0 p, 178 e]
     |   |   |- habitat=l [6 p, 25 e]
     |   |   |   |- cap-color=c, class=e [0 p, 15 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=n, class=e [0 p, 10 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 113 e]
     |   |   |- habitat=p, class=e [0 p, 21 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=n, class=e [0 p, 801 e]
     |   |- spore-print-color=k, class=e [0 p, 787 e]
     |   |- spore-print-color=o, class=e [0 p, 30 e]
     |   |- spore-print-color=b, class=e [0 p, 30 e]
     |   |- spore-print-color=h, class=e [0 p, 31 e]
     |   |- spore-print-color=r, class=p [44 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 25 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [354 p, 0 e]
     |- odor=c, class=p [121 p, 0 e]
     |- odor=f, class=p [1295 p, 0 e]
     |- odor=a, class=e [0 p, 253 e]
     |- odor=m, class=p [23 p, 0 e]
     |- odor=y, class=p [331 p, 0 e]
     |- odor=p, class=p [152 p, 0 e]
     `- odor=l, class=e [0 p, 225 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2350 p, 2525 e]
     |- odor=n [74 p, 2047 e]
     |   |- spore-print-color=w [30 p, 343 e]
     |   |   |- habitat=d [24 p, 6 e]
     |   |   |   |- gill-size=n, class=p [24 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 6 e]
     |   |   |- habitat=g, class=e [0 p, 178 e]
     |   |   |- habitat=l [6 p, 25 e]
     |   |   |   |- cap-color=c, class=e [0 p, 15 e]
     |   |   |   |- cap-color=w, class=p [4 p, 0 e]
     |   |   |   |- cap-color=n, class=e [0 p, 10 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=w, class=e [0 p, 113 e]
     |   |   |- habitat=p, class=e [0 p, 21 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=n, class=e [0 p, 801 e]
     |   |- spore-print-color=k, class=e [0 p, 787 e]
     |   |- spore-print-color=o, class=e [0 p, 30 e]
     |   |- spore-print-color=b, class=e [0 p, 30 e]
     |   |- spore-print-color=h, class=e [0 p, 31 e]
     |   |- spore-print-color=r, class=p [44 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 25 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [354 p, 0 e]
     |- odor=c, class=p [121 p, 0 e]
     |- odor=f, class=p [1295 p, 0 e]
     |- odor=a, class=e [0 p, 253 e]
     |- odor=m, class=p [23 p, 0 e]
     |- odor=y, class=p [331 p, 0 e]
     |- odor=p, class=p [152 p, 0 e]
     `- odor=l, class=e [0 p, 225 e]
----------------------------- majority classifier ------------------------------
# of error = 394
error rate = 0.4852216748768473
Majority (class = e)
================================================================================
=                                   round 10                                   =
================================================================================
# of learning examples = 4875
# of pruning examples = 2437
# of test examples = 812
------------------------------- before pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2325 p, 2550 e]
     |- odor=n [73 p, 2073 e]
     |   |- spore-print-color=w [31 p, 335 e]
     |   |   |- habitat=d [24 p, 5 e]
     |   |   |   |- gill-size=n, class=p [24 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=g, class=e [0 p, 165 e]
     |   |   |- habitat=w, class=e [0 p, 119 e]
     |   |   |- habitat=p, class=e [0 p, 24 e]
     |   |   |- habitat=l [7 p, 22 e]
     |   |   |   |- cap-color=c, class=e [0 p, 13 e]
     |   |   |   |- cap-color=w, class=p [5 p, 0 e]
     |   |   |   |- cap-color=n, class=e [0 p, 9 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=k, class=e [0 p, 800 e]
     |   |- spore-print-color=n, class=e [0 p, 820 e]
     |   |- spore-print-color=o, class=e [0 p, 30 e]
     |   |- spore-print-color=b, class=e [0 p, 33 e]
     |   |- spore-print-color=h, class=e [0 p, 30 e]
     |   |- spore-print-color=r, class=p [42 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 25 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [348 p, 0 e]
     |- odor=c, class=p [125 p, 0 e]
     |- odor=f, class=p [1269 p, 0 e]
     |- odor=a, class=e [0 p, 249 e]
     |- odor=m, class=p [23 p, 0 e]
     |- odor=y, class=p [326 p, 0 e]
     |- odor=p, class=p [161 p, 0 e]
     `- odor=l, class=e [0 p, 228 e]
-------------------------------- after pruning: --------------------------------
# of error = 0
error rate = 0.0
ID3 (33 leaves)
 `- root [2325 p, 2550 e]
     |- odor=n [73 p, 2073 e]
     |   |- spore-print-color=w [31 p, 335 e]
     |   |   |- habitat=d [24 p, 5 e]
     |   |   |   |- gill-size=n, class=p [24 p, 0 e]
     |   |   |   `- gill-size=b, class=e [0 p, 5 e]
     |   |   |- habitat=g, class=e [0 p, 165 e]
     |   |   |- habitat=w, class=e [0 p, 119 e]
     |   |   |- habitat=p, class=e [0 p, 24 e]
     |   |   |- habitat=l [7 p, 22 e]
     |   |   |   |- cap-color=c, class=e [0 p, 13 e]
     |   |   |   |- cap-color=w, class=p [5 p, 0 e]
     |   |   |   |- cap-color=n, class=e [0 p, 9 e]
     |   |   |   |- cap-color=y, class=p [2 p, 0 e]
     |   |   |   |- cap-color=g, class=e [0 p, 0 e]
     |   |   |   |- cap-color=e, class=e [0 p, 0 e]
     |   |   |   |- cap-color=p, class=e [0 p, 0 e]
     |   |   |   |- cap-color=b, class=e [0 p, 0 e]
     |   |   |   |- cap-color=u, class=e [0 p, 0 e]
     |   |   |   `- cap-color=r, class=e [0 p, 0 e]
     |   |   |- habitat=u, class=e [0 p, 0 e]
     |   |   `- habitat=m, class=e [0 p, 0 e]
     |   |- spore-print-color=k, class=e [0 p, 800 e]
     |   |- spore-print-color=n, class=e [0 p, 820 e]
     |   |- spore-print-color=o, class=e [0 p, 30 e]
     |   |- spore-print-color=b, class=e [0 p, 33 e]
     |   |- spore-print-color=h, class=e [0 p, 30 e]
     |   |- spore-print-color=r, class=p [42 p, 0 e]
     |   |- spore-print-color=y, class=e [0 p, 25 e]
     |   `- spore-print-color=u, class=e [0 p, 0 e]
     |- odor=s, class=p [348 p, 0 e]
     |- odor=c, class=p [125 p, 0 e]
     |- odor=f, class=p [1269 p, 0 e]
     |- odor=a, class=e [0 p, 249 e]
     |- odor=m, class=p [23 p, 0 e]
     |- odor=y, class=p [326 p, 0 e]
     |- odor=p, class=p [161 p, 0 e]
     `- odor=l, class=e [0 p, 228 e]
----------------------------- majority classifier ------------------------------
# of error = 420
error rate = 0.5172413793103449
Majority (class = e)
################################################################################
#                                   summary                                    #
################################################################################
+-------+-------+-------+------+---------+---------+-------+-------+----------+
| round | learn | prune | test | leaf    | error   | leaf  | error | error    |
|       |       |       |      | (orig.) | (orig.) | (pr.) | (pr.) | (major.) |
+-------+-------+-------+------+---------+---------+-------+-------+----------+
|     1 |  4874 |  2437 |  813 |      33 |       0 |    33 |     0 |      393 |
|     2 |  4874 |  2437 |  813 |      33 |       0 |    33 |     0 |      418 |
|     3 |  4874 |  2437 |  813 |      33 |       0 |    33 |     0 |      360 |
|     4 |  4874 |  2437 |  813 |      33 |       0 |    33 |     0 |      391 |
|     5 |  4875 |  2437 |  812 |      33 |       0 |    33 |     0 |      368 |
|     6 |  4875 |  2437 |  812 |      33 |       0 |    33 |     0 |      415 |
|     7 |  4875 |  2437 |  812 |      33 |       0 |    33 |     0 |      375 |
|     8 |  4875 |  2437 |  812 |      33 |       0 |    33 |     0 |      382 |
|     9 |  4875 |  2437 |  812 |      33 |       0 |    33 |     0 |      394 |
|    10 |  4875 |  2437 |  812 |      33 |       0 |    33 |     0 |      420 |
+-------+-------+-------+------+---------+---------+-------+-------+----------+
################################################################################
#                                  statistics                                  #
################################################################################
+----------+-------+----------+------+------------------+
|          | leaf  | accuracy | SE   | 95% CI           |
+----------+-------+----------+------+------------------+
|   before | 33.00 |   100.00 | 0.00 | (100.00, 100.00) |
|    after | 33.00 |   100.00 | 0.00 | (100.00, 100.00) |
| majority |   N/A |    51.80 | 2.46 |   (46.32, 57.28) |
+----------+-------+----------+------+------------------+
