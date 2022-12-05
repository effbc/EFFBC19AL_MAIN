page 60062 "RGP In"
{
    // version B2B1.0,Cal1.0

    PageType = Document;
    SourceTable = "RGP In Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("RGP In No."; Rec."RGP In No.")
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

                    trigger OnValidate();
                    var
                        Text050: Label 'By changing consignee,all line will be be deleted,do you wish to proceed?';
                    begin
                        IF (xRec.Consignee <> Rec.Consignee) THEN BEGIN
                            RGPInLine.SETRANGE("Document No.", Rec."RGP In No.");
                            IF RGPInLine.FINDFIRST THEN BEGIN
                                IF CONFIRM(Text050, FALSE) THEN BEGIN
                                    Rec."Consignee No." := '';
                                    Rec."Consignee Name" := '';
                                    Rec.Address := '';
                                    Rec."Consignee City" := '';
                                    Rec."Consignee Contact" := '';
                                    Rec."Phone No." := '';
                                    Rec."Telex No." := '';
                                    RGPInLine.DELETEALL;
                                END ELSE BEGIN
                                    Rec.Consignee := xRec.Consignee;
                                END;
                            END ELSE BEGIN
                                Rec."Consignee No." := '';
                                Rec."Consignee Name" := '';
                                Rec.Address := '';
                                Rec."Consignee City" := '';
                                Rec."Consignee Contact" := '';
                                Rec."Phone No." := '';
                                Rec."Telex No." := '';
                            END;
                        END;
                        ConsigneeOnAfterValidate;
                    end;
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Release Status"; Rec."Release Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("RGP In Date"; Rec."RGP In Date")
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
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                }
                field(Recommendations; Rec.Recommendations)
                {
                    Caption = 'Recommendations';
                    ApplicationArea = All;
                }
            }
            part(RGPLines; "RGP In Lines")
            {
                SubPageLink = "Document No." = FIELD("RGP In No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Get Applied Entries")
                {
                    Caption = 'Get Applied Entries';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                    begin
                        CurrPage.RGPLines.PAGE.showEntries(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get RGP Out")
                {
                    Caption = 'Get RGP Out';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                    begin
                        Rec.TESTFIELD("RGP In No.");
                        Rec.TESTFIELD("Consignee No.");

                        RGPOut.RESET;
                        RGPOutLine.RESET;
                        RGPInLine.RESET;
                        RGPLedgerEntry.RESET;

                        RGPInLine1.SETRANGE("Document No.", Rec."RGP In No.");
                        RGPInLine1.SETRANGE(RGPInLine1."RGP Out Document No.", '');
                        IF RGPInLine1.FINDFIRST THEN BEGIN
                            RGPInLine1.DELETEALL;
                        END;

                        TempLedgerEntry.SETRANGE("RGP In No.", Rec."RGP In No.");
                        TempLedgerEntry.DELETEALL;

                        RGPApplied.SETRANGE("Document No.", Rec."RGP In No.");
                        IF RGPApplied.FINDFIRST THEN BEGIN
                            RGPApplied.DELETEALL;
                        END;

                        COMMIT;

                        RGPInLine.SETRANGE("Document No.", Rec."RGP In No.");
                        IF RGPInLine.FINDLAST THEN BEGIN
                            RGPInLineNo := RGPInLine."Line No.";
                        END ELSE BEGIN
                            RGPInLineNo := 0;
                        END;

                        RGPOut.SETRANGE(Consignee, Rec.Consignee);
                        RGPOut.SETRANGE("Consignee No.", Rec."Consignee No.");
                        RGPOut.SETRANGE(Status, RGPOut.Status::Posted);
                        RGPOut.SETRANGE(Open, TRUE);
                        RGPOut.SETRANGE("Posted RGP", FALSE);
                        IF PAGE.RUNMODAL(0, RGPOut) = ACTION::LookupOK THEN BEGIN
                            RGPOutLine.SETRANGE("Document No.", RGPOut."RGP Out No.");
                            IF RGPOutLine.FINDSET THEN BEGIN
                                REPEAT
                                    RGPLedgerEntry.SETRANGE("Entry No.", RGPOutLine."Entry No.");
                                    IF RGPLedgerEntry.FINDFIRST THEN BEGIN
                                        IF RGPLedgerEntry.Open THEN BEGIN
                                            RGPInLine.SETRANGE("RGP Out Document No.", RGPOutLine."Document No.");
                                            RGPInLine.SETRANGE("RGP Out Line No.", RGPOutLine."Line No.");
                                            IF NOT RGPInLine.FINDFIRST THEN BEGIN
                                                RGPInLineNo := RGPInLineNo + 10000;
                                                RGPInLine."Document No." := Rec."RGP In No.";
                                                RGPInLine."Line No." := RGPInLineNo;
                                                RGPInLine."RGP Out Document No." := RGPOutLine."Document No.";
                                                RGPInLine."RGP Out Line No." := RGPOutLine."Line No.";
                                                RGPInLine.Type := RGPOutLine.Type;
                                                RGPInLine."No." := RGPOutLine."No.";
                                                RGPInLine.Description := RGPOutLine.Description;
                                                RGPInLine.UOM := RGPOutLine.UOM;
                                                RGPInLine."Production Order Line No." := RGPOutLine."Production Order Line No.";
                                                RGPInLine."Production Order" := RGPOutLine."Production Order";
                                                RGPInLine."Drawing No." := RGPOutLine."Drawing No.";
                                                RGPInLine."Operation No." := RGPOutLine."Operation No.";
                                                RGPInLine."Routing No." := RGPOutLine."Routing No.";
                                                RGPInLine."Expected Return Date" := RGPOutLine."Expected Return Date";
                                                RGPLedgerEntry.SETRANGE("Entry No.", RGPOutLine."Entry No.");
                                                IF RGPLedgerEntry.FINDFIRST THEN BEGIN
                                                    RGPInLine.Quantity := RGPLedgerEntry."Remaining Quantity";
                                                    RGPInLine."Quantity to Recieve" := RGPLedgerEntry."Remaining Quantity";
                                                END;
                                                RGPInLine.INSERT;
                                            END;
                                        END;
                                    END;
                                UNTIL RGPOutLine.NEXT = 0;
                            END;
                        END;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPInRelease(Rec);
                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPInReopen(Rec);
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
                    ShortCutKey = 'F11';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                    begin
                        Rec.TESTFIELD("Release Status", Rec."Release Status"::Release);
                        Rec.TESTFIELD("Consignee No.");
                        RGPInLine.RESET;
                        RGPLedgerEntry.RESET;
                        RGPLedgerEntry.LOCKTABLE;
                        IF RGPLedgerEntry.FINDLAST THEN
                            NextEntryNo := RGPLedgerEntry."Entry No."
                        ELSE
                            NextEntryNo := 0;

                        IF CONFIRM(Text002, FALSE, Rec."RGP In No.") THEN BEGIN
                            RGPInLine.SETRANGE("Document No.", Rec."RGP In No.");
                            IF RGPInLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF (RGPInLine.Type = RGPInLine.Type::Item) OR (RGPInLine.Type = RGPInLine.Type::"Fixed Asset")
                                    OR (RGPInLine.Type = RGPInLine.Type::"Fixed Asset") THEN
                                        RGPInLine.TESTFIELD(UOM);
                                    IF RGPInLine."Quantity to Recieve" = 0 THEN BEGIN
                                        TempLedgerEntry.SETRANGE("Line No.", 1);
                                        IF TempLedgerEntry.FINDFIRST THEN BEGIN
                                            IF TempLedgerEntry.Quantity <> 0 THEN
                                                ERROR(Text003, RGPInLine.Quantity, (RGPInLine.Quantity - TempLedgerEntry.Quantity), RGPInLine."Line No.");
                                        END;
                                        RGPApplied.SETRANGE("Consignee No.", Rec."Consignee No.");

                                        IF RGPApplied.FINDSET THEN BEGIN
                                            REPEAT
                                                RGPLedgerEntry.INIT;
                                                NextEntryNo := NextEntryNo + 1;
                                                RGPLedgerEntry."Entry No." := NextEntryNo;
                                                RGPLedgerEntry."Entry Date" := TODAY;
                                                RGPLedgerEntry."Document No." := RGPInLine."Document No.";
                                                RGPLedgerEntry."Document Line No." := RGPInLine."Line No.";
                                                RGPLedgerEntry."Document Date" := Rec."RGP In Date";
                                                RGPLedgerEntry."Document Type" := RGPLedgerEntry."Document Type"::"In";
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
                                            ERROR(Text001, RGPInLine.Type, RGPInLine."No.");
                                        END;
                                    END ELSE BEGIN
                                        RGPLedgerEntry.INIT;
                                        NextEntryNo := NextEntryNo + 1;
                                        RGPLedgerEntry."Entry No." := NextEntryNo;
                                        RGPLedgerEntry."Entry Date" := TODAY;
                                        RGPLedgerEntry."Document No." := RGPInLine."Document No.";
                                        RGPLedgerEntry."Document Line No." := RGPInLine."Line No.";
                                        RGPLedgerEntry."Document Date" := Rec."RGP In Date";
                                        RGPLedgerEntry."Document Type" := RGPLedgerEntry."Document Type"::"In";
                                        RGPLedgerEntry.Consignee := Rec.Consignee;
                                        RGPLedgerEntry."Consignee No." := Rec."Consignee No.";
                                        RGPLedgerEntry.Quantity := RGPInLine.Quantity;

                                        RemainingQty := (RGPInLine."Quantity to Recieve" - RGPInLine.Quantity);

                                        RGPOutLine.SETRANGE("Document No.", RGPInLine."RGP Out Document No.");
                                        RGPOutLine.SETRANGE("Line No.", RGPInLine."RGP Out Line No.");
                                        IF RGPOutLine.FINDFIRST THEN BEGIN
                                            RGPLedgerEntry1.SETRANGE("Entry No.", RGPOutLine."Entry No.");
                                            IF RGPLedgerEntry1.FINDFIRST THEN BEGIN
                                                RGPOutEntryNo := RGPOutLine."Entry No.";
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
                                        RGPOut.SETRANGE("RGP Out No.", RGPOutLine."Document No.");
                                        RGPOut.SETFILTER(Status, 'Posted');
                                        IF RGPOut.FINDFIRST THEN
                                            RGPOut.Check := FALSE;
                                        RGPOut."Posted RGP" := TRUE; //To update this field and not to view from the GetRGPOut from RGPIN form 22May07
                                        RGPOut.MODIFY;
                                        //kpk//
                                        RGPLedgerEntry."Applied To Entry" := RGPOutEntryNo;
                                        RGPLedgerEntry."Remaining Quantity" := RemainingQty;
                                        RGPLedgerEntry.Open := RGPApplied.Open;
                                        RGPLedgerEntry.Type := RGPApplied.Type;
                                        RGPLedgerEntry."No." := RGPApplied."No.";
                                        RGPLedgerEntry.INSERT;
                                    END;
                                UNTIL RGPInLine.NEXT = 0;
                            END;

                            Rec.GET(Rec."RGP In No.");
                            Rec.Status := Rec.Status::Posted;
                            Rec.MODIFY;

                            //Bhavani
                            RGPInLinecal.SETRANGE("Document No.", Rec."RGP In No.");
                            IF RGPInLinecal.FINDSET THEN
                                REPEAT
                                    RGPInLinecal.Status := Rec.Status;
                                    RGPInLinecal.MODIFY;

                                    Calibration.SETRANGE("Equipment No", RGPInLinecal."No.");
                                    IF Calibration.FINDFIRST THEN BEGIN
                                        Calibration."Current Status" := Calibration."Current Status"::Calibrated;
                                        Calibration."Expected Return Date" := 0D;
                                        Calibration.Results := Rec.Results;
                                        Calibration.Recommendations := Rec.Recommendations;
                                        Calibration.MODIFY;
                                    END;
                                UNTIL RGPInLinecal.NEXT = 0;
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
                action("&Print")
                {
                    Caption = '&Print';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPInHead.SETRANGE(RGPInHead."RGP In No.", Rec."RGP In No.");
                        REPORT.RUN(50054, TRUE, FALSE, RGPInHead);
                        RGPInHead.SETRANGE("RGP In No.");
                    end;
                }
            }
        }
    }

    trigger OnClosePage();
    begin
        RGPApplied.SETRANGE("Consignee No.", Rec."Consignee No.");
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

        TempLedgerEntry.DELETEALL;
    end;

    var
        RGPOut: Record "RGP Out Header";
        RGPOutLine: Record "RGP Out Line";
        RGPInLine: Record "RGP In Line";
        RGPInLineNo: Integer;
        RGPLedgerEntry: Record "RGP Ledger Entries";
        TempLedgerEntry: Record "Temp. RGP Ledger Entry";
        RGPApplied: Record "Temp. Applied RGPs";
        NextEntryNo: Integer;
        Text001: Label 'There are no applied entries for %1 No. %2';
        RGPLedgerEntry1: Record "RGP Ledger Entries";
        RemainingQty: Decimal;
        Text002: Label 'Do you want to post the Document No. %1?';
        RGPOutEntryNo: Integer;
        RGPInLine1: Record "RGP In Line";
        EntryNo: Integer;
        Text003: Label 'RGP In Quantity %1 cannot be more than RGP Out Pending Quantity %2 in Line No. %3';
        chkStatus: Boolean;
        DocumentNo: Code[20];
        RGPInHead: Record "RGP In Header";
        RGPInLinecal: Record "RGP In Line";
        Calibration: Record Calibration;
        RGPRelease: Codeunit "RGP Release";


    procedure TempLedgerEntrySave(var RGPInHeader: Record "RGP In Header"; var RGPInLine: Record "RGP In Line");
    begin
        /*TempLedgerEntry.SETRANGE("Line No.",1);
        IF NOT TempLedgerEntry.FINDFIRST THEN BEGIN
          TempLedgerEntry."Line No.":=1;
          TempLedgerEntry.Consignee:=RGPInHeader.Consignee;
          TempLedgerEntry."Consignee No.":=RGPInHeader."Consignee No.";
          TempLedgerEntry.Type:=RGPInLine.Type;
          TempLedgerEntry."No.":=RGPInLine."No.";
          TempLedgerEntry.Quantity:=RGPInLine.Quantity;
          TempLedgerEntry."RGP In No.":=RGPInLine."Document No.";
          TempLedgerEntry."RGP Line No.":=RGPInLine."Line No.";
          TempLedgerEntry."RGP Document Date":=RGPInHeader."RGP In Date";
          TempLedgerEntry.INSERT;
          COMMIT;
        END;   */

    end;


    procedure CheckRGPOutStatus(var RGPEntryNo: Integer);
    begin
        chkStatus := TRUE;
        RGPLedgerEntry.SETRANGE("Entry No.", RGPEntryNo);
        IF RGPLedgerEntry.FINDFIRST THEN BEGIN
            DocumentNo := RGPLedgerEntry."Document No.";
            RGPLedgerEntry1.SETRANGE("Document No.", RGPLedgerEntry."Document No.");
            RGPLedgerEntry1.SETRANGE("Document Line No.", RGPLedgerEntry."Document Line No.");
            RGPLedgerEntry1.SETRANGE("Document Type", RGPLedgerEntry."Document Type"::Out);
            IF RGPLedgerEntry1.FINDSET THEN BEGIN
                REPEAT
                    IF NOT RGPLedgerEntry1.Open THEN
                        chkStatus := FALSE;
                UNTIL RGPLedgerEntry1.NEXT = 0;
            END;
        END;

        IF chkStatus THEN BEGIN
            RGPOut.SETRANGE("RGP Out No.", DocumentNo);
            IF RGPOut.FINDFIRST THEN BEGIN
                RGPOut.Open := FALSE;
                RGPOut.MODIFY;
            END;
        END;
    end;


    local procedure ConsigneeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure ConsigneeNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

