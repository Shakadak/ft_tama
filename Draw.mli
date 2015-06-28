module Button :
    sig
        type button = Sdlvideo.surface -> Sdlttf.font -> (int * int)
        -> (Sdlvideo.color * Sdlvideo.color) -> unit
        val eat : button
        val thunder : button
        val bath : button
        val kill : button
        val all : (('a -> unit) * 'a * 'b * 'c) list -> unit
    end

module StatBar :
    sig
        type stat = Health | Energy | Hygiene | Happy
        val draw : Sdlvideo.surface -> Sdlttf.font -> stat -> int -> unit
        val all : Sdlvideo.surface -> Sdlttf.font -> Engine.t -> unit
    end

val background : Sdlvideo.surface -> Sdlvideo.surface -> unit
(* Fill the entire surface with the surface provided *)

val pet : Sdlvideo.surface -> Engine.action -> unit
