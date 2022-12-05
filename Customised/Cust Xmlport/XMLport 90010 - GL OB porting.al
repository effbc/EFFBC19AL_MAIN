xmlport 90010 "GL OB porting"
{
    Format = VariableText;

    schema
    {
        textelement(GenJournalLine2)
        {
            tableelement("<genjournalline2>"; "Gen. Journal Line2")
            {
                XmlName = 'GenJournalLine2';
                fieldelement(JournalTemplateName; "<GenJournalLine2>"."Journal Template Name")
                {
                }
                fieldelement(LineNo; "<GenJournalLine2>"."Line No.")
                {
                }
                fieldelement(AccountType; "<GenJournalLine2>"."Account Type")
                {
                }
                fieldelement(AccountNo; "<GenJournalLine2>"."Account No.")
                {
                }
                fieldelement(PostingDate; "<GenJournalLine2>"."Posting Date")
                {
                }
                fieldelement(DocumentNo; "<GenJournalLine2>"."Document No.")
                {
                }
                fieldelement(Description; "<GenJournalLine2>".Description)
                {
                }
                fieldelement(JournalBatchName; "<GenJournalLine2>"."Journal Batch Name")
                {
                }
                fieldelement(DocumentDate; "<GenJournalLine2>"."Document Date")
                {
                }
                fieldelement(ExternalDocumentNo; "<GenJournalLine2>"."External Document No.")
                {
                }
                fieldelement(DueDate; "<GenJournalLine2>"."Due Date")
                {
                }
                fieldelement(FAPostingDate; "<GenJournalLine2>"."FA Posting Date")
                {
                }
                fieldelement(FAPostingType; "<GenJournalLine2>"."FA Posting Type")
                {
                }
                fieldelement(DepreciationBookCode; "<GenJournalLine2>"."Depreciation Book Code")
                {
                }
                fieldelement(Amount; "<GenJournalLine2>".Amount)
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

