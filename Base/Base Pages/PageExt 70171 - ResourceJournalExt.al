pageextension 70171 ResourceJournalExt extends "Resource Journal"
{
    layout
    {
        /* modify("Control 1")
        {
            ShowCaption = false;
        }
        modify(Control41)
        {
            ShowCaption = false;
        }
        modify(Control1903222401)
        {
            ShowCaption = false;
        } */
        modify(Description)
        {
            Visible = false;
        }
        modify(CurrentJnlBatchName)
        {
            trigger OnLookup(var Text: Text): Boolean
            begin
                /* IF CurrentJnlBatchName = 'INS-RWL' THEN BEGIN
                    CurrPage.Zones.VISIBLE := TRUE;
                    CurrPage.Division.VISIBLE := TRUE;
                    CurrPage.Station.VISIBLE := TRUE;
                    CurrPage.State.VISIBLE := FALSE;
                    CurrPage.District.VISIBLE := FALSE;
                    CurrPage.City.VISIBLE := FALSE;
                    CurrPage."Product type".VISIBLE := TRUE;
                    CurrPage."Sale order no".VISIBLE := TRUE;
                    CurrPage."Serial no".VISIBLE := TRUE;
                    CurrPage."Work Description".VISIBLE := FALSE;
                    CurrPage."Training/Demo".VISIBLE := FALSE;
                    CurrPage.Designation.VISIBLE := FALSE;
                    CurrPage.Location.VISIBLE := FALSE;
                    CurrPage."Action taken".VISIBLE := FALSE;
                    CurrPage.Reason.VISIBLE := FALSE;
                    CurrPage.Remarks.VISIBLE := FALSE;
                    CurrPage."Work Type Code".VISIBLE := TRUE;
                END ELSE
                    IF CurrentJnlBatchName = 'MAIN' THEN BEGIN
                        CurrPage."Document No.".VISIBLE := TRUE;
                        //CurrPage."Document No.".ENABLED:=FALSE
                        CurrPage.Zones.VISIBLE := TRUE;
                        CurrPage.Division.VISIBLE := TRUE;
                        CurrPage.Station.VISIBLE := TRUE;
                        CurrPage.State.VISIBLE := FALSE;
                        CurrPage.District.VISIBLE := FALSE;
                        CurrPage.City.VISIBLE := FALSE;
                        CurrPage."Product type".VISIBLE := TRUE;
                        CurrPage."Sale order no".VISIBLE := FALSE;
                        CurrPage."Serial no".VISIBLE := FALSE;
                        CurrPage."Work Description".VISIBLE := TRUE;
                        CurrPage."Training/Demo".VISIBLE := FALSE;
                        CurrPage.Designation.VISIBLE := FALSE;
                        CurrPage.Location.VISIBLE := FALSE;
                        CurrPage."Action taken".VISIBLE := FALSE;
                        CurrPage.Reason.VISIBLE := FALSE;
                        CurrPage.Remarks.VISIBLE := FALSE;
                        CurrPage."Work Type Code".VISIBLE := FALSE;
                    END ELSE
                        IF CurrentJnlBatchName = 'GENERAL' THEN BEGIN
                            CurrPage.Zones.VISIBLE := TRUE;
                            CurrPage.Division.VISIBLE := TRUE;
                            CurrPage.Station.VISIBLE := TRUE;
                            CurrPage.State.VISIBLE := FALSE;
                            CurrPage.District.VISIBLE := FALSE;
                            CurrPage.City.VISIBLE := FALSE;
                            CurrPage.Place.VISIBLE := FALSE;
                            CurrPage."Work Description".VISIBLE := TRUE;
                            CurrPage."Product type".VISIBLE := TRUE;
                            CurrPage."Sale order no".VISIBLE := FALSE;
                            CurrPage."Serial no".VISIBLE := FALSE;
                            CurrPage."Action taken".VISIBLE := TRUE;
                            CurrPage."Work Type Code".VISIBLE := FALSE;
                            CurrPage."Training/Demo".VISIBLE := FALSE;
                            CurrPage.Designation.VISIBLE := FALSE;
                            CurrPage.Location.VISIBLE := FALSE;
                            CurrPage."Work Description".VISIBLE := TRUE;
                            CurrPage.Remarks.VISIBLE := TRUE;
                        END ELSE
                            IF CurrentJnlBatchName = 'DEMO' THEN BEGIN
                                CurrPage."Shortcut Dimension 1 Code".VISIBLE := TRUE;
                                CurrPage.Zones.VISIBLE := TRUE;
                                CurrPage.Division.VISIBLE := TRUE;
                                CurrPage.Station.VISIBLE := TRUE;
                                CurrPage.State.VISIBLE := FALSE;
                                CurrPage.District.VISIBLE := FALSE;
                                CurrPage.City.VISIBLE := FALSE;
                                CurrPage.Place.VISIBLE := FALSE;
                                CurrPage."Work Description".VISIBLE := FALSE;
                                CurrPage."Product type".VISIBLE := TRUE;
                                CurrPage."Sale order no".VISIBLE := FALSE;
                                CurrPage."Serial no".VISIBLE := FALSE;
                                CurrPage."Action taken".VISIBLE := FALSE;
                                CurrPage.Reason.VISIBLE := FALSE;
                                CurrPage.Remarks.VISIBLE := FALSE;
                                CurrPage."Work Type Code".VISIBLE := FALSE;
                                CurrPage."Service item".VISIBLE := FALSE;
                            END ELSE
                                IF CurrentJnlBatchName = 'LEAVE' THEN BEGIN
                                    CurrPage.Zones.VISIBLE := FALSE;
                                    CurrPage.Division.VISIBLE := FALSE;
                                    CurrPage.Station.VISIBLE := FALSE;
                                    CurrPage.State.VISIBLE := FALSE;
                                    CurrPage.District.VISIBLE := FALSE;
                                    CurrPage.City.VISIBLE := FALSE;
                                    CurrPage.Place.VISIBLE := FALSE;
                                    CurrPage."Work Description".VISIBLE := TRUE;
                                    CurrPage."Product type".VISIBLE := FALSE;
                                    CurrPage."Sale order no".VISIBLE := FALSE;
                                    CurrPage."Serial no".VISIBLE := FALSE;
                                    CurrPage."Action taken".VISIBLE := FALSE;
                                    CurrPage.Reason.VISIBLE := FALSE;
                                    CurrPage.Remarks.VISIBLE := FALSE;
                                    CurrPage."Work Type Code".VISIBLE := FALSE;
                                    CurrPage."Training/Demo".VISIBLE := FALSE;
                                    CurrPage.Designation.VISIBLE := FALSE;
                                    CurrPage.Location.VISIBLE := FALSE;
                                    CurrPage."Service item".VISIBLE := FALSE;

                                END ELSE
                                    IF CurrentJnlBatchName = 'TRAINING' THEN BEGIN
                                        CurrPage."Shortcut Dimension 1 Code".VISIBLE := TRUE;
                                        CurrPage."Shortcut Dimension 2 Code".VISIBLE := TRUE;
                                        CurrPage.Zones.VISIBLE := TRUE;
                                        CurrPage.Division.VISIBLE := TRUE;
                                        CurrPage.Station.VISIBLE := TRUE;
                                        CurrPage.State.VISIBLE := FALSE;
                                        CurrPage.District.VISIBLE := FALSE;
                                        CurrPage.City.VISIBLE := FALSE;
                                        CurrPage.Place.VISIBLE := FALSE;
                                        CurrPage."Work Description".VISIBLE := FALSE;
                                        CurrPage."Product type".VISIBLE := FALSE;
                                        CurrPage."Sale order no".VISIBLE := FALSE;
                                        CurrPage."Serial no".VISIBLE := FALSE;
                                        CurrPage."Action taken".VISIBLE := FALSE;
                                        CurrPage.Reason.VISIBLE := FALSE;
                                        CurrPage.Remarks.VISIBLE := FALSE;
                                        CurrPage."Work Type Code".VISIBLE := FALSE;
                                        CurrPage."Service item".VISIBLE := FALSE;

                                    END ELSE
                                        IF CurrentJnlBatchName = 'IN-DEPT' THEN BEGIN
                                            CurrPage.Zones.VISIBLE := TRUE;
                                            CurrPage.Division.VISIBLE := TRUE;
                                            CurrPage.Station.VISIBLE := TRUE;
                                            CurrPage.State.VISIBLE := FALSE;
                                            CurrPage.District.VISIBLE := FALSE;
                                            CurrPage.City.VISIBLE := FALSE;
                                            CurrPage.Place.VISIBLE := FALSE;
                                            CurrPage."Work Description".VISIBLE := TRUE;
                                            CurrPage."Product type".VISIBLE := FALSE;
                                            CurrPage."Sale order no".VISIBLE := FALSE;
                                            CurrPage."Serial no".VISIBLE := FALSE;
                                            CurrPage."Action taken".VISIBLE := FALSE;
                                            CurrPage.Reason.VISIBLE := FALSE;
                                            CurrPage.Remarks.VISIBLE := FALSE;
                                            CurrPage."Shortcut Dimension 2 Code".VISIBLE := FALSE;
                                            CurrPage."Work Type Code".VISIBLE := FALSE;
                                            CurrPage."Training/Demo".VISIBLE := FALSE;
                                            CurrPage.Designation.VISIBLE := FALSE;
                                            CurrPage.Location.VISIBLE := FALSE;
                                            CurrPage."Service item".VISIBLE := FALSE;

                                        END ELSE BEGIN
                                            CurrPage.Zones.VISIBLE := TRUE;
                                            CurrPage.Division.VISIBLE := TRUE;
                                            CurrPage.Station.VISIBLE := TRUE;
                                            CurrPage.State.VISIBLE := TRUE;
                                            CurrPage.District.VISIBLE := TRUE;
                                            CurrPage.City.VISIBLE := TRUE;
                                            //CurrPage.Place.VISIBLE:=TRUE;

                                            CurrPage."Product type".VISIBLE := TRUE;
                                            CurrPage."Sale order no".VISIBLE := TRUE;
                                            CurrPage."Serial no".VISIBLE := TRUE;
                                            CurrPage."Work Description".VISIBLE := TRUE;
                                        END; */
            end;
        }
        addfirst(Control1)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field(Place; Rec.Place)
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field(Location; Rec.Location)
            {
                ApplicationArea = All;
            }

        }
        addafter("Resource Group No.")
        {
            field(Reason; Rec.Reason)
            {
                Caption = 'Work Desc';
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
            field("Planned Hr's"; Rec."Planned Hr's")
            {
                Caption = 'Planned Hr''s';
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }
        addafter(ResName)
        {
            field(WorkDate; WORKDATE)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(SuggestLinesFromTimeSheets)
        {
            Promoted = true;
        }
    }

    var
        ResLedgEntry: Record "Res. Ledger Entry";
}

