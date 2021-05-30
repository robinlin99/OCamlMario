(**This will house the entire testing suite*)
open OUnit2

open Sprite

(*******************************************************************************
  Testing Plan and Methodology

  The Input, Physics, Sprite, Parse, and Gamestate Modules can be
  rudimentarily tested with OUnit tested, some more than others.

  Through some experiments, it was determined that the physics
  calculations cannot be tested automatically, and instead are better
  tested visually with the game display. This is how we did all of our
  debugging for the physics system.

  The collision system, however can be tested automatically, and was was
  extensively debugged and tested using automatic testing.

  The physis calculation for NPC's are handled in the AI module, which
  was also unable to be tested automatically and therefore was entirely
  tested visually while running the game.

  The other modules (Input, Sprite, Parse, Gamestate) were tested peice
  by piece, testing parts automatically and testing more intricate
  interactions visually. The most extensively tested systems were the
  Collision and Sprite systems, as they have lots of interesting
  interactions.

  The Graphics Module cannot be automatically tested, as its entire
  funciton is to display things on a screen, that all has to be tested
  and debugged visually.

  All tests were developed using the glass box testing system, mostly
  tested by their creator.

  This testing methodology demonstrates the correctness of our system
  because it tests internal things that cannot be seen with automatic
  testing through OUnit, and everything else in the system is visual and
  therefore tested extensively through our running and observing the
  system.

  *****************************************************************************)

let point_to_string (p : Sprite.point) =
  match p with
  | { x; y } -> "(" ^ string_of_float x ^ ", " ^ string_of_float y ^ ")"

let sprite_to_string (s : Sprite.t) : string =
  let ret = ref "{ " in
  ( match spritetype s with
  | Mario _ -> ret := !ret ^ "Mario, "
  | Goomba -> ret := !ret ^ "Goomba, "
  | Object -> ret := !ret ^ "Object, "
  | _ -> failwith "TODO?" );
  ret := !ret ^ point_to_string (position s) ^ ", ";
  !ret

let gamestate_to_string gs =
  "[ "
  ^
  let rec helper = function
    | [] -> ""
    | h :: t -> sprite_to_string h ^ " " ^ helper t
  in
  helper (Gamestate.sprites gs) ^ "]"

(*gamestates are equal if they are the same length and all of the
  elements in st1 exist in st2*)
let eq_gamestate st1 st2 =
  let a = Gamestate.sprites st1 in
  let b = Gamestate.sprites st2 in
  if List.length a = List.length b then
    List.for_all (fun asp -> List.exists (fun x -> x = asp) b) a
  else false

(*******************************************************************************
  Gamestates used for Testing*)
let from_json =
  Gamestate.make
    [
      make (Mario SmolMario) { x = 10.; y = 100. } 21 37;
      make Object { x = 0.; y = 0. } 600 60;
      make Object { x = 80.; y = 160. } 80 20;
      make Object { x = 240.; y = 60. } 40 60;
      make Object { x = 310.; y = 240. } 160 20;
      make Object { x = 540.; y = 60. } 20 20;
      make Object { x = 560.; y = 60. } 20 40;
      make Object { x = 580.; y = 60. } 20 60;
      make Object { x = -20.; y = 0. } 20 450;
      make Goomba { x = 150.; y = 125. } 30 25;
      make Goomba { x = 300.; y = 60. } 30 25;
      make Koopa { x = 400.; y = 260. } 25 25;
      make BulletBill { x = 550.; y = 100. } 30 20;
      make (Powerup FireFlower) { x = 120.; y = 120. } 30 25;
      make (Powerup Mushroom) { x = 350.; y = 180. } 25 25;
      make Coin { x = 100.; y = 180. } 10 20;
      make Coin { x = 400.; y = 80. } 10 20;
    ]

let basic =
  Gamestate.make
    [
      make (Mario SmolMario) { x = 0.; y = 0. } 21 37;
      make Object { x = 0.; y = 0. } 10 10;
    ]

let p1 = { x = 50.; y = 50. }

let p2 = { x = 40.; y = 60. }

let p3 = { x = 60.; y = 60. }

let p4 = { x = 60.; y = 40. }

let p5 = { x = 40.; y = 40. }

let p6 = { x = 40.; y = 100. }

let p7 = { x = 40.; y = 30. }

let p8 = { x = 30.; y = 50. }

let p9 = { x = 70.; y = 70. }

let p10 = { x = 90.; y = 40. }

(*ded*)
let goomba1 = make Goomba p1 30 25

(*ded*)
let goomba2 = make Goomba p2 30 25

(*ded*)
let goomba5 = make Goomba p5 30 25

(*ded*)
let goomba10 = make Goomba p10 30 25

(*ded*)
let koopa10 = make Koopa p10 25 25

(*shell*)
let koopa5 = make Koopa p5 25 25

(*ded*)
let kshell10 = make KoopaShell p10 25 25

(*ded*)
let coin2 = make Coin p2 10 20

(*ded*)
let coin1 = make Coin p1 10 20

