local 
   % Ceci est le chemin vers le dossier du projet
    Dossier = {Property.condGet cwdir '/home/tux/Documents/projetinfo2/test'} % Fichiers d'exemples.
   SnakeLib

   % Déclaration des deux fonctions que nous avons du implémenter
   Next
   DecodeStrategy
   
   % Hauteur et largeur de la grille
   % (1 <= x <= W=22, 1 <= y <= H=22)
   W = 22
   H = 22

   Options
in
   % Merci de conserver cette ligne telle qu'elle.
   [SnakeLib] = {Link [Dossier#'/'#'ProjectLib.ozf']}
   {Browse SnakeLib.play}

   local
      % Déclaration des fonctions ajoutées
      AppendLists
      DeleteLast
	  ReversedList
	  FlattenList
	  InversedHead
	  ChangeDirection2
	  ChangeDirection1

   in
  
%-----------------Append pour associer 2 listes------------------
      fun {AppendLists L1 L2}
		 case L1 of nil then L2
		 [] H|T then H|{AppendLists T L2}
		 end
      end

%-----------Supprimer le dernier element d une liste-------------
      fun {DeleteLast L}
		 case L of H|T andthen T==nil then nil
		 [] H|T andthen T\=nil then H|{DeleteLast T}
		 end
      end

%-----------Reverse qui renvoit l inverse d une liste----------

	  fun{ReversedList L}
		 case  L of H|T andthen T==nil  then H
		 [] H|T andthen T\=nil then [{ReversedList T} H]
		 end
	  end

% Cette fonction renvoit une concatenation de listes de plusieurs listes en une seule liste

	  fun {FlattenList L}
		 case L of nil then nil
		 [] nil|T then {FlattenList T}
		 [] (H1|T1)|T then {FlattenList H1|T1|T}
		 [] X|T then X | {FlattenList T}
		 end
	  end

% Fonction qui inverse les directions des positions d'un serpent
	  fun {InversedHead L}
		 if L.1.to == north then 
			{FlattenList {AppendLists [pos(x:(L.1.x) y:(L.1.y)-1 to:nort)] {DeleteLast L}}}
		 elseif L.1.to == south then 
			{FlattenList {AppendLists [pos(x:(L.1.x) y:(L.1.y)+1 to:south)] {DeleteLast L}}}
		 elseif L.1.to == west then 
			{FlattenList {AppendLists [pos(x:(L.1.x)-1 y:(L.1.y) to:west)] {DeleteLast L}}}
		 elseif L.1.to == east then 
			{FlattenList {AppendLists [pos(x:(L.1.x)+11 y:(L.1.y) to:east)] {DeleteLast L}}}
		 end
	  end

% Fonctions qui corrigent l orientation des positions intermediaires
	  fun {ChangeDirection2 Direction}
		 if Direction==north then south
		 elseif Direction==south then north
		 elseif Direction==west then east
		 elseif Direction==east then west
		 end
	  end

	  fun{ChangeDirection1 L}
		 if L == nil then nil
		 else pos(x:L.1.x y:L.1.y to:{ChangeDirection2 L.1.to})|{ChangeDirection1 L.2}
		 end
	  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% FONCTION NEXT %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Fonction qui renvoit les nouveaux attributs du serpent après prise
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
%-------------------------------------------------------------------------------- FORWARD
		 if (Instruction==forward) then
			
% ---------------------------------Si le serpent va vers le nord
			if Snakein.positions.1.to == north then 
			   if Snakein.effects == nil then
			%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 1 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:21 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:20 to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] Snakein.positions} effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y)-1 to:north)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers le sud
			elseif Snakein.positions.1.to == south then
			   if Snakein.effects == nil then 
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 22 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:2 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:1 to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
				  end
				  
			   elseif Snakein.effects == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] Snakein.positions} effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y)+1 to:south)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers l ouest
			elseif Snakein.positions.1.to == west then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 1 then snake(positions:({AppendLists [pos(x:21 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:22 y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] Snakein.positions} effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x)-1 y:(Snakein.effects.y) to:west)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers l est
			elseif Snakein.positions.1.to == east then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 22 then snake(positions:({AppendLists [pos(x:2 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] Snakein.positions} effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x)+1 y:(Snakein.effects.y) to:east)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			end
			
%-------------------------------------------------------------------------------- TURN(LEFT)
		 elseif (Instruction==turn(left)) then
			
% ---------------------------------Si le serpent va vers le nord
			if Snakein.positions.1.to == north then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 1 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:21 to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:22 to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x)-1 y:(Snakein.effects.y) to:west)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers le sud
			elseif Snakein.positions.1.to == south then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 22 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:2 to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:1 to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x)+1 y:(Snakein.effects.y) to:east)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers l ouest
			elseif Snakein.positions.1.to == west then
			   if Snakein.effects == nil then
			%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 1 then snake(positions:({AppendLists [pos(x:21 y:(Snakein.positions.1.y) to:south)] {AppendLists [pos(x:22 y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y)+1 to:south)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers l est
			elseif Snakein.positions.1.to == east then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 22 then snake(positions:({AppendLists [pos(x:2 y:(Snakein.positions.1.y) to:north)] {AppendLists [pos(x:1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y)-1 to:north)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			end
%-------------------------------------------------------------------------------- TURN(RIGHT)      
		 elseif (Instruction==turn(right)) then
			
% ---------------------------------Si le serpent va vers le nord
			if Snakein.positions.1.to == north then
			   if Snakein.effects == nil then
			    %Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 1 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:21 to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:22 to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x)+1 y:(Snakein.effects.y) to:east)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers le sud
			elseif Snakein.positions.1.to == south then
			   if Snakein.effects == nil then
		 %Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 22 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:2 to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:1 to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x)-1 y:(Snakein.effects.y) to:west)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers l ouest
			elseif Snakein.positions.1.to == west then
			   if Snakein.effects == nil then
			%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 1 then snake(positions:({AppendLists [pos(x:21 y:(Snakein.positions.1.y) to:north)] {AppendLists [pos(x:22 y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y)-1 to:north)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			   
% ---------------------------------Si le serpent va vers l est
			elseif Snakein.positions.1.to == east then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 22 then snake(positions:({AppendLists [pos(x:2 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y)+1 to:south)] {AppendLists [pos(x:(Snakein.effects.x) y:(Snakein.effects.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			end
		 end
	  end
	  
      
	  
%%%%%%%%%%%%%%%%%%%%%%%
%%% DECODE STRATEGY %%%
%%%%%%%%%%%%%%%%%%%%%%%
      % Fonction qui décode la stratégie d'un serpent en une liste de fonctions. Chacune correspond
      % à un instant du jeu et applique l'instruction devant être exécutée à cet instant au snake
      % passé en argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil
	  
	  fun{DecodeStrategy Strategy}
		 case Strategy of H|T then
			if H== forward orelse H==turn(left) orelse H==turn(right) then
			   fun{$ Snake} {Next Snake H}end|{DecodeStrategy T}
			else nil
%	    else
%	    {DecodeRepeat H}|{DecodeStrategy T}
			end
		 []nil then nil
		 end
      end
	  
	  
%%%%%%%%%%%%%%%%%% Options %%%%%%%%%%%%%%%%%%
      Options = options(
		   % Fichier contenant le scénario (depuis Dossier)
				   scenario:'scenario_test_moves.oz'
		   % Visualisation de la partie
				   debug: true
		   % Instants par seconde, 0 spécifie une exécution pas à pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
				   frameRate:1
				   )
   end
   
   local 
      R = {SnakeLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options}
   in
      {Browse R}
   end
end
