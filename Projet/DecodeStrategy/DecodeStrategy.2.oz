local
   DecodeRepeat
   ListNext
   CellList={NewCell nil} %La cellule contenant la liste d'appels à Next sous la forme @CellList = [fun{$ Snake}{Next Snake Instruction}end]
   Next
   DecodeStrategy
   DecodeStrategy2
in
      % La fonction qui decode la strategie d'un serpent en une liste de fonctions. Chacune correspond
      % a un instant du jeu et applique l'instruction devant etre executee a cet instant au snake
      % passe en argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil
   fun{DecodeStrategy Strategy}
      
      proc{DecodeStrategy2 Strategy}
	 case Strategy of H|T then
	    if H == forward orelse H == turn(left) orelse H == turn(right) then
	       CellList := {ListNext H @CellList}
	       {DecodeStrategy2 T}
	    else
	       {DecodeRepeat H}
	       {DecodeStrategy2 T}
	    end
	 else skip
	 end
      end
      {DecodeStrategy2 Strategy}
      @CellList
   end
   
      %Procedure qui decode les instructions de type : repeat([turn(right)] times:2)
      %et change ainsi la liste contenue dans la cell : CellList
   proc{DecodeRepeat X}
      local Times in
	 Times = X.times
	 for E in 1..Times do
	    {DecodeStrategy2 X.1}
	 end
      end
   end
   
      %Fonction qui rajoute a la fin de la liste L la fonction d'appel a Next
      %Avec l'instruction donnee en X
   fun{ListNext X L}
      case L of H|T then H|{ListNext X T}
      [] nil then
	 fun{$ Snake}{Next Snake X}end|nil
      end
   end

   fun{Next Snake X}
      Snake|X|nil
   end

%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  {Browse {{DecodeStrategy [repeat([turn(right)] times:2) forward]}.1 'Snake' }}
end