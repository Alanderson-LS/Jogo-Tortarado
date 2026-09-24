extends Area2D

const MINIGAME = "scaring_birds"

func use_item(item: ItemData):
	if item.id == "rock":
		GameState.active_inventory().remove_item(item)
		GameState.main.load_minigame(MINIGAME)
