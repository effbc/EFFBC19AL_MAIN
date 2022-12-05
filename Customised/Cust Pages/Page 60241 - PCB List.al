page 60241 "PCB List"
{
    CardPageID = "PCB Card";
    PageType = List;
    SourceTable = PCB;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                    Caption = 'PCB Thickness(In mm)';
                    ApplicationArea = All;
                }
                field("Copper Clad Thinkness"; Rec."Copper Clad Thinkness")
                {
                    Caption = 'Copper Clad Thinkness(In Microns)';
                    ApplicationArea = All;
                }
                field("PCB Area"; Rec."PCB Area")
                {
                    Caption = 'PCB Area(In Sq Cm)';
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
                field("Soldering Area"; Rec."Soldering Area")
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
                    LookupPageID = "Stencil List";
                    ApplicationArea = All;
                }
                field("Double Side Stencil"; Rec."Double Side Stencil")
                {
                    LookupPageID = "Stencil List";
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

