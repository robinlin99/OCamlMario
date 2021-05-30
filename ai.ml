open Sprite

(*performs a step of adding change to value, akin to euler's method*)
let euler_step (old : Sprite.point) (to_add : Sprite.point) :
    Sprite.point =
  { x = old.x +. to_add.x; y = old.y +. to_add.y }

(*Does goomba-specific ai calculations*)
(*max_horizontal velocity = 4.5 terminal velocity the same*)
let g_h_vel = 1.

let g = 1.

let terminal = -15.

let goomba_koopa_ai gb =
  let acc = ref { x = 0.; y = -.g } in
  if (velocity gb).x = 0. then acc := { !acc with x = -.g_h_vel }
  else ();
  let vel = ref (euler_step (velocity gb) !acc) in
  if !vel.x > g_h_vel || !vel.x < -.g_h_vel then
    if !vel.x > 0. then vel := { !vel with x = g_h_vel }
    else vel := { !vel with x = -.g_h_vel }
  else ();
  if !vel.y < terminal then vel := { !vel with y = terminal } else ();
  let pos = euler_step (position gb) !vel in
  update_position gb pos;
  update_velocity gb !vel

let shell_fireball_ai s =
  let acc = { x = 0.; y = -.g } in
  let vel = ref (euler_step (velocity s) acc) in
  if !vel.y < terminal then vel := { !vel with y = terminal } else ();
  let pos = euler_step (position s) !vel in
  update_position s pos

let bullet_ai b =
  let vel = ref (velocity b) in
  if !vel.x = 0. then vel := { !vel with x = -0.5 } else ();
  let pos = euler_step (position b) !vel in
  update_position b pos

let ai sprite =
  match spritetype sprite with
  | Mario _ | Object | Coin | Powerup _ -> failwith "impossible"
  | Goomba | Koopa -> goomba_koopa_ai sprite
  | KoopaShell -> shell_fireball_ai sprite
  | BulletBill -> bullet_ai sprite
  | Fireball -> shell_fireball_ai sprite
