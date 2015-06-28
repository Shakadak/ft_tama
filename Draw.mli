module Button :
    sig
        val eat : Sdlvideo.surface -> (int * int) -> Sdlttf.font
        -> (Sdlvideo.color * Sdlvideo.color) -> unit
        val thunder : Sdlvideo.surface -> (int * int) -> Sdlttf.font
        -> (Sdlvideo.color * Sdlvideo.color) -> unit
        val bath : Sdlvideo.surface -> (int * int) -> Sdlttf.font
        -> (Sdlvideo.color * Sdlvideo.color) -> unit
        val kill : Sdlvideo.surface -> (int * int) -> Sdlttf.font
        -> (Sdlvideo.color * Sdlvideo.color) -> unit
    end

val background : Sdlvideo.surface -> Sdlvideo.color -> unit
(* Fill the entire surface with the color provided *)
