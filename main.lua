loc_colour()
CardPronouns = {}
CardPronouns.badge_types = {}
CardPronouns.classifications = {}

function CardPronouns.contains(table, check)
    for _, val in pairs(table) do
        if val == check then
            return true
        end
    end
    return false
end

function CardPronouns.overlap(table1, table2)
    local result = false

    for i, entry in pairs(table2) do
        if CardPronouns.contains(table1, entry) then
            return true
        end
    end
    return false
end

function CardPronouns.format(tab)
    local t = ""
    for i, entry in ipairs(tab) do
        t = t .. entry .. (tab[i + 1] and "/" or "")
    end
    return t
end

function CardPronouns.get_available_pronouns()
    local prns = {}

    for _, entry in pairs(CardPronouns.badge_types) do
        if entry.in_pool and entry.in_pool() then
            prns[#prns + 1] = entry
        end
    end
    return prns
end

function CardPronouns.badge_by_string(str)
    local n = 1
    local allowed = CardPronouns.get_available_pronouns()

    for i = 1, #(str or "") do
        local code = string.byte(str, i, i)
        n = (code * i)
    end

    math.randomseed(n)
    return allowed[math.random(1, #allowed)]
end

function CardPronouns.Pronoun(tab)
    if tab.pronoun_table and tab.key then
        CardPronouns.badge_types[tab.key] = tab

        if tab.classification then
            for i, pronoun in pairs(tab.pronoun_table) do
                local nexti = #CardPronouns.classifications[tab.classifications] + 1
                CardPronouns.classifications[tab.classifications][nexti] = pronoun
            end
        end

        -- incredibly simple
    else
        error("Failed to initialize pronoun: Missing pronoun_table or key")
    end
end

--may optionally contain a set of pronouns that are part of it
function CardPronouns.PronounClassification(tab)
    if tab.key then
        tab.pronouns = tab.pronouns or {}
        if not tab.exclude_anyall then
            tab.pronouns[#tab.pronouns + 1] = "Any"
            tab.pronouns[#tab.pronouns + 1] = "All"
        end
        CardPronouns.classifications[tab.key] = tab
        -- incredibly simple
    else
        error("Failed to initialize pronoun classification: Missing key")
    end
end

function CardPronouns.has(set, key)
    local cen = G.P_CENTERS[key]
    return CardPronouns.overlap(CardPronouns.badge_types[cen.pronouns].pronoun_table,
        (CardPronouns.classifications[set] and CardPronouns.classifications[set].pronouns) or {})
end

function CardPronouns.is(prnskey, cardkey)
    return prnskey == G.P_CENTERS[cardkey].pronouns
end

local fakemodbadge = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    fakemodbadge(obj, badges)
    if not obj then
        return
    end

    local badge = nil

    badge = CardPronouns.badge_by_string(obj.key)

    if G.P_CENTERS[obj.key] and G.P_CENTERS[obj.key].pronouns then
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

local function load_pronouns()
    for key, cent in pairs(G.P_CENTERS) do
        G.P_CENTERS[key].pronouns = G.P_CENTERS[key].pronouns or CardPronouns.badge_by_string(key).key
    end
end

local smodsinject = SMODS.injectItems

function SMODS.injectItems(...)
    smodsinject(...)

    load_pronouns()
end

CardPronouns.PronounClassification {
    key = "masculine",
    pronouns = { "He", "Him", "His" }
}

CardPronouns.PronounClassification {
    key = "feminine",
    pronouns = { "She", "Her", "Hers" }
}

CardPronouns.PronounClassification {
    key = "neutral",
    pronouns = { "They", "Them", "Theirs", "It", "Its" }
}

CardPronouns.Pronoun {
    colour = HEX("FF90FF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "She", "Her" },
    in_pool = function()
        return true
    end,
    key = "she_her"
}
CardPronouns.Pronoun {
    colour = HEX("61B5FA"),
    text_colour = G.C.WHITE,
    pronoun_table = { "He", "Him" },
    in_pool = function()
        return true
    end,
    key = "he_him"
}
CardPronouns.Pronoun {
    colour = HEX("A83EFF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "They", "Them" },
    in_pool = function()
        return true
    end,
    key = "they_them"
}
CardPronouns.Pronoun {
    colour = HEX("FF89E5"),
    text_colour = G.C.WHITE,
    pronoun_table = { "Any", "All" },
    in_pool = function()
        return true
    end,
    key = "any_all"
}
CardPronouns.Pronoun {
    colour = HEX("5F5F5F"),
    text_colour = G.C.WHITE,
    pronoun_table = { "It", "Its" },
    in_pool = function()
        return true
    end,
    key = "it_its"
}
CardPronouns.Pronoun {
    colour = HEX("FFABFF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "She", "They" },
    in_pool = function()
        return true
    end,
    key = "she_they"
}
CardPronouns.Pronoun {
    colour = HEX("96D0FF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "He", "They" },
    in_pool = function()
        return true
    end,
    key = "he_they"
}
