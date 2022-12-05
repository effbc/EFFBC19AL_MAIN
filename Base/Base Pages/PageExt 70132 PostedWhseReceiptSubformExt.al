pageextension 70132 PostedWhseReceiptSubformExt extends "Posted Whse. Receipt Subform"
{


    layout
    {



        /* modify(Control1)
         {



             ShowCaption = false;
         }*/


    }
    actions
    {


        addafter("Bin Contents List")
        {
            group(Inspection)
            {
                Caption = 'Inspection';
                action("Inspection Data Sheets")
                {
                    Caption = 'Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #7330. Unsupported part was commented. Please check it.
                        /*CurrPage.PostedWhseRcptLines.Page.*/
                        ShowDataSheet;

                    end;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #7330. Unsupported part was commented. Please check it.
                        /*CurrPage.PostedWhseRcptLines.Page.*/
                        ShowPostedDataSheet;

                    end;
                }
                action("Inspection &Receipts")
                {
                    Caption = 'Inspection &Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #7330. Unsupported part was commented. Please check it.
                        /*CurrPage.PostedWhseRcptLines.Page.*/
                        ShowInspectReceipt;

                    end;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #7330. Unsupported part was commented. Please check it.
                        /*CurrPage.PostedWhseRcptLines.Page.*/
                        ShowPostedInspectReceipt;

                    end;
                }
            }
        }
    }



    var
        "QC--": Integer;
        InspectDataSheet: Record "Inspection Datasheet Header";
        PostedInspectDataSheet: Record "Posted Inspect DatasheetHeader";
        InspectReportHeader: Record "Inspection Receipt Header";


    procedure "--QC--"();
    begin
    end;


    procedure ShowDataSheet();
    begin
        Rec.TESTFIELD("Source Document", Rec."Source Document"::"Purchase Order");
        InspectDataSheet.SETRANGE("Receipt No.", REc."Posted Source No.");
        InspectDataSheet.SETRANGE("Item No.", Rec."Item No.");
        InspectDataSheet.SETRANGE("Purch Line No", Rec."Source Line No.");
        PAGE.RUN(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    end;

    procedure ShowPostedDataSheet();
    begin
        Rec.TESTFIELD("Source Document", Rec."Source Document"::"Purchase Order");
        PostedInspectDataSheet.SETRANGE("Receipt No.", Rec."Posted Source No.");
        PostedInspectDataSheet.SETRANGE("Item No.", Rec."Item No.");
        PostedInspectDataSheet.SETRANGE("Purch Line No", Rec."Source Line No.");
        PAGE.RUN(PAGE::"Posted Inspect Data Sheet List", PostedInspectDataSheet);
    end;

    procedure ShowInspectReceipt();
    begin
        /*InspectReportHeader.SETRANGE("Receipt No.","Document No.");
        InspectReportHeader.SETRANGE("Purch Line No","Line No.");
        Page.RUN(Page::"Inspection Report  List",InspectReportHeader);
        */
        Rec.TESTFIELD("Source Document", Rec."Source Document"::"Purchase Order");
        InspectReportHeader.SETRANGE("Receipt No.", Rec."Posted Source No.");
        InspectReportHeader.SETRANGE("Item No.", Rec."Item No.");
        InspectReportHeader.SETRANGE("Purch Line No", Rec."Source Line No.");
        InspectReportHeader.SETRANGE(Status, FALSE);
        PAGE.RUN(PAGE::"Inspection Receipt List", InspectReportHeader);
        InspectReportHeader.RESET;

    end;

    procedure ShowPostedInspectReceipt();
    begin
        Rec.TESTFIELD("Source Document", Rec."Source Document"::"Purchase Order");
        InspectReportHeader.SETRANGE("Receipt No.", Rec."Posted Source No.");
        InspectReportHeader.SETRANGE("Item No.", Rec."Item No.");
        InspectReportHeader.SETRANGE("Purch Line No", Rec."Source Line No.");
        InspectReportHeader.SETRANGE(Status, TRUE);
        PAGE.RUN(PAGE::"Inspection Receipt List", InspectReportHeader);
        InspectReportHeader.RESET;
    end;


}

