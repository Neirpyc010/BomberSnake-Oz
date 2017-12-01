local 
   % Vous pouvez remplacer ce chemin par celui du dossier qui contient ProjectLib.ozf
   % Please replace this path with your own working directory that contains ProjectLib.ozf

   % Dossier = {Property.condGet cwdir '/home/max/Desktop/FSAB1402/Projet-2017/StudentPack'} % Unix example
    Dossier = {Property.condGet cwdir 'D:\\Clouds\\Dropbox\\Etudes\\EPL\\Bac 1\\Q3\\LFSAB1402 - Informatique 2\\Projet'} % Windows example.
   SnakeLib

   % Les deux fonctions que vous devez implémenter
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
   % Please do NOT change this line.
   [SnakeLib] = {Link [Dossier#'/'#'ProjectLib.ozf']}
   {Browse SnakeLib.play}

%%%%%%%%%%%%%%%%%%%%%%%%
% Your code goes here  %
% Votre code vient ici %
%%%%%%%%%%%%%%%%%%%%%%%%

   local
      % Déclarez vos functions ici
      % Declare your functions here
      AppendLists
      DeleteLast
      Next
   in
      % La fonction qui renvoit les nouveaux attributs du serpent après prise
      % en compte des effets qui l'affectent et de son instruction
      % The function that computes the next attributes of the snake given the effects
      % affecting him as well as the instruction
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

      %Append pour associer 2 listes
      fun {AppendLists L1 L2}
	 if L1 == nil then L2
	 else L1.1 | {AppendLists L1.2  L2}
	 end
      end
      
      %Supprimer le dernier element d une liste
      fun {DeleteLast L}
	 case L of H|T andthen T==nil then nil
	 [] H|T andthen T\=nil then H|{DeleteLast T}
	 end
      end

      %La fameuse fonction Next
      fun {Next Snakein Instruction}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FORWARD %%%%%%%%%%%%%%%%%%%%%%%%%%
	 if (Instruction==forward) then
	    if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)]  {DeleteLast Snakein.positions}}) effects:nil)
	       else 'Les autres effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {DeleteLast Snakein.positions}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {DeleteLast Snakein.positions}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    end
	    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURN LEFT %%%%%%%%%%%
	 elseif (Instruction==turn(left)) then
	    if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'LEs autres effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    end
	    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURN RIGHT %%%%%%%%%%%
	 elseif (Instruction==turn(right)) then 
	    if Snakein.positions.1.to == north then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)+1 y:(Snakein.positions.1.y) to:east)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:east)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'LEs autres effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == south then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x)-1 y:(Snakein.positions.1.y) to:west)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:west)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == west then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)-1 to:north)] {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:north)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end
	    elseif Snakein.positions.1.to == east then
	       if Snakein.effects.1 == nil then snake(positions:({AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y)+1 to:south)]  {AppendLists [pos(x:(Snakein.positions.1.x) y:(Snakein.positions.1.y) to:south)] {DeleteLast Snakein.positions.2}}}) effects:nil)
	       else 'Les effets ne sont pas encore pris en compte'
	       end	 
	    end
	 else 'Erreur, l instruction n est pas d aller vers l avant'
	 end
      end
      
      
      % La fonction qui décode la stratégie d'un serpent en une liste de fonctions. Chacune correspond
      % à un instant du jeu et applique l'instruction devant être exécutée à cet instant au snake
      % passé en argument
      % The function that decodes the strategy of a snake into a list of functions. Each corresponds
      % to an instant in the game and should apply the instruction of that instant to the snake
      % passed as argument
      %
      % strategy ::= <instruction> '|' <strategy>
      %            | repeat(<strategy> times:<integer>) '|' <strategy>
      %            | nil
      fun {DecodeStrategy Strategy}
	 [fun{$ Snake}
	     Snake
	  end]
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
		   frameRate: 0
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
