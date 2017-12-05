local
   NoBomb=false|NoBomb
in
   scenario(bombLatency:3
	    walls:false
	    step: 0
	    snakes: [
		     snake(team:yellow name:jason
			   positions: [pos(x:4 y:3 to:east) pos(x:3 y:3 to:east) pos(x:2 y:3 to:east)]
			   effects: nil
			   strategy: keyboard(left:'Left' right:'Right' intro:nil)
			   bombing: NoBomb
			  )
		     snake(team:green name:steve
			   positions: [pos(x:19 y:20 to:west) pos(x:20 y:20 to:west) pos(x:21 y:20 to:west)]
			   effects: nil
			   strategy: keyboard(left:q right:d intro:nil)
			   bombing: NoBomb
			  )
		    ]
	    bonuses: [
		      bonus(position:pos(x:6 y:9) color:orange effect:teleport(x:17 y:15) target:catcher)
		      bonus(position:pos(x:17 y:15) color:orange effect:teleport(x:6 y:9) target:catcher)
		      bonus(position:pos(x:3 y:12) color:green effect:grow target:catcher)
		      bonus(position:pos(x:20 y:11) color:green effect:grow target:catcher)
		      bonus(position:pos(x:10 y:11) color:red effect:revert target:opponents)
		      bonus(position:pos(x:12 y:19) color:brown effect:revert target:catcher)
		      bonus(position:pos(x:6 y:14) color:black effect:shrink target:opponents)
		     ]
	    bombs: nil
	   )
end