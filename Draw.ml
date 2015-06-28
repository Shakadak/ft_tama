module Shape =
    struct
        let button = (137 + 8 + 4, 45 + 4 + 2)
        (* THUNDER width + inner +*)
    end

let background screen c = Sdlvideo.fill_rect screen (Sdlvideo.map_RGB screen c)

let button screen (x, y) label (foreground, background) =
    let (w, h) = Shape.button
    in let outer = Sdlvideo.rect x y (w) (h)
    in let middle = Sdlvideo.rect (x + 1) (y + 1) (w - 2) (h - 2)
    in let inner = Sdlvideo.rect (x + 3) (y + 3) (w - 6) (h - 6)
    in let (lw, _, _) = Sdlvideo.surface_dims label
    in let text = Sdlvideo.rect (x + (w - lw) / 2) (y + 4) 0 0
    in Sdlvideo.fill_rect ~rect:outer screen foreground
    ; Sdlvideo.fill_rect ~rect:middle screen background
    ; Sdlvideo.fill_rect ~rect:inner screen foreground
    ; Sdlvideo.blit_surface ~src:label ~dst:screen ~dst_rect:text ()
