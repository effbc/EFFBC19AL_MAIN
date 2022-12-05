xmlport 80216 "GEN Templates"
{
    Format = VariableText;

    schema
    {
        textelement(GenJournalTemplates)
        {
            tableelement("<genjournaltemplate>"; "Gen. Journal Template")
            {
                XmlName = 'GenJournalTemplate';
                fieldelement(Name; "<GenJournalTemplate>".Name)
                {
                }
                fieldelement(Description; "<GenJournalTemplate>".Description)
                {
                }
                fieldelement(Type; "<GenJournalTemplate>".Type)
                {
                }
                fieldelement(Recurring; "<GenJournalTemplate>".Recurring)
                {
                }
                fieldelement(BalAccountType; "<GenJournalTemplate>"."Bal. Account Type")
                {
                }
                fieldelement(SourceCode; "<GenJournalTemplate>"."Source Code")
                {
                }
                fieldelement(ForceDocBalance; "<GenJournalTemplate>"."Force Doc. Balance")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

