pageextension 70046 DimensionValuesExt extends "Dimension Values"
{
    layout
    {
        addafter(Control1)
        {
            field("Dimension Code"; Rec."Dimension Code")
            {
                ApplicationArea = All;

            }
        }
        addafter(Name)
        {
            field(Address1; Rec.Address1)
            {
                ApplicationArea = All;

            }
            field(Address2; Rec.Address2)
            {
                ApplicationArea = All;

            }
        }

        addafter(Totaling)
        {
            field("Global Dimension No."; Rec."Global Dimension No.")
            {
                ApplicationArea = All;

            }
        }
    }
}

