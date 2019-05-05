open Archetype
open ParseTree
open Solidity_parser
open Ast
open Location

exception Anomaly of string

let transform ast : archetype =
  let dumlocA = Archetype.Location.dumloc in

  let extract_contract ast =
    (match unloc ast with
     | Solidity decls -> (
         List.fold_right (fun x accu ->
             let a = unloc x in
             match a with
             | Dcontract (t, _, _, _) when (match t with | CTcontract -> true | _ -> false) -> a::accu
             | _ -> accu
           ) decls [])) in

  let extract_action c : (string * 'a) =
    match c with
    | Dcontract (_, id, _, l) ->(
        let build_action cp =
          match cp with
          | CPfunction (Some id, _, ms, _, _) when (List.fold_left (fun acc i -> match i with | Mpublic -> true | _ -> acc || false) false ms) ->
            let fun_id : string = Solidity_parser.Location.unloc id in
            let dummy_action_properties : action_properties = {
              verif      = None;
              calledby   = None;
              condition  = None;
              functions  = [];
            } in
            let effect = dumlocA Ebreak in
            [(dumlocA (Daction (dumlocA fun_id, [], dummy_action_properties, Some (effect, None), None)))]
          | _ -> [] in
        (unloc id, List.fold_right (fun (x : contract_part) accu -> (build_action x) @ accu) l []))
    | _ -> raise (Anomaly "") in

  let contracts = extract_contract ast in
  let id, funs = (match contracts with
      | a::_ -> extract_action a
      | _ -> raise (Anomaly "Not enough contract")) in

  let archetype_decl : declaration = dumlocA (Darchetype (dumlocA id, None)) in

  (dumlocA (Marchetype ([archetype_decl] @ funs)))
