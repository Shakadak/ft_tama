let background s c = Sdlvideo.fill_rect s (Sdlvideo.map_RGB s c)

let button s r l a =
    let f = Sdlvideo.map_RGB s (if a then Sdlvideo.black else Sdlvideo.white)
    in let b = Sdlvideo.map_RGB s (if not a then Sdlvideo.black else Sdlvideo.white)
    in let outer = Sdlvideo.rect (r.Sdlvideo.r_x - 2) (r.Sdlvideo.r_y - 2) (r.Sdlvideo.r_w + 4) (r.Sdlvideo.r_h + 4)
    in let inner = Sdlvideo.rect (r.Sdlvideo.r_x - 1) (r.Sdlvideo.r_y - 1) (r.Sdlvideo.r_w + 2) (r.Sdlvideo.r_h + 2)
    in Sdlvideo.fill_rect ~rect:outer s f
    ; Sdlvideo.fill_rect ~rect:inner s b
    ; Sdlvideo.fill_rect ~rect:r s f
