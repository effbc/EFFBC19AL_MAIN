page 60130 "New RGP Out"
{
    // version B2B1.0,Cal1.0,Rev01

    Editable = true;
    PageType = Document;
    SourceTable = "RGP Out Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Consignee; Rec.Consignee)
                {
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ConsigneeNoOnAfterValidate;
                    end;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                }
                field("RGP Date"; Rec."RGP Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Zone; Rec.Zone)
                {
                    ApplicationArea = All;
                }
                field(Division; Rec.Division)
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = All;
                }
                field("Sending To"; Rec."Sending To")
                {
                    ApplicationArea = All;
                }
                field("Release Status"; Rec."Release Status")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000022; "RGP Out Lines")
            {
                SubPageLink = "Document No."= FIELD("RGP Out No.");
    ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&RGP Out")
            {
                Caption = '&RGP Out';
                action(List)
                {
                    Caption = 'List';
                    Ellipsis = true;
                    Image = List;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                        Text051: Label 'Do you want to post %1?';
                    begin
                        RGPOutHead.SETRANGE("RGP I/O", TRUE);
                        PAGE.RUN(0, RGPOutHead);
                    end;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Indent")
                {
                    Caption = 'Copy Indent';
                    Image = Indent;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CopyIndent;
                    end;
                }
                action("Get RGP &In")
                {
                    Caption = 'Get RGP &In';
                    Image = GetLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        RGPOut: Record "RGP Out Header";
                        RGPOutLine: Record "RGP Out Line";
                        RGPIn: Record "RGP In Header";
                        RGPInLine: Record "RGP In Line";
                        RGPOutLineNo: Integer;
                        RGPLedgerEntry: Record "RGP Ledger Entries";
                        TempLedgerEntry: Record "Temp. RGP Ledger Entry";
                        RGPApplied: Record "Temp. Applied RGPs";
                        NextEntryNo: Integer;
                        RGPLedgerEntry1: Record "RGP Ledger Entries";
                        RemainingQty: Decimal;
                        RGPOutEntryNo: Integer;
                        RGPOutLine1: Record "RGP Out Line";
                        EntryNo: Integer;
                        chkStatus: Boolean;
                        DocumentNo: Code[20];
                        RGPInHead: Record "RGP In Header";
                        RGPInLinecal: Record "RGP In Line";
                    begin
                        Rec.TESTFIELD("RGP Out No.");
                        Rec.TESTFIELD("Consignee No.");

                        RGPIn.RESET;
                        RGPInLine.RESET;
                        RGPOutLine.RESET;
                        RGPLedgerEntry.RESET;

                        RGPOutLine1.SETRANGE("Document No.", Rec."RGP Out No.");
                        RGPOutLine1.SETRANGE(RGPOutLine1."RGP In Document No.", '');
                        IF RGPOutLine1.FINDFIRST THEN BEGIN
                            RGPOutLine1.DELETEALL;
                        END;

                        TempLedgerEntry.SETRANGE("RGP Out No.", Rec."RGP Out No.");
                        TempLedgerEntry.DELETEALL;

                        RGPApplied.SETRANGE("Document No.", Rec."RGP Out No.");
                        IF RGPApplied.FINDFIRST THEN BEGIN
                            RGPApplied.DELETEALL;
                        END;


                        COMMIT;

                        RGPOutLine.SETRANGE("Document No.", Rec."RGP Out No.");
                        IF RGPOutLine.FINDLAST THEN BEGIN
                            RGPOutLineNo := RGPOutLine."Line No.";
                        END ELSE BEGIN
                            RGPOutLineNo := 0;
                        END;
                        RGPIn.SETRANGE(Consignee, Rec.Consignee);
                        RGPIn.SETRANGE("Consignee No.", Rec."Consignee No.");
                        RGPIn.SETRANGE(Status, RGPIn.Status::Posted);
                        RGPIn.SETRANGE(Open, TRUE);
                        RGPIn.SETRANGE("Posted RGP", FALSE);
                        IF PAGE.RUNMODAL(0, RGPIn) = ACTION::LookupOK THEN BEGIN
                            RGPInLine.SETRANGE("Document No.", RGPIn."RGP In No.");
                            IF RGPInLine.FINDSET THEN BEGIN
                                REPEAT
                                    RGPLedgerEntry.SETRANGE("Entry No.", RGPInLine."Entry No.");
                                    IF RGPLedgerEntry.FINDFIRST THEN BEGIN
                                        IF RGPLedgerEntry.Open THEN BEGIN
                                            RGPOutLine.SETRANGE("RGP In Document No.", RGPInLine."Document No.");
                                            RGPOutLine.SETRANGE("RGP In Line No.", RGPInLine."Line No.");
                                            IF NOT RGPOutLine.FINDFIRST THEN BEGIN
                                                RGPOutLineNo := RGPOutLineNo + 10000;
                                                RGPOutLine."Document No." := Rec."RGP Out No.";
                                                RGPOutLine."Line No." := RGPOutLineNo;
                                                RGPOutLine."RGP In Document No." := RGPInLine."Document No.";
                                                RGPOutLine."RGP In Line No." := RGPInLine."Line No.";
                                                RGPOutLine.Type := RGPInLine.Type;
                                                RGPOutLine."No." := RGPInLine."No.";
                                                RGPOutLine.Description := RGPInLine.Description;
                                                RGPOutLine.UOM := RGPInLine.UOM;
                                                RGPOutLine."Production Order Line No." := RGPInLine."Production Order Line No.";
                                                RGPOutLine."Production Order" := RGPInLine."Production Order";
                                                RGPOutLine."Drawing No." := RGPInLine."Drawing No.";
                                                RGPOutLine."Operation No." := RGPInLine."Operation No.";
                                                RGPOutLine."Routing No." := RGPInLine."Routing No.";
                                                RGPOutLine."Expected Return Date" := RGPInLine."Expected Return Date";
                                                RGPLedgerEntry.SETRANGE("Entry No.", RGPInLine."Entry No.");
                                                IF RGPLedgerEntry.FINDFIRST THEN BEGIN
                                                    RGPOutLine.Quantity := RGPLedgerEntry."Remaining Quantity";
                                                    RGPOutLine."Quantity to Recieve" := RGPLedgerEntry."Remaining Quantity";
                                                END;
                                                RGPOutLine.INSERT;
                                            END;
                                        END;
                                    END;
                                UNTIL RGPInLine.NEXT = 0;
                            END;
                        END;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPOutRelease(Rec);
                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPOutReopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                        Text051: Label 'Do you want to post %1?';
                    begin
                        Rec.TESTFIELD("Release Status", Rec."Release Status"::Release);
                        Rec.TESTFIELD("Consignee No.");
                        RGPOutLine.RESET;
                        RGPLedgerEntry.RESET;
                        RGPLedgerEntry.LOCKTABLE;
                        IF RGPLedgerEntry.FINDLAST THEN
                            NextEntryNo := RGPLedgerEntry."Entry No."
                        ELSE
                            NextEntryNo := 0;

                        IF CONFIRM(Text002, FALSE, Rec."RGP Out No.") THEN BEGIN
                            RGPOutLine.SETRANGE("Document No.", Rec."RGP Out No.");
                            IF RGPOutLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF (RGPOutLine.Type = RGPOutLine.Type::Item) OR (RGPOutLine.Type = RGPOutLine.Type::"Fixed Asset")
                                    OR (RGPOutLine.Type = RGPOutLine.Type::Calibration) THEN
                                        RGPOutLine.TESTFIELD(UOM);
                                    IF RGPOutLine."Quantity to Recieve" = 0 THEN BEGIN
                                        TempLedgerEntry.SETRANGE("Line No.", 1);
                                        IF TempLedgerEntry.FINDFIRST THEN BEGIN
                                            IF TempLedgerEntry.Quantity <> 0 THEN
                                                ERROR(Text003, RGPOutLine.Quantity, (RGPOutLine.Quantity - TempLedgerEntry.Quantity), RGPOutLine."Line No.");
                                        END;
                                        RGPApplied.SETRANGE("Consignee No.", Rec."Consignee No.");

                                        IF RGPApplied.FINDSET THEN BEGIN
                                            REPEAT
                                                RGPLedgerEntry.INIT;
                                                NextEntryNo := NextEntryNo + 1;
                                                RGPLedgerEntry."Entry No." := NextEntryNo;
                                                RGPLedgerEntry."Entry Date" := TODAY;
                                                RGPLedgerEntry."Document No." := RGPOutLine."Document No.";
                                                RGPLedgerEntry."Document Line No." := RGPOutLine."Line No.";
                                                RGPLedgerEntry."Document Date" := Rec."RGP Date";
                                                RGPLedgerEntry."Document Type" := RGPLedgerEntry."Document Type"::Out;
                                                RGPLedgerEntry.Consignee := RGPApplied.Consignee;
                                                RGPLedgerEntry."Consignee No." := RGPApplied."Consignee No.";
                                                RGPLedgerEntry.Quantity := RGPApplied.Quantity;
                                                RGPLedgerEntry."Remaining Quantity" := RGPApplied."Remaining Quantity";
                                                RGPLedgerEntry."Applied To Entry" := RGPApplied."Applied To Entry";
                                                RGPLedgerEntry.Open := RGPApplied.Open;
                                                RGPLedgerEntry.Type := RGPApplied.Type;
                                                RGPLedgerEntry."No." := RGPApplied."No.";
                                                RGPLedgerEntry.INSERT;

                                                CheckRGPOutStatus(RGPApplied."Applied To Entry");

                                                RGPLedgerEntry1.SETRANGE("Entry No.", RGPApplied."Applied To Entry");
                                                IF RGPLedgerEntry1.FINDFIRST THEN BEGIN
                                                    RGPLedgerEntry1."Remaining Quantity" := RGPApplied."Remaining Quantity";
                                                    RGPLedgerEntry1.Open := RGPApplied.Open;
                                                    RGPLedgerEntry1.MODIFY;
                                                END;
                                            UNTIL RGPApplied.NEXT = 0;
                                        END ELSE BEGIN
                                            ERROR(Text001, RGPOutLine.Type, RGPOutLine."No.");
                                        END;
                                    END ELSE BEGIN
                                        RGPLedgerEntry.INIT;
                                        NextEntryNo := NextEntryNo + 1;
                                        RGPLedgerEntry."Entry No." := NextEntryNo;
                                        RGPLedgerEntry."Entry Date" := TODAY;
                                        RGPLedgerEntry."Document No." := RGPOutLine."Document No.";
                                        RGPLedgerEntry."Document Line No." := RGPOutLine."Line No.";
                                        RGPLedgerEntry."Document Date" := Rec."RGP Date";
                                        RGPLedgerEntry."Document Type" := RGPLedgerEntry."Document Type"::Out;
                                        RGPLedgerEntry.Consignee := Rec.Consignee;
                                        RGPLedgerEntry."Consignee No." := Rec."Consignee No.";
                                        RGPLedgerEntry.Quantity := RGPOutLine.Quantity;

                                        RemainingQty := (RGPOutLine."Quantity to Recieve" - RGPOutLine.Quantity);

                                        RGPInLine.SETRANGE("Document No.", RGPOutLine."RGP In Document No.");
                                        RGPInLine.SETRANGE("Line No.", RGPOutLine."RGP In Line No.");
                                        IF RGPInLine.FINDFIRST THEN BEGIN
                                            RGPLedgerEntry1.SETRANGE("Entry No.", RGPInLine."Entry No.");
                                            IF RGPLedgerEntry1.FINDFIRST THEN BEGIN
                                                RGPInEntryNo := RGPInLine."Entry No.";
                                                //RGPLedgerEntry1."Applied To Entry":=NextEntryNo;
                                                IF RemainingQty = 0 THEN BEGIN
                                                    RGPLedgerEntry1."Remaining Quantity" := 0;
                                                    RGPLedgerEntry1.Open := FALSE;
                                                END ELSE BEGIN
                                                    RGPLedgerEntry1."Remaining Quantity" := RemainingQty;
                                                    RGPLedgerEntry1.Open := TRUE;
                                                END;
                                                RGPLedgerEntry1.MODIFY;
                                            END;
                                        END;

                                        //kpk//
                                        RGPIn.SETRANGE("RGP In No.", RGPInLine."Document No.");
                                        RGPIn.SETFILTER(Status, 'Posted');
                                        IF RGPIn.FINDFIRST THEN
                                            //RGPIN.Check := FALSE;
                                            RGPIn."Posted RGP" := TRUE; //To update this field and not to view from the GetRGPIN from RGPOUT form 22May07
                                        RGPIn.MODIFY;
                                        //kpk//
                                        RGPLedgerEntry."Applied To Entry" := RGPInEntryNo;
                                        RGPLedgerEntry."Remaining Quantity" := RemainingQty;
                                        RGPLedgerEntry.Open := RGPApplied.Open;
                                        RGPLedgerEntry.Type := RGPApplied.Type;
                                        RGPLedgerEntry."No." := RGPApplied."No.";
                                        RGPLedgerEntry.INSERT;
                                    END;
                                UNTIL RGPOutLine.NEXT = 0;
                            END;

                            Rec.GET(Rec."RGP Out No.");
                            Rec.Status := Rec.Status::Posted;
                            Rec.MODIFY;

                            //Bhavani
                            RGPOutLinecal.SETRANGE("Document No.", Rec."RGP Out No.");
                            IF RGPOutLinecal.FINDSET THEN
                                REPEAT
                                    RGPOutLinecal.Status := Rec.Status;
                                    RGPOutLinecal.MODIFY;

                                /*Calibration.SETRANGE("Equipment No",RGPInLinecal."No.");
                                IF Calibration.FINDFIRST THEN BEGIN
                                  Calibration."Current Status" := Calibration."Current Status" :: Calibrated;
                                  Calibration."Expected Return Date" := 0D;
                                  Calibration.Results := Results;
                                  Calibration.Recommendations := Recommendations;
                                  Calibration.MODIFY;
                                END;*/
                                UNTIL RGPOutLinecal.NEXT = 0;
                            //Bhavani


                            RGPApplied.SETRANGE("Consignee No.", Rec."Consignee No.");
                            RGPApplied.SETRANGE(Open, TRUE);
                            IF RGPApplied.FINDSET THEN BEGIN
                                REPEAT
                                    EntryNo := RGPApplied."Applied To Entry";
                                    RGPLedgerEntry.SETRANGE("Entry No.", EntryNo);
                                    IF RGPLedgerEntry.FINDFIRST THEN BEGIN
                                        RGPLedgerEntry."Applies To" := '';
                                        RGPLedgerEntry.MODIFY;
                                    END;
                                UNTIL RGPApplied.NEXT = 0;
                            END;

                            RGPApplied.RESET;
                            RGPApplied.SETRANGE("Consignee No.", Rec."Consignee No.");
                            RGPApplied.DELETEALL;

                            TempLedgerEntry.RESET;
                            TempLedgerEntry.SETRANGE(TempLedgerEntry."Line No.", 1);
                            TempLedgerEntry.DELETEALL;

                            CurrPage.UPDATE;
                        END;

                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    RGPOutHead.SETRANGE(RGPOutHead."RGP Out No.", Rec."RGP Out No.");
                    REPORT.RUN(50053, TRUE, FALSE, RGPOutHead);
                    RGPOutHead.SETRANGE("RGP Out No.");
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."RGP I/O" := TRUE;
    end;

    var
        RGPOutLine: Record "RGP Out Line";
        RGPOutHead: Record "RGP Out Header";
        RGPLedgerEntry: Record "RGP Ledger Entries";
        TempLedgerEntry: Record "Temp. RGP Ledger Entry";
        RGPApplied: Record "Temp. Applied RGPs";
        RGPLedgerEntry1: Record "RGP Ledger Entries";
        RGPInLine: Record "RGP In Line";
        RGPIn: Record "RGP In Header";
        RemainingQty: Decimal;
        NextEntryNo: Integer;
        Text001: Label 'There are no applied entries for %1 No. %2';
        Text002: Label 'Do you want to post the Document No. %1?';
        Text003: Label 'RGP In Quantity %1 cannot be more than RGP In Pending Quantity %2 in Line No. %3';
        EntryNo: Integer;
        chkStatus: Boolean;
        RGPInEntryNo: Integer;
        RGPOutLinecal: Record "RGP In Line";
        DocumentNo: Code[20];
        RGPRelease: Codeunit "RGP Release";

   
    procedure CheckRGPOutStatus(var RGPEntryNo: Integer);
    begin
        chkStatus := TRUE;
        RGPLedgerEntry.SETRANGE("Entry No.", RGPEntryNo);
        IF RGPLedgerEntry.FINDFIRST THEN BEGIN
            DocumentNo := RGPLedgerEntry."Document No.";
            RGPLedgerEntry1.SETRANGE("Document No.", RGPLedgerEntry."Document No.");
            RGPLedgerEntry1.SETRANGE("Document Line No.", RGPLedgerEntry."Document Line No.");
            RGPLedgerEntry1.SETRANGE("Document Type", RGPLedgerEntry."Document Type"::"In");
            IF RGPLedgerEntry1.FINDSET THEN BEGIN
                REPEAT
                    IF NOT RGPLedgerEntry1.Open THEN
                        chkStatus := FALSE;
                UNTIL RGPLedgerEntry1.NEXT = 0;
            END;
        END;

        IF chkStatus THEN BEGIN
            RGPIn.SETRANGE("RGP In No.", DocumentNo);
            IF RGPIn.FINDFIRST THEN BEGIN
                RGPIn.Open := FALSE;
                RGPIn.MODIFY;
            END;
        END;
    end;

   
    local procedure ConsigneeNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

