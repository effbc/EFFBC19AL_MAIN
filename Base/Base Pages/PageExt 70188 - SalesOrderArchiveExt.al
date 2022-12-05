pageextension 70188 SalesOrderArchiveExt extends "Sales Order Archive"
{


    layout
    {



        addafter("Sell-to Contact")
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
            field("Cancel / Short Close"; Rec."Cancel / Short Close")
            {
                ApplicationArea = All;
            }

        }
        addafter(Status)
        {
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                ApplicationArea = All;
            }
            field("Customer Order Date"; Rec."Customer Order Date")
            {
                ApplicationArea = All;
            }
            field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
            {
                ApplicationArea = All;
            }

            field("First Released Date Time"; Rec."First Released Date Time")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                MultiLine = true;
                ApplicationArea = All;
            }
        }
        addafter("Payment Terms Code")
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addbefore(Shipping)
        {
            field("Tender No."; Rec."Tender No.")
            {
                ApplicationArea = All;
            }
            /*field("Archived By"; Rec."Archived By")
            {
            }*/
        }
        addafter(Version)
        {
            group(Others)
            {
                Caption = 'Others';
                field("RDSO Inspection By"; Rec."RDSO Inspection By")
                {
                    ApplicationArea = All;
                }
                field("RDSO Charges"; Rec."RDSO Charges")
                {
                    ApplicationArea = All;
                }
                field("RDSO Call Letter"; Rec."RDSO Call Letter")
                {
                    ApplicationArea = All;
                }
                field("CA Date"; Rec."CA Date")
                {
                    ApplicationArea = All;
                }
                field("RDSO Charges Paid By"; Rec."RDSO Charges Paid By")
                {
                    ApplicationArea = All;
                }
                field("LD Amount"; Rec."LD Amount")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit"; Rec."Security Deposit")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
                {
                    ApplicationArea = All;
                }
                field("CA Number"; Rec."CA Number")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; Rec."Document Position")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("<Tender No.2>"; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Call Letter Status")
            {
                CaptionML = ENU = 'Call Letter Status',
                            ENN = 'Version';
                field(CallLetterExpireDate; Rec.CallLetterExpireDate)
                {
                    ApplicationArea = All;
                }
                field(CallLetterRecivedDate; Rec.CallLetterRecivedDate)
                {
                    ApplicationArea = All;
                }
                field("Call letters Status"; Rec."Call letters Status")
                {
                    ApplicationArea = All;
                }
                field("Call Letter Exp.Date"; Rec."Call Letter Exp.Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {



        modify(Restore)
        {



            Promoted = true;
        }
        addafter(Restore)
        {
            action(Attachment)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //added by pranavi on 06-03-2015 for attachments
                    CustAttachments;
                    //end by pranavi
                end;
            }
            action(Doc)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //DOWNLOAD('eff-cpu-428\D:\Shortage_Doc.pdf');
                    HYPERLINK('\\erpserver\ErpAttachments\Authorisation.PDF');
                end;
            }
        }
    }



    procedure CustAttachments();
    var
        CustAttach: Record Attachments;
    begin
        //added by pranavi on 06-03-2015 for attachments
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."No.");
        CustAttach.SETRANGE("Document Type", Rec."Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
        //end by pranavi
    end;



}

