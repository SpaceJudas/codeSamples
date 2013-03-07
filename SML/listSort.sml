fun sel_sort _ [] = []
|   sel_sort comp (first::tl) =
    let
      fun minFinder min ([], ys) = min::(sel_sort comp ys)
      |   minFinder min (x::xs, ys) = 
            if (comp x min<0) then minFinder x (xs, min::ys)
            else minFinder min (xs, x::ys)
    in
      minFinder first (tl, [])
    end;

fun merge_sort _ [] = []
|     merge_sort comp (startHd::startTl) = 
      let fun splitSingles (comp, []) = []
      	  |     splitSingles (comp, (x::xs)) = [x]::splitSingles (comp, xs)
	   in
		let 
	    	fun merge (_, ([], ys)) = ys
	    	|     merge (_,(xs, [])) = xs
	    	|     merge (comp,(x::xs, y::ys)) = 
	    	      if (comp x y<0) then x::merge (comp,(xs, y::ys))
      	       	      else y::merge (comp,(x::xs, ys));
		in
			let
			fun mergeLevel (_, []) = []
			|     mergeLevel (_, [x::y]) = [x::y]
			|     mergeLevel (comp, (x1::x2::xs)) = (merge (comp,(x1,x2)))::(mergeLevel (comp, (xs)))
			in
				let
				fun recurseSort (comp,[hd::tl]) = hd::tl
				|     recurseSort (comp,hd::tl) = recurseSort (comp, mergeLevel (comp, hd::tl))
				in
					recurseSort (comp,(startHd::startTl))
				end
			end
		end
	end;
