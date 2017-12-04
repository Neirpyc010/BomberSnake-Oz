local
   DecodeStrategy
   Next
   DecodeRepeat
in
   %Fake fct Next
   fun{Next Snake X}
      Snake|X|nil
   end

   fun{DecodeStrategy Strategy}
      case Strategy of H|T then
	 if H== forward orelse H==turn(left) orelse H==turn(right) then
	    fun{$ Snake} {Next Snake H}end|{DecodeStrategy T}
	    else nil
%	 else
%	    {DecodeRepeat H}|{DecodeStrategy T}
	 end
      []nil then nil
      end
   end

   %Procedure qui decode les instructions de type : repeat([turn(right)] times:2)
  % fun{DecodeRepeat X}
    %  local Times in
%	 Times = X.times
%	 fun{DecodeReat2 X T}
%	    case X.1 of H|T andthen T\=0 then
%	       {DecodeStrategy X.1}
%	    []nil then nil
%	    end
%     end
%   end

%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   {Browse {{DecodeStrategy [forward forward turn(right) turn(left)]}.2.2.1 'Snake'}}
 %  {Browse {{DecodeStrategy [repeat([turn(right)] times:2) turn(left)]}.2.1 'Snake'}}
	    
end

