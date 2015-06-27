(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Engine.mli                                         :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: fdaudre- <fdaudre-@student.42.fr>          +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/06/27 15:20:09 by fdaudre-          #+#    #+#             *)
(*   Updated: 2015/06/27 15:30:41 by fdaudre-         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t

type action     = Eat | Thunder | Bath | Kill


val set_action  :   t -> action -> t

val get_action  :   t -> action

val health      :   t -> int
val energy      :   t -> int
val hygiene     :   t -> int
val happy       :   t -> int
