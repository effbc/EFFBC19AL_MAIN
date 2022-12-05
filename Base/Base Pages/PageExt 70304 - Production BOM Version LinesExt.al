pageextension 70304 "Production BOM LinesExt" extends "Production BOM Version Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Material Reqired Day"; Rec."Material Reqired Day")
            {
                ApplicationArea = All;

            }
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;

            }
        }
        addafter(Width)
        {
            field("No. of Soldering Points"; Rec."No. of Soldering Points")
            {
                ApplicationArea = All;

            }
            field("No. of Pins"; Rec."No. of Pins")
            {
                ApplicationArea = All;

            }
            field("No. of Opportunities"; Rec."No. of Opportunities")
            {
                ApplicationArea = All;

            }
            field("Type of Solder"; Rec."Type of Solder")
            {
                ApplicationArea = All;

            }
            field("Shelf No."; Rec."Shelf No.")
            {
                ApplicationArea = All;

            }
            field("No. of Fixing Holes"; Rec."No. of Fixing Holes")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}