(**Module to handle and interpret keyboard and mouse input from graphics
   package*)

(**A record type of the input that the graphics package gave on a frame
   with the relevant information*)
type input_frame = {
  key_pressed : char;
  mouse_down : bool;
}

(** A type that defines the input status record*)
type t = {
  current_key : char;
  raw_hist : input_frame list;
  short_hop : bool;
  full_hop : bool;
  fire : bool;
}

(** [new_frame status] returns a input frame with the information from
    [status] *)
val new_frame : Graphics.status -> input_frame

(** Finds the appropriate character to be shown as input from a history
    of input frames represented as a list*)
val update_current_key : input_frame list -> char

(** [draw_input t] draws the contents of input [t] on the display (for
    debug purposes)*)
val draw_input : t -> unit

(** [new_input ()] returns a new input status record (to be passed into
    update input at the start of the game loop)*)
val new_input : unit -> t

(** [update_input t] takes an input status record [t] and updates it
    with current frame information*)
val update_input : t -> t
