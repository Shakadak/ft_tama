type t

type action     = Eat | Thunder | Bath | Kill


val set_action  :   t -> action -> t

val get_action  :   t -> action

val health      :   t -> int
val energy      :   t -> int
val hygiene     :   t -> int
val happy       :   t -> int
