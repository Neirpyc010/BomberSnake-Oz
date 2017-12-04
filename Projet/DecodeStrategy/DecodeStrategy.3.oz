local
   DecodeStrategy
   Next
   DecodeRepeat
   MultList
   FlattenList
in
   %Fake fct Next
   fun{Next Snake X}
      Snake|X|nil
   end

   fun {FlattenList L}
      case L of nil then nil
      [] nil|T then {FlattenList T}
      [] (H1|T1)|T then {FlattenList H1|T1|T}
      [] X|T then X | {FlattenList T}
      end
   end
   
   fun{DecodeStrategy Strategy}
      case Strategy of H|T then
	 if H== forward orelse H==turn(left) orelse H==turn(right) then
	    fun{$ Snake} {Next Snake H}end|{DecodeStrategy T}
	 else
	    {DecodeRepeat H}|{DecodeStrategy T}
	 end
      []nil then nil
      end
   end

   %Procedure qui decode les instructions de type : repeat([turn(right)] times:2)
   fun{DecodeRepeat X}
      local Times L in
	 Times = X.times
	 L = {DecodeStrategy X.1}
	 {MultList L Times}
      end
   end

   %Fonction qui renvoie une liste composée de Times fois la liste L
   fun{MultList L Times}
      if Times == 1 then nil
      else L|{MultList L Times-1}
      end
   end
%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   {Browse {{FlattenList{DecodeStrategy [forward forward turn(right) turn(left)]}}.2.2.1 'Snake'}}
   {Browse {{FlattenList{DecodeStrategy [repeat([turn(right)] times:2) turn(left)]}}.1 'Snake'}}
	    
end

