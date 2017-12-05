%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                        BOMBERSNAKE OZ                       %%
%%                                                             %%
%%            Bienvenue dans le jeu BomberSnake-Oz             %%
%%                                                             %%
%% Bonus et effets :                                           %%
%%                   - Orange : Le serpent est teleporte       %%
%%                   - Rouge : L'adversaire est retourne       %%
%%                   - Vert : Le serpent grandit               %%
%%                   - Brun : Le serpent est retourne          %%
%%                   - Noir : L'adversaire devient plus petit  %%
%%                   - Les serpents peuvent traverser les murs %%
%%                                                             %%
%% Cree par Cyprien J. & Nicolas P.                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                        DEBUT DU CODE                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

local
   % Ceci est le chemin vers le dossier du projet
    Dossier = {Property.condGet cwdir 'D:\\Clouds\\GitHub\\BomberSnake-Oz\\Projet\\SnakeOz_final\\SnakeOz_final'}
   SnakeLib

   % Declaration des deux fonctions que nous avons du implementer
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
      % Declaration des fonctions ajoutees
      AppendLists
      DeleteLast
      ReversedList
      FlattenList
      InversedHead
      ChangeDirection2
      ChangeDirection1
      DecodeRepeat
      MultList
   in

%----------------- Append pour associer 2 listes ------------------
      fun {AppendLists L1 L2}
		 case L1 of nil then L2
		 [] H|T then H|{AppendLists T L2}
		 end
      end

%----------- Supprimer le dernier element d une liste -------------
      fun {DeleteLast L}
		 case L of H|T andthen T==nil then nil
		 [] H|T andthen T\=nil then H|{DeleteLast T}
		 end
      end

%----------- Reverse qui renvoit l inverse d une liste ----------

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
			if L.1.y==1 then {FlattenList {AppendLists [pos(x:(L.1.x) y:21 to:north)] {AppendLists [pos(x:(L.1.x) y:22 to:north)] {DeleteLast L.2}}}}
			else {FlattenList {AppendLists [pos(x:(L.1.x) y:(L.1.y)-1 to:north)] {DeleteLast L}}}
			end
		 elseif L.1.to == south then
			if L.1.y==22 then {FlattenList {AppendLists [pos(x:(L.1.x) y:2 to:south)] {AppendLists [pos(x:(L.1.x) y:1 to:south)] {DeleteLast L.2}}}}
			else {FlattenList {AppendLists [pos(x:(L.1.x) y:(L.1.y)+1 to:south)] {DeleteLast L}}}
			end
		 elseif L.1.to == west then
			if L.1.x==1 then {FlattenList {AppendLists [pos(x:21 y:(L.1.y) to:west)] {AppendLists [pos(x:22 y:(L.1.y) to:west)] {DeleteLast L.2}}}}
			else {FlattenList {AppendLists [pos(x:(L.1.x)-1 y:(L.1.y) to:west)] {DeleteLast L}}}
			   end
		 elseif L.1.to == east then
			if L.1.x==22 then {FlattenList {AppendLists [pos(x:2 y:(L.1.y) to:east)] {AppendLists [pos(x:1 y:(L.1.y) to:east)] {DeleteLast L.2}}}}
			else {FlattenList {AppendLists [pos(x:(L.1.x)+1 y:(L.1.y) to:east)] {DeleteLast L}}}
			end
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
      % Fonction qui renvoit les nouveaux attributs du serpent apres prise
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
				  if Snakein.positions.1.y == 1 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:21 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:22 to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] Snakein.positions} effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers le sud
			elseif Snakein.positions.1.to == south then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 22 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:2 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:1 to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
				  end

			   elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] Snakein.positions} effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers l ouest
			elseif Snakein.positions.1.to == west then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 1 then snake(positions:({AppendLists [pos(x:21 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:22 y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] Snakein.positions} effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x)-1 y:(Snakein.effects.1.y) to:west)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers l est
			elseif Snakein.positions.1.to == east then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 22 then snake(positions:({AppendLists [pos(x:2 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] Snakein.positions} effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)]  {DeleteLast Snakein.positions}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x)+1 y:(Snakein.effects.1.y) to:east)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
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
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x)-1 y:(Snakein.effects.1.y) to:west)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers le sud
			elseif Snakein.positions.1.to == south then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 22 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:2 to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:1 to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x)+1 y:(Snakein.effects.1.y) to:east)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers l ouest
			elseif Snakein.positions.1.to == west then
			   if Snakein.effects == nil then
			%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 1 then snake(positions:({AppendLists [pos(x:21 y:(Snakein.positions.1.y) to:south)] {AppendLists [pos(x:22 y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers l est
			elseif Snakein.positions.1.to == east then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 22 then snake(positions:({AppendLists [pos(x:2 y:(Snakein.positions.1.y) to:north)] {AppendLists [pos(x:1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
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
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x)+1 y:(Snakein.effects.1.y) to:east)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers le sud
			elseif Snakein.positions.1.to == south then
			   if Snakein.effects == nil then
		 %Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.y == 22 then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:2 to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:1 to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x)-1 y:(Snakein.effects.1.y) to:west)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers l ouest
			elseif Snakein.positions.1.to == west then
			   if Snakein.effects == nil then
			%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 1 then snake(positions:({AppendLists [pos(x:21 y:(Snakein.positions.1.y) to:north)] {AppendLists [pos(x:22 y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end

% ---------------------------------Si le serpent va vers l est
			elseif Snakein.positions.1.to == east then
			   if Snakein.effects == nil then
				%Si le serpent arrive en bord de plateau il faut le teleporter
				  if Snakein.positions.1.x == 22 then snake(positions:({AppendLists [pos(x:2 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  else snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
				  end
			   elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
			   elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
			   elseif Snakein.effects.1 == shrink then snake(positions:({DeleteLast {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}}) effects:nil)
			   else snake(positions:({AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.effects.1.x) y:(Snakein.effects.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
			   end
			end
		 end
	  end


%%%%%%%%%%%%%%%%%%%%%%%
%%% DECODE STRATEGY %%%
%%%%%%%%%%%%%%%%%%%%%%%
      % Fonction qui decode la strategie d'un serpent en une liste de fonctions. Chacune correspond
      % a  un instant du jeu et applique l'instruction devant etre executee a cet instant au snake
      % passee en argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil

	  fun{DecodeStrategy Strategy}
	     {FlattenList
	      case Strategy of H|T then
			 if H== forward orelse H==turn(left) orelse H==turn(right) then
				fun{$ Snake} {Next Snake H}end|{DecodeStrategy T}
			 else
				{DecodeRepeat H}|{DecodeStrategy T}
			 end
	      []nil then nil
	      end
	     }
	  end

      %Procedure qui decode les instructions de type : repeat([turn(right)] times:2)
	  fun{DecodeRepeat X}
	     local Times L in
			Times = X.times
			L = {DecodeStrategy X.1}
			{MultList L Times}
	     end
	  end

      %Fonction qui renvoie une liste composée de Times fois la liste L
	  fun{MultList L Times}
	     if Times == 0 then nil
	     else L|{MultList L Times-1}
	     end
	  end


%%%%%%%%%%%%%%%%%% Options %%%%%%%%%%%%%%%%%%
      Options = options(
		   % Fichier contenant le scenario (depuis Dossier)
				   scenario:'scenario_perso.oz'
		   % Visualisation de la partie
				   debug: true
		   % Instants par seconde, 0 spÃ©cifie une exÃ©cution pas Ã  pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
				   frameRate:10
		   )
   end

   local
      R = {SnakeLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options}
   in
      {Browse R}
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                         FIN DU CODE                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
