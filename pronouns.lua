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
    colour = G.C.WHITE,
    text_colour = G.C.BLACK,
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
