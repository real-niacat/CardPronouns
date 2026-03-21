---@meta

---@class CardPronouns.Pronoun
---@field pronoun_table table
---@field key string
---@field classification? string
---@field colour? table
---@field text_colour? table
---@field in_pool? fun():boolean

---@class CardPronouns.PronounClassification
---@field key string
---@field pronouns? string[]
---@field exclude_anyall? boolean

---@class CardPronouns.PlayingCardOverride
---@field key string
---@field pronoun string
---@field suit? string
---@field rank? string
---@field enhancement? string

---@class SMODS.Center
---@field pronouns? string