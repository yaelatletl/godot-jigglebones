@tool
extends Window

@onready var menu_select = get_node("%BoneSelect")
@onready var custom_name = get_node("%BoneCustom")
@onready var toggle = get_node("%Toggle")
@onready var accept = get_node("%AcceptButton")

signal bone_selected(name: String)

var bone_list = []
var selected_bone_name: Dictionary = {}

func _ready() -> void:
	menu_select.get_popup().id_pressed.connect(_on_id_pressed)

	for bone in bone_list:
		menu_select.get_popup().add_item(bone)

	accept.pressed.connect(_on_accept_pressed)
	toggle.toggled.connect(_on_toggle_toggled)
	close_requested.connect(_on_close_requested)

func _on_close_requested() -> void:
	bone_selected.emit("")
	queue_free()

func _on_id_pressed(id: int) -> void:
	selected_bone_name["id"] = menu_select.get_popup().get_item_text(id)
	menu_select.text = selected_bone_name["id"]
	bone_selected.emit(selected_bone_name["id"])


func _on_toggle_toggled(use_custom: bool) -> void:
	print(use_custom)
	menu_select.disabled = use_custom
	custom_name.editable = use_custom

func _on_accept_pressed() -> void:
	if toggle.pressed:
		bone_selected.emit(custom_name.text)
	queue_free()

func setup(bone_list: Array = []) -> void:
	self.bone_list = bone_list
	
	
