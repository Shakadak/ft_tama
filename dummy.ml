let rec wait_for_escape () =
    match Sdlevent.wait_event () with
    | Sdlevent.KEYDOWN {Sdlevent.keysym=Sdlkey.KEY_ESCAPE} ->
            print_endline "You pressed escape! The fun is over
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
    Sdl.init [`VIDEO];
    at_exit Sdl.quit;
    ignore (Sdlvideo.set_video_mode 200 200 []);
    let a = Sdlvideo.get_video_surface ()
    in let r = Sdlvideo.rect 12 12 42 42
    in Sdlvideo.fill_rect ~rect:r a (Sdlvideo.map_RGB a Sdlvideo.red)
    ; Sdlvideo.update_rect a
    ; wait_for_escape ()

let _ = main ()
