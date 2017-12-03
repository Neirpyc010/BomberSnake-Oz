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
      DecodeRepeat
      ListNext
      CellList={NewCell nil} %La cellule contenant la liste d'appels � Next sous la forme @CellList = [fun{$ Snake}{Next Snake Instruction}end]
      
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
      
      
      % La fonction qui decode la strategie d'un serpent en une liste de fonctions. Chacune correspond
      % a un instant du jeu et applique l'instruction devant etre executee a cet instant au snake
      % passe en argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil
      fun{DecodeStrategy Strategy}
	 local
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
	 in
	    {DecodeStrategy2 Strategy}
	    @CellList
	 end
      end
      
      %Procedure qui decode les instructions de type : repeat([turn(right)] times:2)
      %et change ainsi la liste contenue dans la cell : CellList
      proc{DecodeRepeat X}
	 local Inst Times in
	    Inst = X.1
	    Times = X.times
	    for E in 1..Times do
	       CellList := {ListNext Inst @CellList}
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

      
      
      % Options
      Options = options(
		   % Fichier contenant le scénario (depuis Dossier)
		   % Path of the scenario (relative to Dossier)
		   scenario:'scenario_pvp.oz'
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
