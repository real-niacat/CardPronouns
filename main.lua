loc_colour()
CardPronouns = SMODS.current_mod
CardPronouns.badge_types = {}
CardPronouns.classifications = {}

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

assert(SMODS.load_file("api.lua"))()
assert(SMODS.load_file("badge.lua"))()
assert(SMODS.load_file("pronouns.lua"))()