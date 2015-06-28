type action = Press of Engine.action | Release of Engine.action | Quit

val check_button : (int * int) -> Sdlvideo.rect -> bool

val get_action : (Sdlvideo.rect * Engine.action) list -> action option
