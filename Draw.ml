module Button =
    struct
        type button = Sdlvideo.surface -> Sdlttf.font -> (int * int)
        -> (Sdlvideo.color * Sdlvideo.color) -> unit

        let w = 137 + 8 + 4
        let h = 45 + 4 + 2
        let size = (w, h)
        (** THUNDER width + inner *)

        let outer x y = Sdlvideo.rect x y w h
        let middle x y = Sdlvideo.rect (x + 1) (y + 1) (w - 2) (h - 2)
        let inner x y = Sdlvideo.rect (x + 3) (y + 3) (w - 6) (h - 6)
        let text x y tw = Sdlvideo.rect (x + (w - tw) / 2) (y + 4) 0 0

        let draw screen (x, y) label colors =
            let (lw, _, _) = Sdlvideo.surface_dims label
            in let foreground = Sdlvideo.map_RGB screen (fst colors)
            in let background = Sdlvideo.map_RGB screen (snd colors)
            in Sdlvideo.fill_rect ~rect:(outer x y) screen background
            ; Sdlvideo.fill_rect ~rect:(middle x y) screen foreground
            ; Sdlvideo.fill_rect ~rect:(inner x y) screen background
            ; Sdlvideo.blit_surface ~src:label ~dst:screen ~dst_rect:(text x y lw) ()

        let eat screen font coordinate colors =
            let label = Sdlttf.render_text_solid font "EAT" (fst colors)
            in draw screen coordinate label colors

        let thunder screen font coordinate colors =
            let label = Sdlttf.render_text_solid font "THUNDER" (fst colors)
            in draw screen coordinate label colors

        let bath screen font coordinate colors =
            let label = Sdlttf.render_text_solid font "BATH" (fst colors)
            in draw screen coordinate label colors

        let kill screen font coordinate colors =
            let label = Sdlttf.render_text_solid font "KILL" (fst colors)
            in draw screen coordinate label colors

        let all buttons = List.iter
        (fun (button, colors, field, action) ->
            button colors)
        buttons
    end

module StatBar =
    struct
        type stat = Health | Energy | Hygiene | Happy

        (*let font = Sdlttf.open_font "hacked/HACKED.ttf" 42*)

        let draw screen font st value =
            let (x, y, label) =
                match st with
                | Health    ->  (20, 100, "Health")
                | Energy    ->  (20, 250, "Energy")
                | Hygiene   ->  (20, 400, "Hygiene")
                | Happy     ->  (20, 550, "Happy")
            in
            let border_color = Sdlvideo.map_RGB screen (0, 0, 0) in
            let rec draw_bar i =
                let hei =
                    let x_func = ((float_of_int i) /. 100.) -. 2. in
                    int_of_float ((exp x_func) *. 30.)
                in
                let exp_interpolate src aim factor =
                    let s = float_of_int src in
                    let a = float_of_int aim in
                    let f = ((10. ** factor) -. 1.) /. (10. -. 1.) in
                    int_of_float ((a -. s) *. f +. s)
                in
                let log_interpolate src aim factor =
                    let s = float_of_int src in
                    let a = float_of_int aim in
                    let f = log10 (  (factor *. (10. -. 1.)) +. 1.  ) in
                    int_of_float ((a -. s) *. f +. s)
                in
                let line = Sdlvideo.rect (x + i) (y - hei) 1 hei in
                let factor = (float_of_int i) /. 200. in
                let bar_color = Sdlvideo.map_RGB screen (
                        (exp_interpolate 255 0 factor),
                        (log_interpolate 0 255 factor),
                        (exp_interpolate 0 100 factor))
                in
                if i < 200 then
                    begin
                        if i < value then
                            Sdlvideo.fill_rect ~rect:line screen bar_color
                        ;Sdlvideo.put_pixel screen (x + i) y border_color
                        ;Sdlvideo.put_pixel screen (x + i) (y - hei - 1)
                                                                    border_color
                        ;draw_bar (i + 1)
                    end
            in
            let small_border = Sdlvideo.rect (x - 1) (y - 5) 1 6 in
            let big_border = Sdlvideo.rect (x + 200) (y - 30) 1 31 in
            let lbl_video = Sdlttf.render_text_solid font label (0, 0, 0) in
            draw_bar 0
            ;Sdlvideo.blit_surface ~src:lbl_video ~dst:screen
                    ~dst_rect:(Sdlvideo.rect (x - 10) (y - 50) 0 0) ()
            ;Sdlvideo.fill_rect ~rect:small_border screen border_color
            ;Sdlvideo.fill_rect ~rect:big_border screen border_color

        let all screen font30 tama =
            draw screen font30 Health (Engine.health tama)
            ; draw screen font30 Energy (Engine.energy tama)
            ; draw screen font30 Hygiene (Engine.hygiene tama)
            ; draw screen font30 Happy (Engine.happy tama)
    end

module Pet =
    struct
        let thunder = Sdlloader.load_image "data/Thunder.png"
        let kill = Sdlloader.load_image "data/Kill.png"
        let eat = Sdlloader.load_image "data/Eat.png"
        let bath = Sdlloader.load_image "data/Bath.png"
        let none = Sdlloader.load_image "data/None.png"
    end

let background screen scene = Sdlvideo.blit_surface scene screen ()

let get_pos screen pet =
    let (ws, hs, _) = Sdlvideo.surface_dims screen
    in let (wp, hp, _) = Sdlvideo.surface_dims pet
    in Sdlvideo.rect ((ws - wp) / 2) ((hs - hp) / 2) 0 0

let pet screen = function
    | Engine.Thunder    ->
            Sdlvideo.blit_surface ~src:Pet.thunder ~dst:screen
    ~dst_rect:(get_pos screen Pet.thunder) ()
    | Engine.Eat        -> Sdlvideo.blit_surface ~src:Pet.eat ~dst:screen
    ~dst_rect:(get_pos screen Pet.eat) ()
    | Engine.Kill       -> Sdlvideo.blit_surface ~src:Pet.kill ~dst:screen
    ~dst_rect:(get_pos screen Pet.eat) ()
    | Engine.Bath       -> Sdlvideo.blit_surface ~src:Pet.bath ~dst:screen
    ~dst_rect:(get_pos screen Pet.bath) ()
    | _                 -> Sdlvideo.blit_surface ~src:Pet.none ~dst:screen
    ~dst_rect:(get_pos screen Pet.none) ()

let game_over screen font =
    let (w, h, _) = Sdlvideo.surface_dims screen
    in let rect = Sdlvideo.rect 0 0 w h
    in let text = Sdlttf.render_text_solid font "GAME OVER" Sdlvideo.white
    in Sdlvideo.fill_rect ~rect:rect screen (Sdlvideo.map_RGB screen Sdlvideo.black)
    ; Sdlvideo.blit_surface ~src:text ~dst:screen ~dst_rect:(get_pos screen
    text) ()
