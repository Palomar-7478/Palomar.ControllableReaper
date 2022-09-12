untyped
global function Reaper_Controller_Init

void function Reaper_Controller_Init () {
<<<<<<< HEAD
=======
	AddCallback_OnClientConnected( AddSelectInputs )
	CPlayer.CycleActive <- false
	CPlayer.UseActive <- false

>>>>>>> bc24e36 (Reaper as Titan)
    AddClientCommandCallback( "spawnreaper", spawnfunc )
    AddClientCommandCallback( "test", testfunc )
	AddClientCommandCallback( "dummy", spawndummyfunc )
}

<<<<<<< HEAD
=======
void function AddSelectInputs(entity player) { //combination is kinda weird
	AddButtonPressedPlayerInputCallback( player, IN_USE , SetUseActive )
	AddButtonPressedPlayerInputCallback( player, IN_WEAPON_CYCLE, SetCycleActive )

	AddButtonReleasedPlayerInputCallback( player, IN_USE , SetUseInactive )
	AddButtonReleasedPlayerInputCallback( player, IN_WEAPON_CYCLE, SetCycleInactive )

}

void function SetUseActive(entity player) {
	player.UseActive = true
	CheckForCombination(player)
}

void function SetUseInactive(entity player) {
	player.UseActive = false
}

void function SetCycleActive(entity player) {
	player.CycleActive = true
	CheckForCombination(player)
}

void function SetCycleInactive(entity player) {
	player.CycleActive = false
	if (player.UseActive == true ) { //prevents weapon change when you toggled reaper
		player.SetActiveWeaponBySlot( 0 )
	}
}

void function CheckForCombination(entity player) {
	if (player.CycleActive == true && player.UseActive == true) {
		player.EquipedReaperAsTitan = !expect bool (player.EquipedReaperAsTitan)
		EmitSoundOnEntity(player, "titan_eject_dpad" )
		if (player.EquipedReaperAsTitan) {
			Chat_ServerPrivateMessage(player,"Your next Titanfall will be a: Reaper !", false)
		} else {
			Chat_ServerPrivateMessage(player,"Your next Titanfall will be a: Titan !", false)
		}
	}
}



///////////////////////////////////dev-functions///////////////////////////////////////////////
>>>>>>> bc24e36 (Reaper as Titan)
bool function spawnfunc (entity player, array<string> args ) {
    SpawnReaperForPlayer( player )
	return true
}

void function SpawnReaperForPlayer( entity player )
{
	TraceResults r = GetViewTrace( player )
    var s = CtrlReaper(r.endPos,player.GetAngles())
<<<<<<< HEAD
    //doesnt do shit ViewConeZero( player )
=======
>>>>>>> bc24e36 (Reaper as Titan)
}

bool function spawndummyfunc (entity player, array<string> args ) {
	entity guy = CreateSoldier(TEAM_BOTH,GetViewTrace( player ).endPos,player.GetAngles())
	DispatchSpawn( guy )
	try{if (args[0] == "freeze") {guy.Freeze()}}catch(ex){}
	return true
}


bool function testfunc (entity player, array<string> args ) {
    thread testthread(player)
    return true
}

void function testthread (entity player) {
<<<<<<< HEAD
	entity reaper = CreatePropDynamic($"models/robots/super_spectre/super_spectre_v1.mdl",<0,0,0>,<0, 0, 0>,SOLID_VPHYSICS)
	reaper.SetOrigin(GetViewTrace( player ).endPos)
	reaper.SetAngles(player.GetAngles())
	testanim(reaper)
}

