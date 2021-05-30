(* x and y define the bottom left corner of the hitbox*)
let draw_goomba x y =
  let rad = 10 in
  let smallrad = 5 in
  Graphics.set_color Graphics.red;
  Graphics.fill_circle (x + rad + smallrad) (y + smallrad + rad) rad;
  Graphics.set_color Graphics.black;
  Graphics.fill_circle (x + smallrad) (y + smallrad) smallrad;
  Graphics.fill_circle
    (x + smallrad + (2 * rad))
    (y + smallrad) smallrad;
  ()

let draw_object x y bw bh =
  Graphics.set_color (Graphics.rgb 150 21 16);
  Graphics.fill_rect x y bw bh;
  ()

let draw_cloud x y gamestate =
  let offset = Gamestate.camera_position gamestate in
  let x = x - offset in
  let radx = 20 in
  let rady = 12 in
  Graphics.set_color Graphics.white;
  Graphics.fill_ellipse (x - radx + 6) y radx rady;
  Graphics.fill_ellipse x (y - rady) radx rady;
  Graphics.fill_ellipse (x + 3) (y + rady + 2) radx rady;
  Graphics.fill_ellipse (x + (rady * 2)) (y - 2) radx rady;
  ()

let draw_mario_sprite x y kind =
  match kind with
  | Sprite.SmolMario ->
      Graphics.set_color Graphics.black;
      (* Left Foot *)
      Graphics.fill_rect x y 8 3;
      Graphics.fill_rect (x + 4) y 4 5;
      (* Right Foot *)
      Graphics.fill_rect (x + 8 + 5) y 8 3;
      Graphics.fill_rect (x + 8 + 5) y 4 5;
      (* Left Leg *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 2) (y + 5) 6 4;
      Graphics.fill_rect (x + 2 + 1) (y + 9) 6 2;
      Graphics.fill_rect (x + 2 + 2) (y + 9) 6 2;
      (* Right Leg *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 8 + 5) (y + 5) 6 4;
      Graphics.fill_rect (x + 8 + 5 - 1) (y + 9) 6 2;
      Graphics.fill_rect (x + 8 + 5 - 2) (y + 9) 6 2;
      (* Upper Body *)
      Graphics.set_color Graphics.black;
      Graphics.fill_rect (x + 2 + 2 - 4) (y + 8 + 9) 20 2;
      Graphics.fill_rect (x + 2 + 2 - 3) (y + 8 + 11) 18 2;
      Graphics.fill_rect (x + 2 + 2 - 2) (y + 8 + 13) 16 2;
      (* Hands *)
      Graphics.set_color (Graphics.rgb 226 148 49);
      Graphics.fill_rect (x + 2 + 2 - 4) (y + 8 + 7) 3 3;
      Graphics.fill_rect (x + 2 + 2 - 4 + 18) (y + 8 + 7) 3 3;
      (* Torso *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 2 + 2) (y + 9) 13 8;
      Graphics.fill_rect (x + 2 + 2) (y + 9 + 8) 4 2;
      Graphics.fill_rect (x + 2 + 2 + 2) (y + 9 + 8 + 2) 2 5;
      Graphics.fill_rect (x + 2 + 2 + 13 - 4) (y + 9 + 8) 4 2;
      Graphics.fill_rect (x + 2 + 2 + 13 - 4) (y + 9 + 8 + 2) 2 5;
      Graphics.set_color Graphics.yellow;
      Graphics.fill_rect (x + 2 + 4) (y + 9 + 5) 1 1;
      Graphics.fill_rect (x + 2 + 11) (y + 9 + 5) 1 1;
      (* Chin *)
      Graphics.set_color (Graphics.rgb 226 148 49);
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 7) 8 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 8) 10 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 9) 11 3;
      (* Nose *)
      Graphics.set_color (Graphics.rgb 226 148 49);
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 11) 14 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 12) 13 2;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 13) 9 2;
      (* Hat *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 15) 16 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 16) 10 2;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 18) 9 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 1) (y + 8 + 9 + 19) 8 1;
      ()
  | Sprite.FireMario ->
      Graphics.set_color Graphics.black;
      (* Left Foot *)
      Graphics.fill_rect x y 8 3;
      Graphics.fill_rect (x + 4) y 4 5;
      (* Right Foot *)
      Graphics.fill_rect (x + 8 + 5) y 8 3;
      Graphics.fill_rect (x + 8 + 5) y 4 5;
      (* Left Leg *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 2) (y + 5) 6 4;
      Graphics.fill_rect (x + 2 + 1) (y + 9) 6 2;
      Graphics.fill_rect (x + 2 + 2) (y + 9) 6 2;
      (* Right Leg *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 8 + 5) (y + 5) 6 4;
      Graphics.fill_rect (x + 8 + 5 - 1) (y + 9) 6 2;
      Graphics.fill_rect (x + 8 + 5 - 2) (y + 9) 6 2;
      (* Upper Body *)
      Graphics.set_color Graphics.white;
      Graphics.fill_rect (x + 2 + 2 - 4) (y + 8 + 9) 20 2;
      Graphics.fill_rect (x + 2 + 2 - 3) (y + 8 + 11) 18 2;
      Graphics.fill_rect (x + 2 + 2 - 2) (y + 8 + 13) 16 2;
      (* Hands *)
      Graphics.set_color (Graphics.rgb 200 145 119);
      Graphics.fill_rect (x + 2 + 2 - 4) (y + 8 + 7) 3 3;
      Graphics.fill_rect (x + 2 + 2 - 4 + 18) (y + 8 + 7) 3 3;
      (* Torso *)
      Graphics.set_color Graphics.red;
      Graphics.fill_rect (x + 2 + 2) (y + 9) 13 8;
      Graphics.fill_rect (x + 2 + 2) (y + 9 + 8) 4 2;
      Graphics.fill_rect (x + 2 + 2 + 2) (y + 9 + 8 + 2) 2 5;
      Graphics.fill_rect (x + 2 + 2 + 13 - 4) (y + 9 + 8) 4 2;
      Graphics.fill_rect (x + 2 + 2 + 13 - 4) (y + 9 + 8 + 2) 2 5;
      Graphics.set_color Graphics.yellow;
      Graphics.fill_rect (x + 2 + 4) (y + 9 + 5) 1 1;
      Graphics.fill_rect (x + 2 + 11) (y + 9 + 5) 1 1;
      (* Chin *)
      Graphics.set_color (Graphics.rgb 200 145 119);
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 7) 8 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 8) 10 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 9) 11 3;
      (* Nose *)
      Graphics.set_color (Graphics.rgb 200 145 119);
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 11) 14 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 12) 13 2;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 13) 9 2;
      (* Hat *)
      Graphics.set_color Graphics.white;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 15) 16 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 16) 10 2;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 18) 9 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 1) (y + 8 + 9 + 19) 8 1;
      ()
  | Sprite.SuperMario ->
      Graphics.set_color Graphics.black;
      (* Left Foot *)
      Graphics.fill_rect x y 8 3;
      Graphics.fill_rect (x + 4) y 4 5;
      (* Right Foot *)
      Graphics.fill_rect (x + 8 + 5) y 8 3;
      Graphics.fill_rect (x + 8 + 5) y 4 5;
      (* Left Leg *)
      Graphics.set_color Graphics.black;
      Graphics.fill_rect (x + 2) (y + 5) 6 4;
      Graphics.fill_rect (x + 2 + 1) (y + 9) 6 2;
      Graphics.fill_rect (x + 2 + 2) (y + 9) 6 2;
      (* Right Leg *)
      Graphics.set_color Graphics.black;
      Graphics.fill_rect (x + 8 + 5) (y + 5) 6 4;
      Graphics.fill_rect (x + 8 + 5 - 1) (y + 9) 6 2;
      Graphics.fill_rect (x + 8 + 5 - 2) (y + 9) 6 2;
      (* Upper Body *)
      Graphics.set_color Graphics.white;
      Graphics.fill_rect (x + 2 + 2 - 4) (y + 8 + 9) 20 2;
      Graphics.fill_rect (x + 2 + 2 - 3) (y + 8 + 11) 18 2;
      Graphics.fill_rect (x + 2 + 2 - 2) (y + 8 + 13) 16 2;
      (* Hands *)
      Graphics.set_color (Graphics.rgb 200 145 119);
      Graphics.fill_rect (x + 2 + 2 - 4) (y + 8 + 7) 3 3;
      Graphics.fill_rect (x + 2 + 2 - 4 + 18) (y + 8 + 7) 3 3;
      (* Torso *)
      Graphics.set_color Graphics.black;
      Graphics.fill_rect (x + 2 + 2) (y + 9) 13 8;
      Graphics.fill_rect (x + 2 + 2) (y + 9 + 8) 4 2;
      Graphics.fill_rect (x + 2 + 2 + 2) (y + 9 + 8 + 2) 2 5;
      Graphics.fill_rect (x + 2 + 2 + 13 - 4) (y + 9 + 8) 4 2;
      Graphics.fill_rect (x + 2 + 2 + 13 - 4) (y + 9 + 8 + 2) 2 5;
      Graphics.set_color Graphics.yellow;
      Graphics.fill_rect (x + 2 + 4) (y + 9 + 5) 1 1;
      Graphics.fill_rect (x + 2 + 11) (y + 9 + 5) 1 1;
      (* Chin *)
      Graphics.set_color (Graphics.rgb 200 145 119);
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 7) 8 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 8) 10 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 9) 11 3;
      (* Nose *)
      Graphics.set_color (Graphics.rgb 200 145 119);
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 11) 14 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 12) 13 2;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 13) 9 2;
      (* Hat *)
      Graphics.set_color Graphics.white;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 15) 16 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 3) (y + 8 + 9 + 16) 10 2;
      Graphics.fill_rect (x + 2 + 2 + 4 - 2) (y + 8 + 9 + 18) 9 1;
      Graphics.fill_rect (x + 2 + 2 + 4 - 1) (y + 8 + 9 + 19) 8 1;
      ()

