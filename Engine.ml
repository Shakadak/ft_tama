(******************)
(*          types *)
(******************)

type action = None | Eat | Thunder | Bath | Kill

type millisecond = int
type percent = float

(* current action, begining of the action, last update *)
type t = ((int * int * int * int) * (action * millisecond * millisecond))



module Time = struct

    (* values in half a second *)
    let get = function
        | None      ->  infinity
        | Eat       ->  5.
        | Thunder   ->  5.
        | Bath      ->  5.
        | Kill      ->  2.

    let percent act t0 t =
        (t -. t0) *. (get act) /. 20.

end


(******************)
(*      functions *)
(******************)

let get_new time =
    ((200, 200, 200, 200), (None, time, time))



let update_action (tama:t) act t =
    let ((hea, ene, hyg, hap), (cur, t0, ti)) = tama in
    let elapsed = t - ti in
    let perct = Time.percent cur (float_of_int t0) (float_of_int t) in
    let verify (hea0, ene0, hyg0, hap0) =
        let hea1 =
            if hea0 < 0 then 0
            else if hea0 > 200 then 200
            else hea0
        in
        let ene1 =
            if ene0 < 0 then 0
            else if ene0 > 200 then 200
            else ene0
        in
        let hyg1 =
            if hyg0 < 0 then 0
            else if hyg0 > 200 then 200
            else hyg0
        in
        let hap1 =
            if hap0 < 0 then 0
            else if hap0 > 200 then 200
            else hap0
        in
        (hea1, ene1, hyg1, hap1)
    in
    let apply = function
        | None      ->  verify (hea - 1,   ene    ,    hyg    ,    hap    )
        | Eat       ->  verify (hea + 10,  ene - 4,    hyg - 8,    hap + 2)
        | Thunder   ->  verify (hea - 8,   ene + 10,   hyg,        hap - 8)
        | Bath      ->  verify (hea - 8,   ene - 4,    hyg + 10,   hap + 2)
        | Kill      ->  verify (hea - 20,  ene - 10,   hyg,        hap + 20)
    in
    let init_action () =
        (apply act, (act, t, t))
    in
    let update_action () =
        if perct >= 100. && cur <> None then
            init_action ()
        else if elapsed < 500 then
            tama
        else
            (apply cur, (cur, t0, ti + 500))
    in
    match (cur, act) with
    | (None, x) when x <> None  ->  init_action ()
    | (_, _)                    ->  update_action ()

let get_action (tama:t) time =
    let tama = update_action tama None time in
    match tama with
    | (_, (act, time0, _))    ->
            let t0 = float_of_int time0 in
            let t = float_of_int time in
            (act, Time.percent act t0 t)



let health (tama:t) =
    match tama with
    | ((health, _, _, _), _)    ->  (health:int)

let energy (tama:t) =
    match tama with
    | ((_, energy, _, _), _)    ->  (energy:int)

let hygiene (tama:t) =
    match tama with
    | ((_, _, hygiene, _), _)   ->  (hygiene:int)

let happy (tama:t) =
    match tama with
    | ((_, _, _, happy), _)     ->  (happy:int)



let is_dead (tama:t) =
    let ((hea, ene, hyg, hap), _) = tama in
    if hea <= 0 || ene <= 0 || hyg <= 0 || hap <= 0 then
        begin true end
    else
        begin false end



let save (tama:t) =
    let ((hea, ene, hyg, hap), _) = tama in
    let ofile = open_out "save.itama" in
    output_string ofile ((string_of_int hea) ^ "\n")
    ;output_string ofile ((string_of_int ene) ^ "\n")
    ;output_string ofile ((string_of_int hyg) ^ "\n")
    ;output_string ofile ((string_of_int hap) ^ "\n")
    ;output_string ofile ("END")
    ;close_out ofile

let load time =
    try begin
    let ifile = open_in "save.itama" in
    let hea = int_of_string (input_line ifile) in
    let ene = int_of_string (input_line ifile) in
    let hyg = int_of_string (input_line ifile) in
    let hap = int_of_string (input_line ifile) in
    close_in ifile
    ;let tama = ((hea, ene, hyg, hap), (None, time, time)) in
    if is_dead tama then get_new time
    else tama
    end with
    | _ ->  print_endline "Erreur: cannot load the game"
    ;get_new time
