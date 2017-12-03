local
   %Variables
   DecodeStrategy
   ApplyInstruction
   Next
   DecodeRepeat
%   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:nil)
   Snake= 'snake'
   Appel= 'Appel de la fonction Next {'
   Crochet= '}'
   ListNext
in
   %Fonction Next simplifiee pour les tests
   proc{Next Snake I}
      {Browse Appel|Snake|I|Crochet}
   end

   %Fonction qui decode les instructions de type : repeat([turn(right)] times:2)
   %et appelle la fonction next en consequence
   proc{DecodeRepeat X}
      local Inst Times in
	 Inst = X.1.1
	 Times = X.times
	 for E in 1..Times do
	    {Next Snake Inst}
	 end
      end
   end

   %Fonction qui cree la liste d'appels a Next
   fun{ListNext X L}
      case L of H|T then H|{ListNext X T}
      [] nil then X|nil
      end
   end
   
   %Fonction qui applique Next a une liste d'instructions de types : forward,turn(left),turn(right)
   %(pour l'instant elle n'est plus utile
   proc{ApplyInstruction L Next}
      case L of nil then skip
      [] H|T then
	 {Next Snake H}
	 {ApplyInstruction T Next}
      end
   end

   %Fonction principale
   proc{DecodeStrategy Strategy}
      case Strategy of H|T then
	 if H == forward orelse H == turn(left) orelse H == turn(right) then
	    {Next Snake H}
	    {DecodeStrategy T}
	 else
	    {DecodeRepeat H}
	    {DecodeStrategy T}
	 end
      [] nil then skip
      end
   end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   %Test de la fonction ApplyInstruction
 %  {ApplyInstruction [turn(right) turn(right) turn(right) forward] Next}

   %Test de la fonction DecodeStrategy
   {DecodeStrategy [turn(left) repeat([turn(right)] times:2) forward]}

   %Test de la fonction DecodeRepeat
 %  {DecodeRepeat repeat([turn(right)] times:2)}

end
