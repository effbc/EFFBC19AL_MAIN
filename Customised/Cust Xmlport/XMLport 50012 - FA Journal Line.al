xmlport 50012 "FA Journal Line"
{
    Format = VariableText;

    schema
    {
        textelement(FAJournalLines)
        {
            tableelement("<fajournalline>"; "FA Journal Line")
            {
                XmlName = 'FAJournalLine';
                fieldelement(JournalTemplateName; "<FAJournalLine>"."Journal Template Name")
                {
                }
                fieldelement(JournalBatchName; "<FAJournalLine>"."Journal Batch Name")
                {
                }
                fieldelement(LineNo; "<FAJournalLine>"."Line No.")
                {
                }
                fieldelement(DepreciationBookCode; "<FAJournalLine>"."Depreciation Book Code")
                {
                }
                fieldelement(FAPostingType; "<FAJournalLine>"."FA Posting Type")
                {
                }
                fieldelement(FANo; "<FAJournalLine>"."FA No.")
                {
                }
                fieldelement(FAPostingDate; "<FAJournalLine>"."FA Posting Date")
                {
                }
                fieldelement(PostingDate; "<FAJournalLine>"."Posting Date")
                {
                }
                fieldelement(DocumentDate; "<FAJournalLine>"."Document Date")
                {
                }
                fieldelement(DocumentNo; "<FAJournalLine>"."Document No.")
                {
                }
                fieldelement(Description; "<FAJournalLine>".Description)
                {
                }
                fieldelement(Amount; "<FAJournalLine>".Amount)
                {
                }
                fieldelement(FAPostingGroup; "<FAJournalLine>"."FA Posting Group")
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