let draw_fireball_sprite x y =
  let rad = 7 in
  Graphics.set_color Graphics.red;
  Graphics.fill_circle (x + rad) (y + rad) rad;
  Graphics.set_color (Graphics.rgb 242 176 45);
  Graphics.fill_circle (x + rad) (y + rad) 5;
  Graphics.set_color (Graphics.rgb 251 247 154);
  Graphics.fill_circle (x + rad) (y + rad) 3;
  ()

let draw_koopa x y =
  let rx = 5 in
  let ry = 8 in
  let h = 10 in
  let w = 5 in
  Graphics.set_color Graphics.green;
  Graphics.fill_ellipse (x + rx) (y + (2 * ry)) rx ry;
  Graphics.set_color Graphics.yellow;
  Graphics.fill_rect (x + (2 * rx)) (y + 5) w h;
  Graphics.fill_circle (x + (2 * rx)) (y + 2) 2;
  Graphics.fill_circle (x + (2 * rx) + w) (y + 2) 2;
  Graphics.fill_circle (x + (2 * rx) + (w / 2)) (y + (2 * h)) 5;
  ()

let draw_koopa_shell_sprite x y =
  let rx = 8 in
  let ry = 5 in
  let rx_small = 5 in
  let ry_small = 3 in
  Graphics.set_color Graphics.green;
  Graphics.fill_ellipse (x + rx) (y + ry + ry_small) rx ry;
  Graphics.set_color Graphics.yellow;
  Graphics.fill_ellipse (x + rx) (y + ry_small) rx_small ry_small;
  ()

