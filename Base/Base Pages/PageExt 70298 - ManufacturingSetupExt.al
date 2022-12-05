pageextension 70298 ManufacturingSetupExt extends "Manufacturing Setup"
{

    layout
    {
        addafter("Cost Incl. Setup")
        {
            field("Total Fixing Points Time"; Rec."Total Fixing Points Time")
            {
                ApplicationArea = All;

            }
            field("Production Location"; Rec."Production Location")
            {
                ApplicationArea = All;

            }
            field("Soldering Time Req.for DIP"; Rec."Soldering Time Req.for DIP")
            {
                ApplicationArea = All;

            }
            field("Soldering Time Req.for BID"; Rec."Soldering Time Req.for BID")
            {
                Caption = 'Soldering Time Req.for SMD';
                ApplicationArea = All;
            }
            field("Soldering Cost per Hour"; Rec."Soldering Cost per Hour")
            {
                ApplicationArea = All;

            }
            field("Development Cost Per Hour"; Rec."Development Cost Per Hour")
            {
                ApplicationArea = All;

            }
            field("MI Transfer From Code"; Rec."MI Transfer From Code")
            {
                ApplicationArea = All;

            }
        }
        addafter("Blank Overflow Level")
        {
            field("No. of Units/Day"; Rec."No. of Units/Day")
            {
                ApplicationArea = All;

            }
            field("Consider Exp. Order Material"; Rec."Consider Exp. Order Material")
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