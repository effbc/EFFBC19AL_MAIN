page 60141 "Material Issue Subform-1"
{
    // version MI1.0

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Material Issues Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    Caption = 'Inventory at Location';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        "PostedMat.RcptLine": Record "Posted Material Issues Line";
                    begin
                        Rec.TESTFIELD("Document No.");
                        Rec.TESTFIELD("Item No.");
                        "PostedMat.RcptLine".SETRANGE("Material Issue No.", Rec."Document No.");
                        "PostedMat.RcptLine".SETRANGE("PostedMat.RcptLine"."Material Issue Line No.");
                        PAGE.RUNMODAL(0, "PostedMat.RcptLine");
                    end;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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
        MatIssuesLine: Record "Material Issues Line";
        TrackingSpecification: Record "Mat.Issue Track. Specification";


    /* procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location);
     begin
         Rec.ItemAvailability(AvailabilityType);
     end;*/ //B2BUPG


    /* procedure ShowDimensions();
     begin
         Rec.ShowDimensions;
     end;*/
    //B2BUPG


    /* procedure OpenItemTrackingLines();
     var
         Item: Record Item;
         Text001: TextConst ENU = 'You must specify Item Tracking Code in Item No. =''%1''.';
     begin
         Item.GET(Rec."Item No.");
         IF Item."Item Tracking Code" <> '' THEN BEGIN
             TrackingSpecification.SETRANGE("Order No.", Rec."Document No.");
             TrackingSpecification.SETRANGE("Order Line No.", Rec."Line No.");
             TrackingSpecification.SETRANGE("Item No.", Rec."Item No.");
             TrackingSpecification.SETRANGE("Location Code", Rec."Transfer-from Code");
             PAGE.RUN(PAGE::"Mat.Issues Track.Specification", TrackingSpecification);
         END ELSE
             MESSAGE(Text001, Rec."Item No.");
     end;*/ //B2BUPG
}

