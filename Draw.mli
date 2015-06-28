module Button :
    sig
        type button = Sdlvideo.surface -> Sdlttf.font -> (int * int)
        -> (Sdlvideo.color * Sdlvideo.color) -> unit
        val eat : button
        val thunder : button
        val bath : button
        val kill : button
    end

val background : Sdlvideo.surface -> Sdlvideo.color -> unit
(* Fill the entire surface with the color provided *)
