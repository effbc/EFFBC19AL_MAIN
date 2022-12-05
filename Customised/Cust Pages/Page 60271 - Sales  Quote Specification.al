page 60271 "Sales  Quote Specification"
{
    // version B2BQTO

    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Sales Quote Specification";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type ID"; Rec."Lookup Type ID")
                {
                    ApplicationArea = All;
                }
                field("Lookup Type Name"; Rec."Lookup Type Name")
                {
                    ApplicationArea = All;
                }
                field("Lookup Code"; Rec."Lookup Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ApplicationArea = All;
                }
                field(FieldNo1; Rec.FieldNo1)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(FieldNo2; Rec.FieldNo2)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(FieldNo3; Rec.FieldNo3)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(FieldNo4; Rec.FieldNo4)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(FieldNo5; Rec.FieldNo5)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(FieldNo6; Rec.FieldNo6)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(Qty; Rec.Qty)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = EditLookUp;
                    ApplicationArea = All;
                }
                field("Terms LookUp"; Rec."Terms LookUp")
                {
                    Editable = TermLookUp;
                    ApplicationArea = All;
                }
                field("Schedule LookUp"; Rec."Schedule LookUp")
                {
                    Editable = SechLookup;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152009)
            {
                action(Specification)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        LookUpType.RESET;
                        LookUpType.SETRANGE("Lookup Type ID", Rec."Lookup Type ID");
                        CLEAR(QuoteLookUpList);
                        QuoteLookUpList.SETRECORD(LookUpType);
                        QuoteLookUpList.SETTABLEVIEW(LookUpType);
                        QuoteLookUpList.LOOKUPMODE(TRUE);
                        QuoteLookUpList.CarrySalesQuoteNo(Rec."Sales Quote No.");
                        IF QuoteLookUpList.RUNMODAL = ACTION::LookupOK THEN;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF Rec."Lookup Type ID" = 5 THEN
            SechLookup := TRUE
        ELSE
            SechLookup := FALSE;

        IF Rec."Lookup Type ID" = 3 THEN
            TermLookUp := TRUE
        ELSE
            TermLookUp := FALSE;

        IF (Rec."Lookup Type ID" = 5) OR (Rec."Lookup Type ID" = 3) THEN
            EditLookUp := TRUE
        ELSE
            EditLookUp := FALSE;
    end;

    var
        LookUpType: Record "Quote Lookup";
        QuoteLookUpList: Page "Quote LookUp List";
        EditLookUp: Boolean;
        SechLookup: Boolean;
        TermLookUp: Boolean;
}

