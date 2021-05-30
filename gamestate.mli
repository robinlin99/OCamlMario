(** Module that handles the current game state*)

(** The type for a gamestate *)
type t

(**[sprites t] is the list of sprites in the game*)
val sprites : t -> Sprite.t list

(**[camera_position t] is the current camera/screen position of the game*)
val camera_position : t -> int

(**[get_current_score t] is the current score of the player*)
val get_current_score : t -> int

(**[get_coins t] returns the current number of coins the player has
   collected*)
val get_coins : t -> int

(**[make sprites] makes a gamestate from a list of sprites

   REQUIRES: a Mario sprite be the first sprite. only one Mario sprite. *)
val make : Sprite.t list -> t

(**[update_score t] is [t] with [t.score] updated with the time elapsed,
   enemies killed, and coins collected *)
val update_score : t -> t

(**[update_sprites t s] is [t] with [s] as the sprite list*)
val update_sprites : t -> Sprite.t list -> t

(**[update_camera t c] is [t] with [c] as the camera_position*)
val update_camera : t -> int -> t

(**[get_mario t] returns the state of mario in the game*)
val get_mario : t -> Sprite.t

(**[has_mario t] returns true if the gamestate has a mario*)
val has_mario : t -> bool
