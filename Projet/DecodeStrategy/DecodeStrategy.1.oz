local
   %Variables
   DecodeStrategy
   ApplyInstruction
   Next
   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:nil)
in
   proc{ApplyInstruction L}
      case L of H|T then
	 {Next H}
	 {ApplyInstruction T}
	 else skip end
   end
   
   fun{DecodeStrategy Strategy}
      Strategy
   end

   
   fun{Next Instruction}
      {Browse Instruction}
   end
   {ApplyInstruction [turn(right) turn(right) turn(right) forward]}
end
