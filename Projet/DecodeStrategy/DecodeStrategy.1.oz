local
   %Variables
   DecodeStrategy
   ApplyInstruction
   Next
   DecodeRepeat
   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:nil)
in
   fun{Next}
      {Browse $}
   end

   fun{DecodeRepeat X}
      
   proc{ApplyInstruction L Next}
      case L of nil then skip
      [] H|T then
	 {Next H}
	 {ApplyInstruction T Next}
      end
   end
   
   fun{DecodeStrategy Strategy}
      Strategy
   end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   %Test de la fonction ApplyInstruction
   {ApplyInstruction [turn(right) turn(right) turn(right) forward] Next} 
end
