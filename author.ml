(*When you work on the project, put the time spent in the appropriate
  list*)
let ms1_list = [ 2; 2; 4; 4; 4; 2; 18 ]

let ms2_list = [ 4; 3; 4; 1 ]

let ms3_list = [ 10; 10; 17; 6 ]

(** Total hours put it*)
let hours_worked = List.fold_left ( + ) 0 ms3_list
