extends Button
var data
#refers to the upgrade cards title label and changes it to the upgrades name
@onready var title = $"VBoxContainer/mar_UpgradeName/lbl_UpgradeTitle"
#refers to the upgrade cards imagebox and changes it to the upgrades icon
@onready var image: TextureRect = $"VBoxContainer/mar_UpgradeIcon/img_UpgradeIcon"
#refers to the upgrade cards description label and changes it to the upgrades description
@onready var description = $"VBoxContainer/mar_UpgradeEffect/lbl_UpgradeDescription"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = "Bonk" 
	image.texture = PlaceholderTexture2D.new()
	description.text = "Stat: +/- x\nStat2: +/. x%"
	
func update():
	data = get_meta("Data")
	print(data)
	title.text = data["title"]
	description.text = data["description"]
	image.texture = ImageTexture.new()
	image.texture.set_image(Image.load_from_file(data["icon"]))
