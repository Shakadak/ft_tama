module Button =
    struct
        let w = 137 + 8 + 4
        let h = 45 + 4 + 2
        let size = (w, h)
        (** THUNDER width + inner *)

        let outer x y = Sdlvideo.rect x y w h
        let middle x y = Sdlvideo.rect (x + 1) (y + 1) (w - 2) (h - 2)
        let inner x y = Sdlvideo.rect (x + 3) (y + 3) (w - 6) (h - 6)
        let text x y tw = Sdlvideo.rect (x + (w - tw) / 2) (y + 4) 0 0

        let thunder font color = Sdlttf.render_text_solid font "THUNDER" color
    end

let background screen c = Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen c)

let button screen (x, y) label (foreground, background) =
    let (lw, _, _) = Sdlvideo.surface_dims label
    in Sdlvideo.fill_rect ~rect:(Button.outer x y) screen foreground
    ; Sdlvideo.fill_rect ~rect:(Button.middle x y) screen background
    ; Sdlvideo.fill_rect ~rect:(Button.inner x y) screen foreground
    ; Sdlvideo.blit_surface ~src:label ~dst:screen ~dst_rect:(Button.text x y lw) ()
