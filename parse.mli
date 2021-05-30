(**Module that parses a game state out of a suitable .json file*)

(** [from_json filename] is the game file that [filename] represents.
    Requires: [filename] is a valid JSON file name and the JSON is of
    valid structure. *)
val from_json : string -> Gamestate.t
