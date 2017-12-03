%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% FONCTIONS SUPPLEMENTAIRES %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Append pour associer 2 listes
declare
fun {AppendLists L1 L2}
   if L1 == nil then L2
   else L1.1 | {AppendLists L1.2  L2}
   end
end

%Delete qui supprime le dernier element d une liste
declare
fun {DeleteLast L}
   case L of H|T andthen T==nil then nil
   [] H|T andthen T\=nil then H|{DeleteLast T}
   end
end

%Reverse qui renvoit l inverse d une liste
declare
fun{ReversedList L}
   case  L of H|T andthen T==nil  then H
   [] H|T andthen T\=nil then [{ReversedList T} H]
   end
end

% Cette fonction renvoit une concatenation de listes de plusieurs listes en une seule liste
declare
fun {FlattenList L}
   case L of nil then nil
   [] nil|T then {FlattenList T}
   [] (H1|T1)|T then {FlattenList H1|T1|T}
   [] X|T then X | {FlattenList T}
   end
end

% Fonction qui inverse les directions des positions d'un serpent

declare
fun {ChangeDirection Direction}
   if Direction==north then south
   elseif Direction==south then north
   elseif Direction==west then east
   elseif Direction==east then west
   end
end


%Fonctions devenues inutiles mais qui sont qd mm styles pour changer toutes les directions des positions d'un serpent
%SI ON A LE TEMPS IL FAUDRAIT CORRIGER LES DIRECTIONS DES POSITIONS INTERMEDIAIRES DANS LES SERPENTS

%declare
%fun{ChangeDirectionToNorth L}
%   if L == nil then nil
%   else pos(x:L.1.x y:L.1.y to:north)|{ChangeDirectionToNorth L.2}
%   end
%end

%declare
%fun{ChangeDirectionToSouth L}
%   if L == nil then nil
%   else pos(x:L.1.x y:L.1.y to:south)|{ChangeDirectionToSouth L.2}
%   end
%end

%declare
%fun{ChangeDirectionToWest L}
%   if L == nil then nil
%   else pos(x:L.1.x y:L.1.y to:west)|{ChangeDirectionToWest L.2}
%   end
%end

%declare
%fun{ChangeDirectionToEast L}
%   if L == nil then nil
%   else pos(x:L.1.x y:L.1.y to:east)|{ChangeDirectionToEast L.2}
%   end
%end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% FONCTION NEXT %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

declare
fun {Next Snakein Instruction}
%-------------------------------------------------------------------------------- FORWARD
   if (Instruction==forward) then
      if Snakein.positions.1.to == north then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] Snakein.positions} effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)+1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les autres effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == south then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:north)] Snakein.positions} effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)-1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == west then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:north)] Snakein.positions} effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x)+1 y:(({ReversedList Snakein.positions}).1.1.y) to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == east then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:north)] Snakein.positions} effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x)-1 y:(({ReversedList Snakein.positions}).1.1.y) to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      end
%-------------------------------------------------------------------------------- TURN(LEFT)
   elseif (Instruction==turn(left)) then
      if Snakein.positions.1.to == north then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)+1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les autres effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == south then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)-1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == west then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)-1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == east then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x)-1 y:(({ReversedList Snakein.positions}).1.1.y) to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
	  end
%-------------------------------------------------------------------------------- TURN(RIGHT)
   elseif (Instruction==turn(right)) then
      if Snakein.positions.1.to == north then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)+1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'LEs autres effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == south then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{ChangeDirectionToNorth {FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)-1 to:north)] {DeleteLast {ReversedList Snakein.positions}}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == west then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x) y:(({ReversedList Snakein.positions}).1.1.y)-1 to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      elseif Snakein.positions.1.to == east then
		 if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
		 elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
		 elseif Snakein.effects.1 == revert then snake(positions:{FlattenList {AppendLists [pos(x:(({ReversedList Snakein.positions}).1.1.x)-1 y:(({ReversedList Snakein.positions}).1.1.y) to:{ChangeDirection (({ReversedList Snakein.positions}).1.1.to)})] {DeleteLast {ReversedList Snakein.positions}}}} effects:nil)
		 else 'Les effets ne sont pas encore pris en compte'
		 end
      end
   end
end

declare
Serpent=snake(positions:[pos(x:5 y:7 to:north) pos(x:5 y:8 to:north) pos(x:5 y:9 to:north)] effects:[revert])
{Browse {Next Serpent forward}}
