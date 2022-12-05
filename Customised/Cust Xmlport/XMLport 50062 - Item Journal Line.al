xmlport 50062 "Item Journal Line"
{
    Format = VariableText;

    schema
    {
        textelement(ItemJournalLines)
        {
            tableelement("<itemjournalline>"; "Item Journal Line")
            {
                XmlName = 'ItemJournalLine';
                fieldelement(ItemNo; "<ItemJournalLine>"."Item No.")
                {
                }
                fieldelement(Quantity; "<ItemJournalLine>".Quantity)
                {
                }
                fieldelement(UnitAmount; "<ItemJournalLine>"."Unit Amount")
                {
                }
                fieldelement(DocumentNo; "<ItemJournalLine>"."Document No.")
                {
                }
                fieldelement(LineNo; "<ItemJournalLine>"."Line No.")
                {
                }
                fieldelement(LocationCode; "<ItemJournalLine>"."Location Code")
                {
                }
                fieldelement(JournalBatchName; "<ItemJournalLine>"."Journal Batch Name")
                {
                }
                fieldelement(JournalTemplateName; "<ItemJournalLine>"."Journal Template Name")
                {
                }

                trigger OnAfterInsertRecord();
                begin

                    ItemJournalLine.Init;
                    ItemJournalLine."Journal Template Name" := JournalTemplateName;
                    ItemJournalLine.Validate("Journal Template Name");

                    ItemJournalLine."Journal Batch Name" := JournalBatchName;
                    ItemJournalLine.Validate("Journal Batch Name");

                    ItemJournalLine."Line No." := LineNo;
                    ItemJournalLine.Validate("Line No.");

                    ItemJournalLine."Item No." := "ItemNo.";
                    ItemJournalLine.Validate("Item No.");

                    ItemJournalLine.Quantity := Quantity;
                    ItemJournalLine.Validate(Quantity);

                    ItemJournalLine."Posting Date" := WorkDate;
                    ItemJournalLine.Validate("Posting Date");

                    ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
                    ItemJournalLine.Validate("Entry Type");

                    ItemJournalLine."Document No." := DocumentNo;
                    ItemJournalLine.Validate("Document No.");

                    ItemJournalLine."Location Code" := LocationCode;
                    ItemJournalLine.Validate("Location Code");

                    ItemJournalLine."Unit Amount" := UnitAmount;
                    ItemJournalLine.Validate("Unit Amount");

                    ItemJournalLine."Document Date" := DocumentDate;
                    ItemJournalLine.Insert;
                end;
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

    var
        "ItemNo.": Code[20];
        Quantity: Decimal;
        UnitAmount: Decimal;
        DocumentNo: Code[20];
        DocumentDate: Date;
        LineNo: Integer;
        LocationCode: Code[20];
        JournalBatchName: Code[20];
        JournalTemplateName: Code[20];
        InventoryPostingGroup: Code[20];
        GenProdPostingGroup: Code[20];
        UnitofMeasureCode: Code[20];
        ItemJournalLine: Record "Item Journal Line";
}

