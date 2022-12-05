table 33000259 "Inspection Lot"
{
    // version QC1.0

    LookupPageID = "Inspection Lots";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header";
            DataClassification = CustomerContent;
        }
        field(2; "Purch. Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(5; "Item Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CheckItemLotTracking;
            end;
        }
        field(7; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Quantity);
                TestField("Inspect. Data sheet created", false);
            end;
        }
        field(8; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(9; "Inspect. Data sheet created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Purch. Line No.", "Lot No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key2; "Document No.", "Item No.")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        TestField(Quantity);
        PostPurchLine.SetRange("Document No.", "Document No.");
        PostPurchLine.SetRange("Line No.", "Purch. Line No.");
        PostPurchLine.Find('-');
        "Item No." := PostPurchLine."No.";
        "Item Description" := PostPurchLine.Description;
        "Spec Id" := PostPurchLine."Spec ID";
    end;

    var
        Item: Record Item;
        PostPurchLine: Record "Purch. Rcpt. Line";
        Text000: Label 'Quantity can not be changed as Inspection Data sheets already Exists for this lot.';


    procedure CopyItemTrackingLots();
    var
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgEntry: Record "Item Ledger Entry";
        InspectLot: Record "Inspection Lot";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        LineNo: Integer;
        LotNo: Code[20];
        LotQuantity: Integer;
    begin
        ItemEntryRelation.SetCurrentKey("Source ID", "Source Type");
        ItemEntryRelation.SetRange("Source Type", DATABASE::"Purch. Rcpt. Line");
        ItemEntryRelation.SetRange("Source Subtype", 0);
        ItemEntryRelation.SetRange("Source ID", "Document No.");
        ItemEntryRelation.SetRange("Source Batch Name", '');
        ItemEntryRelation.SetRange("Source Prod. Order Line", 0);
        ItemEntryRelation.SetRange("Source Ref. No.", "Purch. Line No.");
        TempItemLedgEntry.DeleteAll;
        LineNo := 10000;
        if ItemEntryRelation.Find('-') then begin
            repeat
                ItemLedgEntry.Get(ItemEntryRelation."Item Entry No.");
                TempItemLedgEntry := ItemLedgEntry;
                AddTempRecordSet(TempItemLedgEntry);
            until ItemEntryRelation.Next = 0;
        end;
        if TempItemLedgEntry.Find('-') then begin
            InspectLot.SetRange("Document No.", "Document No.");
            InspectLot.SetRange("Purch. Line No.", "Purch. Line No.");
            if InspectLot.Find('+') then
                LineNo := InspectLot."Line No.";
            InspectLot.Init;
            repeat
                InspectLot."Document No." := "Document No.";
                InspectLot."Purch. Line No." := "Purch. Line No.";
                InspectLot."Lot No." := TempItemLedgEntry."Lot No.";
                InspectLot."Line No." := LineNo;
                InspectLot.Quantity := TempItemLedgEntry.Quantity;
                InspectLot.Insert(true);
                LineNo := LineNo + 10000;
            until TempItemLedgEntry.Next = 0;
        end;
    end;


    procedure AddTempRecordSet(var TempItemLedgEntry: Record "Item Ledger Entry");
    var
        TempItemLedgEntry2: Record "Item Ledger Entry";
    begin
        TempItemLedgEntry2 := TempItemLedgEntry;
        TempItemLedgEntry.Reset;
        TempItemLedgEntry.SetRange("Lot No.", TempItemLedgEntry2."Lot No.");
        if TempItemLedgEntry.Find('-') then begin
            TempItemLedgEntry.Quantity += TempItemLedgEntry2.Quantity;
            TempItemLedgEntry.Modify;
        end else begin
            TempItemLedgEntry.Insert;
        end;
        TempItemLedgEntry.Reset;
    end;


    procedure CheckItemLotTracking();
    var
        ItemEntryRelation: Record "Item Entry Relation";
    begin
        ItemEntryRelation.SetCurrentKey("Source ID", "Source Type");
        ItemEntryRelation.SetRange("Source Type", DATABASE::"Purch. Rcpt. Line");
        ItemEntryRelation.SetRange("Source Subtype", 0);
        ItemEntryRelation.SetRange("Source ID", "Document No.");
        ItemEntryRelation.SetRange("Source Batch Name", '');
        ItemEntryRelation.SetRange("Source Prod. Order Line", 0);
        ItemEntryRelation.SetRange("Source Ref. No.", "Purch. Line No.");
        ItemEntryRelation.SetRange("Lot No.", '');
        if ItemEntryRelation.Find('-') then
            Error('%1', ItemEntryRelation."Lot No.")
        else
            Message('test')
    end;
}

