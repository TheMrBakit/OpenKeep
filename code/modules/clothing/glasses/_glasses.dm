//Glasses
/obj/item/clothing/glasses
	name = "glasses"
	icon = 'icons/obj/clothing/glasses.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = GLASSESCOVERSEYES
	slot_flags = ITEM_SLOT_HEAD
	strip_delay = 20
	equip_delay_other = 25
	resistance_flags = NONE
	custom_materials = list(/datum/material/glass = 250)
	var/vision_flags = 0
	var/darkness_view = 2//Base human is 2
	var/invis_view = SEE_INVISIBLE_LIVING	//admin only for now
	var/invis_override = 0 //Override to allow glasses to set higher than normal see_invis
	var/lighting_alpha
	var/list/icon/current = list() //the current hud icons
	var/vision_correction = 0 //does wearing these glasses correct some of our vision defects?
	var/glass_colour_type //colors your vision when worn

/obj/item/clothing/glasses/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] is stabbing \the [src] into [user.p_their()] eyes! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS

/obj/item/clothing/glasses/examine(mob/user)
	. = ..()
	if(glass_colour_type && ishuman(user))
		. += "<span class='notice'>Alt-click to toggle its colors.</span>"

/obj/item/clothing/glasses/visor_toggling()
	..()
	if(visor_vars_to_toggle & VISOR_VISIONFLAGS)
		vision_flags ^= initial(vision_flags)
	if(visor_vars_to_toggle & VISOR_DARKNESSVIEW)
		darkness_view ^= initial(darkness_view)
	if(visor_vars_to_toggle & VISOR_INVISVIEW)
		invis_view ^= initial(invis_view)

/obj/item/clothing/glasses/weldingvisortoggle(mob/user)
	. = ..()
	if(. && user)
		user.update_sight()

//called when thermal glasses are emped.
/obj/item/clothing/glasses/proc/thermal_overload()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/H = src.loc
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(!(HAS_TRAIT(H, TRAIT_BLIND)))
			if(H.glasses == src)
				to_chat(H, "<span class='danger'>[src] overloads and blinds you!</span>")
				H.flash_act(visual = 1)
				H.blind_eyes(3)
				H.blur_eyes(5)
				eyes.applyOrganDamage(5)

/obj/item/clothing/glasses/meson
	name = "optical meson scanner"
	desc = ""
	icon_state = "meson"
	item_state = "meson"
	darkness_view = 2
	vision_flags = SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/meson/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] is putting \the [src] to [user.p_their()] eyes and overloading the brightness! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS

/obj/item/clothing/glasses/meson/night
	name = "night vision meson scanner"
	desc = ""
	icon_state = "nvgmeson"
	item_state = "nvgmeson"
	darkness_view = 8
	flash_protect = FLASH_PROTECTION_SENSITIVE
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/meson/gar
	name = "gar mesons"
	icon_state = "garm"
	item_state = "garm"
	desc = ""
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/blank.ogg'
	sharpness = IS_SHARP

/obj/item/clothing/glasses/science
	name = "science goggles"
	desc = ""
	icon_state = "purple"
	item_state = "glasses"
	clothing_flags = SCAN_REAGENTS //You can see reagents while wearing science goggles
	actions_types = list(/datum/action/item_action/toggle_research_scanner)
	glass_colour_type = /datum/client_colour/glass_colour/purple
	resistance_flags = ACID_PROOF
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)

/obj/item/clothing/glasses/science/item_action_slot_check(slot)
	if(slot == SLOT_GLASSES)
		return 1

/obj/item/clothing/glasses/night
	name = "night vision goggles"
	desc = ""
	icon_state = "night"
	item_state = "glasses"
	darkness_view = 8
	flash_protect = FLASH_PROTECTION_SENSITIVE
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/science/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] is tightening \the [src]'s straps around [user.p_their()] neck! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return OXYLOSS

/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	desc = ""
	icon_state = "eyepatch"
	item_state = "eyepatch"

/obj/item/clothing/glasses/monocle
	name = "monocle"
	desc = ""
	icon_state = "monocle"
	item_state = "headset" // lol

/obj/item/clothing/glasses/material
	name = "optical material scanner"
	desc = ""
	icon_state = "material"
	item_state = "glasses"
	vision_flags = SEE_OBJS
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/material/mining
	name = "optical material scanner"
	desc = ""
	icon_state = "material"
	item_state = "glasses"
	darkness_view = 0

