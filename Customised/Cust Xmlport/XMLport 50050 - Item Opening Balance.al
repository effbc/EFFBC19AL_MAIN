xmlport 50050 "Item Opening Balance"
{
    Format = VariableText;

    schema
    {
        textelement(ItemJournalLines)
        {
            tableelement("<itemjournalline>"; "Item Journal Line")
            {
                XmlName = 'ItemJournalLine';
                fieldelement(JournalTemplateName; "<ItemJournalLine>"."Journal Template Name")
                {
                }
                fieldelement(LineNo; "<ItemJournalLine>"."Line No.")
                {
                }
                fieldelement(PostingDate; "<ItemJournalLine>"."Posting Date")
                {
                }
                fieldelement(EntryType; "<ItemJournalLine>"."Entry Type")
                {
                }
                fieldelement(SourceCode; "<ItemJournalLine>"."Source Code")
                {
                }
                fieldelement(JournalBatchName; "<ItemJournalLine>"."Journal Batch Name")
                {
                }
                fieldelement(DocumentNo; "<ItemJournalLine>"."Document No.")
                {
                }
                fieldelement(ItemNo; "<ItemJournalLine>"."Item No.")
                {
                }
                fieldelement(Quantity; "<ItemJournalLine>".Quantity)
                {
                }
                fieldelement(UnitAmount; "<ItemJournalLine>"."Unit Amount")
                {
                }
                fieldelement(Amount; "<ItemJournalLine>".Amount)
                {
                }
                fieldelement(LocationCode; "<ItemJournalLine>"."Location Code")
                {
                }
                fieldelement(Description; "<ItemJournalLine>".Description)
                {
                }
                fieldelement(UnitofMeasureCode; "<ItemJournalLine>"."Unit of Measure Code")
                {
                }
                fieldelement(InventoryPostingGroup; "<ItemJournalLine>"."Inventory Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "<ItemJournalLine>"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(QtyperUnitofMeasure; "<ItemJournalLine>"."Qty. per Unit of Measure")
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

