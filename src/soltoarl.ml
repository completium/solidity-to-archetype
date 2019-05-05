open Transform

let process (filename, channel) =
  let ast = Solidity_parser.Io.parse_solidity ~name:filename channel in
  let pt = transform ast in
  Format.printf "%a" Archetype.Printer.pp_archetype pt

let close dispose channel =
  if dispose then close_in channel

let main () =
  let arg_list = Arg.align [] in
  let arg_usage = String.concat "\n" [
      "transform [OPTIONS] FILE";
      "";
      "Available options:";
    ]  in

  let ofilename = ref "" in
  let ochannel : in_channel option ref = ref None in
  Arg.parse arg_list (fun s -> (ofilename := s;
                                  ochannel := Some (open_in s))) arg_usage;
  let filename, channel, dispose =
    match !ochannel with
    | Some c -> (!ofilename, c, true)
    | _ -> ("<stdin>", stdin, false) in

  try
    process (filename, channel);
    close dispose channel

  with
  | Solidity_parser.Utils.ParseError exn ->
    close dispose channel;
    Format.eprintf "%a@." Solidity_parser.Utils.pp_parse_error exn;
    exit 1

let _ = main ()
