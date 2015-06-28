let swap (x, y) = (y, x)

let print_action = function
    | Engine.None -> print_endline "None"
    | Engine.Eat -> print_endline "Eat"
    | Engine.Thunder -> print_endline "Thunder"
    | Engine.Bath -> print_endline "Bath"
    | Engine.Kill -> print_endline "Kill"

let rec loop screen font30 ui tama scene =
    if Engine.is_dead tama
    then Draw.game_over screen font30
    else begin
        Draw.background screen scene
        ; Draw.pet screen (fst (Engine.get_action tama (Sdltimer.get_ticks ())))
        ; Draw.Button.all ui
        ; Draw.StatBar.all screen font30 tama
    end
        ; Sdlvideo.flip screen
        ; let time = Sdltimer.get_ticks ()
        in match Event.get_action ui with
        | None -> loop screen font30 ui (Engine.update_action tama Engine.None time)
        scene
        | Some(Event.Quit) -> Engine.save tama
        | Some(Event.Press(action) | Event.Release(action)) ->
                let tama = Engine.update_action tama action time
                in let ui = List.map (fun (b, c, f, a) -> (b, (if a = action then swap c
    else c), f, a)) ui
                in loop screen font30 ui tama scene
let () =
    Sdl.init [`VIDEO]
    ; Sdlttf.init ()
    ; at_exit Sdl.quit
    ; at_exit Sdlttf.quit
    ; let screen = Sdlvideo.set_video_mode 1024 600 []
                in let font = Sdlttf.open_font "data/hacked/HACKED.ttf" 42
    in let font30 = Sdlttf.open_font "data/hacked/HACKED.ttf" 30
                in let eat = Draw.Button.eat screen font (844, 10)
    in let thunder = Draw.Button.thunder screen font (844, 70)
                in let bath = Draw.Button.bath screen font (844, 130)
    in let kill = Draw.Button.kill screen font (844, 190)
                in let ui = [(eat, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 10 149 51, Engine.Eat)
                ; (thunder, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 70 149 51, Engine.Thunder)
                ; (bath, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 130 149 51, Engine.Bath)
                ; (kill, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 190 149 51,
                Engine.Kill)]
    in let scene = Sdlloader.load_image "data/background.png"
                in let tama = Engine.load (Sdltimer.get_ticks ())
    in loop screen font30 ui tama scene
