extends Node
var skill : Dictionary ={
	0:"silvery",
	8:"gold",
	16:"wood",
	32:"water",
	64:"fire"
}

var skill_name : Dictionary ={
	"silvery" : "魔法飞弹",
	"gold" : "金符「金属疲劳」",
	"wood" : "木符「风灵的角笛」",
	"water" : "水符「水精公主」",
	"fire" : "火符「火神之光」",
	"noskill" : "没有技能"
}

var skill_description : Dictionary={
	"silvery" : "我释放魔法飞弹",
	"gold" : "以投掷金属铸成的弹丸进行攻击的弹幕。弹丸射出后半路上就会破碎分解。破碎了总伤害却会变高，难以探究其中的原因。",
	"wood" : "让树叶随风飘舞的弹幕。会自动吹向敌人，不过很笨。",
	"water" : "发动后水珠四散射出的弹幕。水珠的飞行弹道是笔直的。打在身上会很痛。",
	"fire" : "发动后生成火焰的弹幕。威力惊人，擅长对付群聚的敌人。",
	"noskill" : "全都不会用"
}
