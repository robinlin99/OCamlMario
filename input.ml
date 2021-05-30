type input_frame = {
  key_pressed : char;
  mouse_down : bool;
}

type t = {
  current_key : char;
  raw_hist : input_frame list;
  short_hop : bool;
  full_hop : bool;
  fire : bool;
}

let new_input () =
  {
    current_key = Char.chr 0;
    raw_hist = [];
    short_hop = false;
    full_hop = false;
    fire = false;
  }

let new_frame (frame : Graphics.status) =
  { key_pressed = frame.key; mouse_down = frame.button }

let get_new_input () =
  if Graphics.key_pressed () then
    Graphics.wait_next_event [ Graphics.Key_pressed ]
  else Graphics.wait_next_event [ Graphics.Poll ]

let update_raw_hist (new_elem : input_frame) (lst : input_frame list) =
  match List.rev lst with
  | [] -> [ new_elem ]
  | h :: t ->
      if List.length lst >= 40 then new_elem :: List.rev t
      else new_elem :: lst

let rec draw_hist (lst : input_frame list) =
  match lst with
  | [] -> ()
  | h :: t ->
      Graphics.draw_char h.key_pressed;
      draw_hist t

let rec draw_mouse_input (lst : input_frame list) =
  match lst with
  | [] -> ()
  | h :: t ->
      if h.mouse_down then (
        Graphics.draw_string "Y";
        draw_mouse_input t)
      else (
        Graphics.draw_string "N";
        draw_mouse_input t)

let rec get_recent_input
    (lst : input_frame list)
    (code : int)
    (place : int) =
  if code = 0 then
    match lst with
    | [] -> (Char.chr code, place, [])
    | h :: t -> get_recent_input t (Char.code h.key_pressed) (place + 1)
  else (Char.chr code, place, lst)

let update_current_key (lst : input_frame list) =
  match get_recent_input lst 0 0 with
  | key, frames_old, newlst ->
      if newlst <> [] then
        match get_recent_input (List.tl newlst) 0 0 with
        | key2, frames_old2, flst ->
            if Char.code key = 0 || frames_old >= 16 then Char.chr 0
            else if key <> key2 || frames_old2 >= 5 then key
            else if frames_old <= 7 then key
            else Char.chr 0
      else if Char.code key = 0 || frames_old >= 16 then Char.chr 0
      else key

let fire_and_key t =
  let key = update_current_key t.raw_hist in
  if String.contains "ADWES" key then (true, Char.lowercase_ascii key)
  else (false, key)

let draw_current_key t =
  Graphics.draw_char (Char.chr 32);
  Graphics.draw_char t.current_key;
  Graphics.draw_char (Char.chr 32)

let rec jump_hold (lst : input_frame list) (length : int) =
  match lst with
  | [] -> 0
  | h :: t -> if h.mouse_down then jump_hold t (length + 1) else length

let get_short_jump (lst : input_frame list) =
  match lst with
  | [] -> false
  | h :: t ->
      (not h.mouse_down) && jump_hold t 0 > 0 && jump_hold t 0 < 6

let get_full_jump (lst : input_frame list) = jump_hold lst 0 = 6

let draw_short_jump (jump : bool) =
  Graphics.draw_string " SJ:";
  if jump then Graphics.draw_string "Yes" else Graphics.draw_string "No"

let draw_full_jump (jump : bool) =
  Graphics.draw_string " FJ:";
  if jump then Graphics.draw_string "Yes" else Graphics.draw_string "No"

let draw_fire (fire : bool) =
  Graphics.draw_string " FIRE:";
  if fire then Graphics.draw_string "Yes" else Graphics.draw_string "No"

let draw_input t =
  Graphics.moveto 0 0;
  Graphics.set_color Graphics.white;
  draw_current_key t;
  draw_hist t.raw_hist;
  draw_mouse_input t.raw_hist;
  draw_short_jump t.short_hop;
  draw_full_jump t.full_hop;
  draw_fire t.fire

let update_input t =
  let fire_and_update = fire_and_key t in
  {
    current_key = snd fire_and_update;
    raw_hist = update_raw_hist (new_frame (get_new_input ())) t.raw_hist;
    short_hop = get_short_jump t.raw_hist;
    full_hop = get_full_jump t.raw_hist;
    fire = fst fire_and_update;
  }
