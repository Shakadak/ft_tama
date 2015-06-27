val background : Sdlvideo.surface -> Sdlvideo.color -> unit
(* Fill the entire surface with the color provided *)

val button : Sdlvideo.surface -> Sdlvideo.rect -> string -> bool -> unit
(* Draw a button of size rect, containing the string passed.
 * The last parameter determine wether the button is activated or not. *)
