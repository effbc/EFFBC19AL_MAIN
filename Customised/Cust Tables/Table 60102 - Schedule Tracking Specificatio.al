table 60102 "Schedule Tracking Specificatio"
{
    // version NAVW17.00,NAVIN7.00,EFFUPG

    // <changelog>
    //     <change releaseversion="IN7.00"/>
    // </changelog>

    CaptionML = ENU = 'Tracking Specification',
                ENN = 'Tracking Specification';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        ENN = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        ENN = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(3; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        ENN = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(4; "Quantity (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity (Base)',
                        ENN = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Quantity (Base)" * "Quantity Handled (Base)" < 0) or
                   (Abs("Quantity (Base)") < Abs("Quantity Handled (Base)"))
                then
                    FieldError("Quantity (Base)", StrSubstNo(Text002, FieldCaption("Quantity Handled (Base)")));

                //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
                InitQtyToShip;
                CheckSerialNoQty;
                Validate("Appl.-to Item Entry", 0);
            end;
        }
        field(7; Description; Text[200])
        {
            CaptionML = ENU = 'Description',
                        ENN = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Creation Date"; Date)
        {
            CaptionML = ENU = 'Creation Date',
                        ENN = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(10; "Source Type"; Integer)
        {
            CaptionML = ENU = 'Source Type',
                        ENN = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(11; "Source Subtype"; Option)
        {
            CaptionML = ENU = 'Source Subtype',
                        ENN = 'Source Subtype';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10',
                              ENN = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
            DataClassification = CustomerContent;
        }
        field(12; "Source ID"; Code[20])
        {
            CaptionML = ENU = 'Source ID',
                        ENN = 'Source ID';
            DataClassification = CustomerContent;
        }
        field(13; "Source Batch Name"; Code[10])
        {
            CaptionML = ENU = 'Source Batch Name',
                        ENN = 'Source Batch Name';
            DataClassification = CustomerContent;
        }
        field(14; "Source Prod. Order Line"; Integer)
        {
            CaptionML = ENU = 'Source Prod. Order Line',
                        ENN = 'Source Prod. Order Line';
            DataClassification = CustomerContent;
        }
        field(15; "Source Ref. No."; Integer)
        {
            CaptionML = ENU = 'Source Ref. No.',
                        ENN = 'Source Ref. No.';
            DataClassification = CustomerContent;
        }
        field(16; "Item Ledger Entry No."; Integer)
        {
            CaptionML = ENU = 'Item Ledger Entry No.',
                        ENN = 'Item Ledger Entry No.';
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ReservationEntry: Record "Reservation Entry";
            begin

                ReservationEntry.SetRange("Item No.", "Item No.");
                ReservationEntry.SetRange("Location Code", "Location Code");
                ReservationEntry.SetRange("Source Type", "Source Type");
                ReservationEntry.SetRange("Source Subtype", "Source Subtype");
                ReservationEntry.SetRange("Source ID", "Source ID");
                ReservationEntry.SetRange("Source Batch Name", "Source Batch Name");
                ReservationEntry.SetRange("Lot No.", "Lot No.");
                ReservationEntry.SetRange("Serial No.", "Serial No.");
                if ReservationEntry.Find('-') then
                    repeat
                        ReservationEntry."Appl.-to Item Entry" := "Appl.-to Item Entry";
                        ReservationEntry.Modify;
                    until ReservationEntry.Next = 0;
            end;
        }
        field(17; "Transfer Item Entry No."; Integer)
        {
            CaptionML = ENU = 'Transfer Item Entry No.',
                        ENN = 'Transfer Item Entry No.';
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(24; "Serial No."; Code[20])
        {
            CaptionML = ENU = 'Serial No.',
                        ENN = 'Serial No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Serial No." <> xRec."Serial No." then begin
                    TestField("Quantity Handled (Base)", 0);
                    if (Format("Source Type") = '39') or (Format("Source Type") = '83') then begin
                        ILE.SetCurrentKey(ILE."Item No.", ILE."Lot No.", ILE."Serial No.");
                        ILE.SetRange(ILE."Item No.", "Item No.");
                        ILE.SetRange(ILE."Serial No.", "Serial No.");
                        ILE.SetRange(ILE.Open, true);
                        /* IF ILE.FINDFIRST THEN
                           ERROR(FORMAT("Serial No.")+' Serial No. Already Exists');*/
                    end;
                    //  TestRPOStatus;  //pranavi

                    if IsReclass then
                        "New Serial No." := "Serial No.";
                    //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
                    if not SkipSerialNoQtyValidation then
                        CheckSerialNoQty;
                    InitExpirationDate;
                end;

            end;
        }
        field(28; Positive; Boolean)
        {
            CaptionML = ENU = 'Positive',
                        ENN = 'Positive';
            DataClassification = CustomerContent;
        }
        field(29; "Qty. per Unit of Measure"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Unit of Measure',
                        ENN = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            CaptionML = ENU = 'Appl.-to Item Entry',
                        ENN = 'Appl.-to Item Entry';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                ItemLedgEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code");
                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Positive, true);
                ItemLedgEntry.SetRange("Location Code", "Location Code");
                ItemLedgEntry.SetRange("Variant Code", "Variant Code");
                ItemLedgEntry.SetRange("Serial No.", "Serial No.");
                ItemLedgEntry.SetRange("Lot No.", "Lot No.");
                ItemLedgEntry.SetRange(Open, true);
                if PAGE.RunModal(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK then
                    Validate("Appl.-to Item Entry", ItemLedgEntry."Entry No.");
            end;

            trigger OnValidate();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                if "Appl.-to Item Entry" = 0 then
                    exit;

                if ("Serial No." = '') and ("Lot No." = '') then begin
                    TestField("Serial No.");
                    TestField("Lot No.");
                end;

                ItemLedgEntry.Get("Appl.-to Item Entry");
                ItemLedgEntry.TestField("Item No.", "Item No.");
                ItemLedgEntry.TestField(Positive, true);
                ItemLedgEntry.TestField("Variant Code", "Variant Code");
                ItemLedgEntry.TestField("Serial No.", "Serial No.");
                ItemLedgEntry.TestField("Lot No.", "Lot No.");
                if Abs("Quantity (Base)") > Abs(ItemLedgEntry."Remaining Quantity") then
                    Error(RemainingQtyErr, ItemLedgEntry.FieldCaption("Remaining Quantity"), ItemLedgEntry."Entry No.", FieldCaption("Quantity (Base)"));
            end;
        }
        field(40; "Warranty Date"; Date)
        {
            CaptionML = ENU = 'Warranty Date',
                        ENN = 'Warranty Date';
            DataClassification = CustomerContent;
        }
        field(41; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date',
                        ENN = 'Expiration Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
                if "Buffer Status2" = "Buffer Status2"::"ExpDate blocked" then begin
                    "Expiration Date" := xRec."Expiration Date";
                    Message(Text004);
                end;
            end;
        }
        field(50; "Qty. to Handle (Base)"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Handle (Base)',
                        ENN = 'Qty. to Handle (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Qty. to Handle (Base)" * "Quantity (Base)" < 0) or
                   (Abs("Qty. to Handle (Base)") > Abs("Quantity (Base)")
                    - "Quantity Handled (Base)")
                then
                    Error(
                      Text001,
                      "Quantity (Base)" - "Quantity Handled (Base)");

                InitQtyToInvoice;
                "Qty. to Handle" := CalcQty("Qty. to Handle (Base)");
                CheckSerialNoQty;
            end;
        }
        field(51; "Qty. to Invoice (Base)"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Invoice (Base)',
                        ENN = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Qty. to Invoice (Base)" * "Quantity (Base)" < 0) or
                   (Abs("Qty. to Invoice (Base)") > Abs("Qty. to Handle (Base)"
                      + "Quantity Handled (Base)" - "Quantity Invoiced (Base)"))
                then
                    Error(
                      Text000,
                      "Qty. to Handle (Base)" + "Quantity Handled (Base)" - "Quantity Invoiced (Base)");

                "Qty. to Invoice" := CalcQty("Qty. to Invoice (Base)");
                CheckSerialNoQty;
            end;
        }
        field(52; "Quantity Handled (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity Handled (Base)',
                        ENN = 'Quantity Handled (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(53; "Quantity Invoiced (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity Invoiced (Base)',
                        ENN = 'Quantity Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60; "Qty. to Handle"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Handle',
                        ENN = 'Qty. to Handle';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(61; "Qty. to Invoice"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Invoice',
                        ENN = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(70; "Buffer Status"; Option)
        {
            CaptionML = ENU = 'Buffer Status',
                        ENN = 'Buffer Status';
            Editable = false;
            OptionCaptionML = ENU = ' ,MODIFY,INSERT',
                              ENN = ' ,MODIFY,INSERT';
            OptionMembers = " ",MODIFY,INSERT;
            DataClassification = CustomerContent;
        }
        field(71; "Buffer Status2"; Option)
        {
            CaptionML = ENU = 'Buffer Status2',
                        ENN = 'Buffer Status2';
            Editable = false;
            OptionCaptionML = ENU = ',ExpDate blocked',
                              ENN = ',ExpDate blocked';
            OptionMembers = ,"ExpDate blocked";
            DataClassification = CustomerContent;
        }
        field(72; "Buffer Value1"; Decimal)
        {
            CaptionML = ENU = 'Buffer Value1',
                        ENN = 'Buffer Value1';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73; "Buffer Value2"; Decimal)
        {
            CaptionML = ENU = 'Buffer Value2',
                        ENN = 'Buffer Value2';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(74; "Buffer Value3"; Decimal)
        {
            CaptionML = ENU = 'Buffer Value3',
                        ENN = 'Buffer Value3';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(75; "Buffer Value4"; Decimal)
        {
            CaptionML = ENU = 'Buffer Value4',
                        ENN = 'Buffer Value4';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(76; "Buffer Value5"; Decimal)
        {
            CaptionML = ENU = 'Buffer Value5',
                        ENN = 'Buffer Value5';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80; "New Serial No."; Code[20])
        {
            CaptionML = ENU = 'New Serial No.',
                        ENN = 'New Serial No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
            end;
        }
        field(81; "New Lot No."; Code[20])
        {
            CaptionML = ENU = 'New Lot No.',
                        ENN = 'New Lot No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
            end;
        }
        field(900; "Prohibit Cancellation"; Boolean)
        {
            CaptionML = ENU = 'Prohibit Cancellation',
                        ENN = 'Prohibit Cancellation';
            DataClassification = CustomerContent;
        }
        field(5400; "Lot No."; Code[20])
        {
            CaptionML = ENU = 'Lot No.',
                        ENN = 'Lot No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Lot No." <> xRec."Lot No." then begin
                    TestField("Quantity Handled (Base)", 0);
                    //  TestRPOStatus;  //pranavi
                    if IsReclass then
                        "New Lot No." := "Lot No.";
                    //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
                    InitExpirationDate;
                end;
            end;
        }
        field(5401; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code',
                        ENN = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
        field(5402; "Bin Code"; Code[20])
        {
            CaptionML = ENU = 'Bin Code',
                        ENN = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            DataClassification = CustomerContent;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            CaptionML = ENU = 'Appl.-from Item Entry',
                        ENN = 'Appl.-from Item Entry';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                ItemLedgEntry.SetCurrentKey("Item No.", Positive, "Location Code", "Variant Code");
                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Positive, false);
                if "Location Code" <> '' then
                    ItemLedgEntry.SetRange("Location Code", "Location Code");
                ItemLedgEntry.SetRange("Variant Code", "Variant Code");
                ItemLedgEntry.SetRange("Serial No.", "Serial No.");
                ItemLedgEntry.SetRange("Lot No.", "Lot No.");
                ItemLedgEntry.SetFilter("Shipped Qty. Not Returned", '<0');
                if PAGE.RunModal(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK then
                    Validate("Appl.-from Item Entry", ItemLedgEntry."Entry No.");
            end;

            trigger OnValidate();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                if "Appl.-from Item Entry" = 0 then
                    exit;

                case "Source Type" of
                    DATABASE::"Sales Line":
                        if (("Source Subtype" in [3, 5]) and ("Quantity (Base)" < 0)) or
                           (("Source Subtype" in [1, 2]) and ("Quantity (Base)" > 0)) // sale
                        then
                            FieldError("Quantity (Base)");
                    DATABASE::"Item Journal Line":
                        if (("Source Subtype" in [0, 2, 6]) and ("Quantity (Base)" < 0)) or
                           (("Source Subtype" in [1, 3, 4, 5]) and ("Quantity (Base)" > 0))
                        then
                            FieldError("Quantity (Base)");
                    DATABASE::"Service Line":
                        if (("Source Subtype" in [3]) and ("Quantity (Base)" < 0)) or
                           (("Source Subtype" in [1, 2]) and ("Quantity (Base)" > 0))
                        then
                            FieldError("Quantity (Base)");
                    else
                        FieldError("Source Subtype");
                end;

                if ("Serial No." = '') and ("Lot No." = '') then begin
                    TestField("Serial No.");
                    TestField("Lot No.");
                end;
                ItemLedgEntry.Get("Appl.-from Item Entry");
                ItemLedgEntry.TestField("Item No.", "Item No.");
                ItemLedgEntry.TestField(Positive, false);
                if ItemLedgEntry."Shipped Qty. Not Returned" + Abs("Qty. to Handle (Base)") > 0 then
                    ItemLedgEntry.FieldError("Shipped Qty. Not Returned");
                ItemLedgEntry.TestField("Variant Code", "Variant Code");
                ItemLedgEntry.TestField("Serial No.", "Serial No.");
                ItemLedgEntry.TestField("Lot No.", "Lot No.");
            end;
        }
        field(5817; Correction; Boolean)
        {
            CaptionML = ENU = 'Correction',
                        ENN = 'Correction';
            DataClassification = CustomerContent;
        }
        field(6505; "New Expiration Date"; Date)
        {
            CaptionML = ENU = 'New Expiration Date',
                        ENN = 'New Expiration Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //WMSManagement.CheckItemTrackingChange(Rec,xRec);//EFFUPG
            end;
        }
        field(7300; "Quantity actual Handled (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity actual Handled (Base)',
                        ENN = 'Quantity actual Handled (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60002; "Item Entry No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Qty. to Handle (Base)", "Qty. to Invoice (Base)", "Quantity Handled (Base)", "Quantity Invoiced (Base)";
        }
        key(Key3; "Lot No.", "Serial No.")
        {
        }
        key(Key4; "Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.", "Location Code", "Item No.", "Variant Code")
        {
            SumIndexFields = "Qty. to Handle (Base)", "Qty. to Invoice (Base)", "Quantity Handled (Base)", "Quantity Invoiced (Base)";
        }
        key(Key5; "Source ID")
        {
        }
        key(Key6; "Source Type")
        {
        }
        key(Key7; "Item No.", "Lot No.", "Serial No.")
        {
        }
        key(Key8; "Source ID", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        /*
        TESTFIELD("Quantity Handled (Base)",0);
        TESTFIELD("Quantity Invoiced (Base)",0);
        */

    end;

    trigger OnInsert();
    begin
        Message('Inserting');
    end;

    var
        Text000: TextConst ENU = 'You cannot invoice more than %1 units.', ENN = 'You cannot invoice more than %1 units.';
        Text001: TextConst ENU = 'You cannot handle more than %1 units.', ENN = 'You cannot handle more than %1 units.';
        Text002: TextConst ENU = 'must not be less than %1', ENN = 'must not be less than %1';
        Text003: TextConst ENU = '%1 must be -1, 0 or 1 when %2 is stated.', ENN = '%1 must be -1, 0 or 1 when %2 is stated.';
        Text004: TextConst ENU = 'Expiration date has been established by existing entries and cannot be changed.', ENN = 'Expiration date has been established by existing entries and cannot be changed.';
        WMSManagement: Codeunit "WMS Management";
        Text005: TextConst ENU = '%1 in %2 for %3 %4, %5: %6, %7: %8 is currently %9. It must be %10.', ENN = '%1 in %2 for %3 %4, %5: %6, %7: %8 is currently %9. It must be %10.';
        SkipSerialNoQtyValidation: Boolean;
        RemainingQtyErr: TextConst ENU = 'The %1 in item ledger entry %2 is too low to cover %3.', ENN = 'The %1 in item ledger entry %2 is too low to cover %3.';
        ILE: Record "Item Ledger Entry";


    procedure InitQtyToShip();
    begin
        "Qty. to Handle (Base)" := "Quantity (Base)" - "Quantity Handled (Base)";
        "Qty. to Handle" := CalcQty("Qty. to Handle (Base)");

        InitQtyToInvoice;
    end;


    procedure InitQtyToInvoice();
    begin
        "Qty. to Invoice (Base)" := "Quantity Handled (Base)" + "Qty. to Handle (Base)" - "Quantity Invoiced (Base)";
        "Qty. to Invoice" := CalcQty("Qty. to Invoice (Base)");
    end;


    procedure CheckSerialNoQty();
    begin
        if "Serial No." = '' then
            exit;
        if not ("Quantity (Base)" in [-1, 0, 1]) then
            Error(Text003, FieldCaption("Quantity (Base)"), FieldCaption("Serial No."));
        if not ("Qty. to Handle (Base)" in [-1, 0, 1]) then
            Error(Text003, FieldCaption("Qty. to Handle (Base)"), FieldCaption("Serial No."));
        if not ("Qty. to Invoice (Base)" in [-1, 0, 1]) then
            Error(Text003, FieldCaption("Qty. to Invoice (Base)"), FieldCaption("Serial No."));
    end;


    procedure CopyPointerFilters(var ReservEntry: Record "Reservation Entry");
    begin
        ReservEntry.CopyFilter("Source Type", "Source Type");
        ReservEntry.CopyFilter("Source Subtype", "Source Subtype");
        ReservEntry.CopyFilter("Source ID", "Source ID");
        ReservEntry.CopyFilter("Source Batch Name", "Source Batch Name");
        ReservEntry.CopyFilter("Source Prod. Order Line", "Source Prod. Order Line");
        ReservEntry.CopyFilter("Source Ref. No.", "Source Ref. No.");
    end;


    procedure CalcQty(BaseQty: Decimal): Decimal;
    begin
        if "Qty. per Unit of Measure" = 0 then
            "Qty. per Unit of Measure" := 1;
        exit(Round(BaseQty / "Qty. per Unit of Measure", 0.00001));
    end;


    procedure InitExpirationDate();
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ExpDate: Date;
        EntriesExist: Boolean;
    begin
        if ("Serial No." = xRec."Serial No.") and ("Lot No." = xRec."Lot No.") then
            exit;

        "Expiration Date" := 0D;

        ExpDate := ItemTrackingMgt.ExistingExpirationDate("Item No.", "Variant Code", "Lot No.", "Serial No.", false, EntriesExist);
        if EntriesExist then begin
            "Expiration Date" := ExpDate;
            "Buffer Status2" := "Buffer Status2"::"ExpDate blocked";
        end else
            "Buffer Status2" := 0;

        if IsReclass then begin
            "New Expiration Date" := "Expiration Date";
            "Warranty Date" := ItemTrackingMgt.ExistingWarrantyDate("Item No.", "Variant Code", "Lot No.", "Serial No.", EntriesExist);
        end;
    end;


    procedure IsReclass(): Boolean;
    begin
        exit(("Source Type" = DATABASE::"Item Journal Line") and ("Source Subtype" = 4));
    end;

    procedure TestFieldError(FieldCaptionText: Text[80]; CurrFieldValue: Decimal; CompareValue: Decimal);
    begin
        //IF CurrFieldValue = CompareValue THEN
        if Round(CurrFieldValue, 0.00001) = CompareValue then
            exit;

        Error(Text005,
          FieldCaptionText,
          TableCaption,
          FieldCaption("Item No."),
          "Item No.",
          FieldCaption("Serial No."),
          "Serial No.",
          FieldCaption("Lot No."),
          "Lot No.",
          Abs(CurrFieldValue),
          Abs(CompareValue));
    end;


    procedure SetSkipSerialNoQtyValidation(NewVal: Boolean);
    begin
        SkipSerialNoQtyValidation := NewVal;
    end;


    procedure CheckItemTrackingQuantity(TableNo: Integer; DocumentType: Option; DocumentNo: Code[20]; LineNo: Integer; QtyToHandleBase: Decimal; QtyToInvoiceBase: Decimal; Handle: Boolean; Invoice: Boolean);
    var
        ReservationEntry: Record "Reservation Entry";
    begin
        if QtyToHandleBase = 0 then
            Handle := false;
        if QtyToInvoiceBase = 0 then
            Invoice := false;
        if not (Handle or Invoice) then
            exit;
        ReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");
        ReservationEntry.SetRange("Source Type", TableNo);
        ReservationEntry.SetRange("Source Subtype", DocumentType);
        ReservationEntry.SetRange("Source ID", DocumentNo);
        ReservationEntry.SetRange("Source Ref. No.", LineNo);
        ReservationEntry.SetFilter("Item Tracking", '%1|%2',
          ReservationEntry."Item Tracking"::"Lot and Serial No.",
          ReservationEntry."Item Tracking"::"Serial No.");
        CheckItemTrackingByType(ReservationEntry, QtyToHandleBase, QtyToInvoiceBase, false, Handle, Invoice);
        ReservationEntry.SetRange("Item Tracking", ReservationEntry."Item Tracking"::"Lot No.");
        CheckItemTrackingByType(ReservationEntry, QtyToHandleBase, QtyToInvoiceBase, true, Handle, Invoice);
    end;

    local procedure CheckItemTrackingByType(var ReservationEntry: Record "Reservation Entry"; QtyToHandleBase: Decimal; QtyToInvoiceBase: Decimal; OnlyLot: Boolean; Handle: Boolean; Invoice: Boolean);
    var
        TrackingSpecification: Record "Tracking Specification";
        HandleQtyBase: Decimal;
        InvoiceQtyBase: Decimal;
        LotsToHandleUndefined: Boolean;
        LotsToInvoiceUndefined: Boolean;
    begin
        if OnlyLot then begin
            GetUndefinedLots(ReservationEntry, Handle, Invoice, LotsToHandleUndefined, LotsToInvoiceUndefined);
            if not (LotsToHandleUndefined or LotsToInvoiceUndefined) then
                exit;
        end;
        if not ReservationEntry.Find('-') then
            exit;
        repeat
            if Handle then
                HandleQtyBase += ReservationEntry."Qty. to Handle (Base)";
            if Invoice then
                InvoiceQtyBase += ReservationEntry."Qty. to Invoice (Base)";
        until ReservationEntry.Next = 0;
        TrackingSpecification.TransferFields(ReservationEntry);
        if Handle then
            if Abs(HandleQtyBase) > Abs(QtyToHandleBase) then
                TrackingSpecification.TestFieldError(FieldCaption("Qty. to Handle (Base)"), HandleQtyBase, QtyToHandleBase);
        if Invoice then
            if Abs(InvoiceQtyBase) > Abs(QtyToInvoiceBase) then
                TrackingSpecification.TestFieldError(FieldCaption("Qty. to Invoice (Base)"), InvoiceQtyBase, QtyToInvoiceBase);
    end;


    local procedure GetUndefinedLots(var ReservationEntry: Record "Reservation Entry"; Handle: Boolean; Invoice: Boolean; var LotsToHandleUndefined: Boolean; var LotsToInvoiceUndefined: Boolean);
    var
        HandleLot: Code[20];
        InvoiceLot: Code[20];
        StopLoop: Boolean;
    begin
        LotsToHandleUndefined := false;
        LotsToInvoiceUndefined := false;
        if not ReservationEntry.FindSet then
            exit;
        repeat
            if Handle then begin
                CheckLot(ReservationEntry."Qty. to Handle (Base)", ReservationEntry."Lot No.", HandleLot, LotsToHandleUndefined);
                if LotsToHandleUndefined and not Invoice then
                    StopLoop := true;
            end;
            if Invoice then begin
                CheckLot(ReservationEntry."Qty. to Invoice (Base)", ReservationEntry."Lot No.", InvoiceLot, LotsToInvoiceUndefined);
                if LotsToInvoiceUndefined and not Handle then
                    StopLoop := true;
            end;
            if LotsToHandleUndefined and LotsToInvoiceUndefined then
                StopLoop := true;
        until StopLoop or (ReservationEntry.Next = 0);
    end;


    local procedure CheckLot(ReservQty: Decimal; ReservLot: Code[20]; var Lot: Code[20]; var Undefined: Boolean);
    begin
        Undefined := false;
        if ReservQty = 0 then
            exit;
        if Lot = '' then
            Lot := ReservLot
        else
            if ReservLot <> Lot then
                Undefined := true;
    end;
}

