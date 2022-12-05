pageextension 70299 CapacityJournalExt extends "Capacity Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;

            }
        }
        addafter(Type)
        {
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;

            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;

            }
        }
        addafter(CapDescription)
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WorkDate)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Gen. Prod. Posting Group" := 'MISC';
        Rec.Type := Rec.Type::"Machine Center";
    end;

    var
        myInt: Integer;
}