(*1 coin*)
(*ded*)
let mario1 = make (Mario SmolMario) p1 21 37

(*1 coin*)
let mario2 = make (Mario SmolMario) p2 21 37

let mario5 = make (Mario SmolMario) p5 21 37

(*now a mario3*)
(*moving at (3., 15.)*)
(*ded, useless, should have invincibility*)
let mario6 = make (Mario SmolMario) p6 21 37

let mario7 = make (Mario SmolMario) p7 21 37

let mario8 = make (Mario SmolMario) p8 21 37

(*ded*)
let mario10 = make (Mario SmolMario) p10 21 37

(*speedy*)
(*at x = 96.*)
(*ded*)
let kshell1 = make KoopaShell p1 25 25

(*ded*)
let fire5 = make Fireball p5 14 14

(*ded*)
let mushroom9 = make (Powerup Mushroom) p9 25 25

let fireflower5 = make (Powerup FireFlower) p5 30 25

(*ded*)
let kshell7 = make KoopaShell p7 25 25

let wall = make Object { x = 45.; y = 40. } 5 20

let bullet8 = make BulletBill p8 30 20

open Input

let frame_list1 = [ { key_pressed = 'a'; mouse_down = false } ]

let frame_list2 =
  { key_pressed = char_of_int 0; mouse_down = false } :: frame_list1

let frame_list3 =
  { key_pressed = char_of_int 0; mouse_down = false } :: frame_list2

let frame_list4 =
  { key_pressed = 'b'; mouse_down = false } :: frame_list3

let frame_list5 =
  { key_pressed = 'b'; mouse_down = false } :: frame_list4

let frame_list6 =
  { key_pressed = 'b'; mouse_down = false } :: frame_list5

let frame_list7 =
  List.append
    [
      { key_pressed = char_of_int 0; mouse_down = false };
      { key_pressed = char_of_int 0; mouse_down = false };
      { key_pressed = char_of_int 0; mouse_down = true };
      { key_pressed = char_of_int 0; mouse_down = false };
      { key_pressed = char_of_int 0; mouse_down = false };
      { key_pressed = char_of_int 0; mouse_down = true };
    ]
    frame_list6

let frame_list8 =
  { key_pressed = char_of_int 0; mouse_down = false } :: frame_list7

let frame_list9 =
  [
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = true };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = true };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = char_of_int 0; mouse_down = false };
    { key_pressed = 'd'; mouse_down = false };
  ]

let frame_list10 =
  { key_pressed = char_of_int 0; mouse_down = false } :: frame_list9

let frame_list11 =
  { key_pressed = char_of_int 0; mouse_down = false } :: frame_list10

let frame_list12 =
  { key_pressed = 'd'; mouse_down = false } :: frame_list11

(******************************************************************************)

let parse_test s a b = s >:: fun _ -> assert (eq_gamestate a b)

let ded_test s f = s >:: fun _ -> assert (not (is_alive (f ())))

let alive_test s f = s >:: fun _ -> assert (is_alive (f ()))

let eq_test s f1 f2 = s >:: fun _ -> assert_equal (f1 ()) (f2 ())

let false_test s f = s >:: fun _ -> assert (not (f ()))

