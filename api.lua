

function CardPronouns.Pronoun(tab)
    if tab.pronoun_table and tab.key then
        CardPronouns.badge_types[tab.key] = tab

        if tab.classification then
            for i, pronoun in pairs(tab.pronoun_table) do
                local nexti = #CardPronouns.classifications[tab.classification].pronouns + 1
                CardPronouns.classifications[tab.classification].pronouns[nexti] = pronoun
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

