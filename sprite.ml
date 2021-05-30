(**[mario_type] is the different types of mario*)
type mario_type =
  | SmolMario
  | SuperMario
  | FireMario

(**[pwr_up] is the different types of powerup*)
type pwr_up =
  | Mushroom
  | FireFlower

(**[sprite] is the different types of sprites there are*)
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

(** AF: this represents a sprite, such that most fields are protected*)
type t = {
  mutable kind : sprite;
  mutable pos : point;
  mutable vel : point;
  size : int * int;
  (*width * height*)
  mutable alive : bool;
  mutable coins : int;
  mutable inv_time : int;
  mutable fire_time : int;
}

let position boi = boi.pos

let velocity boi = boi.vel

let size boi = boi.size

let coins boi = boi.coins

let is_alive boi = boi.alive

let can_fire boi =
  match boi.kind with
  | Mario FireMario -> boi.fire_time = 0
  | _ -> false

let kill boi =
  match boi.kind with
  | Mario mt ->
      if boi.inv_time > 0 then ()
      else (
        boi.inv_time <- 60;
        match mt with
        | SmolMario -> boi.alive <- false
        | SuperMario -> boi.kind <- Mario SmolMario
        | FireMario -> boi.kind <- Mario SuperMario )
  | Koopa ->
      boi.kind <- KoopaShell;
      boi.vel <- { x = 0.; y = 0. }
  | _ -> boi.alive <- false

let got_coin boi c =
  match boi.kind with
  | Mario _ ->
      boi.coins <- boi.coins + 1;
      kill c
  (*these bois can't get coins*)
  | Goomba | Object | Koopa | KoopaShell | Fireball | Coin | BulletBill
  | Powerup _ ->
      ()

let power_up boi power =
  match (boi.kind, power.kind) with
  | Mario mt, Powerup Mushroom ->
      if mt = FireMario then (
        got_coin boi
          {
            kind = Coin;
            pos = { x = 0.; y = 0. };
            vel = { x = 0.; y = 0. };
            size = (1, 1);
            alive = true;
            coins = 0;
            inv_time = 0;
            fire_time = 0;
          };
        kill power )
      else (
        boi.kind <- Mario SuperMario;
        kill power )
  | Mario _, Powerup FireFlower ->
      boi.kind <- Mario FireMario;
      kill power
  | _, _ -> ()

let collision boi =
  { lower_left = boi.pos; width = fst boi.size; height = snd boi.size }

let spritetype boi = boi.kind

let update_position boi pos = boi.pos <- pos

let update_velocity boi vel = boi.vel <- vel

let fire boi =
  match boi.kind with Mario FireMario -> boi.fire_time <- 60 | _ -> ()

let tick_timers boi =
  if boi.inv_time > 0 then boi.inv_time <- boi.inv_time - 1 else ();
  if boi.fire_time > 0 then boi.fire_time <- boi.fire_time - 1 else ()

let make nkind npos w h =
  {
    kind = nkind;
    pos = npos;
    vel = { x = 0.; y = 0. };
    size = (w, h);
    alive = true;
    coins = 0;
    inv_time = 0;
    fire_time = 0;
  }