/obj/item/clothing/glasses/material/mining/gar
	name = "gar material scanner"
	icon_state = "garm"
	item_state = "garm"
	desc = ""
	force = 10
	throwforce = 20
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/blank.ogg'
	sharpness = IS_SHARP
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/regular
	name = "prescription glasses"
	desc = ""
	icon_state = "glasses"
	item_state = "glasses"
	vision_correction = 1 //corrects nearsightedness

/obj/item/clothing/glasses/regular/jamjar
	name = "jamjar glasses"
	desc = ""
	icon_state = "jamjar_glasses"
	item_state = "jamjar_glasses"

/obj/item/clothing/glasses/regular/hipster
	name = "prescription glasses"
	desc = ""
	icon_state = "hipster_glasses"
	item_state = "hipster_glasses"

/obj/item/clothing/glasses/regular/circle
	name = "circle glasses"
	desc = ""
	icon_state = "circle_glasses"
	item_state = "circle_glasses"

//Here lies green glasses, so ugly they died. RIP

/obj/item/clothing/glasses/sunglasses
	name = "sunglasses"
	desc = ""
	icon_state = "sun"
	item_state = "sunglasses"
	darkness_view = 1
	flash_protect = FLASH_PROTECTION_FLASH
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/glasses/sunglasses/reagent
	name = "beer goggles"
	desc = ""
	clothing_flags = SCAN_REAGENTS

/obj/item/clothing/glasses/sunglasses/reagent/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user) && slot == SLOT_GLASSES)
		ADD_TRAIT(user, TRAIT_BOOZE_SLIDER, CLOTHING_TRAIT)

/obj/item/clothing/glasses/sunglasses/reagent/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_BOOZE_SLIDER, CLOTHING_TRAIT)

/obj/item/clothing/glasses/sunglasses/garb
	name = "black gar glasses"
	desc = ""
	icon_state = "garb"
	item_state = "garb"
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/blank.ogg'
	sharpness = IS_SHARP

/obj/item/clothing/glasses/sunglasses/garb/supergarb
	name = "black giga gar glasses"
	desc = ""
	icon_state = "supergarb"
	item_state = "garb"
	force = 12
	throwforce = 12

/obj/item/clothing/glasses/sunglasses/gar
	name = "gar glasses"
	desc = ""
	icon_state = "gar"
	item_state = "gar"
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/blank.ogg'
	sharpness = IS_SHARP
	glass_colour_type = /datum/client_colour/glass_colour/orange

/obj/item/clothing/glasses/sunglasses/gar/supergar
	name = "giga gar glasses"
	desc = ""
	icon_state = "supergar"
	item_state = "gar"
	force = 12
	throwforce = 12
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/welding
	name = "welding goggles"
	desc = ""
	icon_state = "welding-g"
	item_state = "welding-g"
	actions_types = list(/datum/action/item_action/toggle)
	flash_protect = FLASH_PROTECTION_WELDER
	custom_materials = list(/datum/material/iron = 250)
	tint = 2
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	flags_cover = GLASSESCOVERSEYES
	glass_colour_type = /datum/client_colour/glass_colour/gray

/obj/item/clothing/glasses/welding/attack_self(mob/user)
	weldingvisortoggle(user)


/obj/item/clothing/glasses/blindfold
	name = "blindfold"
	desc = ""
	icon_state = "blindfold"
	item_state = "blindfold"
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 3
	darkness_view = 1
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/glasses/blindfold/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_GLASSES)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/blindfold/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/blindfold/white
	name = "blind personnel blindfold"
	desc = ""
	icon_state = "blindfoldwhite"
	item_state = "blindfoldwhite"
	var/colored_before = FALSE

/obj/item/clothing/glasses/blindfold/white/equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && slot == SLOT_GLASSES)
		update_icon(user)
		user.update_inv_glasses() //Color might have been changed by update_icon.
	..()

/obj/item/clothing/glasses/blindfold/white/update_icon(mob/living/carbon/human/user)
	if(ishuman(user) && !colored_before)
		add_atom_colour("#[user.eye_color]", FIXED_COLOUR_PRIORITY)
		colored_before = TRUE

