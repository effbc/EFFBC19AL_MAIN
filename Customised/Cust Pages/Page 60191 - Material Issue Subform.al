page 60191 "Material Issue Subform"
{
    // version MI1.0,Rev01

    AutoSplitKey = true;
    PageType = ListPart;
    SaveValues = true;
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
                    StyleExpr = ColorCode;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        MaterialIssuesHeader.SETRANGE("No.", Rec."Document No.");
                        IF MaterialIssuesHeader.FINDFIRST THEN BEGIN
                            Rec."Prod. Order No." := MaterialIssuesHeader."Prod. Order No.";
                            Rec."Prod. Order Line No." := MaterialIssuesHeader."Prod. Order Line No.";
                            Rec."Reason Code" := MaterialIssuesHeader."Reason Code";
                            /*IF MaterialIssuesHeader."Transfer-to Code"='SITE' THEN
                            BEGIN
                              ItemFilter:='';
                              ItemGRec.RESET;
                              IF ItemGRec.GET("Item No.") THEN
                                IGCFilter:=ItemGRec."CS IGC";
                              IF IGCFilter <>'' THEN
                              BEGIN
                                ItemGRec.RESET;
                                ItemGRec.SETRANGE(ItemGRec."CS IGC",IGCFilter);
                                IF ItemGRec.FINDFIRST THEN
                                REPEAT
                                  ItemFilter+=ItemGRec."No."+'|';
                                UNTIL ItemGRec.NEXT=0;
                                ItemFilter:=COPYSTR(ItemFilter,1,STRLEN(ItemFilter)-1);
                              END;
                              IF ItemFilter='' THEN
                                ItemFilter:="Item No.";
                              DivisionGRec.RESET;
                              DivisionGRec.SETFILTER(DivisionGRec."Division Code",MaterialIssuesHeader."Shortcut Dimension 2 Code");
                              IF DivisionGRec.FINDFIRST THEN
                                ManagerFilter:=DivisionGRec."Project Manager";

                              DivisionGRec.RESET;
                              DivisionGRec.SETFILTER(DivisionGRec."Project Manager",ManagerFilter);
                              IF DivisionGRec.FINDFIRST THEN
                              REPEAT
                                DivFilter+=DivisionGRec."Division Code"+'|';
                              UNTIL DivisionGRec.NEXT=0;
                                DivFilter:=COPYSTR(DivFilter,1,STRLEN(DivFilter)-1);

                              ItemLedgerEntryGRec.RESET;
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Item No.",ItemFilter);
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Location Code",'SITE');
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Global Dimension 2 Code",MaterialIssuesHeader."Shortcut Dimension 2 Code");
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Remaining Quantity",'>%1',0);
                              IF ItemLedgerEntryGRec.FINDSET THEN
                                StockAtSite:=ItemLedgerEntryGRec.COUNT;
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Global Dimension 2 Code",DivFilter);
                              IF ItemLedgerEntryGRec.FINDSET THEN
                                StockAtManager:=ItemLedgerEntryGRec.COUNT;
                            END;*/
                        END;
                        /* MatIssuesLine.SETCURRENTKEY(Item No.,Prod. Order No.);
                         MatIssuesLine.SETRANGE(MatIssuesLine."Item No.","Item No.");
                         MatIssuesLine.SETRANGE(MatIssuesLine."Prod. Order No.","Prod. Order No.");
                         IF MatIssuesLine.COUNT>0 THEN
                         ERROR('Not possible to draw item on this project code');
                          postedmaterialissuesline.SETRANGE(postedmaterialissuesline."Item No.","Item No.");
                         postedmaterialissuesline.SETFILTER(postedmaterialissuesline."Prod. Order No.","Prod. Order No.");
                        IF  postedmaterialissuesline.COUNT >0 THEN
                          ERROR('Posted material issue present for this item');  */
                        /*
                        // Added by Pranavi on 29-11-2016 for restricting items selection in sta code
                          MaterialIssuesHeader.RESET;
                          MaterialIssuesHeader.SETRANGE(MaterialIssuesHeader."No.","Document No.");
                          IF MaterialIssuesHeader.FINDFIRST THEN
                          BEGIN
                            IF MaterialIssuesHeader."Prod. Order No." IN ['EFF14STA01','EFF08STA01'] THEN
                            BEGIN
                              ItemGRec.RESET;
                              ItemGRec.SETRANGE(ItemGRec."No.","Item No.");
                              IF ItemGRec.FINDFIRST THEN
                              BEGIN
                                IF ItemGRec."Product Group Code" <> 'STATIONARY' THEN
                                  ERROR('You cannot select other than stationary items in the project code: '+MaterialIssuesHeader."Prod. Order No.");
                              END;
                            END;
                          END;
                        // End--Pranavi
                        */

                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("MBB Packet Open DateTime"; Rec."MBB Packet Open DateTime")
                {
                    ApplicationArea = All;
                }
                field("MBB Packet Close DateTime"; Rec."MBB Packet Close DateTime")
                {
                    ApplicationArea = All;
                }
                field("BOM Quantity"; Rec."BOM Quantity")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Non-Returnable"; Rec."Non-Returnable")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
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
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Station Name"; Rec."Station Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Target Date"; Rec."Target Date")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
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
                field("Monitor Problem"; Rec."Monitor Problem")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Stock at Site"; StockAtSite)
                {
                    ApplicationArea = All;
                }
                field(StockAtManager; StockAtManager)
                {
                    Caption = 'Stock at Manager';
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
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
            }
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
            field(MSLColor; MSLColor)
            {
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
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
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                            /*CurrPage.MaterialIssueLine.FORM.*/
                            _ItemAvailability(0);

                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                            /*CurrPage.MaterialIssueLine.FORM.*/
                            _ItemAvailability(2);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                            /*CurrPage.MaterialIssueLine.FORM.*/
                            _ItemAvailability(2);

                        end;
                    }
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                        /*CurrPage.MaterialIssueLine.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                        /*CurrPage.MaterialIssueLine.FORM.*/
                        OpenItemTrackingLinesPage;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        /*MaterialIssuesHeader.SETRANGE("No.","Document No.");
        IF MaterialIssuesHeader.FINDFIRST THEN
        BEGIN
          IF MaterialIssuesHeader."Transfer-to Code"='SITE' THEN
          BEGIN
            ItemFilter:='';
            ItemGRec.RESET;
            IF ItemGRec.GET("Item No.") AND ("Item No."<>'') THEN
              IGCFilter:=ItemGRec."CS IGC";
            IF IGCFilter <>'' THEN
            BEGIN
              ItemGRec.RESET;
              ItemGRec.SETFILTER(ItemGRec."CS IGC",IGCFilter);
              IF ItemGRec.FINDFIRST THEN
              REPEAT
                ItemFilter+=ItemGRec."No."+'|';
              UNTIL ItemGRec.NEXT=0;
              ItemFilter:=COPYSTR(ItemFilter,1,STRLEN(ItemFilter)-1);
            END;
            IF ItemFilter='' THEN
              ItemFilter:="Item No.";
        
            DivisionGRec.RESET;
            DivisionGRec.SETFILTER(DivisionGRec."Division Code",MaterialIssuesHeader."Shortcut Dimension 2 Code");
            IF DivisionGRec.FINDFIRST THEN
              ManagerFilter:=DivisionGRec."Project Manager";
        
            DivisionGRec.RESET;
            DivisionGRec.SETFILTER(DivisionGRec."Project Manager",ManagerFilter);
            IF DivisionGRec.FINDFIRST THEN
            REPEAT
              DivFilter+=DivisionGRec."Division Code"+'|';
            UNTIL DivisionGRec.NEXT=0;
              DivFilter:=COPYSTR(DivFilter,1,STRLEN(DivFilter)-1);
        
            ItemLedgerEntryGRec.RESET;
            ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Item No.",ItemFilter);
            ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Location Code",'SITE');
            ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Global Dimension 2 Code",MaterialIssuesHeader."Shortcut Dimension 2 Code");
            ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Remaining Quantity",'>%1',0);
            IF ItemLedgerEntryGRec.FINDSET THEN
              StockAtSite:=ItemLedgerEntryGRec.COUNT;
            ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Global Dimension 2 Code",DivFilter);
            IF ItemLedgerEntryGRec.FINDSET THEN
              StockAtManager:=ItemLedgerEntryGRec.COUNT;
          END;
        END;
        */
        ColorCode := '';
        IF ItemGRec.GET(Rec."Item No.") AND (ItemGRec.MSL <> 0) AND NOT (ItemGRec."Floor Life at 25 C 40% RH" IN ['INFINITE']) THEN
            ColorCode := 'StrongAccent';

    end;

    var
        MatIssuesLine: Record "Material Issues Line";
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        MaterialIssuesHeader: Record "Material Issues Header";
        postedmaterialissuesline: Record "Posted Material Issues Line";
        Mail_From: Text[1000];
        Mail_to: Text[1000];
        Mail_Subject: Text[1000];
        Body: Text[500];
        //   SMTP_MAIL: Codeunit "SMTP Mail";
        User: Record User;
        Subject: Text[500];
        StockAtSite: Decimal;
        ItemLedgerEntryGRec: Record "Item Ledger Entry";
        ItemGRec: Record Item;
        ItemFilter: Code[1000];
        IGCFilter: Code[1000];
        StockAtManager: Decimal;
        DivisionGRec: Record 5212;
        ManagerFilter: Code[250];
        DivFilter: Code[250];
        StationGRec: Record Station;
        ColorCode: Code[30];
        MSLColor: Label 'MSL Component';


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location);
    begin
        Rec.ItemAvailability(AvailabilityType);
    end;


    /*procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location);
    begin
        Rec.ItemAvailability(AvailabilityType);
    end;*/


    procedure _ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;


    /* procedure ShowDimensions();
     begin
         Rec.ShowDimensions;
     end;*/


    procedure OpenItemTrackingLinesPage();
    var
        Item: Record Item;
        Text001: TextConst ENU = 'You must specify Item Tracking Code in Item No. =''%1''.';
    begin
        Item.GET(Rec."Item No.");  //Rev01 Changed Function Name
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            TrackingSpecification.SETRANGE("Order No.", Rec."Document No.");
            TrackingSpecification.SETRANGE("Order Line No.", Rec."Line No.");
            TrackingSpecification.SETRANGE("Item No.", Rec."Item No.");
            TrackingSpecification.SETRANGE("Location Code", Rec."Transfer-from Code");
            PAGE.RUN(PAGE::"Mat.Issues Track.Specification", TrackingSpecification);
        END ELSE
            MESSAGE(Text001, Rec."Item No.");
    end;


    local procedure RemarksOnInputChange(var Text: Text[1024]);
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;
}

