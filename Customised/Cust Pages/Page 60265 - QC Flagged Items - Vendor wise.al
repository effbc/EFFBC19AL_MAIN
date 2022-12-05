page 60265 "QC Flagged Items - Vendor wise"
{
    // Page Created by Vishnu Priya on 30-06-2020 for the QC Flag items  listing.

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Inspection Receipt Header";
    SourceTableView = SORTING("Item No.", "Vendor No.") ORDER(Ascending) WHERE(Flag = FILTER(true), Status = CONST(true));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt No."; Rec."Receipt No.")
                {
                    Caption = 'Inward Number';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'IR Number';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Caption = 'Purchase Order Number';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Accepted"; Rec."Qty. Accepted")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Rejected"; Rec."Qty. Rejected")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Action Required"; Rec."Action Required")
                {
                    ApplicationArea = All;
                }
                field("Action To Be Taken"; Rec."Action To Be Taken")
                {
                    ApplicationArea = All;
                }
                field("Concerned Dept"; Rec."Concerned Dept")
                {
                    ApplicationArea = All;
                }
                field("Tentative Clearance Date"; Rec."Tentative Clearance Date")
                {
                    ApplicationArea = All;
                }
                field("Flag Cleared Date"; Rec."Flag Cleared Date")
                {
                    ApplicationArea = All;
                }
                field("Action Completed time"; Rec."Action Completed time")
                {
                    ApplicationArea = All;
                }
                field(Sample; Rec.Sample)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Flag = TRUE THEN BEGIN
                            IRH.RESET;
                            IRH.SETRANGE(Flag, TRUE);
                            IRH.SETFILTER("Item No.", Rec."Item No.");
                            IRH.SETFILTER("Vendor No.", Rec."Vendor No.");
                            IF IRH.FINDFIRST THEN
                                ERROR('Item was QC Flagged with the same vendor in IR Number: ' + IRH."No.");
                        END;
                    end;
                }
            }
            field("xRec.COUNT"; xRec.COUNT)
            {
                Editable = false;
                Style = Unfavorable;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        IRH: Record "Inspection Receipt Header";
}

