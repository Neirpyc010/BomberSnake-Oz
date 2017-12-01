declare
Serpent=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:[nil])
%Record(Tableau[Record(x y to)] effects) 

%Append pour associer 2 listes
declare
fun {AppendLists L1 L2}
   if L1 == nil then L2
   else L1.1 | {AppendLists L1.2  L2}
   end
end

declare
fun {DeleteLast L}
   case L of H|T andthen T==nil then nil
   [] H|T andthen T\=nil then H|{DeleteLast T}
   end
end

%Test du debut de la fonction next
declare Snakeout
fun {Next Snakein Instruction}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FORWARD %%%%%%%%%%%%%%%%%%%%%%%%%%
   if (Instruction==forward) then
      if Snakein.positions.1.to == north then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les autres effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == south then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == west then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == east then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURN LEFT %%%%%%%%%%%
   elseif (Instruction==turn(left)) then
      if Snakein.positions.1.to == north then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'LEs autres effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == south then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:est)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == west then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == east then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURN RIGHT %%%%%%%%%%%
   elseif (Instruction==turn(right)) then 
      if Snakein.positions.1.to == north then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'LEs autres effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == south then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == west then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end
      elseif Snakein.positions.1.to == east then
	 if Snakein.effects.1 == nil then Snakeout=snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
	 else 'Les effets ne sont pas encore pris en compte'
	 end	 
      end
   else 'Erreur, l instruction n est pas d aller vers l avant'
   end
end

{Browse {Next Serpent forward}}
