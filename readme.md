# CardPronouns!
The mod everyone needed!

Adds pronouns to cards, because honestly I think we all needed it.

All cards now have their own pronouns, and playing cards even have three!
One based on their enhancement, suit, and rank

## For developers:
If you'd like to change the pronouns of a card, for any reason

Simply set the center's `pronouns` field to a table containing the text, colour and text colour

Example:

```
SMODS.Joker {
    ...
    pronouns = {
        text = "She/They",
        colour = G.C.RED,
        text_colour = G.C.WHITE
    }
}

```

# Inspiration
This mod was heavily inspired by a [similar mod](https://geode-sdk.org/mods/n.level-pronouns) for Geometry Dash