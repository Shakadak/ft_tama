let rec wait_for_escape () =
    match Sdlevent.wait_event () with
    | Sdlevent.KEYDOWN {Sdlevent.keysym=Sdlkey.KEY_ESCAPE} ->
            print_endline "You pressed escape! The fun is over \
            now."
    | Sdlevent.MOUSEBUTTONUP ({Sdlevent.mbe_state=Sdlevent.RELEASED} as click) ->
            string_of_int click.Sdlevent.mbe_x ^ " "
            ^ string_of_int click.Sdlevent.mbe_y
            |> print_endline
            ; wait_for_escape ()
    | event ->
            print_endline (Sdlevent.string_of_event
            event)
            ; wait_for_escape ()

let main () =
    Sdl.init [`VIDEO]
    ; Sdlttf.init ()
    ; at_exit Sdl.quit
    ; ignore (Sdlvideo.set_video_mode 1440 690 [])
    ; let a = Sdlvideo.get_video_surface ()
    in let r = Sdlvideo.rect 12 12 42 42
    in Sdlvideo.fill_rect ~rect:r a (Sdlvideo.map_RGB a Sdlvideo.red)
    ; Draw.background a Sdlvideo.blue
    ; let font = Sdlttf.open_font "hacked/HACKED.ttf" 42
    in let (w, h) = Sdlttf.size_text font "THUNDER"
    in print_int w ; print_char ' ' ; print_int h ; print_endline " w, h"
    ; Draw.Button.eat a (10, 10) font (Sdlvideo.white, Sdlvideo.black)
    ; Draw.Button.thunder a (60, 60) font (Sdlvideo.white, Sdlvideo.black)
    ; Draw.Button.bath a (110, 110) font (Sdlvideo.white, Sdlvideo.black)
    ; Draw.Button.kill a (160, 160) font (Sdlvideo.black, Sdlvideo.white)
    ; Sdlvideo.update_rect a
    ; wait_for_escape ()
    ; Sdlttf.quit ()

let _ = main ()
