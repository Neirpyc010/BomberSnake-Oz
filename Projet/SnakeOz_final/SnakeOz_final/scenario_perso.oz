local
   NoBomb=false|NoBomb
in
   scenario(bombLatency:3
	    walls:false
	    step: 0
	    snakes: [
		     snake(team:blue name:peter
			   positions: [pos(x:3 y:18 to:north) pos(x:3 y:19 to:north) pos(x:3 y:20 to:north)]
			   effects: nil
			   strategy: [repeat([forward] times:30) turn(right) repeat([forward] times:29) turn(right) repeat([forward] times:20) turn(right) turn(left) turn(right) turn(left) repeat([forward] times:4) turn(left) turn(left) repeat([forward] times:2) turn(left) turn(left) repeat([forward] times:5) turn(left) repeat([forward] times:5) turn(left) repeat([forward] times:18)]
			   bombing: NoBomb
			  )
		     snake(team:yellow name:maxime
			   positions: [pos(x:20 y:5 to:south) pos(x:20 y:4 to:south) pos(x:20 y:3 to:south)]
			   effects: nil
			   strategy: [repeat([forward] times:30) turn(right) repeat([forward] times:30) turn(right) repeat([forward] times:4) turn(left) repeat([forward] times:5) turn(right) repeat([forward] times:6) turn(right) repeat([forward] times:9) turn(left) turn(right) forward turn(right) repeat([forward] times:2) turn(right) turn(left) repeat([forward] times:13) turn(right) turn(right) repeat([forward] times:2) turn(right) turn(right) repeat([forward] times:2) turn(right) turn(right) repeat([forward] times:2) turn(right) forward]
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