mcl_farming = {}

-- IMPORTANT API AND HELPER FUNCTIONS --
-- Contain functions for planting seed, addind plant growth and gourds (melon/pumpkin-like)
dofile(minetest.get_modpath("mcl_farming").."/shared_functions.lua")

-- ========= SOIL =========
dofile(minetest.get_modpath("mcl_farming").."/soil.lua")

-- ========= HOES =========
dofile(minetest.get_modpath("mcl_farming").."/hoes.lua")

-- ========= WHEAT =========
dofile(minetest.get_modpath("mcl_farming").."/wheat.lua")

-- ======= PUMPKIN =========
dofile(minetest.get_modpath("mcl_farming").."/pumpkin.lua")

-- ========= MELON =========
dofile(minetest.get_modpath("mcl_farming").."/melon.lua")

-- ========= CARROT =========
dofile(minetest.get_modpath("mcl_farming").."/carrots.lua")

-- ========= POTATOES =========
dofile(minetest.get_modpath("mcl_farming").."/potatoes.lua")

-- ========= BEETROOT =========
dofile(minetest.get_modpath("mcl_farming").."/beetroot.lua")

-- This function generates a row of plantlike and nodebox nodes whose
-- name starts with a given string, starting at a given position. It
-- places a given node below so that the rendering can be examined.
local function generate_plant_row(prefix, pos, below_node)
	local i = 1
	for node_name, node in pairs(minetest.registered_nodes) do
		if (
			1 == node_name:find(prefix) and
			(
				"plantlike" == node.drawtype or
				"nodebox" == node.drawtype
			)
		) then
			local node_pos = {
				x = pos.x + i,
				y = pos.y,
				z = pos.z,
			}
			minetest.set_node(
				node_pos,
				{
					name = node_name,
					param2 = node.place_param2 or 0
				}
			)
			local below_pos = {
				x = node_pos.x,
				y = node_pos.y - 1,
				z = node_pos.z
			}
			minetest.set_node(
				below_pos,
				below_node
			)
			i = i + 1
		end
	end
end

minetest.register_chatcommand("generate_farming_plant_rows",{
	description = "Generates rows of mcl_farming plant nodes on farming soil and glass",
	privs = { debug = true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local pos = player:get_pos()
		local node_prefixes = {
			"mcl_farming:beetroot",
			"mcl_farming:carrot",
			"mcl_farming:melon",
			"mcl_farming:potato",
			"mcl_farming:pumpkin",
			"mcl_farming:wheat",
		}
		for i,node_prefix in ipairs(node_prefixes) do
			generate_plant_row(
				node_prefix,
				pos,
				{ name = "mcl_farming:soil" }
			)
			pos.z = pos.z + 2
			generate_plant_row(
				node_prefix,
				pos,
				{ name = "mcl_core:glass" }
			)
			pos.z = pos.z + 2
		end
	end
})
