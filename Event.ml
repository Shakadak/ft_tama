let check_button (x, y) range =
    let r_x = range.Sdlvideo.r_x
    in let r_y = range.Sdlvideo.r_x
    in r_x <= x && x <= r_x + range.Sdlvideo.r_w
    && r_y <= y && y <= r_y + range.Sdlvideo.r_h
