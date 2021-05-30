(** Module that handles characters that can move with hit box *)

(**[mario_type] is the different types of mario*)
type mario_type =
  | SmolMario
  | SuperMario
  | FireMario

(**[pwr_up] is the different types of powerup*)
type pwr_up =
  | Mushroom
  | FireFlower

(**[sprite] is the different types of sprites there are. Object does not
   move*)
type sprite =
  | Mario of mario_type
  | Goomba
  | Object
  | Koopa
  | KoopaShell
  | Fireball
  | Coin
  | BulletBill
  | Powerup of pwr_up

(**[point] is a record representing a point (x, y)*)
type point = {
  x : float;
  y : float;
}

(**[hitbox] is a hitbox for a sprite*)
type hitbox = {
  lower_left : point;
  width : int;
  height : int;
}

(**Representation type of sprites*)
type t

(**[position t] is the current position of this sprite*)
val position : t -> point

(**[velocity t] is the current velocity*)
val velocity : t -> point

(**[size t] is the current size of this sprite*)
val size : t -> int * int

(**[coins t] is the current ammount of coins*)
val coins : t -> int

(**[is_alive t] is true if the sprite is alive, false if it is dead. For
   objects and projectiles this is false when it becomes irrelvant and
   should be removed from memory.*)
val is_alive : t -> bool

(**[kill t] kills the sprite such that [is_alive t] after will return
   false*)
val kill : t -> unit

(**[power_up t pwr] gives the sprite t the power up pwr if t can be
   powerd up*)
val power_up : t -> t -> unit

(**[got_coin t] gives the sprite 1 more coin if the sprite can have
   coins*)
val got_coin : t -> t -> unit

(**[update_position t] changes the position of the sprite*)
val update_position : t -> point -> unit

(**[update_velocity t] changes the velocity of the sprite*)
val update_velocity : t -> point -> unit

(**[collision t] is the current hitbox of this sprite*)
val collision : t -> hitbox

(**[chartype t] is the type of sprite stored*)
val spritetype : t -> sprite

(**[tick_timers t] ticks any timers on the character*)
val tick_timers : t -> unit

(**[can_fire t] is true if Mario can fire a fireball*)
val can_fire : t -> bool

(**[fire t] fires a fireball if the sprite can*)
val fire : t -> unit

(**[make c p w h] is a new sprite of type [c] with their bottom left
   corner at [p] and a witdth of [w] and a height of [h]*)
val make : sprite -> point -> int -> int -> t
