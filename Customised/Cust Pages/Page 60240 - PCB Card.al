page 60240 "PCB Card"
{
    PageType = Card;
    SourceTable = PCB;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("PCB No."; Rec."PCB No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("PCB Thickness"; Rec."PCB Thickness")
                {
                    Caption = 'PCB Thickness (In mm)';
                    ApplicationArea = All;
                }
                field("Copper Clad Thinkness"; Rec."Copper Clad Thinkness")
                {
                    Caption = 'Copper Clad Thinkness(In Microns)';
                    ApplicationArea = All;
                }
                field("PCB Area"; Rec."PCB Area")
                {
                    Caption = 'PCB Area(In Sq cm)';
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    Caption = 'Length(In mm)';
                    ApplicationArea = All;
                }
                field(Width; Rec.Width)
                {
                    Caption = 'Width(In mm)';
                    ApplicationArea = All;
                }
                field("PCB Shape"; Rec."PCB Shape")
                {
                    ApplicationArea = All;
                }
                field("On C-side"; Rec."On C-side")
                {
                    ApplicationArea = All;
                }
                field("On D-side"; Rec."On D-side")
                {
                    ApplicationArea = All;
                }
                field("On S-side"; Rec."On S-side")
                {
                    ApplicationArea = All;
                }
                field(Stencil; Rec.Stencil)
                {
                    Caption = 'C Side Stencil';
                    LookupPageID = "Stencil List";
                    ApplicationArea = All;
                }
                field("Double Side Stencil"; Rec."Double Side Stencil")
                {
                    Caption = 'D Side Stencil';
                    LookupPageID = "Stencil List";
                    ApplicationArea = All;
                }
                field("Soldering Area"; Rec."Soldering Area")
                {
                    ApplicationArea = All;
                }
                field("Master PCB"; Rec."Master PCB")
                {
                    ApplicationArea = All;
                }
                field(Multiples_Per_Stencil; Rec.Multiples_Per_Stencil)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

