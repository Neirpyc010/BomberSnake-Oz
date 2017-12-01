local
   %Variables
   DecodeStrategy
   ApplyInstruction
in
   proc{ApplyInstruction L}
      case L of H|T then
	 {Next Snake H}
	 {ApplyInstruction T}
	 else skip end
   end
   fun{DecodeStrategy Strategy}
      
   end
end
