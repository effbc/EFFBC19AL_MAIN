page 60210 "CS Others"
{
    // version Rev01

    PageType = Worksheet;
    SourceTable = "Res. Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = All;

                trigger OnLookup(Var Text: Text): Boolean;
                begin
                    CurrPage.SAVERECORD;
                    ResJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);

                    IF CurrentJnlBatchName = 'INST-OTH' THEN BEGIN
                        ZonesVisible := FALSE;
                        DivisionVisible := FALSE;
                        StationVisible := FALSE;
                        StateVisible := TRUE;
                        DistrictVisible := TRUE;
                        CityVisible := TRUE;
                        "Product typeVisible" := TRUE;
                        "Sale order noVisible" := TRUE;
                        "Serial noVisible" := TRUE;
                        "Work DescriptionVisible" := FALSE;
                        "Training/DemoVisible" := FALSE;
                        DesignationVisible := FALSE;
                        LocationVisible := FALSE;
                        "Action takenVisible" := FALSE;
                        ReasonVisible := FALSE;
                        RemarksVisible := FALSE;
                        "Work Type CodeVisible" := FALSE;
                    END ELSE
                        IF CurrentJnlBatchName = 'MAIN' THEN BEGIN
                            "Document No.Visible" := TRUE;
                            "Document No.Enable" := FALSE;
                            ZonesVisible := FALSE;
                            DivisionVisible := FALSE;
                            StationVisible := FALSE;
                            StateVisible := TRUE;
                            DistrictVisible := TRUE;
                            CityVisible := TRUE;
                            "Product typeVisible" := TRUE;
                            "Sale order noVisible" := FALSE;
                            "Serial noVisible" := FALSE;
                            "Work DescriptionVisible" := TRUE;
                            "Training/DemoVisible" := FALSE;
                            DesignationVisible := FALSE;
                            LocationVisible := FALSE;
                            "Action takenVisible" := FALSE;
                            ReasonVisible := FALSE;
                            RemarksVisible := FALSE;
                            "Work Type CodeVisible" := FALSE;
                        END ELSE
                            IF CurrentJnlBatchName = 'GENERAL' THEN BEGIN
                                ZonesVisible := FALSE;
                                DivisionVisible := FALSE;
                                StationVisible := FALSE;
                                StateVisible := TRUE;
                                DistrictVisible := TRUE;
                                CityVisible := TRUE;
                                PlaceVisible := TRUE;
                                "Work DescriptionVisible" := TRUE;
                                "Product typeVisible" := TRUE;
                                "Sale order noVisible" := FALSE;
                                "Serial noVisible" := FALSE;
                                "Action takenVisible" := TRUE;
                                "Work Type CodeVisible" := FALSE;
                                "Training/DemoVisible" := FALSE;
                                DesignationVisible := FALSE;
                                LocationVisible := FALSE;
                                "Work DescriptionVisible" := TRUE;
                                RemarksVisible := TRUE;
                            END ELSE
                                IF CurrentJnlBatchName = 'DEMO' THEN BEGIN
                                    ShortcutDimension1CodeVisible := TRUE;
                                    ZonesVisible := FALSE;
                                    DivisionVisible := FALSE;
                                    StationVisible := FALSE;
                                    StateVisible := TRUE;
                                    DistrictVisible := TRUE;
                                    CityVisible := TRUE;
                                    PlaceVisible := TRUE;
                                    "Work DescriptionVisible" := FALSE;
                                    "Product typeVisible" := TRUE;
                                    "Sale order noVisible" := FALSE;
                                    "Serial noVisible" := FALSE;
                                    "Action takenVisible" := FALSE;
                                    ReasonVisible := FALSE;
                                    RemarksVisible := FALSE;
                                    "Work Type CodeVisible" := FALSE;
                                    "Service itemVisible" := FALSE;
                                END ELSE
                                    IF CurrentJnlBatchName = 'LEAVE' THEN BEGIN
                                        ZonesVisible := FALSE;
                                        DivisionVisible := FALSE;
                                        StationVisible := FALSE;
                                        StateVisible := FALSE;
                                        DistrictVisible := FALSE;
                                        CityVisible := FALSE;
                                        PlaceVisible := FALSE;
                                        "Work DescriptionVisible" := TRUE;
                                        "Product typeVisible" := FALSE;
                                        "Sale order noVisible" := FALSE;
                                        "Serial noVisible" := FALSE;
                                        "Action takenVisible" := FALSE;
                                        ReasonVisible := FALSE;
                                        RemarksVisible := FALSE;
                                        "Work Type CodeVisible" := FALSE;
                                        "Training/DemoVisible" := FALSE;
                                        DesignationVisible := FALSE;
                                        LocationVisible := FALSE;
                                        "Service itemVisible" := FALSE;

                                    END ELSE
                                        IF CurrentJnlBatchName = 'TRAINING' THEN BEGIN
                                            ShortcutDimension1CodeVisible := TRUE;
                                            ShortcutDimension2CodeVisible := TRUE;
                                            ZonesVisible := FALSE;
                                            DivisionVisible := FALSE;
                                            StationVisible := FALSE;
                                            StateVisible := TRUE;
                                            DistrictVisible := TRUE;
                                            CityVisible := TRUE;
                                            PlaceVisible := TRUE;
                                            "Work DescriptionVisible" := FALSE;
                                            "Product typeVisible" := FALSE;
                                            "Sale order noVisible" := FALSE;
                                            "Serial noVisible" := FALSE;
                                            "Action takenVisible" := FALSE;
                                            ReasonVisible := FALSE;
                                            RemarksVisible := FALSE;
                                            "Work Type CodeVisible" := FALSE;
                                            "Service itemVisible" := FALSE;

                                        END ELSE
                                            IF CurrentJnlBatchName = 'IN-DEPT' THEN BEGIN
                                                ZonesVisible := FALSE;
                                                DivisionVisible := FALSE;
                                                StationVisible := FALSE;
                                                StateVisible := TRUE;
                                                DistrictVisible := TRUE;
                                                CityVisible := TRUE;
                                                PlaceVisible := TRUE;
                                                "Work DescriptionVisible" := TRUE;
                                                "Product typeVisible" := FALSE;
                                                "Sale order noVisible" := FALSE;
                                                "Serial noVisible" := FALSE;
                                                "Action takenVisible" := FALSE;
                                                ReasonVisible := FALSE;
                                                RemarksVisible := FALSE;
                                                ShortcutDimension2CodeVisible := FALSE;
                                                "Work Type CodeVisible" := FALSE;
                                                "Training/DemoVisible" := FALSE;
                                                DesignationVisible := FALSE;
                                                LocationVisible := FALSE;
                                                "Service itemVisible" := FALSE;

                                            END ELSE BEGIN
                                                ZonesVisible := TRUE;
                                                DivisionVisible := TRUE;
                                                StationVisible := TRUE;
                                                StateVisible := TRUE;
                                                DistrictVisible := TRUE;
                                                CityVisible := TRUE;
                                                //CurrPage.Place.VISIBLE:=TRUE;
                                                "Product typeVisible" := TRUE;
                                                "Sale order noVisible" := TRUE;
                                                "Serial noVisible" := TRUE;
                                                "Work DescriptionVisible" := TRUE;
                                            END;
                end;

                trigger OnValidate();
                begin
                    ResJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1000000016)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    Enabled = "Document No.Enable";
                    Visible = "Document No.Visible";
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Product type"; Rec."Product type")
                {
                    Visible = "Product typeVisible";
                    ApplicationArea = All;
                }
                field(Zones; Rec.Zones)
                {
                    Visible = ZonesVisible;
                    ApplicationArea = All;
                }
                field(Division; Rec.Division)
                {
                    Visible = DivisionVisible;
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    Visible = StationVisible;
                    ApplicationArea = All;
                }
                field("Training/Demo"; Rec."Training/Demo")
                {
                    Visible = "Training/DemoVisible";
                    ApplicationArea = All;
                }
                field("Service item"; Rec."Service item")
                {
                    Visible = "Service itemVisible";
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Visible = LocationVisible;
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    Visible = DesignationVisible;
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    Visible = StateVisible;
                    ApplicationArea = All;
                }
                field("Action taken"; Rec."Action taken")
                {
                    Visible = "Action takenVisible";
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    Visible = ReasonVisible;
                    ApplicationArea = All;
                }
                field(District; Rec.District)
                {
                    Visible = DistrictVisible;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Visible = CityVisible;
                    ApplicationArea = All;
                }
                field(Place; Rec.Place)
                {
                    Visible = PlaceVisible;
                    ApplicationArea = All;
                }
                field("Sale order no"; Rec."Sale order no")
                {
                    Visible = "Sale order noVisible";
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Visible = RemarksVisible;
                    ApplicationArea = All;
                }
                field("Serial no"; Rec."Serial no")
                {
                    Visible = "Serial noVisible";
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Work Description"; Rec."Work Description")
                {
                    Visible = "Work DescriptionVisible";
                    ApplicationArea = All;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ResJnlManagement.GetRes(Rec."Resource No.", ResName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Resource Group No."; Rec."Resource Group No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = ShortcutDimension1CodeVisible;
                    ApplicationArea = All;
                }
                field("Planned Hr's"; Rec."Planned Hr's")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = ShortcutDimension2CodeVisible;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    Caption = 'Activity Code';
                    Visible = "Work Type CodeVisible";
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Spent Hr''s';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1000000002)
            {
                ShowCaption = false;
                field(ResName; ResName)
                {
                    Caption = 'Resource Name';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                }
            }
            group("&Resource")
            {
                Caption = '&Resource';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Resource Card";
                    RunPageLink = "No." = FIELD("Resource No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = LedgerEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Ledger Entries";
                    RunPageLink = "Resource No." = FIELD("Resource No.");
                    RunPageView = SORTING("Resource No.");
                    ShortCutKey = 'Ctrl+F5';
                    ApplicationArea = All;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ReportPrint.PrintResJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Res. Jnl.-Post", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Res. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnInit();
    begin
        "Document No.Enable" := TRUE;
        "Service itemVisible" := TRUE;
        PlaceVisible := TRUE;
        "Document No.Visible" := TRUE;
        "Work Type CodeVisible" := TRUE;
        RemarksVisible := TRUE;
        ReasonVisible := TRUE;
        "Action takenVisible" := TRUE;
        LocationVisible := TRUE;
        DesignationVisible := TRUE;
        "Training/DemoVisible" := TRUE;
        "Work DescriptionVisible" := TRUE;
        "Serial noVisible" := TRUE;
        "Sale order noVisible" := TRUE;
        "Product typeVisible" := TRUE;
        CityVisible := TRUE;
        DistrictVisible := TRUE;
        StateVisible := TRUE;
        StationVisible := TRUE;
        DivisionVisible := TRUE;
        ZonesVisible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SetUpNewLine(xRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage();
    begin
        ResJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        ResJnlManagement: Codeunit ResJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        ResName: Text[30];
        ShortcutDimCode: array[8] of Code[20];
        "Service item": Record "Service Item";
        "Service Item(DUM)": Record "Service Item" temporary;
        ResLedgEntry: Record "Res. Ledger Entry";
        "Res. Journal Line": Record "Res. Journal Line";
        Line: Integer;

        ZonesVisible: Boolean;

        DivisionVisible: Boolean;

        StationVisible: Boolean;

        StateVisible: Boolean;

        DistrictVisible: Boolean;

        CityVisible: Boolean;

        "Product typeVisible": Boolean;

        "Sale order noVisible": Boolean;

        "Serial noVisible": Boolean;

        "Work DescriptionVisible": Boolean;

        "Training/DemoVisible": Boolean;

        DesignationVisible: Boolean;

        LocationVisible: Boolean;

        "Action takenVisible": Boolean;

        ReasonVisible: Boolean;

        RemarksVisible: Boolean;

        "Work Type CodeVisible": Boolean;

        "Document No.Visible": Boolean;

        PlaceVisible: Boolean;

        ShortcutDimension1CodeVisible: Boolean;

        "Service itemVisible": Boolean;

        ShortcutDimension2CodeVisible: Boolean;

        "Document No.Enable": Boolean;


    local procedure CurrentJnlBatchNameOnAfterVali();
    begin


        CurrPage.SAVERECORD;
        ResJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        ResJnlManagement.GetRes("Resource No.", ResName);
    end;
}

