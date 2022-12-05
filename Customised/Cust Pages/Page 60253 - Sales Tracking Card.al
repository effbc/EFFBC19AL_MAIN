page 60253 "Sales Tracking Card"
{
    PageType = Card;
    SourceTable = "Sales Header Archive";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer OrderNo."; Rec."Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("BG No."; Rec."BG No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Warranty Period"; Rec."Warranty Period")
                {
                    ApplicationArea = All;
                }
                field("Order Status"; Rec."Order Status")
                {
                    ApplicationArea = All;
                }
                field("Warranty Completed"; Rec."Warranty Completed")
                {
                    ApplicationArea = All;
                }
                field("Converted to AMC"; Rec."Converted to AMC")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Converted to AMC" = TRUE THEN
                            Rec.TESTFIELD("Converted AMC Order");
                    end;
                }
                field("Bill Attached"; Rec."Bill Attached")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Scope To AMC"; Rec."Scope To AMC")
                {
                    ApplicationArea = All;
                }
                field("Converted AMC Order"; Rec."Converted AMC Order")
                {
                    ApplicationArea = All;
                }
                field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
                {
                    ApplicationArea = All;
                }
                field("SD status"; Rec."SD status")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."SD status" = Rec."SD status"::Received THEN BEGIN
                            Rec.TESTFIELD("Order Status", Rec."Order Status"::"Expired & amounts tobe recovered");
                            Rec.TESTFIELD("Security Deposit Amount");
                            IF (Rec."BG Status" = Rec."BG Status"::Received) AND (Rec."BG Status" = Rec."BG Status"::Received) THEN
                                Rec."Order Status" := Rec."Order Status"::"Amounts recovered";
                        END;
                    end;
                }
                field("BG Amount"; Rec."BG Amount")
                {
                    ApplicationArea = All;
                }
                field("BG Status"; Rec."BG Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."BG Status" = Rec."BG Status"::Received THEN BEGIN
                            Rec.TESTFIELD("Order Status", Rec."Order Status"::"Expired & amounts tobe recovered");
                            Rec.TESTFIELD("BG Amount");
                            IF (Rec."EMD Status" = Rec."EMD Status"::Received) AND (Rec."SD status" = Rec."SD status"::Received) THEN
                                Rec."Order Status" := Rec."Order Status"::"Amounts recovered";
                        END;
                    end;
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Amount"; Rec."EMD Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Status"; Rec."EMD Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."EMD Status" = Rec."EMD Status"::Received THEN BEGIN
                            Rec.TESTFIELD("Order Status", Rec."Order Status"::"Expired & amounts tobe recovered");
                            Rec.TESTFIELD("EMD Amount");
                            IF (Rec."BG Status" = Rec."BG Status"::Received) AND (Rec."SD status" = Rec."SD status"::Received) THEN
                                Rec."Order Status" := Rec."Order Status"::"Amounts recovered";
                        END;
                    end;
                }
                field("BG Date of Issue"; Rec."BG Date of Issue")
                {
                    ApplicationArea = All;
                }
                field("BG Expiry Date"; Rec."BG Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Reference Sale Order"; Rec."Reference Sale Order")
                {
                    ApplicationArea = All;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    CaptionML = ENU = 'Last Posted',
                                ENN = 'Date Archived';
                    ApplicationArea = All;
                }
                field("Warranty Exp Date"; Rec."Warranty Exp Date")
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
            action(Attachment)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CustAttachments;
                end;
            }
        }
    }

    var
        SIH: Record "Sales Invoice Header";
        BG: Record "Bank Guarantee";
        Attachment: Record Attachments;


    procedure CustAttachments();
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header Archive");
        CustAttach.SETRANGE("Document No.", Rec."No.");
        CustAttach.SETRANGE("Document Type", Rec."Document Type");
        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", DATABASE::"Sales Header Archive");
        Attachment.SETRANGE("Document No.", Rec."No.");
        Attachment.SETRANGE(Attachment."Attachment Status", TRUE);
        IF Attachment.FINDFIRST THEN BEGIN
            Rec."Bill Attached" := TRUE;
            Rec.MODIFY;
        END
        ELSE BEGIN
            Rec."Bill Attached" := FALSE;
            Rec.MODIFY;
        END;
    end;
}

