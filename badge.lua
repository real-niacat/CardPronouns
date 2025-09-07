local fakemodbadge = SMODS.create_mod_badges
last_hovered_card = nil
function SMODS.create_mod_badges(obj, badges)
    fakemodbadge(obj, badges)
    if not obj then
        return
    end
    if obj.is_rank or obj.is_suit then
        return
    end

    -- print(obj.key)
    -- last_hovered_card = obj

    local badge = nil

    -- badge = CardPronouns.badge_by_string(obj.key)
    badge = CardPronouns.badge_by_obj(obj)

    if G.P_CENTERS[obj.key] and G.P_CENTERS[obj.key].pronouns and not (obj.base_card and obj.base_card.base) then
        badge = CardPronouns.badge_types[G.P_CENTERS[obj.key].pronouns]
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
                                string = CardPronouns.format(badge.pronoun_table),
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