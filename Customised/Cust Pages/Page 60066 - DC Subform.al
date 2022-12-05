page 60066 "DC Subform"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "DC Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Serial Or Lot No"; Rec."Serial Or Lot No")
                {
                    ApplicationArea = All;
                }
                field("Non-Returnable"; Rec."Non-Returnable")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = All;
                }
                field("Net Wt./Kgs."; Rec."Net Wt./Kgs.")
                {
                    ApplicationArea = All;
                }
                field("Gross Wt./Kgs."; Rec."Gross Wt./Kgs.")
                {
                    ApplicationArea = All;
                }
                field("Size.of Case"; Rec."Size.of Case")
                {
                    ApplicationArea = All;
                }
                field("Returned Quantity"; Rec."Returned Quantity")
                {
                    ApplicationArea = All;
                }
                field("Returned Serial Or Lot No"; Rec."Returned Serial Or Lot No")
                {
                    ApplicationArea = All;
                }
                field(Returned; Rec.Returned)
                {
                    Visible = ReturnedVisible;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Returned = TRUE THEN BEGIN
                            IF Rec."Returned Quantity" <> Rec.Quantity THEN
                                ERROR('Returned Quantity must be equal to Quantity!');
                            DCL.RESET;
                            DCL.SETRANGE(DCL."Document No.", Rec."Document No.");
                            DCL.SETFILTER(DCL."Line No.", '<>%1', Rec."Line No.");
                            DCL.SETRANGE(DCL."Non-Returnable", FALSE);
                            DCL.SETRANGE(DCL.Returned, FALSE);
                            IF NOT DCL.FINDFIRST THEN BEGIN
                                DCH.RESET;
                                DCH.SETRANGE(DCH."No.", Rec."Document No.");
                                //DCH.SETRANGE(DCH.NonReturnable,FALSE);
                                IF DCH.FINDFIRST THEN BEGIN
                                    DCH.Returned := TRUE;
                                    DCH."Returned Date" := TODAY();
                                    DCH.MODIFY;
                                END;
                            END;
                            Rec."Returned Date" := TODAY();
                            Rec.MODIFY;
                        END
                        ELSE BEGIN
                            IF Rec."Non-Returnable" = FALSE THEN BEGIN
                                DCH.RESET;
                                DCH.SETRANGE(DCH."No.", Rec."Document No.");
                                //DCH.SETRANGE(DCH.NonReturnable,FALSE);
                                IF DCH.FINDFIRST THEN BEGIN
                                    DCH.Returned := FALSE;
                                    DCH."Returned Date" := 0D;
                                    DCH.MODIFY;
                                END;
                            END;
                            Rec."Returned Date" := 0D;
                            Rec.MODIFY;
                        END;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Returned Date"; Rec."Returned Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(DC)
            {
                Caption = 'DC';
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60065. Unsupported part was commented. Please check it.
                        /*CurrPage.DCLine.FORM.*/
                        OpenItemTrackingLines;

                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        ReturnedVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Type := Rec.Type::Item
    end;

    trigger OnOpenPage();
    begin
        IF UPPERCASE(USERID) IN ['EFFTRONICS\DMADHAVI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\MARY', 'EFFTRONICS\RATNA', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\KSUGUNA', 'EFFTRONICS\PARDHU', 'EFFTRONICS\RENUKACH'] THEN
            ReturnedVisible := TRUE
        ELSE
            ReturnedVisible := FALSE;
    end;

    var
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        DCH: Record "DC Header";
        [InDataSet]
        ReturnedVisible: Boolean;
        DCL: Record "DC Line";


    procedure OpenItemTrackingLines();
    var
        Item: Record Item;
        Text001: TextConst ENU = 'You must specify Item Tracking Code in Item No. =''%1''.';
    begin
        Item.GET(Rec."No.");
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            TrackingSpecification.SETRANGE("Order No.", Rec."Document No.");
            TrackingSpecification.SETRANGE("Order Line No.", Rec."Line No.");
            TrackingSpecification.SETRANGE("Item No.", Rec."No.");
            DCH.RESET;
            DCH.SETFILTER(DCH."No.", Rec."Document No.");
            IF DCH.FINDFIRST THEN
                TrackingSpecification.SETRANGE("Location Code", DCH.SessionCode);
            //MESSAGE(FORMAT(TrackingSpecification.COUNT));
            //PAGE.RUN(60097,TrackingSpecification);
            PAGE.RUN(PAGE::"Mat.Issues Track.Specification", TrackingSpecification);
        END ELSE
            MESSAGE(Text001, Rec."No.");
    end;
}

