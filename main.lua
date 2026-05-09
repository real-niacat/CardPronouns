loc_colour()
CardPronouns = SMODS.current_mod
CardPronouns.badge_types = {}
CardPronouns.classifications = {}
CardPronouns.PlayingCardOverrides = {}

assert(SMODS.load_file("util.lua"))()
assert(SMODS.load_file("api.lua"))()
assert(SMODS.load_file("badge.lua"))()
assert(SMODS.load_file("pronouns.lua"))()