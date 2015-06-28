let check_button (x, y) range =
    let r_x = range.Sdlvideo.r_x
    in let r_y = range.Sdlvideo.r_x
    in r_x <= x && x <= r_x + range.Sdlvideo.r_w
    && r_y <= y && y <= r_y + range.Sdlvideo.r_h

let rec loop tama ui =
    match Sdlevent.poll () with
    | Some(Sdlevent.QUIT)
    | Some(Sdlevent.KEYDOWN {Sdlevent.keysym=Sdlkey.KEY_ESCAPE}) ->
            ()
    | Some(Sdlevent.MOUSEBUTTONUP
    {Sdlevent.mbe_state=Sdlevent.RELEASED}) ->
            ()
    | Some(Sdlevent.MOUSEBUTTONDOWN
    {Sdlevent.mbe_state=Sdlevent.PRESSED
    ; Sdlevent.mbe_x=_ as x
    ; Sdlevent.mbe_y=_ as y}) ->
            string_of_int x |> print_endline
            ; string_of_int y |> print_endline
            ; loop tama ui
    | _ -> loop tama ui
