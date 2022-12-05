pageextension 70179 SalesCreditMemoExt extends 44
{
    layout
    {
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code/City';
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code/City';
        }
        /* modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code/City';
        }
        modify("Reference Invoice No.")
        {
            Visible = false;
        } */
        modify("Applies-to Doc. No.")
        {
            trigger OnBeforeValidate()
            begin
                IF Rec."Reference Invoice No." = '' THEN BEGIN
                    Rec."Reference Invoice No." := Rec."Applies-to Doc. No.";
                    Rec.MODIFY;
                END;
            end;
        }
        addafter(Status)
        {
            field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
            }
            field("Sale Order No."; Rec."Sale Order No.")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
        modify("Co&mments")
        {
            Promoted = true;
        }
        modify(Dimensions)
        {
            Promoted = true;
        }
        modify(Approvals)
        {
            Promoted = true;
        }
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(Comment)
        {
            Promoted = true;
        }
        modify(Release)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reopen)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(GetPostedDocumentLinesToReverse)
        {
            Promoted = true;
        }
        modify(CalculateInvoiceDiscount)
        {
            Promoted = true;
        }
        modify(ApplyEntries)
        {
            Promoted = true;
        }
        /* modify("Get St&d. Cust. Sales Codes")
        {
            Promoted = true;
        } */
        modify(CopyDocument)
        {
            Promoted = true;
        }
        modify("Move Negative Lines")
        {
            Promoted = true;
        }
        /* modify("Update Reference Invoice No")
        {
            Promoted = true;
        } */
        modify(SendApprovalRequest)
        {
            Promoted = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            begin
                IF Rec."Posting Date" < TODAY THEN BEGIN
                    ERROR('Credit Note can not be posted with Previous date');
                END;
            end;
        }
        modify(TestReport)
        {
            Promoted = true;
        }
        modify(PostAndSend)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        /* modify("Post and &Print")
        {
            PromotedIsBig = true;
        } */
        addafter(Reopen)
        {
            separator(Action1102152000)
            {
            }
            group(Inspection)
            {
                Caption = 'Inspection';
                action("Cancel Inspection")
                {
                    Caption = 'Cancel Inspection';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        QualityStatusValue: Text[50];
                        SalesCrLine: Record 37;

                    begin
                        IF CONFIRM(Text33000260, FALSE) THEN BEGIN
                            QualityStatusValue := 'Cancel';
                            // CurrPage.SalesLines.PAGE.CancelInspection(QualityStatusValue);//EFFUPG1.2
                            CurrPage.SalesLines.page.GetRecord(SalesCrLine);//EFFUPG1.2

                            CancelInspection(QualityStatusValue, SalesCrLine);//EFFUPG1.2
                            CurrPage.UPDATE(FALSE);

                        END;
                    end;
                }
                action("Short Close Inspection")
                {
                    Caption = 'Short Close Inspection';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        QualityStatusValue: Text[50];
                        SalesCrLine: Record 37;
                    begin
                        IF CONFIRM(Text33000261, FALSE) THEN BEGIN
                            QualityStatusValue := 'Close';
                            //CurrPage.SalesLines.PAGE.CancelInspection(QualityStatusValue);//EFFUPG1.2
                            CurrPage.SalesLines.page.GetRecord(SalesCrLine);//EFFUPG1.2
                            CancelInspection(QualityStatusValue, SalesCrLine);//EFFUPG1.2
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
            }
        }
    }



    var
        Text33000260: Label 'Do you want to Cancel Quality Inspection?';
        Text33000261: Label 'Do you want to Close Quality Inspection?';




    PROCEDURE CancelInspection(VAR QualityStatus: Text[50]; SalesLinePar: Record "Sales Line")
    VAR
        IDS: Record 33000255;
        IDSL: Record 33000256;
        QILE: Record 33000262;
        PIDS: Record 33000263;
        PIDSL: Record 33000264;
    BEGIN
        with SalesLinePar do begin
            IF "Quality Before Receipt" = TRUE THEN BEGIN
                IDS.SETRANGE("Sales Order No.", "Document No.");
                IDS.SETRANGE("Sales Line No", "Line No.");
                IF NOT IDS.FIND('-') THEN
                    ERROR('You can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
                ELSE BEGIN
                    PIDS.TRANSFERFIELDS(IDS);
                    PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                    PIDS.INSERT;
                    IDS.DELETE;
                    IDSL.SETRANGE("Document No.", IDS."No.");
                    IF IDSL.FIND('-') THEN BEGIN
                        REPEAT
                            PIDSL.TRANSFERFIELDS(IDSL);
                            PIDSL.INSERT;
                        UNTIL IDSL.NEXT = 0;
                        IDSL.DELETEALL;
                    END;
                    IF QualityStatus = 'Cancel' THEN BEGIN
                        //"Quality Status" := "Quality Status" :: Cancel;
                        "Quality Before Receipt" := FALSE;
                        "Qty. Sending To Quality" := 0;
                        "Qty. Sent To Quality" := 0;
                        MODIFY;
                    END;
                END;
            END ELSE BEGIN
                IDS.SETRANGE("Sales Order No.", "Document No.");
                IDS.SETRANGE("Sales Line No", "Line No.");
                IF NOT IDS.FIND('-') THEN
                    ERROR('You Can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
                ELSE BEGIN
                    PIDS.TRANSFERFIELDS(IDS);
                    PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                    PIDS.INSERT;
                    IDS.DELETE;
                    IDSL.SETRANGE("Document No.", IDS."No.");
                    IF IDSL.FIND('-') THEN BEGIN
                        REPEAT
                            PIDSL.TRANSFERFIELDS(IDSL);
                            PIDSL.INSERT;
                        UNTIL IDSL.NEXT = 0;
                        IDSL.DELETEALL;
                    END;
                    QILE.SETRANGE("Document No.", IDS."Receipt No.");
                    IF QILE.FIND('-') THEN
                        QILE.DELETE;
                    IF QualityStatus = 'Cancel' THEN BEGIN
                        //"Quality Status" := "Quality Status" :: Cancel;
                        "Qty. Sending To Quality" := 0;
                        "Qty. Sent To Quality" := 0;
                        MODIFY;
                    END;
                END;
            END;
        END;
    end;


}

