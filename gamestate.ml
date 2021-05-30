type score = {
  frames_elapsed : int;
  enemies_killed : int;
  current_score : int;
}

type t = {
  sprites : Sprite.t list;
  camera_position : int;
  coins : int;
  score : score;
}

let sprites boi = boi.sprites

let get_current_score gs = gs.score.current_score

let get_coins gs = gs.coins

let camera_position boi = boi.camera_position

let make s =
  {
    sprites = s;
    camera_position = 0;
    coins = 0;
    score =
      {
        frames_elapsed = 0;
        enemies_killed = 0;
        current_score = 1000000;
      };
  }

let update_score gs =
  {
    gs with
    coins =
      gs.coins
      + List.length
          (List.filter
             (fun s ->
               (not (Sprite.is_alive s))
               &&
               match Sprite.spritetype s with
               | Sprite.Coin -> true
               | _ -> false)
             gs.sprites);
    score =
      {
        frames_elapsed = gs.score.frames_elapsed + 1;
        enemies_killed =
          gs.score.enemies_killed
          + List.length
              (List.filter
                 (fun s ->
                   (not (Sprite.is_alive s))
                   &&
                   match Sprite.spritetype s with
                   | Sprite.BulletBill | Sprite.Koopa | Sprite.Goomba ->
                       true
                   | _ -> false)
                 gs.sprites);
        current_score =
          1000000
          - (gs.score.frames_elapsed * 10)
          + (gs.score.enemies_killed * 5000)
          + (1000 * gs.coins);
      };
  }

let update_sprites gs sl = { gs with sprites = sl }

let update_camera gs c = { gs with camera_position = c }

let get_mario gs =
  List.find
    (fun s ->
      match Sprite.spritetype s with Mario _ -> true | _ -> false)
    gs.sprites

let has_mario gs =
  List.exists
    (fun s ->
      match Sprite.spritetype s with Mario _ -> true | _ -> false)
    gs.sprites
