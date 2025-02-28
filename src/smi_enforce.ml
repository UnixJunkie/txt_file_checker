(* enforce proper SMILES format *)

module LO = Line_oriented
module Log = Dolog.Log
module S = BatString

let input_fn = Sys.argv.(1)

let main () =
  Log.color_on ();
  Log.(set_log_level INFO);
  LO.iteri input_fn (fun i line ->
      try
        let smi, name = Scanf.sscanf line "%s@\t%s" (fun x y -> x, y) in
        assert(S.length smi > 0 &&
               S.length name > 0 &&
               S.count_char line '\t' == 1)
      with exn ->
        let () = Log.error "line %d incorrect: %s" i line in
        raise exn
    )

let () = main ()
