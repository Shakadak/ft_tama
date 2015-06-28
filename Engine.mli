type t
type action         =   None | Eat | Thunder | Bath | Kill
type millisecond    =   int
type percent        =   float


val get_new         :   millisecond -> t

val update_action   :   t -> action -> millisecond -> t
val get_action      :   t -> millisecond -> (action * percent)

val health          :   t -> int
val energy          :   t -> int
val hygiene         :   t -> int
val happy           :   t -> int

val is_dead         :   t -> bool

val save            :   t -> unit
val load            :   millisecond -> t
