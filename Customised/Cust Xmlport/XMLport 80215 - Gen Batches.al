xmlport 80215 "Gen Batches"
{
    Format = VariableText;

    schema
    {
        textelement(GenJournalBatchs)
        {
            tableelement("<genjournalbatch>"; "Gen. Journal Batch")
            {
                XmlName = 'GenJournalBatch';
                fieldelement(JournalTemplateName; "<GenJournalBatch>"."Journal Template Name")
                {
                }
                fieldelement(Name; "<GenJournalBatch>".Name)
                {
                }
                fieldelement(Description; "<GenJournalBatch>".Description)
                {
                }
                fieldelement(BalAccountType; "<GenJournalBatch>"."Bal. Account Type")
                {
                }
                fieldelement(NoSeries; "<GenJournalBatch>"."No. Series")
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

