local
   %Variables
   DecodeStrategy
   ApplyInstruction
   Next
   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:nil)
in
   fun{Next}
      {Browse $}
   end
   
   proc{ApplyInstruction L Next}
      case L of nil then skip
      [] X|L2 then
	 {Next X}
	 {ApplyInstruction L2 Next}
      end
   end
   
   fun{DecodeStrategy Strategy}
      Strategy
   end

   

   {ApplyInstruction [turn(right) turn(right) turn(right) forward] Next}
end
