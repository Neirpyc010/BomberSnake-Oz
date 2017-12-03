local
   %Variables
   Snake=snake(positions:[pos(x:4 y:2 to:east) pos(x:3 y:2 to:east) pos(x:2 y:2 to:east)] effects:grow)
   DecodeEffects
   EffectGrow
in
   %Fonction qui dispatche le snake en fct de son effet
   fun{DecodeEffects Snake}
      if Snake.effects == nil then
	 Snake
      elseif Snake.effects == grow then
	 {EffectGrow Snake}
      end
   end

   %Fonction qui applique l'effet grow au serpent
   fun{EffectGrow Snake}
      'Effect Grow'
   end
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   {Browse {DecodeEffects Snake}}
end
