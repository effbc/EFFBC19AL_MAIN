pageextension 70123 PostedSalesShptSubformExt extends "Posted Sales Shpt. Subform"
{
    Editable = true;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */

        addafter(Type)
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            field("RDSO Unit Charges"; Rec."RDSO Unit Charges")
            {
                ApplicationArea = All;
            }
            field("RDSO Charges Paid By"; Rec."RDSO Charges Paid By")
            {
                ApplicationArea = All;
            }
            field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
            {
                ApplicationArea = All;
            }
            field("RDSO Inspection By"; Rec."RDSO Inspection By")
            {
                ApplicationArea = All;
            }
            field("RDSO Charges"; Rec."RDSO Charges")
            {
                ApplicationArea = All;
            }
            field("Unit Cost";"Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Unitcost(LOA)";"Unitcost(LOA)")
            {
                ApplicationArea = All;
            }
            field("Unit Cost (LCY)";"Unit Cost (LCY)")
            {
                ApplicationArea =All;
            }
        }
        addafter(Correction)
        {
            field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ItemInvoiceLines)
        {
            action("Design Worksheet")
            {
                Caption = 'Design Worksheet';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #130. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesShipmLines.Page.*/
                    ShowSalesOrderWorkSheet;

                end;
            }
            action(Schedule)
            {
                Caption = 'Schedule';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #130. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesShipmLines.Page.*/
                    ShowSchedule;

                end;
            }
        }
    }



    procedure TrackingPage();
    begin
    end;





    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        Item: Record Item;
    begin
        //TESTFIELD("Document Type");
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.", Rec."Order No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Order Line No.");
        PAGE.RUNMODAL(PAGE::"Posted Design Worksheet", DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
    end;

    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
        SalesShptHeader: Record "Sales Shipment Header";
        OrderNo: Code[20];
    begin
        IF SalesShptHeader.GET(Rec."Document No.") THEN;
        OrderNo := SalesShptHeader."Order No.";
        Schedule.RESET;
        Schedule.SETRANGE("Document No.", OrderNo);
        Schedule.SETRANGE(Schedule."Document Line No.", Rec."Order Line No.");
        PAGE.RUN(60189, Schedule);
    end;
}

