page 60131 "New RGP In"
{
    // version B2B1.0,Cal1.0,Rev01

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
                field("Release Status"; Rec."Release Status")
                {
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
            group("&RGP In")
            {
                Caption = '&RGP In';
                action("&List")
                {
                    Caption = '&List';
                    Ellipsis = true;
                    Image = List;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text050: Label 'There is nothing to post';
                    begin
                        RGPInHead.SETRANGE("RGP I/O", TRUE);
                        PAGE.RUN(0, RGPInHead);
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
                    Image = GetLines;
                    Visible = false;
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
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPRelease.RGPInRelease(Rec);
                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
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
                        RGPInLine.SETRANGE("Document No.", Rec."RGP In No.");
                        IF NOT RGPInLine.FINDFIRST THEN
                            ERROR(Text050);
                        IF CONFIRM(Text051, FALSE, Rec."RGP In No.") THEN BEGIN
                            Rec.PostNewRGP;
                            CurrPage.UPDATE;
                        END;
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Image = Print;
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

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."RGP I/O" := TRUE;
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


    local procedure ConsigneeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure ConsigneeNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

