let loop buttons ui tama =
    let time = Sdltimer.get_ticks
    in 

let () =
    Sdl.init [`VIDEO]
    ; Sdlttf.init ()
    ; at_exit Sdl.quit
    ; at_exit Sdlttf.quit
    ; let screen = Sdlvideo.set_video_mode 1440 690 []
    in let font = Sdlttf.open_font "hacked/HACKED.ttf" 42
    in let eat = Draw.Button.eat a font (1260, 10)
    in let thunder = Draw.Button.thunder a font (1260, 70)
    in let bath = Draw.Button.bath a font (1260, 130)
    in let kill = Draw.Button.kill a font (1260, 190)
    in let ui = [(eat, (Sdlvideo.white, Sdlvideo.black))
    ; (thunder, (Sdlvideo.white, Sdlvideo.black))
    ; (bath, (Sdlvideo.white, Sdlvideo.black))
    ; (kill, (Sdlvideo.white, Sdlvideo.black))]
    in let buttons = [(Sdlvideo.rect 1260 10 149 51, Engine.Eat)
    ; (Sdlvideo.rect 1260 70 149 51, Engine.Thunder)
    ; (Sdlvideo.rect 1260 130 149 51, Engine.Bath)
    ; (Sdlvideo.rect 1260 190 149 51, Engine.Kill)
    in let tama = Engine.load ()
    in loop buttons ui tama
