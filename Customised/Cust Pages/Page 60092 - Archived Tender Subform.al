page 60092 "Archived Tender Subform"
{
    // version B2B1.0,SH1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Tender Line Archive";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
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
                field("Design Cost"; Rec."Design Cost")
                {
                    ApplicationArea = All;
                }
                field("CRM Cost"; Rec."CRM Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Estimated Unit Cost"; Rec."Estimated Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated Total Unit Cost"; Rec."Estimated Total Unit Cost")
                {
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
                        //This functionality was copied from page #60091. Unsupported part was commented. Please check it.
                        /*CurrPage.TenderLines.FORM.*/
                        ShowSchedule;

                    end;
                }
            }
        }
    }


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        Item: Record Item;
    begin
        //TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Tender);
        DesignWorksheetHeader.SETRANGE("Document No.", "Document No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.", "Line No.");
        PAGE.RUNMODAL(PAGE::"Design Worksheet", DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
    begin
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", "Document No.");
        Schedule.SETRANGE("Document Line No.", "Line No.");
        //Schedule.SETRANGE("Item No.","No.");
        //Schedule.SETRANGE(Quantity,Quantity);
        Schedule.FILTERGROUP(2);
        PAGE.RUN(60186, Schedule);
        Schedule.FILTERGROUP(0);
    end;
}

