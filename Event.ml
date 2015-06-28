type action = Press of Engine.action | Release of Engine.action | Quit

let check_button (x, y) range =
    let r_x = range.Sdlvideo.r_x
    in let r_y = range.Sdlvideo.r_x
    in r_x <= x && x <= r_x + range.Sdlvideo.r_w
    && r_y <= y && y <= r_y + range.Sdlvideo.r_h

let retrieve_button coord buttons =
    List.fold_left
    (fun acc (rect, action) ->
        if check_button coord rect
        then action
        else acc) Engine.None buttons

let get_action buttons =
    match Sdlevent.poll () with
    | Some(Sdlevent.QUIT)
    | Some(Sdlevent.KEYDOWN {Sdlevent.keysym=Sdlkey.KEY_ESCAPE}) ->
            Some(Quit)
    | Some(Sdlevent.MOUSEBUTTONUP
    {Sdlevent.mbe_state=Sdlevent.RELEASED
    ; Sdlevent.mbe_x=_ as x
    ; Sdlevent.mbe_y=_ as y}) ->
            Some(Release(retrieve_button (x, y) buttons))
    | Some(Sdlevent.MOUSEBUTTONDOWN
    {Sdlevent.mbe_state=Sdlevent.PRESSED
    ; Sdlevent.mbe_x=_ as x
    ; Sdlevent.mbe_y=_ as y}) ->
            Some(Press(retrieve_button (x, y) buttons))
    | _ -> None
