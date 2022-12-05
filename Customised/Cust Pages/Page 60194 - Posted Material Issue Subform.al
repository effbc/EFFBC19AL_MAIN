page 60194 "Posted Material Issue Subform"
{
    // version MI1.0,DIM1.0

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                              DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13           ->Code has been Commented in the ShowDimensions() because Dimension Tables does not exist in the
    //                                                              NAV 2013 Instead of that code new Code is added for shows the data from the database against the Dimension Set ID.

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Posted Material Issues Line";

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Material Issue No."; Rec."Material Issue No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Issued DateTime"; Rec."Issued DateTime")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = Visibility;
                    ApplicationArea = All;
                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = All;
                }
                field("Avg. unit cost"; Rec."Avg. unit cost")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = Visibility;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field(Dept; Rec.Dept)
                {
                    ApplicationArea = All;
                }
                field("Material Requisition Date"; Rec."Material Requisition Date")
                {
                    ApplicationArea = All;
                }
                field("Material Picked"; Rec."Material Picked")
                {
                    ApplicationArea = All;
                }
                field("Non-Returnable"; Rec."Non-Returnable")
                {
                    ApplicationArea = All;
                }
                field("Material Picked Date"; Rec."Material Picked Date")
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
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60193. Unsupported part was commented. Please check it.
                        /*
                        CurrPage.MaterialIssueLines.FORM.
                        */
                        ShowDimensions;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60193. Unsupported part was commented. Please check it.
                        /*CurrPage.MaterialIssueLines.FORM.*/
                        ShowItemTrackingLines;

                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin

        IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            Visibility := TRUE
        ELSE
            Visibility := FALSE;
    end;

    var
        "-DIM1.0": Integer;
        DimMgt: Codeunit DimensionManagement;
        Visibility: Boolean;


    procedure ShowItemTrackingLines();
    var
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
    begin
        ItemTrackingDocMgt.ShowItemTrackingForShptRcptLine(DATABASE::"Posted Material Issues Line", 0, Rec."Document No.", '', 0, Rec."Line No.");
    end;


    procedure ShowDimensions();
    begin
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");
        //DIM1.0 Start
        //Code Commented
        /*
        PostedDocDim.SETRANGE("Table ID",DATABASE::"Posted Material Issues Line");
        PostedDocDim.SETRANGE("Document No.","Document No.");
        PostedDocDim.SETRANGE("Line No.","Line No.");
        PostedDocDimensions.SETTABLEVIEW(PostedDocDim);
        PostedDocDimensions.RUNMODAL;
        */

        DimMgt.ShowDimensionSet(Rec."Dimension Set ID", STRSUBSTNO('%1 %2', Rec."Document No.", Rec."Line No."));
        //DIM1.0 End

    end;
}