/obj/item/clothing/glasses/blindfold/white/worn_overlays(isinhands = FALSE, file2use)
	. = list()
	if(!isinhands && ishuman(loc) && !colored_before)
		var/mob/living/carbon/human/H = loc
		var/mutable_appearance/M = mutable_appearance('icons/mob/clothing/eyes.dmi', "blindfoldwhite")
		M.appearance_flags |= RESET_COLOR
		M.color = "#[H.eye_color]"
		. += M

/obj/item/clothing/glasses/sunglasses/big
	desc = ""
	icon_state = "bigsunglasses"
	item_state = "bigsunglasses"

/obj/item/clothing/glasses/thermal
	name = "optical thermal scanner"
	desc = ""
	icon_state = "thermal"
	item_state = "glasses"
	vision_flags = SEE_MOBS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	flash_protect = FLASH_PROTECTION_SENSITIVE
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()

/obj/item/clothing/glasses/thermal/xray
	name = "syndicate xray goggles"
	desc = ""
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS

/obj/item/clothing/glasses/thermal/monocle
	name = "thermoncle"
	desc = ""
	icon_state = "thermoncle"
	flags_1 = null //doesn't protect eyes because it's a monocle, duh

/obj/item/clothing/glasses/thermal/monocle/examine(mob/user) //Different examiners see a different description!
	if(user.gender == MALE)
		desc = replacetext(desc, "person", "man")
	else if(user.gender == FEMALE)
		desc = replacetext(desc, "person", "woman")
	. = ..()
	desc = initial(desc)

/obj/item/clothing/glasses/thermal/eyepatch
	name = "optical thermal eyepatch"
	desc = ""
	icon_state = "eyepatch"
	item_state = "eyepatch"

/obj/item/clothing/glasses/cold
	name = "cold goggles"
	desc = ""
	icon_state = "cold"
	item_state = "cold"

/obj/item/clothing/glasses/heat
	name = "heat goggles"
	desc = ""
	icon_state = "heat"
	item_state = "heat"

/obj/item/clothing/glasses/orange
	name = "orange glasses"
	desc = ""
	icon_state = "orangeglasses"
	item_state = "orangeglasses"
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/red
	name = "red glasses"
	desc = ""
	icon_state = "redglasses"
	item_state = "redglasses"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/godeye
	name = "eye of god"
	desc = ""
	icon_state = "godeye"
	item_state = "godeye"
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS
	darkness_view = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	clothing_flags = SCAN_REAGENTS

/obj/item/clothing/glasses/godeye/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, EYE_OF_GOD_TRAIT)

/obj/item/clothing/glasses/godeye/attackby(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, src) && W != src && W.loc == user)
		if(W.icon_state == "godeye")
			W.icon_state = "doublegodeye"
			W.item_state = "doublegodeye"
			W.desc = ""
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.update_inv_wear_mask()
		else
			to_chat(user, "<span class='notice'>The eye winks at you and vanishes into the abyss, you feel really unlucky.</span>")
		qdel(src)
	..()

/obj/item/clothing/glasses/AltClick(mob/user)
	if(glass_colour_type && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.client)
			if(H.client.prefs)
				if(src == H.glasses)
					H.client.prefs.uses_glasses_colour = !H.client.prefs.uses_glasses_colour
					if(H.client.prefs.uses_glasses_colour)
						to_chat(H, "<span class='notice'>I will now see glasses colors.</span>")
					else
						to_chat(H, "<span class='notice'>I will no longer see glasses colors.</span>")
					H.update_glasses_color(src, 1)
	else
		return ..()

/obj/item/clothing/glasses/proc/change_glass_color(mob/living/carbon/human/H, datum/client_colour/glass_colour/new_color_type)
	var/old_colour_type = glass_colour_type
	if(!new_color_type || ispath(new_color_type)) //the new glass colour type must be null or a path.
		glass_colour_type = new_color_type
		if(H && H.glasses == src)
			if(old_colour_type)
				H.remove_client_colour(old_colour_type)
			if(glass_colour_type)
				H.update_glasses_color(src, 1)


/mob/living/carbon/human/proc/update_glasses_color(obj/item/clothing/glasses/G, glasses_equipped)
	if(client && client.prefs.uses_glasses_colour && glasses_equipped)
		add_client_colour(G.glass_colour_type)
	else
		remove_client_colour(G.glass_colour_type)
