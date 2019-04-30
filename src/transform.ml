open ArchetypeLib
open Location

let transform (_ast : SolidityLib.Ast) : ArchetypeLib.ParseTree =
  dumloc (Marchetype
     [dumloc (Darchetype (dumloc "hello", None))(*;
      dumloc (Dvariable (name, (Tref string), None, None, false, None));
      dumloc (Daction (dumloc "main", [(dumloc "str", (Some (Tref (dumloc "string"))), None)],
                       { verif = None; calledby = None; condition = None; functions = [] },
                       (Some ((Eassign (SimpleAssign, (Eterm (None, name)),
                                        (Eterm (None, str)))),
                              None)),
                                                  None))*)
     ])

