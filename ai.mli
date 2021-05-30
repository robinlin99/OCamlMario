(**Module that handles AI of anything not controlled via keyboard
   directly*)

(**[ai t] performs one frame of AI calculations on [t], including
   physics*)
val ai : Sprite.t -> unit