let draw_coin x y =
  Graphics.set_color (Graphics.rgb 235 195 35);
  Graphics.fill_ellipse (x + 5) (y + 10) 5 10;
  ()

let draw_bulletbill x y =
  Graphics.set_color Graphics.black;
  let r = 10 in
  let w = 20 in
  Graphics.fill_circle (x + r) (y + r) r;
  Graphics.fill_rect (x + r) y w (2 * r);
  ()

let draw_fireflower x y =
  Graphics.set_color Graphics.green;
  let r = 5 in
  let w = 4 in
  let h = 15 in
  Graphics.fill_circle (x + r) (y + r) r;
  Graphics.fill_circle (x + (2 * r) + r + w) (y + r) r;
  Graphics.fill_rect (x + (2 * r)) y w h;
  Graphics.set_color Graphics.red;
  Graphics.fill_circle (x + (2 * r) + (w / 2)) (y + h) 8;
  Graphics.set_color Graphics.yellow;
  Graphics.fill_circle (x + (2 * r) + (w / 2)) (y + h) 6;
  Graphics.set_color Graphics.white;
  Graphics.fill_circle (x + (2 * r) + (w / 2)) (y + h) 4;
  ()

let draw_mushroom x y =
  Graphics.set_color Graphics.red;
  let r = 10 in
  Graphics.fill_circle (x + r) (y + r + 3) r;
  Graphics.set_color (Graphics.rgb 210 170 110);
  Graphics.fill_ellipse (x + r) (y + 5) 6 5;
  Graphics.set_color Graphics.white;
  Graphics.fill_circle (x + r) (y + r + 5) 4;
  ()

let draw_background max_width max_height =
  Graphics.set_color (Graphics.rgb 80 140 250);
  Graphics.fill_rect 0 0 max_width max_height;
  ()

