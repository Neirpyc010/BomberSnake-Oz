local
   AppendLists
   Next
   DeleteLast
   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3y:2 to:east) pos(x:2 y:2 to:east)] effects:[nil])
in
   %Append pour associer 2 listes
   fun {AppendLists L1 L2}
      if L1 == nil then L2
      else L1.1 | {AppendLists L1.2  L2}
      end
   end
   
   %Supprimer le dernier element d'une liste
   fun {DeleteLast L}
      case L of H|T andthen T==nil then nil
      [] H|T andthen T\=nil then H|{DeleteLast T}
      end
   end
   
   % La fonction qui renvoit les nouveaux attributs du serpent apres prise
   % en compte des effets qui l'affectent et de son instruction
   %
   % instruction ::= forward | turn(left) | turn(right)
   % P ::= <integer x such that 1 <= x <= 22>
   % direction ::= north | south | west | east
   % snake ::=  snake(
   %               positions: [
   %                  pos(x:<P> y:<P> to:<direction>) % Head
   %                  ...
   %                  pos(x:<P> y:<P> to:<direction>) % Tail
   %               ]
   %               effects: [grow|revert|teleport(x:<P> y:<P>)|... ...]
   %            )
   fun {Next Snakein Instruction}
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FORWARD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
      if (Instruction==forward) then
	 
	    %Direction de la tete du serpent vers le : nord
	 if Snakein.positions.1.to == north then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
	    else 'Les autres effets ne sont pas encore pris en compte'
	    end
	    
	    %Direction de la tete du serpent vers le : sud
	 elseif Snakein.positions.1.to == south then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
	    else 'Les effets ne sont pas encore pris en compte'
	    end
	    
	    %Direction de la tete du serpent vers le : Ouest
	 elseif Snakein.positions.1.to == west then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
	    else 'Les effets ne sont pas encore pris en compte'
	    end
	    
	    %Direction de la tete du serpent vers le : Est
	 elseif Snakein.positions.1.to == east then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions}}) effects:nil)
	    else 'Les effets ne sont pas encore pris en compte'
	    end
	 end
	 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURN LEFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	 
      elseif (Instruction==turn(left)) then
	 
	    %Direction de la tete du serpent vers le : nord
	 if Snakein.positions.1.to == north then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	    else 'LEs autres effets ne sont pas encore pris en compte'
	    end
	    
	    %Direction de la tete du serpent vers le : sud
	 elseif Snakein.positions.1.to == south then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	    else 'Les effets ne sont pas encore pris en compte'
	    end
	    
	    %Direction de la tete du serpent vers le : ouest
	 elseif Snakein.positions.1.to == west then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	    else 'Les effets ne sont pas encore pris en compte'
	    end
	    
	    %Direction de la tete du serpent vers le : est
	 elseif Snakein.positions.1.to == east then
	    if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	    else 'Les effets ne sont pas encore pris en compte'
	    end
	 end
	 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURN RIGHT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	 
      elseif (Instruction==turn(right)) then
	 
	    %Direction de la tete du serpent vers le : nord
	 if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'LEs autres effets ne sont pas encore pris en compte'
	       end

	    %Direction de la tete du serpent vers le : sud
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end

	    %Direction de la tete du serpent vers le : ouest
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end

	    %Direction de la tete du serpent vers le : est
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end	 
	    end

	 %Erreur qui ne devrait jamais arriver
	 else 'Erreur, l instruction n est pas d aller vers l avant'
	 end
   end

   {Browse {Next Snake turn(left)}}
end