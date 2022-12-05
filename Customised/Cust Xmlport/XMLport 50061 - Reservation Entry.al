xmlport 50061 "Reservation Entry"
{
    Format = VariableText;

    schema
    {
        textelement(ReservationEntryKNRs)
        {
            tableelement("<reservationentryknr>"; "Reservation Entry-KNR")
            {
                XmlName = 'ReservationEntryKNR';
                fieldelement(ItemNo; "<ReservationEntryKNR>"."Item No.")
                {
                }
                fieldelement(LocationCode; "<ReservationEntryKNR>"."Location Code")
                {
                }
                fieldelement(SerialNo; "<ReservationEntryKNR>"."Serial No.")
                {
                }
                fieldelement(LotNo; "<ReservationEntryKNR>"."Lot No.")
                {
                }
                fieldelement(Quantity; "<ReservationEntryKNR>".Quantity)
                {
                }
                fieldelement(SourceRefNo; "<ReservationEntryKNR>"."Source Ref. No.")
                {
                }

                trigger OnAfterInsertRecord();
                begin

                    ReservationEntry.Init;
                    if ReservationEntry.Find('+') then
                        ReservationEntry."Entry No." := ReservationEntry."Entry No." + 1
                    else
                        ReservationEntry."Entry No." := 1;
                    ReservationEntry.Positive := true;
                    ReservationEntry."Item No." := ItemNo;
                    ReservationEntry."Location Code" := Location;
                    ReservationEntry."Quantity (Base)" := "Qty.";
                    ReservationEntry."Serial No." := "SerialNo.";
                    ReservationEntry."Lot No." := "LotNo.";
                    ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                    ReservationEntry."Source Type" := 83;
                    ReservationEntry."Source Subtype" := 2;
                    ReservationEntry."Source ID" := 'ITEM';
                    // added
                    ReservationEntry."Source Ref. No." := "<ReservationEntryKNR>"."Source Ref. No.";

                    ReservationEntry."Source Batch Name" := 'IJNL-OPNB';
                    ReservationEntry."Created By" := UserId;
                    ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
                    ReservationEntry."Creation Date" := WorkDate;
                    ReservationEntry.Validate(ReservationEntry."Quantity (Base)");
                    ReservationEntry.Insert;

                    IJLItemTracking(ReservationEntry);
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
        ItemNo: Code[20];
        Location: Code[20];
        "SerialNo.": Code[20];
        "LotNo.": Code[20];
        "Qty.": Decimal;
        ReservationEntry: Record "Reservation Entry-KNR";
        ItemJournalLine: Record "Item Journal Line";


    procedure IJLItemTracking(var ReservationEntryKNR: Record "Reservation Entry-KNR");
    var
        ReservationEntry: Record "Reservation Entry";
        ItemJournalLine: Record "Item Journal Line";
    begin
        ReservationEntryKNR.SetFilter("Quantity (Base)", '<>%1', 0);
        if ReservationEntryKNR.Find('+') then
            repeat
                ItemJournalLine.SetRange("Journal Template Name", ReservationEntryKNR."Source ID");
                ItemJournalLine.SetRange("Journal Batch Name", ReservationEntryKNR."Source Batch Name");
                ItemJournalLine.SetRange("Item No.", ReservationEntryKNR."Item No.");
                ItemJournalLine.SetRange("Location Code", ReservationEntryKNR."Location Code");
                ItemJournalLine.SetRange(ItemJournalLine.Assigned, false);
                ItemJournalLine.SetRange(ItemJournalLine."Line No.", ReservationEntryKNR."Source Ref. No.");//added

                if ItemJournalLine.Find('-') then begin
                    //ReservationEntry."Entry No." := ReservationEntryKNR."Entry No.";
                    if ReservationEntry.Find('+') then
                        ReservationEntry."Entry No." := ReservationEntry."Entry No." + 1
                    else
                        ReservationEntry."Entry No." := 1;

                    ReservationEntry.Positive := ReservationEntryKNR.Positive;
                    ReservationEntry."Item No." := ReservationEntryKNR."Item No.";
                    ReservationEntry."Location Code" := ReservationEntryKNR."Location Code";
                    ReservationEntry."Quantity (Base)" := ReservationEntryKNR."Quantity (Base)";
                    ReservationEntry."Serial No." := ReservationEntryKNR."Serial No.";
                    ReservationEntry."Lot No." := ReservationEntryKNR."Lot No.";
                    ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                    ReservationEntry."Source Type" := 83;
                    ReservationEntry."Source Subtype" := 2;
                    ReservationEntry."Source ID" := 'ITEM';
                    ReservationEntry."Source Batch Name" := 'IJNL-OPNB';
                    ReservationEntry."Created By" := UserId;
                    ReservationEntry."Source Ref. No." := ItemJournalLine."Line No.";
                    ReservationEntry."Planning Flexibility" := ReservationEntry."Planning Flexibility"::Unlimited;
                    ReservationEntry."Creation Date" := WorkDate;
                    ReservationEntry."Source Prod. Order Line" := 0;
                    ReservationEntry.Validate("Quantity (Base)");
                    ReservationEntry.Insert;
                end;
            //ReservationEntryKNR."Quantity (Base)" := ItemJournalLine.Quantity - ReservationEntryKNR."Quantity (Base)";
            //ReservationEntryKNR.MODIFY;
            until ReservationEntryKNR.Next = 0;
    end;
}

