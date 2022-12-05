pageextension 70119 PostedSalesInvoiceSubformExt extends "Posted Sales Invoice Subform"
{
    Editable = true;
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        /* modify(Control1)
        {
            ShowCaption = false;
        } 
        modify("Control 28")
        {
            ShowCaption = false;
        }
        modify("Control 23")
        {
            ShowCaption = false;
        }*/

        addfirst(Control1)
        {
            field("Schedule Type"; Rec."Schedule Type")
            {
                Editable = EditableVarTrue;
                ApplicationArea = All;
            }
            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("Schedule No"; Rec."Schedule No")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Unitcost(LOA)";"Unitcost(LOA)")
            {
                ApplicationArea =All;
            }
        }
        addafter(Type)
        {
            /*  field("Amount Added to Tax Base"; "Amount Added to Tax Base")
              {
                  Editable = EditableVarFalse;
                  ApplicationArea = All;
              }
              field("Amount Including Excise"; "Amount Including Excise")
              {
                  Editable = EditableVarFalse;
                  ApplicationArea = All;
              }*/
            field("Unit Cost"; Rec."Unit Cost")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            /*  field("Service Tax Amount"; "Service Tax Amount")
              {
                  Editable = EditableVarFalse;
                  ApplicationArea = All;
              }
              field("Excise Amount"; "Excise Amount")
              {
                  Editable = EditableVarFalse;
                  ApplicationArea = All;
              }*/
        }
        addafter("No.")
        {
            /*   field("Service Tax SHE Cess Amount"; "Service Tax SHE Cess Amount")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("Tax Base Amount"; "Tax Base Amount")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("Amount Including Tax"; "Amount Including Tax")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("Service Tax Group"; "Service Tax Group")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }*/
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            /* field("SHE Cess Amount"; "SHE Cess Amount")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }
             field("Excise Effective Rate"; "Excise Effective Rate")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }
             field("Tax %"; "Tax %")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }*/
            /*  field("Tax Amount";Rec."Tax Amount");
              {
                  Editable = EditableVarFalse;
                  ApplicationArea = All;
              }*/

            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            /* field("Service Tax eCess Amount"; "Service Tax eCess Amount")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }*/
            field(Amount; Rec.Amount)
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            /*field("Amount To Customer"; "Amount To Customer")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }*/
            field("Posting Group"; Rec."Posting Group")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            /* field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }
             field("BED Amount"; "BED Amount")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }*/
            /* field("eCess Amount"; "eCess Amount")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }*/
            field("Packet No"; Rec."Packet No")
            {
                Editable = true;
                ApplicationArea = All;
            }
            /* field("Form Code"; "Form Code")
             {
                 Editable = EditableVarFalse;
                 Visible = false;
                 ApplicationArea = All;
             }*/
            field("RDSO Charges Paid By"; Rec."RDSO Charges Paid By")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("RDSO Unit Charges"; Rec."RDSO Unit Charges")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            field("RDSO Inspection By"; Rec."RDSO Inspection By")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            /*field("Form No."; "Form No.")
            {
                Editable = EditableVarFalse;
                Visible = false;
                ApplicationArea = All;
            }*/
        }
        addafter("Line Discount Amount")
        {
            /* field("TDS/TCS Amount"; "TDS/TCS Amount")
             {
                 ApplicationArea = All;
             }
             field("TCS Type"; "TCS Type")
             {
                 ApplicationArea = All;
             }*/
            field("TCS Nature of Collection"; Rec."TCS Nature of Collection")
            {
                ApplicationArea = All;
            }
            /* field("TDS/TCS Base Amount"; "TDS/TCS Base Amount")
             {
                 ApplicationArea = All;
             }
             field("TDS/TCS %"; "TDS/TCS %")
             {
                 ApplicationArea = All;
             }*/ //B2BUPG
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                Editable = EditableVarFalse;
                ApplicationArea = All;
            }
            /* field("Excise Base Amount"; "Excise Base Amount")
             {
                 Editable = EditableVarFalse;
                 ApplicationArea = All;
             }*/ //B2BUPG
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
            field("Order Line No."; Rec."Order Line No.")
            {
                ApplicationArea = All;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
            }
            /*  field("Service Tax SBC %"; "Service Tax SBC %")
              {
                  Editable = true;
                  ApplicationArea = All;
              }
              field("Service Tax SBC Amount"; "Service Tax SBC Amount")
              {
                  Editable = true;
                  ApplicationArea = All;
              }
              field("KK Cess%"; "KK Cess%")
              {
                  Editable = true;
                  ApplicationArea = All;
              }
              field("KK Cess Amount"; "KK Cess Amount")
              {
                  Editable = true;
                  ApplicationArea = All;
              }
              field("Service Tax SBC Amount (Intm)"; "Service Tax SBC Amount (Intm)")
              {
                  Editable = true;
                  ApplicationArea = All;
              }
              field("MRP Price"; "MRP Price")
              {
                  ApplicationArea = All;
              }
              field(MRP; MRP)
              {
                  ApplicationArea = All;
              }
              field("Abatement %"; "Abatement %")
              {
                  ApplicationArea = All;
              }*/
            /*  field("Product Group Code"; Rec."Product Group Code")
              {
                  ApplicationArea = All;
              }*/  //B2BUPG
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
            }
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = All;
            }
            field("GST Group Type"; Rec."GST Group Type")
            {
                ApplicationArea = All;
            }
            /*  field("GST %"; "GST %")
              {
                  ApplicationArea = All;
              }*/ //B2BUPG
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field(Exempted; Rec.Exempted)
            {
                ApplicationArea = All;
            }
            field("Retention Portion"; Rec."Retention Portion")
            {
                ApplicationArea = All;
            }
            field("Supply Portion"; Rec."Supply Portion")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        addafter(DeferralSchedule)
        {
            action(Schedule)
            {
                Caption = 'Schedule';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #132. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesInvLines.Page.*/
                    ShowSchedule;

                end;
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            ENN = 'F&unctions';
                Image = "Action";
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CustAttachments;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /* IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI'] THEN BEGIN
            CurrPage.EDITABLE := TRUE;
            //EditableVarTrue := TRUE;
        END
        ELSE BEGIN
            //EditableVarFalse := TRUE;
            EditableVarTrue := TRUE;
            //CurrPage.EDITABLE := FALSE;

        END; */

        IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
            EditableVarFalse := TRUE

            //EditableVarTrue := TRUE;
        END else
            EditableVarFalse := TRUE
    end;

    trigger OnAfterGetRecord()
    begin
        //EditableVarFalse := TRUE;
    end;

    var
        EditableVarFalse: Boolean;
        EditableVarTrue: Boolean;
        SIH: Record "Sales Invoice Header";
        OrderNo: Code[30];




    procedure StrOrderLineDetailsPage();
    begin
    end;


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        Item: Record Item;
    begin
        /*
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        
        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type",DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.","Order No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.","Order Line No.");
        Page.RUNMODAL(FORM::"Posted Design Worksheet",DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
        */

    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
        SalesINVHeader: Record "Sales Invoice Header";
        OrderNo: Code[20];
    begin
        IF SalesINVHeader.GET(Rec."Document No.") THEN;
        OrderNo := SalesINVHeader."Order No.";
        Schedule.RESET;
        Schedule.SETRANGE("Document No.", OrderNo);
        Schedule.SETRANGE(Schedule."Document Line No.", Rec."Line No.");
        PAGE.RUN(60189, Schedule);
    end;


    procedure CustAttachments();
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        //CustAttach.SETRANGE("Table ID",DATABASE::"Sales Invoice Header");
        CustAttach.SETFILTER("Table ID", '%1|%2', DATABASE::"Sales Invoice Header", DATABASE::"Sales Header");   //>> Added by Pranavi on 30-Mar-17
        SIH.RESET;
        SIH.SETRANGE(SIH."No.", Rec."Document No.");
        IF SIH.FINDFIRST THEN
            OrderNo := SIH."Order No.";
        CustAttach.SETFILTER("Document No.", '%1|%2', Rec."Document No.", OrderNo);
        //CustAttach.SETRANGE("Document No.",Rec."Document No.");    //<< Added by Pranavi on 30-Mar-17
        CustAttach.SETRANGE("Document Type", CustAttach."Document Type"::Order);
        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;
}

