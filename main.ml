let basic_gamestate =
  let filename = "demo.json" in
  Parse.from_json filename

let rec find_furthest_x sprite_lst x =
  match sprite_lst with
  | [] -> x
  | h :: t ->
      let newx =
        Float.to_int (Sprite.position h).x + fst (Sprite.size h)
      in
      if newx > x then find_furthest_x t newx else find_furthest_x t x

(*integer constants*)
let max_width = find_furthest_x (Gamestate.sprites basic_gamestate) 0

let max_height = 400

let margin_left = 150

let margin_right = 600

let screen_width = 1000

(*cleans up the sprite list, removing any dead sprites*)
let sprite_cleanup gs =
  (*kill any sprites below the screen*)
  let updated =
    List.map
      (fun s ->
        if (Sprite.position s).y < 0.0 then Sprite.kill s;
        s)
      (Gamestate.sprites gs)
  in
  Gamestate.update_sprites gs (List.filter Sprite.is_alive updated)

(*Check if win/lose conditions have been met*)
let check_win gs =
  if not (Gamestate.has_mario gs) then (
    Display.draw_loss_message ();
    false)
  else if not (Sprite.is_alive (Gamestate.get_mario gs)) then (
    Display.draw_loss_message ();
    false)
  else if
    (Sprite.position (Gamestate.get_mario gs)).x
    > Float.of_int (max_width - 50)
  then (
    Display.draw_win_message gs;
    false)
  else true

(*Spawns a fireball if conditions have been met*)
let fireball_spawner state (i : Input.t) =
  if Gamestate.has_mario state then
    let mario = Gamestate.get_mario state in
    if i.fire = true && Sprite.can_fire mario then (
      let fire =
        Sprite.make Fireball
          {
            x = (Sprite.position mario).x +. 25.;
            y = (Sprite.position mario).y +. 20.;
          }
          14 14
      in
      Sprite.update_velocity fire { x = 7.; y = 0. };
      Sprite.fire mario;
      let sprites = Gamestate.sprites state in
      Gamestate.update_sprites state (sprites @ [ fire ]))
    else state
  else state

let rec gameloop gs i =
  let newi = Input.update_input i in
  let physics_done = Physics.calculate_physics newi gs in
  let camera_done =
    Gamestate.update_score
      (Display.update_frame physics_done max_width margin_left
         margin_right screen_width)
  in
  Display.render_state camera_done max_width max_height;
  let cleanup_done = sprite_cleanup camera_done in
  let continue = check_win camera_done in
  List.iter Sprite.tick_timers (Gamestate.sprites cleanup_done);
  let spawn_fireball = fireball_spawner cleanup_done newi in
  Unix.sleepf 0.016;
  match (continue, newi.current_key) with
  | _, 'q' -> ()
  | false, _ -> ()
  | _ -> gameloop spawn_fireball newi

let main () =
  Graphics.open_graph " 1000x400";
  gameloop basic_gamestate (Input.new_input ())

let () = main ()
