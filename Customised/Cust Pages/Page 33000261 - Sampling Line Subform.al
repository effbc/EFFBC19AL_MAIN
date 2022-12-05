page 33000261 "Sampling Line Subform"
{
    // version QC1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Sampling Plan Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Lot Size - Min"; Rec."Lot Size - Min")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot Size - Max"; Rec."Lot Size - Max")
                {
                    ApplicationArea = All;
                }
                field("Sampling Size"; Rec."Sampling Size")
                {
                    ApplicationArea = All;
                }
                field("Allowable Defects - Max"; Rec."Allowable Defects - Max")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        SamplePlanline: Record "Sampling Plan Line";
}

