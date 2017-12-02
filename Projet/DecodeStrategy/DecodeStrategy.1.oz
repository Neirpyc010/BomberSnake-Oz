local
   %Variables
   DecodeStrategy
   ApplyInstruction
   Next
   DecodeRepeat
   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:nil)
in
   proc{Next Snake I}
      {Browse Snake}
      {Browse I}
   end

   fun{DecodeRepeat X}
      X
   end
   proc{ApplyInstruction L Next}
      case L of nil then skip
      [] H|T then
	 {Next Snake H}
	 {ApplyInstruction T Next}
      end
   end
   
%   fun{DecodeStrategy Strategy}
 %     case Strategy of
%	 H|T then case H of repeat(X) then {DecodeRepeat H} else {ApplyInstruction H Next}
%		  end
 %     end
  %    
  % end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   %Test de la fonction ApplyInstruction
   {ApplyInstruction [turn(right) turn(right) turn(right) forward] Next} 
end
