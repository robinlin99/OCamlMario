open Yojson.Basic.Util

let get_object j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make Sprite.Object { x = pos_x; y = pos_y } w h

let gen_objects j =
  j |> member "objects" |> to_list |> List.map get_object

let gen_mario j =
  let pos_x =
    j |> member "mario"
    |> member "starting position"
    |> member "x" |> to_float
  in
  let pos_y =
    j |> member "mario"
    |> member "starting position"
    |> member "y" |> to_float
  in
  let w =
    j |> member "mario" |> member "size" |> member "w" |> to_int
  in
  let h =
    j |> member "mario" |> member "size" |> member "h" |> to_int
  in
  let mario =
    Sprite.make (Sprite.Mario Sprite.SmolMario)
      { x = pos_x; y = pos_y }
      w h
  in
  [ mario ]

let get_goomba j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make Sprite.Goomba { x = pos_x; y = pos_y } w h

let gen_goombas j =
  j |> member "goombas" |> to_list |> List.map get_goomba

let get_koopa j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make Sprite.Koopa { x = pos_x; y = pos_y } w h

let gen_koopas j = j |> member "koopas" |> to_list |> List.map get_koopa

let get_koopa_shell j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make Sprite.KoopaShell { x = pos_x; y = pos_y } w h

let gen_koopa_shell j =
  j |> member "koopa_shells" |> to_list |> List.map get_koopa_shell

let get_bulletbill j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make Sprite.BulletBill { x = pos_x; y = pos_y } w h

let gen_bulletbills j =
  j |> member "bulletbills" |> to_list |> List.map get_bulletbill

let get_mushroom j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make (Sprite.Powerup Mushroom) { x = pos_x; y = pos_y } w h

let gen_mushrooms j =
  j |> member "mushrooms" |> to_list |> List.map get_mushroom

let get_fireflower j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make (Sprite.Powerup FireFlower) { x = pos_x; y = pos_y } w h

let gen_fireflowers j =
  j |> member "fireflowers" |> to_list |> List.map get_fireflower

let get_coin j =
  let pos_x = j |> member "position" |> member "x" |> to_float in
  let pos_y = j |> member "position" |> member "y" |> to_float in
  let w = j |> member "size" |> member "w" |> to_int in
  let h = j |> member "size" |> member "h" |> to_int in
  Sprite.make Sprite.Coin { x = pos_x; y = pos_y } w h

let gen_coins j = j |> member "coins" |> to_list |> List.map get_coin

let from_json filename =
  let j = Yojson.Basic.from_file filename in
  let objects = gen_objects j in
  let mario = gen_mario j in
  let goombas = gen_goombas j in
  let koopas = gen_koopas j in
  let bulletbills = gen_bulletbills j in
  let mushrooms = gen_mushrooms j in
  let fireflowers = gen_fireflowers j in
  let coins = gen_coins j in
  let game =
    mario @ objects @ goombas @ koopas @ bulletbills @ mushrooms
    @ fireflowers @ coins
  in
  Gamestate.make game
