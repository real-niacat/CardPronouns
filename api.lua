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