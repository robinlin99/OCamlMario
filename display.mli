(**Module that handles drawing of all Sprites and the background*)

(** [draw_goomba x y] draws a goomba sprite at x position [x] and y
    position [y] *)
val draw_goomba : int -> int -> unit

(** [draw_object x y w h] draws a wall sprite with width [w] and height
    [h] at x position [x] and y position [y] *)
val draw_object : int -> int -> int -> int -> unit

(** [draw_cloud x y gs] draws a cloud at x position [x] and y position
    [y] with gamestate [gs] *)
val draw_cloud : int -> int -> Gamestate.t -> unit

(** [draw_mario_sprite x y kind] draws a mario at x position [x] and y
    position [y] with the type [kind] *)
val draw_mario_sprite : int -> int -> Sprite.mario_type -> unit

(** [draw_fireball_sprite x y] draws a fireball at x position [x] and y
    position [y] *)
val draw_fireball_sprite : int -> int -> unit

(** [draw_koopa x y] draws a koopa facing the right direction at x
    position [x] and y position [y] *)
val draw_koopa : int -> int -> unit

(** [draw_koopa_shell_sprite x y] draws a koopa shell at x position [x]
    and y position [y] *)
val draw_koopa_shell_sprite : int -> int -> unit

(** [draw_coin x y] draws a coin at x position [x] and y position [y] *)
val draw_coin : int -> int -> unit

(** [draw_bulletbill x y] draws a bulletbill at x position [x] and y
    position [y] *)
val draw_bulletbill : int -> int -> unit

(** [draw_fireflower x y] draws a fireflower at x position [x] and y
    position [y] *)
val draw_fireflower : int -> int -> unit

(** [draw_mushroom x y] draws a mushroom at x position [x] and y
    position [y] *)
val draw_mushroom : int -> int -> unit

(** [draw_background x y] draws the background image at x position [x]
    and y position [y] *)
val draw_background : int -> int -> unit

(** [draw_sprite s gs] draws the sprite [s] with a gamestate of [gs] *)
val draw_sprite : Sprite.t -> Gamestate.t -> unit

(** [draw_sprites gs] draws the sprites inside gamestate of [gs]*)
val draw_sprites : Gamestate.t -> unit

(** [draw_string_of_number x y num size] draws the numbers represented
    by [num] starting at position x position [x] and y position [y] *)
val draw_string_of_number : int -> int -> string -> int -> unit

(** [draw_text_of_string x y text size] draws the text represented by
    [text] starting at position x position [x] and y position [y] *)
val draw_text_of_string : int -> int -> string -> int -> unit

(** [draw_win_message gs] draws the winning message *)
val draw_win_message : Gamestate.t -> unit

(** [draw_loss_message ()] draws the losing message *)
val draw_loss_message : unit -> unit

(** [update_frame gamestate max_width margin_left margin_right screen_width]
    updates the rendered positions of objects due to player's motion *)
val update_frame :
  Gamestate.t -> int -> int -> int -> int -> Gamestate.t

(** [render_state gamestate max_width max_height] renders the entire
    game on the screen*)
val render_state : Gamestate.t -> int -> int -> unit