let tests =
  [
    parse_test "Parse from a .json" from_json
      (Parse.from_json "test.json");
    parse_test "testing gamestate equals" (Gamestate.make [])
      (Gamestate.make []);
    parse_test "Basic parsing" basic (Parse.from_json "basic.json");
    ded_test "killing sprites" (fun _ ->
        kill goomba1;
        goomba1);
    eq_test "getting coins"
      (fun _ -> 1)
      (fun _ ->
        coins
          ( got_coin mario1 coin2;
            mario1 ));
    ded_test "coins die" (fun _ -> coin2);
    eq_test "get coins collision"
      (fun _ -> 1)
      (fun _ ->
        coins
          ( Physics.test_collision mario2 coin1;
            mario2 ));
    ded_test "coins from collision die" (fun _ -> coin1);
    alive_test "no collision" (fun _ ->
        Physics.test_collision mario6 goomba5;
        goomba5);
    ded_test "jumping on goomba kills" (fun _ ->
        Physics.test_collision mario2 goomba5;
        goomba5);
    alive_test "jumping doesn't kill mario" (fun _ -> mario2);
    ded_test "koopashell fire a" (fun _ ->
        Physics.test_collision fire5 kshell7;
        fire5);
    ded_test "koopashell fire b" (fun _ -> kshell7);
    alive_test "kicking koopa" (fun _ ->
        Physics.test_collision mario8 kshell1;
        mario8);
    eq_test "Velocity of speedy shell"
      (fun _ -> 8.)
      (fun _ -> (velocity kshell1).x);
    eq_test "update position"
      (fun _ -> 60.)
      (fun _ ->
        Sprite.update_position mario6 p3;
        (position mario6).x);
    eq_test "update velocity"
      (fun _ -> 3.)
      (fun _ ->
        Sprite.update_velocity mario6 { x = 3.; y = 15. };
        (velocity mario6).x);
    eq_test "update velocity2"
      (fun _ -> 15.)
      (fun _ ->
        Sprite.update_velocity mario6 { x = 3.; y = 15. };
        (velocity mario6).y);
    eq_test "mario is a mario"
      (fun _ -> Mario SmolMario)
      (fun _ -> Sprite.spritetype mario6);
    eq_test "Powerup!"
      (fun _ -> Mario SuperMario)
      (fun _ ->
        Physics.test_collision mario6 mushroom9;
        Sprite.spritetype mario6);
    alive_test "Powerups extra life" (fun _ ->
        Sprite.kill mario6;
        mario6);
    alive_test "invulnerability" (fun _ ->
        Sprite.kill mario6;
        mario6);
    false_test "Small mario can't fire fire" (fun _ ->
        Sprite.can_fire mario6);
    ded_test "Powerups die" (fun _ -> mushroom9);
    eq_test "Fireflower powerup"
      (fun _ -> Mario FireMario)
      (fun _ ->
        Physics.test_collision mario7 fireflower5;
        Sprite.spritetype mario7);
    eq_test "kicking moves shells out of mario"
      (fun _ -> 96.)
      (fun _ -> (Sprite.position kshell1).x);
    alive_test "kicking koopa shell moves it out of marios way"
      (fun _ ->
        Physics.test_collision mario1 kshell1;
        mario1);
    ded_test "Moving koopa shells kill mario" (fun _ ->
        Physics.test_collision mario10 kshell1;
        mario10);
    ded_test "moving shell kills all1" (fun _ ->
        Physics.test_collision goomba10 kshell1;
        goomba10);
    eq_test "moving shell keeps speed"
      (fun _ -> 8.)
      (fun _ -> (Sprite.velocity kshell1).x);
    ded_test "moving shell kills all2" (fun _ ->
        Physics.test_collision koopa10 kshell1;
        koopa10);
    alive_test "moving shell invincible" (fun _ -> kshell1);
    ded_test "moving shell kills all3" (fun _ ->
        Physics.test_collision kshell10 kshell1;
        kshell10);
    ded_test "hitting other shell self destruct" (fun _ -> kshell1);
    false_test "goombas can't shoot fire" (fun _ ->
        Sprite.can_fire goomba5);
    ded_test "Bulletbill kills all1" (fun _ ->
        Physics.test_collision mario1 bullet8;
        mario1);
    eq_test "Bulletbill kills all2"
      (fun _ -> KoopaShell)
      (fun _ ->
        Physics.test_collision koopa5 bullet8;
        Sprite.spritetype koopa5);
    ded_test "bulletbill kills all3" (fun _ ->
        Physics.test_collision goomba2 bullet8;
        goomba2);
    alive_test "bullets never die" (fun _ -> bullet8);
    false_test "empty gamestate doesn't have mario" (fun _ ->
        Gamestate.has_mario (Gamestate.make []));
    ( "gamestate has mario" >:: fun _ ->
      assert (Gamestate.has_mario basic) );
    eq_test "get mario test"
      (fun _ -> make (Mario SmolMario) { x = 0.; y = 0. } 21 37)
      (fun _ -> Gamestate.get_mario basic);
    eq_test "input frame creation"
      (fun _ ->
        Input.new_frame
          {
            mouse_x = 0;
            mouse_y = 0;
            button = false;
            keypressed = true;
            key = 'a';
          })
      (fun _ -> { key_pressed = 'a'; mouse_down = false });
    eq_test "input update current key test 1"
      (fun _ -> 'a')
      (fun _ -> update_current_key frame_list1);
    eq_test "input update current key test 2"
      (fun _ -> 'a')
      (fun _ -> update_current_key frame_list2);
    eq_test "input update current key test 3"
      (fun _ -> 'a')
      (fun _ -> update_current_key frame_list3);
    eq_test "input update current key test 4"
      (fun _ -> 'b')
      (fun _ -> update_current_key frame_list4);
    eq_test "input update current key test 6"
      (fun _ -> 'b')
      (fun _ -> update_current_key frame_list6);
    eq_test "input update current key test 7"
      (fun _ -> 'b')
      (fun _ -> update_current_key frame_list7);
    eq_test "input update current key test 8"
      (fun _ -> char_of_int 0)
      (fun _ -> update_current_key frame_list8);
    eq_test "input update current key test 9"
      (fun _ -> 'd')
      (fun _ -> update_current_key frame_list9);
    eq_test "input update current key test 10"
      (fun _ -> char_of_int 0)
      (fun _ -> update_current_key frame_list10);
    eq_test "input update current key test 11"
      (fun _ -> char_of_int 0)
      (fun _ -> update_current_key frame_list11);
    eq_test "input update current key test 12"
      (fun _ -> 'd')
      (fun _ -> update_current_key frame_list12);
  ]

(**Add new test suites to the list*)
let suite = "test suite for A2" >::: List.flatten [ tests ]

let _ = run_test_tt_main suite