void function testanim (entity ai) {

	vector origin = ai.GetOrigin()
	entity mover = CreateOwnedScriptMover( ai )
	ai.SetParent( mover, "", false, 0 )
	ai.Hide()

	WaitFrame() // give AI time to hide before moving
	ai.Anim_Play("sspec_speclaunch_fire")
	ai.Anim_Stop()

	vector warpPos = origin + < 0, 0, 1000 >
	mover.SetOrigin( warpPos )


	EmitSoundAtPosition( TEAM_UNASSIGNED, origin, "Titan_1P_Warpfall_Start" )

	local e = {}
	e.warpfx <- PlayFX( TURBO_WARP_FX, warpPos + < 0, 0, -104 >, mover.GetAngles() )
	e.smokeFx <- null

	wait 0.5

	EmitSoundAtPosition( TEAM_UNASSIGNED, origin, "Titan_3P_Warpfall_WarpToLanding" )

	wait 0.4

	ai.Show()

	e.smokeFx = PlayFXOnEntity( TURBO_WARP_COMPANY, ai, "", <0.0, 0.0, 152.0> )

	local time = 0.2
	mover.MoveTo( origin, time, 0, 0 )
	wait time

	e.smokeFx.Destroy()
	PlayFX( $"droppod_impact", origin )
}
=======
	 PlayerEarnMeter_SetOwnedFrac( player, 1.0 )
}

>>>>>>> bc24e36 (Reaper as Titan)








//how to find animations: open the mdl containing the anims in a hex editor and search for the modelname (here its the superspectrecore one and the searchterm is sspec)
//search for cat_or_not and playanim in the modding-chat channel in the northstar discrd for more details

//"sspec_idle" idle anim

//"sspec_speclaunch_fire" kinda crouching like before jumping
//"sspec_speclaunch_to_idle" //dk

//sspec_attack_idle //attack pose
//sspec_idle_to_attack_f //from idle anim to attack pose
//sspec_idle_to_startup_to_attack_f //cooler idle to attack pose

//"sspec_aim" //spazzes out
//sspec_idle_to_walk //kinda slow walk , probably ment to be a transition
//sspec_walk_to_idle //probably also a transition

//"sspec_dash_short_r_hop" //short hop to the right //replace r with l for left

//sspec_idle_melee_high //melee attack from above with right hand
//sspec_run_melee //melee attack from below with left hand

//sspec_sprint_temp //looping sprint animation

//sspec_attack_powerdown_idle //superhero landing esq pose
//sspec_attack_powerdown_start //dk man
//sspec_attack_powerdown_end //dk man but reverse

//sspec_speclaunch_to_idle //after landing i think
//sspec_attack_groundslam" //damage included

/* sorta working fire animation
thread PlayAnim(reaper,"sspec_attack_aimtrans_l_to_f",null,null,2)
wait 0.5
thread PlayAnim(reaper,"sspec_attack_aimtrans_r_to_f",null,null,2)
wait 0.5
*/

/* sorta working fly animation
thread PlayAnim(reaper,"sspec_idle_to_speclaunch",null,null,0)
wait 2
thread PlayAnim(reaper,"sspec_speclaunch_to_idle",null,null,0)
wait 2
*/


<<<<<<< HEAD





//    LaunchExternalWebBrowser( "youtube.com", WEBBROWSER_FLAG_FORCEEXTERNAL ) opens a browser lmao only client tho

/*titan indicator

vector origin =  GetViewTrace( player ).endPos
float delay = 3
player.EndSignal( "OnDestroy" )
float endTime = Time() + delay

for ( ;; )
{
	if ( !IsAlive( player ) )
	{
		player.WaitSignal( "OnRespawned" )
		continue
	}

	float remainingTime = endTime - Time()
	if ( remainingTime <= 0 )
		return

	player.SetHotDropImpactDelay( remainingTime )
	Remote_CallFunction_Replay( player, "ServerCallback_ReplacementTitanSpawnpoint", origin.x, origin.y, origin.z, Time() + remainingTime )
	player.WaitSignal( "OnDeath" )
=======
//    LaunchExternalWebBrowser( "youtube.com", WEBBROWSER_FLAG_FORCEEXTERNAL ) opens a browser lmao only client tho

/*titan indicator
	Remote_CallFunction_Replay( player, "ServerCallback_ReplacementTitanSpawnpoint", origin.x, origin.y, origin.z, Time() + remainingTime )
>>>>>>> bc24e36 (Reaper as Titan)
}*/