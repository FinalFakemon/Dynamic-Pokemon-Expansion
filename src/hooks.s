.thumb
.align 2

@0x8103530 with r1
PrepareDexListViewsHook:
	cmp r0, #0x0
	beq PrepareDexListViewsReturn
	ldr r2, =gNumDexEntries
	ldrh r2, [r2]
	str r2, [sp]

PrepareDexListViewsReturn:
	ldr r0, =0x810353A | 1
	bx r0

.pool
@0x8103684 with r1
AlphabeticalDexHook:
	add r8, r0
	ldr r0, =gNumSpecies
	ldrh r0, [r0]
	cmp r8, r0
	ldr r1, =0x810368C | 1
	bx r1

.pool
@0x8105CBC with r0
AlternateDexEntriesHook:
	lsl r2, r2, #0x18
	lsr r5, r2, #0x18
	lsl r3, r3, #0x18
	lsr r7, r3, #0x18
	mov r0, r1
	mov r4, r1
	bl TryLoadAlternateDexEntry
	cmp r0, #0x0
	bne AlternateDexEntriesReturn
	mov r0, r4
	ldr r1, =0x8105CC6 | 1
bxr1:
	bx r1

AlternateDexEntriesReturn:
	push {r0}
	mov r0, r4
	ldr r1, =SpeciesToNationalPokedexNum
	bl bxr1
	mov r4, r0
	mov r1, #0x1
	mov r2, #0x0
	bl DexFlagCheckCall
	lsl r0, #0x18
	cmp r0, #0x0
	pop {r0}
	beq DontDisplayDesc
	mov r1, r0
	ldr r0, =0x8105CEA | 1
	bx r0

DontDisplayDesc:
	ldr r0, =0x8105D5C | 1
	bx r0

DexFlagCheckCall:
	ldr r3, =0x8104AB0 | 1
	bx r3

@0x8045C58 with r0
UpdateEggMoveLimit:
	add r0, r2, #0x1
	lsl r0, r0, #0x10
	lsr r2, r0, #0x10
	push {r2}
	bl GetUpdatedEggMoveLimit
	pop {r2}
	ldr r1, =0x8045C60 | 1
	bx r1

@0x800ECF2 with r4
LoadSpecialPokePicHook:
	mov r7, r8
	push {r7}
	ldr r4, [sp, #0x18]
	sub sp, #0x4
	str r4, [sp, #0x0]
	bl LoadSpecialPokePic
	add sp, #0x4
	pop {r7}
	mov r8, r7
	pop {r4-r7}
	pop {r0}
	bx r0

@0x8096E38 with r2
GenderedMonIconHook:
	lsr r7, r3, #0x10
	lsl r0, #0x18
	lsr r0, #0x18
	mov r9, r0

	mov r0, r4
	ldr r1, [sp, #0x50] @Personality
	bl TryGetFemaleGenderedSpecies
	mov r4, r0

	ldr r1, [sp, #0x50] @Personality
	ldr r0, =0x8096E40 | 1
	bx r0
	
