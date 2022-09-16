untyped
global function Reaper_Controller_Init

void function Reaper_Controller_Init () {
	AddCallback_OnClientConnected( AddSelectInputs )
	CPlayer.CycleActive <- false
	CPlayer.UseActive <- false
	CPlayer.EquipedReaperAsTitan <- false

    AddClientCommandCallback( "spawnreaper", spawnfunc )
    AddClientCommandCallback( "test", testfunc )
	AddClientCommandCallback( "dummy", spawndummyfunc )
}

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
	PrevenWeaponCycle(player,player.GetActiveWeapon())
	player.CycleActive = true
	CheckForCombination(player)
}

void function SetCycleInactive(entity player) {
	PrevenWeaponCycle(player,player.GetActiveWeapon())
	player.CycleActive = false
}

void function PrevenWeaponCycle(entity player ,entity activeweaponbeforechange) {
	if (player.UseActive == true ) { //prevents weapon change when you toggled reaper
		foreach (index , wpn in player.GetMainWeapons()) {
			if (wpn == activeweaponbeforechange) {
				player.SetActiveWeaponBySlot( index )
			}
		}
	}

}

void function CheckForCombination(entity player) {
	if (player.CycleActive == true && player.UseActive == true) {
		if (IsValid(player)) {
			player.EquipedReaperAsTitan = !expect bool (player.EquipedReaperAsTitan)
			//EmitSoundOnEntity(player, "titan_eject_dpad" )
			EmitSoundOnEntityOnlyToPlayer( player,player, "titan_eject_dpad" )
			if (player.EquipedReaperAsTitan) {
				Chat_ServerPrivateMessage(player,"Your next Titanfall will be a: Reaper !", false)
			} else {
				Chat_ServerPrivateMessage(player,"Your next Titanfall will be a: Titan !", false)
			}
		}
	}
}



///////////////////////////////////dev-functions///////////////////////////////////////////////
bool function spawnfunc (entity player, array<string> args ) {
    SpawnReaperForPlayer( player )
	return true
}

void function SpawnReaperForPlayer( entity player )
{
	TraceResults r = GetViewTrace( player )
    var s = CtrlReaper(r.endPos,player.GetAngles())
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


}










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


//    LaunchExternalWebBrowser( "youtube.com", WEBBROWSER_FLAG_FORCEEXTERNAL ) opens a browser lmao only client tho

/*titan indicator
	Remote_CallFunction_Replay( player, "ServerCallback_ReplacementTitanSpawnpoint", origin.x, origin.y, origin.z, Time() + remainingTime )
}*/