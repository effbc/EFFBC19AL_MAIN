pageextension 70187 SalesOrderArchiveSubformExt extends "Sales Order Archive Subform"
{


    layout
    {


        /* modify("Control1")
         {



             ShowCaption = false;
         }*/



        modify("Unit Price")
        {
            Visible = false;
        }

        addafter("Shortcut Dimension 2 Code")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Supply Portion"; Rec."Supply Portion")
            {
                ApplicationArea = All;
            }
            field("Retention Portion"; Rec."Retention Portion")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        addafter(DeferralSchedule)
        {
            action("Design Worksheet")
            {
                Caption = 'Design Worksheet';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #5159. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLinesArchive.Page.*/
                    ShowSalesOrderWorkSheet;

                end;
            }
        }
    }




    var
    //StrOrderLineArchiveDetailsPage: Page "Str Order Line Archive Details";

    /*procedure StrOrderLineArchiveDetailsPage();
    begin
    end;*/





    procedure ShowSalesOrderWorkSheet();
    var
        ArchivedDesignWorksheetHeader: Record "Archived DesignWorksheet";
        Item: Record Item;
    begin
        //TESTFIELD("Document Type");
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");

        CLEAR(ArchivedDesignWorksheetHeader);
        ArchivedDesignWorksheetHeader.SETRANGE("Document Type", ArchivedDesignWorksheetHeader."Document Type"::Order);
        ArchivedDesignWorksheetHeader.SETRANGE("Document No.", Rec."Document No.");
        ArchivedDesignWorksheetHeader.FILTERGROUP(2);
        ArchivedDesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Line No.");
        ArchivedDesignWorksheetHeader.SETRANGE("Version No.", Rec."Version No.");
        PAGE.RUNMODAL(PAGE::"Archived Design Worksheet", ArchivedDesignWorksheetHeader);
        ArchivedDesignWorksheetHeader.FILTERGROUP(0);
    end;



}

