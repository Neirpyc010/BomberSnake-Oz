local 
   % Vous pouvez remplacer ce chemin par celui du dossier qui contient ProjectLib.ozf
   % Please replace this path with your own working directory that contains ProjectLib.ozf

   % Dossier = {Property.condGet cwdir '/home/max/Desktop/FSAB1402/Projet-2017/StudentPack'} % Unix example
   Dossier = {Property.condGet cwdir 'D:\\Clouds\\Dropbox\\Etudes\\EPL\\Bac 1\\Q3\\LFSAB1402 - Informatique 2\\Projet'} % Windows example.
   SnakeLib

   % Les deux fonctions que vous devez implementer
   % The two function you have to implement
   Next
   DecodeStrategy
   
   % Hauteur et largeur de la grille
   % Width and height of the grid
   % (1 <= x <= W=22, 1 <= y <= H=22)
   W = 22
   H = 22

   Options
in
   % Merci de conserver cette ligne telle qu'elle.
   [SnakeLib] = {Link [Dossier#'/'#'ProjectLib.ozf']}
   {Browse SnakeLib.play}

%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here  %
%%%%%%%%%%%%%%%%%%%%%%%%

   local
      % Declarez vos functions ici
      AppendLists
      DeleteLast
      ReversedList
      FlattenList
      InversedHead
      ChangeDirection2
      ChangeDirection1
      
   in
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%%%%%%%% FONCTIONS SUPPLEMENTAIRES %%%%%%%%%%%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      %Append pour associer 2 listes
      fun {AppendLists L1 L2}
	 if L1 == nil then L2
	 else L1.1 | {AppendLists L1.2  L2}
	 end
      end
      
      %Delete qui supprime le dernier element d une liste
      fun {DeleteLast L}
	 case L of H|T andthen T==nil then nil
	 [] H|T andthen T\=nil then H|{DeleteLast T}
	 end
      end
      
      %Reverse qui renvoit l inverse d une liste
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
      
      %Fonctions devenues inutiles mais qui sont qd mm stylees pour changer toutes les directions des positions d'un serpent
      %SI ON A LE TEMPS IL FAUDRAIT CORRIGER LES DIRECTIONS DES POSITIONS INTERMEDIAIRES DANS LES SERPENTS


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
      
%declare
%Test=[pos(x:6 y:4 to:south) pos(x:6 y:3 to:south) pos(x:5 y:3 to:east) pos(x:4 y:3 to:east) pos(x:4 y:4 to:north)]
%{Browse {ChangeDirection1 Test}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% FONCTION NEXT %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


      fun {Next Snakein Instruction}
%-------------------------------------------------------------------------------- FORWARD
	 if (Instruction==forward) then
	    if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] Snakein.positions} effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les autres effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:north)] Snakein.positions} effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:north)] Snakein.positions} effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:{AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:north)] Snakein.positions} effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    end
%-------------------------------------------------------------------------------- TURN(LEFT)
	 elseif (Instruction==turn(left)) then
	    if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les autres effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    end
%-------------------------------------------------------------------------------- TURN(RIGHT)
	 elseif (Instruction==turn(right)) then
	    if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'LEs autres effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       elseif Snakein.effects.1 == grow then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] Snakein.positions.2}}) effects:nil)
	       elseif Snakein.effects.1 == revert then snake(positions:{InversedHead {FlattenList {ReversedList {ChangeDirection1 Snakein.positions}}}} effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    end
	 end
      end
      
      % La fonction qui decode la strategie d'un serpent en une liste de fonctions. Chacune correspond
      % a un instant du jeu et applique l'instruction devant etre executee a cet instant au snake
      % passe en argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil
      fun{DecodeStrategy Strategy}
	 case Strategy of H|T then
	    if H== forward orelse H==turn(left) orelse H==turn(right) then
	       fun{$ Snake} {Next Snake H}end|{DecodeStrategy T}
	    else nil
%	 else
%	    {DecodeRepeat H}|{DecodeStrategy T}
	    end
	 []nil then nil
	 end
      end

      
      
      % Options
      Options = options(
		   % Fichier contenant le scénario (depuis Dossier)
		   % Path of the scenario (relative to Dossier)
		   scenario:'scenario_moves.oz'
		   % Visualisation de la partie
		   % Graphical mode
		   debug: true
		   % Instants par seconde, 0 spécifie une exécution pas à pas. (appuyer sur 'Espace' fait avancer le jeu d'un pas)
		   % Steps per second, 0 for step by step. (press 'Space' to go one step further)
		   frameRate: 1
		   )
   end

%%%%%%%%%%%
% The end %
%%%%%%%%%%%
   
   local 
      R = {SnakeLib.play Dossier#'/'#Options.scenario Next DecodeStrategy Options}
   in
      {Browse R}
   end
end
