(**Module for calculating the physics on game objects*)

(**All non-player character physics is instead performed in Ai module*)

(**[calculate_physics i gst] performs physics calculations for all of
   the sprites in [gst] based on the inputs i*)
val calculate_physics : Input.t -> Gamestate.t -> Gamestate.t

(** [test_physics input gs] takes a dummy input [input] and a current
    game [state] and outputs the new gamestate*)
val test_physics : char -> Gamestate.t -> Gamestate.t

(** [test_collision a b] creates a call for [a] colliding into [b]*)
val test_collision : Sprite.t -> Sprite.t -> unit
