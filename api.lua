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

function CardPronouns.badge_by_obj(obj)
    local badge = CardPronouns.badge_by_string(obj.key or obj.config.center.key)
    if obj.base_card and obj.base_card.base and obj.base_card.base.id then
        local en = next(SMODS.get_enhancements(obj.base_card))
        local suit = SMODS.Suits[obj.base_card.base.suit]
        local rank = SMODS.Ranks[obj.base_card.base.value]
        local res = suit.key .. rank.key .. (en or "")
        badge = CardPronouns.badge_by_string(res)
    end

    if obj.base and obj.base.id then
        local en = next(SMODS.get_enhancements(obj))
        local suit = SMODS.Suits[obj.base.suit]
        local rank = SMODS.Ranks[obj.base.value]
        local res = suit.key .. rank.key .. (en or "")
        badge = CardPronouns.badge_by_string(res)
    end
    return badge
end

function CardPronouns.Pronoun(tab)
    if tab.pronoun_table and tab.key then
        CardPronouns.badge_types[tab.key] = tab

        if tab.classification then
            for i, pronoun in pairs(tab.pronoun_table) do
                local nexti = #CardPronouns.classifications[tab.classification] + 1
                CardPronouns.classifications[tab.classification][nexti] = pronoun
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

function CardPronouns.has(set, card)
    local check = CardPronouns.badge_by_obj(card).pronoun_table
    local match = (CardPronouns.classifications[set] and CardPronouns.classifications[set].pronouns) or {}
    return CardPronouns.overlap(check, match)
end

function CardPronouns.is(prnskey, card)
    return prnskey == CardPronouns.badge_by_obj(card).key
end

function CardPronouns.find_all(set, strict)
    local found = {}
    for _, cardarea in pairs(G.I.CARDAREA) do
        for __, card in pairs(cardarea.cards) do
            if strict then
                if CardPronouns.is(set, card) then
                    found[#found + 1] = card
                end
            else
                if CardPronouns.has(set, card) then
                    found[#found + 1] = card
                end
            end
        end
    end

    return found
end