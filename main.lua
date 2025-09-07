loc_colour()
local badge_types = {
    {
        text = "She/Her",
        colour = HEX("FF90FF"),
        text_colour = G.C.WHITE,
    },
    {
        text = "He/Him",
        colour = HEX("61B5FA"),
        text_colour = G.C.WHITE,
    },
    {
        text = "They/Them",
        colour = HEX("A83EFF"),
        text_colour = G.C.WHITE,
    },
    {
        text = "Any/All",
        colour = HEX("FF89E5"),
        text_colour = G.C.WHITE,
    },
    {
        text = "It/Its",
        colour = HEX("5F5F5F"),
        text_colour = G.C.WHITE,
    },


    {
        text = "She/They",
        colour = HEX("FFABFF"),
        text_colour = G.C.WHITE,
    },
    {
        text = "He/They",
        colour = HEX("96D0FF"),
        text_colour = G.C.WHITE,
    },
}

local fakemodbadge = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    fakemodbadge(obj, badges)
    if not obj then
        return
    end

    local badge = nil

    badge = badge_by_string(obj.key)

    if G.P_CENTERS[obj.key] and G.P_CENTERS[obj.key].pronouns then 
        badge = G.P_CENTERS[obj.key].pronouns
    end

    badges[#badges + 1] = {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    colour = badge.colour,
                    r = 0.1,
                    minw = 2,
                    minh = 0.36,
                    emboss = 0.05,
                    padding = 0.027,
                },
                nodes = {
                    { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText({
                                string = badge.text,
                                colours = { badge.text_colour or G.C.WHITE },
                                silent = true,
                                float = true,
                                shadow = true,
                                offset_y = -0.03,
                                spacing = 1,
                                scale = 0.33 * 0.9,
                            }),
                        },
                    },
                    { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                },
            },
        },
    }
end



function badge_by_string(str)
    local n = 1

    for i=1,#str do
        local code = string.byte(str, i, i)
        n = (code * i)
    end

    math.randomseed(n)
    return badge_types[math.random(1,#badge_types)]

end

function load_pronouns()
    for key,cent in pairs(G.P_CENTERS) do
        G.P_CENTERS[key].pronouns = G.P_CENTERS[key].pronouns or badge_by_string(key)
    end
end

local smodsinject = SMODS.injectItems

function SMODS.injectItems(...)
    smodsinject(...)

    load_pronouns()

end 