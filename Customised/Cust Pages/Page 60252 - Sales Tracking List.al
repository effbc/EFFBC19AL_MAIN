page 60252 "Sales Tracking List"
{
    CardPageID = "Sales Tracking Card";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Header Archive";
    SourceTableTemporary = true;
    SourceTableView = SORTING("Document Type", "No.", "Date Archived", "Time Archived") ORDER(Ascending) WHERE(SaleDocType = FILTER(Order | Amc), "Customer Posting Group" = CONST('RAILWAYS'));//EFFUPG1.5
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Caption = 'No';
                    StyleExpr = "No.Format";
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Date Archived"; "Date Archived")
                {
                    CaptionML = ENU = 'Last Posted',
                                ENN = 'Date Archived';
                    ApplicationArea = All;
                }
                field("Customer OrderNo."; "Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Warranty Period"; "Warranty Period")
                {
                    ApplicationArea = All;
                }
                field("Order Status"; "Order Status")
                {
                    ApplicationArea = All;
                }
                field("Warranty Completed"; "Warranty Completed")
                {
                    ApplicationArea = All;
                }
                field("Converted to AMC"; "Converted to AMC")
                {
                    ApplicationArea = All;
                }
                field("Bill Attached"; "Bill Attached")
                {
                    ApplicationArea = All;
                }
                field("Scope To AMC"; "Scope To AMC")
                {
                    ApplicationArea = All;
                }
                field("Converted AMC Order"; "Converted AMC Order")
                {
                    ApplicationArea = All;
                }
                field("Sale Order Total Amount"; "Sale Order Total Amount")
                {
                    ApplicationArea = All;
                }
                field("SD status"; "SD status")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152010)
            {
                Enabled = true;
                ShowCaption = false;
                grid(Control1102152012)
                {
                    ShowCaption = false;
                    group(Control1102152018)
                    {
                        ShowCaption = false;
                        field(Color_Attachment; Color_Attachment)
                        {
                            Caption = 'Color_Attachment';
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            Visible = true;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Get Details")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SHA.RESET;
                    SHA.SETCURRENTKEY("Document Type", "No.", "Date Archived", "Time Archived");
                    SHA.SETFILTER(SHA."Document Type", '%1|%2', SHA."Document Type"::Order);//, SHA."Document Type"::Amc);//EFFUPG1.5
                    SHA.SETFILTER(SHA."Customer Posting Group", '%1', 'RAILWAYS');
                    //SHA.SETFILTER(SHA."No.",'%1','EFF/SAL/03-04/013');
                    IF SHA.FINDSET THEN BEGIN
                        MESSAGE(FORMAT(SHA.COUNT));
                        REPEAT
                            //  MESSAGE(FORMAT(SHA."No."));
                            tempvar := '';
                            SalesHdr.RESET;
                            SalesHdr.SETCURRENTKEY("Document Type", "No.");
                            SalesHdr.SETFILTER(SalesHdr."No.", SHA."No.");
                            IF SalesHdr.FINDFIRST THEN BEGIN
                                SHA."Sale Order Total Amount" := SalesHdr."Sale Order Total Amount";
                                SHA."Warranty Period" := SalesHdr."Warranty Period";
                                SHA."Security Deposit Amount" := SalesHdr."Security Deposit Amount";
                                //  MESSAGE(FORMAT(SHA."Security Deposit Amount"));
                            END
                            ELSE BEGIN
                                SIH.RESET;
                                SIH.SETCURRENTKEY("Order No.");
                                SIH.SETFILTER(SIH."Order No.", SHA."No.");
                                IF SIH.FINDLAST THEN BEGIN
                                    SHA."Sale Order Total Amount" := SIH."Sale Order Total Amount";
                                    SHA."Warranty Period" := SIH."Warranty Period";
                                    SHA."Security Deposit Amount" := SIH."Security Deposit Amount";
                                    //  MESSAGE(FORMAT(SHA."Security Deposit Amount"));
                                END;
                            END;
                            BG.RESET;
                            BG.SETCURRENTKEY("BG No.");
                            BG.SETFILTER(BG."Doc No.", SHA."No.");
                            IF BG.FINDFIRST THEN BEGIN
                                SHA."BG Amount" := BG."BG Value";
                                SHA."BG Date of Issue" := BG."Date of Issue";
                                SHA."BG Expiry Date" := BG."Expiry Date";
                                //MESSAGE(FORMAT(SHA."BG Amount"));
                                TH.RESET;
                                TH.SETCURRENTKEY("Tender No.");
                                TH.SETFILTER(TH."Tender No.", BG."Tender No.");
                                IF TH.FINDFIRST THEN BEGIN
                                    SHA."EMD Amount" := TH."EMD Amount";
                                    //MESSAGE(FORMAT(SHA."EMD Amount"));
                                END;
                            END;
                            IF FORMAT(SHA."Warranty Period") <> '' THEN BEGIN
                                tempvar := '+' + FORMAT(SHA."Warranty Period");
                                SHA."Warranty Exp Date" := CALCDATE(tempvar, SHA."Date Archived");
                            END;
                            SHA.MODIFY;
                        UNTIL SHA.NEXT = 0;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        Color_Attachment := 'Has Attachment';
        prev := '';
        "No.Format" := 'None';
        SHA.RESET;
        SHA.SETCURRENTKEY("Document Type", "No.", "Date Archived", "Time Archived");
        SHA.SETFILTER(SHA."Document Type", '%1|%2', SHA."Document Type"::Order);//, SHA."Document Type"::Amc);//EFFUPG1.5
        SHA.SETFILTER(SHA."Customer Posting Group", '%1', 'RAILWAYS');
        Dum1.INIT;
        IF SHA.FINDSET THEN
            REPEAT
                "No.Format" := 'None';
                IF (prev <> '') AND (prev <> SHA."No.") THEN BEGIN
                    SalesHdr.RESET;
                    SalesHdr.SETCURRENTKEY("Document Type", "No.");
                    SalesHdr.SETFILTER(SalesHdr."No.", Dum1."No.");
                    IF NOT SalesHdr.FINDLAST THEN BEGIN
                        TRANSFERFIELDS(Dum1);
                        INSERT;
                        Attachment.RESET;
                        Attachment.SETRANGE("Table ID", DATABASE::"Sales Header Archive");
                        Attachment.SETRANGE("Document No.", "No.");
                        Attachment.SETRANGE(Attachment."Attachment Status", TRUE);
                        IF Attachment.FINDFIRST THEN BEGIN
                            "No.Format" := 'StrongAccent';
                        END;

                    END;
                END;
                prev := SHA."No.";
                Dum1.TRANSFERFIELDS(SHA);
            UNTIL SHA.NEXT = 0;
        SETCURRENTKEY("Document Type", "No.", "Date Archived", "Time Archived");
    end;

    var
        Dum1: Record "Sales Header Archive" temporary;
        Dum2: Record "Sales Header Archive" temporary;
        SHA: Record "Sales Header Archive";
        prev: Code[30];
        SalesHdr: Record "Sales Header";
        BG: Record "Bank Guarantee";
        TH: Record "Tender Header";
        SIH: Record "Sales Invoice Header";
        tempvar: Text;
        Color_Attachment: Text;
        "No.Format": Text;
        Attachment: Record Attachments;
}