let draw_a x y size =
  Graphics.fill_rect x y (1 * size) (5 * size);
  Graphics.fill_rect x (y + (2 * size)) (5 * size) (1 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (5 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (6 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (5 * size)

let draw_b x y size =
  Graphics.fill_rect x y (4 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect x (y + (3 * size)) (4 * size) (1 * size);
  Graphics.fill_rect x (y + (6 * size)) (4 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (4 * size))
    (1 * size) (2 * size)

let draw_c x y size =
  Graphics.fill_rect (x + (1 * size)) y (3 * size) (1 * size);
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (5 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (5 * size))
    (1 * size) (1 * size)

let draw_d x y size =
  Graphics.fill_rect x y (4 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect x (y + (6 * size)) (4 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (5 * size)

let draw_e x y size =
  Graphics.fill_rect x y (5 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect x (y + (6 * size)) (5 * size) (1 * size);
  Graphics.fill_rect x (y + (3 * size)) (4 * size) (1 * size)

let draw_f x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect x (y + (3 * size)) (3 * size) (1 * size);
  Graphics.fill_rect x (y + (6 * size)) (5 * size) (1 * size)

let draw_g x y size =
  Graphics.fill_rect (x + (1 * size)) y (3 * size) (1 * size);
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (5 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (4 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (3 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (2 * size)

let draw_h x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (3 * size))
    (4 * size) (1 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (7 * size)

let draw_i x y size =
  Graphics.fill_rect x y (5 * size) (1 * size);
  Graphics.fill_rect x (y + (6 * size)) (5 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (1 * size))
    (1 * size) (5 * size)

let draw_j x y size =
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (2 * size);
  Graphics.fill_rect x (y + (6 * size)) (5 * size) (1 * size);
  Graphics.fill_rect (x + (1 * size)) y (2 * size) (1 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (1 * size))
    (1 * size) (5 * size)

let draw_k x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (3 * size))
    (2 * size) (1 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (5 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect (x + (3 * size)) (y + (4 * size)) size size;
  Graphics.fill_rect (x + (3 * size)) (y + (2 * size)) size size

let draw_l x y size =
  Graphics.fill_rect x y (5 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (7 * size)

let draw_m x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (4 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (3 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (4 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (7 * size)

let draw_n x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (4 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (3 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (1 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (7 * size)

let draw_o x y size =
  Graphics.fill_rect (x + (1 * size)) y (3 * size) (1 * size);
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (5 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (5 * size)

let draw_p x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (3 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (4 * size))
    (1 * size) (2 * size)

let draw_q x y size =
  Graphics.fill_rect (x + (1 * size)) y (2 * size) (1 * size);
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (5 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (2 * size))
    (1 * size) (4 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (2 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (1 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (1 * size)

let draw_r x y size =
  Graphics.fill_rect x y (1 * size) (7 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (3 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (4 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (2 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (1 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (1 * size)

let draw_s x y size =
  Graphics.fill_rect x y (4 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (3 * size))
    (3 * size) (1 * size);
  Graphics.fill_rect x (y + (4 * size)) (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (6 * size))
    (4 * size) (1 * size)

let draw_t x y size =
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (6 * size);
  Graphics.fill_rect x (y + (6 * size)) (5 * size) (1 * size)

let draw_u x y size =
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (6 * size);
  Graphics.fill_rect (x + (1 * size)) y (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (6 * size)

let draw_v x y size =
  Graphics.fill_rect x (y + (2 * size)) (1 * size) (5 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (1 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (1 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (2 * size))
    (1 * size) (5 * size)

let draw_w x y size =
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (6 * size);
  Graphics.fill_rect (x + (1 * size)) y (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (1 * size))
    (1 * size) (3 * size);
  Graphics.fill_rect (x + (3 * size)) y (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (6 * size)

let draw_x x y size =
  Graphics.fill_rect x y (1 * size) (2 * size);
  Graphics.fill_rect x (y + (5 * size)) (1 * size) (2 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (2 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (4 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (3 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (2 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (4 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (5 * size))
    (1 * size) (2 * size);
  Graphics.fill_rect (x + (4 * size)) y (1 * size) (2 * size)

let draw_y x y size =
  Graphics.fill_rect x (y + (4 * size)) (1 * size) (3 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (3 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (3 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (3 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (4 * size))
    (1 * size) (3 * size)

let draw_z x y size =
  Graphics.fill_rect x y (5 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (1 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect x (y + (1 * size)) (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (1 * size))
    (y + (2 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (3 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (3 * size))
    (y + (4 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect
    (x + (4 * size))
    (y + (5 * size))
    (1 * size) (1 * size);
  Graphics.fill_rect x (y + (6 * size)) (5 * size) (1 * size);
  Graphics.fill_rect x (y + (5 * size)) (1 * size) (1 * size)

let draw_colon x y size =
  Graphics.fill_rect (x + size) (y + size) (2 * size) (2 * size);
  Graphics.fill_rect (x + size) (y + (4 * size)) (2 * size) (2 * size)

let rec draw_text_of_string x y text size =
  if String.length text = 1 then
    match text.[0] with
    | 'a' -> draw_a x y size
    | 'b' -> draw_b x y size
    | 'c' -> draw_c x y size
    | 'd' -> draw_d x y size
    | 'e' -> draw_e x y size
    | 'f' -> draw_f x y size
    | 'g' -> draw_g x y size
    | 'h' -> draw_h x y size
    | 'i' -> draw_i x y size
    | 'j' -> draw_j x y size
    | 'k' -> draw_k x y size
    | 'l' -> draw_l x y size
    | 'm' -> draw_m x y size
    | 'n' -> draw_n x y size
    | 'o' -> draw_o x y size
    | 'p' -> draw_p x y size
    | 'q' -> draw_q x y size
    | 'r' -> draw_r x y size
    | 's' -> draw_s x y size
    | 't' -> draw_t x y size
    | 'u' -> draw_u x y size
    | 'v' -> draw_v x y size
    | 'w' -> draw_w x y size
    | 'x' -> draw_x x y size
    | 'y' -> draw_y x y size
    | 'z' -> draw_z x y size
    | ':' -> draw_colon x y size
    | _ -> ()
  else
    let newx = x + (6 * size) in
    match text.[0] with
    | 'a' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_a x y size
    | 'b' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_b x y size
    | 'c' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_c x y size
    | 'd' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_d x y size
    | 'e' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_e x y size
    | 'f' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_f x y size
    | 'g' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_g x y size
    | 'h' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_h x y size
    | 'i' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_i x y size
    | 'j' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_j x y size
    | 'k' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_k x y size
    | 'l' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_l x y size
    | 'm' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_m x y size
    | 'n' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_n x y size
    | 'o' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_o x y size
    | 'p' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_p x y size
    | 'q' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_q x y size
    | 'r' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_r x y size
    | 's' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_s x y size
    | 't' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_t x y size
    | 'u' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_u x y size
    | 'v' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_v x y size
    | 'w' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_w x y size
    | 'x' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_x x y size
    | 'y' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_y x y size
    | 'z' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_z x y size
    | ' ' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size
    | ':' ->
        draw_text_of_string newx y
          (String.sub text 1 (String.length text - 1))
          size;
        draw_colon x y size
    | _ -> ()

let draw_one x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect (x + size) y (1 * size) (5 * size);
  Graphics.fill_rect x (y + (3 * size)) (1 * size) (1 * size)

let draw_two x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (3 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect
    (x + (2 * size))
    (y + (2 * size))
    (1 * size) (3 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_three x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (5 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_four x y size =
  Graphics.fill_rect x (y + (2 * size)) (1 * size) (3 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (5 * size)

let draw_five x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect x (y + (2 * size)) (1 * size) (2 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (2 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_six x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (5 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (2 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_seven x y size =
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (4 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_eight x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (5 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (5 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_nine x y size =
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (4 * size);
  Graphics.fill_rect x (y + (2 * size)) (3 * size) (1 * size);
  Graphics.fill_rect x (y + (2 * size)) (1 * size) (2 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let draw_zero x y size =
  Graphics.fill_rect x y (3 * size) (1 * size);
  Graphics.fill_rect x y (1 * size) (5 * size);
  Graphics.fill_rect (x + (2 * size)) y (1 * size) (5 * size);
  Graphics.fill_rect x (y + (4 * size)) (3 * size) (1 * size)

let rec draw_string_of_number x y num size =
  if String.length num = 1 then
    match num.[0] with
    | '1' -> draw_one x y size
    | '2' -> draw_two x y size
    | '3' -> draw_three x y size
    | '4' -> draw_four x y size
    | '5' -> draw_five x y size
    | '6' -> draw_six x y size
    | '7' -> draw_seven x y size
    | '8' -> draw_eight x y size
    | '9' -> draw_nine x y size
    | '0' -> draw_zero x y size
    | _ -> ()
  else
    let newx = x + (4 * size) in
    match num.[0] with
    | '1' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_one x y size
    | '2' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_two x y size
    | '3' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_three x y size
    | '4' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_four x y size
    | '5' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_five x y size
    | '6' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_six x y size
    | '7' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_seven x y size
    | '8' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_eight x y size
    | '9' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_nine x y size
    | '0' ->
        draw_string_of_number newx y
          (String.sub num 1 (String.length num - 1))
          size;
        draw_zero x y size
    | _ -> ()

let draw_sprite sprite gamestate =
  let offset = Gamestate.camera_position gamestate in
  let pos = Sprite.position sprite in
  let x = int_of_float pos.x in
  let x = x - offset in
  let y = int_of_float pos.y in
  let sz = Sprite.size sprite in
  let bw = fst sz in
  let bh = snd sz in
  match Sprite.spritetype sprite with
  | Sprite.Mario kind -> draw_mario_sprite x y kind
  | Sprite.Goomba -> draw_goomba x y
  | Sprite.Object -> draw_object x y bw bh
  | Sprite.Fireball -> draw_fireball_sprite x y
  | Sprite.Koopa -> draw_koopa x y
  | Sprite.KoopaShell -> draw_koopa_shell_sprite x y
  | Sprite.Coin -> draw_coin x y
  | Sprite.BulletBill -> draw_bulletbill x y
  | Sprite.Powerup pu -> (
      match pu with
      | Mushroom -> draw_mushroom x y
      | FireFlower -> draw_fireflower x y)

let draw_score gs =
  Graphics.set_color Graphics.black;
  Graphics.fill_rect 800 380 200 20;
  Graphics.fill_rect 48 380 125 20;
  Graphics.set_color Graphics.white;
  draw_text_of_string 802 382 "score:" 2;
  draw_text_of_string 50 382 "coins:" 2;
  draw_string_of_number 140 382
    (string_of_int (Gamestate.get_coins gs))
    3;
  draw_string_of_number 900 382
    (string_of_int (Gamestate.get_current_score gs))
    3

let draw_win_message gs =
  Graphics.set_color Graphics.black;
  draw_text_of_string 225 200 "you win" 15;
  draw_text_of_string 400 125 "mazel tov" 5;
  Graphics.set_color Graphics.green;
  draw_text_of_string 200 35 "your score:" 4;
  draw_string_of_number 475 20
    (string_of_int (Gamestate.get_current_score gs))
    15;
  Unix.sleepf 4.0

let draw_loss_message () =
  Graphics.set_color Graphics.black;
  draw_text_of_string 285 200 "you died" 10;
  draw_text_of_string 200 100 "better luck next time" 5;
  Unix.sleepf 3.5

let draw_sprites gamestate =
  let sprite_list = Gamestate.sprites gamestate in
  let rec rec_draw_sprites sprite_list =
    match sprite_list with
    | [] -> ()
    | h :: t ->
        draw_sprite h gamestate;
        rec_draw_sprites t
  in
  rec_draw_sprites sprite_list

let update_frame
    gamestate
    max_width
    margin_left
    margin_right
    screen_width =
  let curr_camera_frame = Gamestate.camera_position gamestate in
  let left_boundary = margin_left in
  let right_boundary = screen_width - margin_right in
  let mario = Gamestate.get_mario gamestate in
  let mario_pos = Sprite.position mario in
  let mario_global_pos_x = mario_pos.x in
  let mario_local_pos_x =
    int_of_float mario_pos.x - curr_camera_frame
  in
  if
    int_of_float mario_global_pos_x > max_width - margin_right
    || int_of_float mario_global_pos_x < margin_left
  then gamestate
  else if
    mario_local_pos_x > left_boundary
    && mario_local_pos_x < right_boundary
  then gamestate
  else if mario_local_pos_x <= left_boundary then
    let offset = left_boundary - mario_local_pos_x in
    Gamestate.update_camera gamestate (curr_camera_frame - offset)
  else
    let offset = mario_local_pos_x - right_boundary in
    Gamestate.update_camera gamestate (curr_camera_frame + offset)

let rec render_state gamestate max_width max_height =
  Graphics.auto_synchronize false;
  Graphics.clear_graph ();
  draw_background max_width max_height;
  draw_cloud 100 350 gamestate;
  draw_cloud 359 300 gamestate;
  draw_cloud 800 330 gamestate;
  draw_cloud 1000 230 gamestate;
  draw_sprites gamestate;
  draw_score gamestate;
  Graphics.auto_synchronize true
