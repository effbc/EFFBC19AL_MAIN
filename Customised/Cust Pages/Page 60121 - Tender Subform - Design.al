page 60121 "Tender Subform - Design"
{
    // version B2B1.0,DWS1.0,SH1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Tender Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production Bom No."; Rec."Production Bom No.")
                {
                    ApplicationArea = All;
                }
                field("Production Bom Version No."; Rec."Production Bom Version No.")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Design Cost"; Rec."Design Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CRM Cost"; Rec."CRM Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Estimated Unit Cost"; Rec."Estimated Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Estimated Total Unit Cost"; Rec."Estimated Total Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Schedule)
                {
                    Caption = 'Schedule';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60120. Unsupported part was commented. Please check it.
                        /*CurrPage.TenderLines.FORM.*/
                        ShowSchedule2;

                    end;
                }
            }
        }
    }

    var
        TransferExtendedText: Codeunit 378;


    procedure ShowSalesOrderWorkSheet2();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        Item: Record Item;
    begin
        //TESTFIELD("Document Type");
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Tender);
        DesignWorksheetHeader.SETRANGE("Document No.", Rec."Document No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Line No.");
        PAGE.RUNMODAL(PAGE::"Design Worksheet", DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
    end;


    //EFFUPG>>
    /*
    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        IF TransferExtendedText.TenderCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertTenderExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            CurrPage.UPDATE(TRUE);
    end;
    */
    //EFFUPG<<


    procedure ShowSchedule2();
    var
        Schedule: Record Schedule2;
    begin
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Line No.");
        PAGE.RUNMODAL(60125, Schedule);
    end;


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        //TESTFIELD("Document Type");
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");
        ItemDesignWorksheetHeader.RESET;
        IF ItemDesignWorksheetHeader.GET(Rec."No.") THEN BEGIN
            DesignWorksheetHeader.INIT;
            DesignWorksheetHeader.TRANSFERFIELDS(ItemDesignWorksheetHeader);
            DesignWorksheetHeader."Document No." := Rec."Document No.";
            DesignWorksheetHeader."Document Line No." := Rec."Line No.";
            DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::Order;
            IF DesignWorksheetHeader.INSERT THEN;
            ItemDesignWorksheetLine.RESET;
            ItemDesignWorksheetLine.SETRANGE(ItemDesignWorksheetLine."Item No", ItemDesignWorksheetHeader."Item No.");
            IF ItemDesignWorksheetLine.FINDSET THEN
                REPEAT
                        DesignWorksheetLine.INIT;
                    DesignWorksheetLine.TRANSFERFIELDS(ItemDesignWorksheetLine);
                    DesignWorksheetLine."Document No." := Rec."Document No.";
                    DesignWorksheetLine."Document Line No." := Rec."Line No.";
                    DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::Tender;
                    IF DesignWorksheetLine.INSERT THEN;
                UNTIL ItemDesignWorksheetLine.NEXT = 0;
        END;
        COMMIT;


        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Tender);
        DesignWorksheetHeader.SETRANGE("Document No.", Rec."Document No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Line No.");
        PAGE.RUNMODAL(PAGE::"Design Worksheet", DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
    begin
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Line No.");
        PAGE.RUNMODAL(60129, Schedule);
    end;
}

