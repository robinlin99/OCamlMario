(*List of numerical constants used below. Here for easy adjusting*)

(*gravity*)
let g = 1.

(*small hop*)
let shop = 14.

(*large hop*)
let lhop = 18.

(*horizontal acceleration*)
let accel = 3.

(* let deccel = -3. *)
(* Currently not used *)

(*maximum horizontal velocity aka top speed*)
let maxhvel = 6.

(*max falling speed*)
let terminalvel = -15.

(******************************************************************************)
(* Mario Physics Helper Functions *)

(*Looks at the keys pressed and determines x accel*)
let get_x_accel (input : Input.t) (v : Sprite.point) =
  match input.current_key with
  | 'd' -> if v.x >= maxhvel then 0. else accel
  | 'a' -> if v.x <= -.maxhvel then 0. else accel *. -1.
  | _ -> -.v.x /. 2.

(*Looks at keys keys pressed and determines y accel*)
let get_y_accel (input : Input.t) (v : Sprite.point) =
  if input.short_hop && v.y = 0. then shop
  else if input.full_hop && v.y = 0. then lhop
  else -.g

(*takes input and turns it into appropriate accelerations*)
let get_accel input v : Sprite.point =
  { x = get_x_accel input v; y = get_y_accel input v }

(*performs a step of adding change to value, akin to euler's method*)
let euler_step (old : Sprite.point) (to_add : Sprite.point) :
    Sprite.point =
  { x = old.x +. to_add.x; y = old.y +. to_add.y }

(*velocity and accelaration calculations*)
let calculations input sprite =
  let acceleration = get_accel input (Sprite.velocity sprite) in
  let velocity =
    ref (euler_step (Sprite.velocity sprite) acceleration)
  in
  (*check it doesn't exceed max velocity*)
  if !velocity.x > maxhvel || !velocity.x < -.maxhvel then
    if !velocity.x > 0. then velocity := { !velocity with x = maxhvel }
    else velocity := { !velocity with x = -.maxhvel }
  else ();
  if !velocity.y < terminalvel then
    velocity := { !velocity with y = terminalvel }
  else ();
  let position = euler_step (Sprite.position sprite) !velocity in
  Sprite.update_position sprite position;
  Sprite.update_velocity sprite !velocity

(******************************************************************************)

(*Debugging helpers*)
let string_from_sprite s =
  let open Sprite in
  match s with
  | Mario _ -> "Mario"
  | Goomba -> "Goomba"
  | Koopa -> "Koopa"
  | _ -> "Other"

(******************************************************************************)
(* Sprite Collision Helper Functions*)

(*center of a hitbox*)
let midpoint (box : Sprite.hitbox) : Sprite.point =
  {
    x = box.lower_left.x +. (float_of_int box.width /. 2.);
    y = box.lower_left.y +. (float_of_int box.height /. 2.);
  }

(*This is a in poor taste patch for a bug I have no idea or time to hunt
  down. Ooopsies. Ideally, when you update the x velocity in this case,
  you just negate x velocity, but for whatever reason, the get velocity
  function here is consistently returning 0 even when I can confim the
  velocity is in fact not zero.*)
(*hardcoded enemy velocity values*)
let enemy_velocity s =
  match Sprite.spritetype s with
  | Goomba | Koopa -> 1.
  | KoopaShell -> 8.
  | BulletBill -> 3.
  | Fireball -> 7.
  | Object | Powerup _ | Coin | Mario _ -> failwith "impossible"

(*collision means move up and left*)
let up_left a b =
  let open Sprite in
  (*this will work by comparing distance between edges*)
  let h_dif =
    (position a).x +. float_of_int (collision a).width -. (position b).x
  in
  let v_dif =
    (position b).y
    +. float_of_int (collision b).height
    -. (position a).y
  in
  if h_dif >= v_dif then (
    update_position a
      { x = (position a).x; y = (position a).y +. v_dif };
    if spritetype a = Fireball then
      update_velocity a { x = (velocity a).x; y = -.(velocity a).y }
    else update_velocity a { x = (velocity a).x; y = 0. } )
  else (
    update_position a
      { x = (position a).x -. h_dif; y = (position a).y };
    if
      spritetype a <> Mario SmolMario
      && spritetype a <> Mario SuperMario
      && spritetype a <> Mario FireMario
    then
      update_velocity a { x = -.enemy_velocity a; y = (velocity a).y }
    else update_velocity a { x = 0.; y = (velocity a).y };
    if spritetype b = Goomba || spritetype b = Koopa then
      update_velocity b { (velocity b) with x = 1. }
    else () )

(*collision means move up right*)
let up_right a b =
  let open Sprite in
  (*this will work by comparing distance between edges*)
  let h_dif =
    (position b).x +. float_of_int (collision b).width -. (position a).x
  in
  let v_dif =
    (position b).y
    +. float_of_int (collision b).height
    -. (position a).y
  in
  if h_dif >= v_dif then (
    update_position a
      { x = (position a).x; y = (position a).y +. v_dif };
    if spritetype a = Fireball then
      update_velocity a { x = (velocity a).x; y = -.(velocity a).y }
    else update_velocity a { x = (velocity a).x; y = 0. } )
  else (
    update_position a
      { x = (position a).x +. h_dif; y = (position a).y };
    if
      spritetype a <> Mario SmolMario
      && spritetype a <> Mario SuperMario
      && spritetype a <> Mario FireMario
    then update_velocity a { x = enemy_velocity a; y = (velocity a).y }
    else update_velocity a { x = 0.; y = (velocity a).y };
    if spritetype b = Goomba || spritetype b = Koopa then
      update_velocity b { (velocity b) with x = -1. }
    else () )

(*collision means move down left*)
let down_left a b =
  let open Sprite in
  (*this will work by comparing distance between edges*)
  let h_dif =
    (position a).x +. float_of_int (collision a).width -. (position b).x
  in
  let v_dif =
    (position a).y
    +. float_of_int (collision a).height
    -. (position b).y
  in
  if h_dif >= v_dif then (
    update_position a
      { x = (position a).x; y = (position a).y -. v_dif };
    update_velocity a { x = (velocity a).x; y = 0. } )
  else (
    update_position a
      { x = (position a).x -. h_dif; y = (position a).y };
    if
      spritetype a <> Mario SmolMario
      && spritetype a <> Mario SuperMario
      && spritetype a <> Mario FireMario
    then
      update_velocity a { x = -.enemy_velocity a; y = (velocity a).y }
    else update_velocity a { x = 0.; y = (velocity a).y };
    if spritetype b = Goomba || spritetype b = Koopa then
      update_velocity b { (velocity b) with x = 1. }
    else () )

(*collision means move down right*)
let down_right a b =
  let open Sprite in
  (*this will work by comparing distance between edges*)
  let h_dif =
    (position b).x +. float_of_int (collision b).width -. (position a).x
  in
  let v_dif =
    (position a).y
    +. float_of_int (collision a).height
    -. (position b).y
  in
  if h_dif >= v_dif then (
    update_position a
      { x = (position a).x; y = (position a).y -. v_dif };
    update_velocity a { x = (velocity a).x; y = 0. } )
  else (
    update_position a
      { x = (position a).x +. h_dif; y = (position a).y };
    if
      spritetype a <> Mario SmolMario
      && spritetype a <> Mario SuperMario
      && spritetype a <> Mario FireMario
    then update_velocity a { x = enemy_velocity a; y = (velocity a).y }
    else update_velocity a { x = 0.; y = (velocity a).y };
    if spritetype b = Goomba || spritetype b = Koopa then
      update_velocity b { (velocity b) with x = -1. }
    else () )

(*Handles collision between mario and enemy where mario could kill enemy
  Mirrors some of the code in general collision, but not all is
  necessary*)
let mario_enemy_collision_l a b =
  let open Sprite in
  let h_dif =
    (position a).x +. float_of_int (collision a).width -. (position b).x
  in
  let v_dif =
    (position b).y
    +. float_of_int (collision b).height
    -. (position a).y
  in
  if h_dif >= v_dif then (
    kill b;
    update_position a
      { x = (position a).x; y = (position a).y +. v_dif };
    update_velocity a { x = (velocity a).x; y = shop } )
  else kill a

(*Handles collision between mario and enemy where mario could kill enemy
  Mirrors some of the code in general collision, but not all is
  necessary*)
let mario_enemy_collision_r a b =
  let open Sprite in
  let h_dif =
    (position b).x +. float_of_int (collision b).width -. (position a).x
  in
  let v_dif =
    (position b).y
    +. float_of_int (collision b).height
    -. (position a).y
  in
  if h_dif >= v_dif then (
    kill b;
    update_position a
      { x = (position a).x; y = (position a).y +. v_dif };
    update_velocity a { x = (velocity a).x; y = shop } )
  else kill a

let kshell_collision a b (mid_x_dif, mid_y_dif) =
  let open Sprite in
  if (velocity b).x <> 0. then
    if spritetype a = KoopaShell && is_alive a then (
      kill a;
      kill b )
    else if spritetype a = Koopa then (
      (*Koopas need to be double killed so they don't spawn a koopa
        shell*)
      kill a;
      kill a )
    else kill a
  else
    match spritetype a with
    | Object | Coin | Powerup _ | BulletBill -> failwith "impossible"
    | Goomba | Koopa ->
        if mid_x_dif <= 0. && mid_y_dif >= 0. then up_left a b
        else if mid_x_dif > 0. && mid_y_dif >= 0. then up_right a b
        else if mid_x_dif <= 0. && mid_y_dif < 0. then down_left a b
        else down_right a b
    | KoopaShell | Fireball ->
        if is_alive a then (
          kill a;
          kill b )
    | Mario mt ->
        (*Kick the shell*)
        let h_dif =
          (position b).x
          +. float_of_int (collision b).width
          -. (position a).x
        in
        if mid_x_dif <= 0. then (
          update_position b
            { (position b) with x = (position b).x +. h_dif +. 1. };
          update_velocity b { (velocity b) with x = 8. } )
        else (
          update_position b
            { (position b) with x = (position b).x -. h_dif -. 1. };
          update_velocity b { (velocity b) with x = -8. } )

(*This is where type of collisions is calculated*)
let collision a b (mid_x_dif, mid_y_dif) =
  match (Sprite.spritetype a, Sprite.spritetype b) with
  | _, Object
  | Goomba, Goomba
  | Goomba, Koopa
  | Koopa, Goomba
  | Koopa, Koopa ->
      if mid_x_dif <= 0. && mid_y_dif >= 0. then up_left a b
      else if mid_x_dif > 0. && mid_y_dif >= 0. then up_right a b
      else if mid_x_dif <= 0. && mid_y_dif < 0. then down_left a b
      else down_right a b
  | Mario _, Goomba | Mario _, Koopa | Mario _, BulletBill ->
      if
        (*if the goomba is above mario, mario ded*)
        (mid_x_dif <= 0. && mid_y_dif < 0.)
        || (mid_x_dif > 0. && mid_y_dif < 0.)
      then Sprite.kill a
      else if mid_x_dif <= 0. then mario_enemy_collision_l a b
      else mario_enemy_collision_r a b
  | _, BulletBill -> Sprite.kill a
  (*Mario isn't damaged by his own fireballs*)
  | Mario _, Fireball -> ()
  | _, Fireball ->
      Sprite.kill a;
      Sprite.kill b
  | _, KoopaShell -> kshell_collision a b (mid_x_dif, mid_y_dif)
  | _, Coin -> Sprite.got_coin a b
  | _, Powerup p -> Sprite.power_up a b
  | Goomba, Mario _ | Fireball, _ | KoopaShell, _ | Koopa, _ ->
      () (*We don't deal with that now*)
  | Mario _, Mario _ -> failwith "Only one Mario allowed"
  | Object, _ | Coin, _ | Powerup _, _ | BulletBill, _ ->
      failwith "impossible"

(*a is colliding into b. A will be moved to not collide*)
(*If they are centered on one another, a will pop out to the left*)
let calc_collision a b =
  let mida = a |> Sprite.collision |> midpoint in
  let midb = b |> Sprite.collision |> midpoint in
  let mid_x_dif = mida.x -. midb.x in
  let mid_y_dif = mida.y -. midb.y in
  let mid_x_sep =
    (float_of_int (Sprite.collision a).width /. 2.)
    +. (float_of_int (Sprite.collision b).width /. 2.)
  in
  let mid_y_sep =
    (float_of_int (Sprite.collision a).height /. 2.)
    +. (float_of_int (Sprite.collision b).height /. 2.)
  in
  if
    (*Is there actually a collision*)
    Float.abs mid_x_dif < Float.abs mid_x_sep
    && Float.abs mid_y_dif < Float.abs mid_y_sep
  then collision a b (mid_x_dif, mid_y_dif)
  else ()

(******************************************************************************)

(*lobby for physics calculations. Goes to AI for npcs*)
let calc_check input sprite =
  match Sprite.spritetype sprite with
  | Mario _ -> calculations input sprite
  | Goomba | Koopa | KoopaShell | Fireball | BulletBill -> Ai.ai sprite
  | Object | Powerup _ | Coin -> ()

(*the main collision method*)
let check_collision sprite_lst sprite =
  match Sprite.spritetype sprite with
  | Mario _ | Goomba | Koopa | KoopaShell | Fireball ->
      sprite_lst
      |> List.filter (fun a -> a <> sprite)
      |> List.iter (calc_collision sprite)
  | Object | Powerup _ | Coin | BulletBill -> ()

(*the main method call*)
let calculate_physics (input : Input.t) state =
  let s = Gamestate.sprites state in
  List.iter (calc_check input) s;
  List.iter (check_collision s) s;
  state

(*fake call to help testing*)
let test_physics (input : char) gs =
  let fake_input =
    ( {
        current_key = input;
        raw_hist = [];
        short_hop = false;
        full_hop = false;
        fire = false;
      }
      : Input.t )
  in
  calculate_physics fake_input gs

(*fake call for testing*)
let test_collision a b = calc_collision a b
