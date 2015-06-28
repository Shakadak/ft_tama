let swap (x, y) = (y, x)

let print_action = function
    | Engine.None -> print_endline "None"
    | Engine.Eat -> print_endline "Eat"
    | Engine.Thunder -> print_endline "Thunder"
    | Engine.Bath -> print_endline "Bath"
    | Engine.Kill -> print_endline "Kill"

let rec loop screen font30 ui tama =
    Draw.background screen (244, 244, 230)
    ; List.iter (fun (button, colors, field, action) -> button colors) ui
    ; Draw.StatBar.draw screen font30 Draw.StatBar.Health (Engine.health tama)
    ; Draw.StatBar.draw screen font30 Draw.StatBar.Energy (Engine.energy tama)
    ; Draw.StatBar.draw screen font30 Draw.StatBar.Hygiene (Engine.hygiene tama)
    ; Draw.StatBar.draw screen font30 Draw.StatBar.Happy (Engine.happy tama)
    ; Sdlvideo.flip screen
    ; let time = Sdltimer.get_ticks ()
    in match Event.get_action ui with
    | None -> loop screen font30 ui (Engine.update_action tama Engine.None time)
    | Some(Event.Quit) -> Engine.save tama
    | Some(Event.Press(action) | Event.Release(action)) -> let tama = Engine.update_action tama action time
        in let ui = List.map (fun (b, c, f, a) -> (b, (if a = action then swap c
        else c), f, a)) ui
        in loop screen font30 ui tama

let () =
    Sdl.init [`VIDEO]
    ; Sdlttf.init ()
    ; at_exit Sdl.quit
    ; at_exit Sdlttf.quit
    ; let screen = Sdlvideo.set_video_mode 1024 600 []
    in let font = Sdlttf.open_font "hacked/HACKED.ttf" 42
    in let font30 = Sdlttf.open_font "hacked/HACKED.ttf" 30
    in let eat = Draw.Button.eat screen font (844, 10)
    in let thunder = Draw.Button.thunder screen font (844, 70)
    in let bath = Draw.Button.bath screen font (844, 130)
    in let kill = Draw.Button.kill screen font (844, 190)
    in let ui = [(eat, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 10 149 51, Engine.Eat)
    ; (thunder, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 70 149 51, Engine.Thunder)
    ; (bath, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 130 149 51, Engine.Bath)
    ; (kill, (Sdlvideo.white, Sdlvideo.black), Sdlvideo.rect 844 190 149 51,
    Engine.Kill)]
    in let tama = Engine.load (Sdltimer.get_ticks ())
    in loop screen font30 ui tama
