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
    end

let background screen c = Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen c)
