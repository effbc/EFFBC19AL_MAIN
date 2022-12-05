page 50016 "MSL Items List"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Item Ledger Entry" = rm;
    RefreshOnActivate = true;
    SourceTable = "Item Ledger Entry";
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Control1102152014)
            {
                ShowCaption = false;
                Visible = true;
                field("Recharge Cycles Exceeded Items"; "Recharge Cycles Exceeded Items")
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FilterData;
                    end;
                }
                field("Shelf Life Expired Items"; "Shelf Life Expired Items")
                {
                    Caption = 'Shelf Life Expired Items';
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FilterData;
                    end;
                }
                field("Shelf Life To Be Expired Items"; "Shelf Life To Be Expired Items")
                {
                    Caption = 'Shelf Life To Be Expired Items';
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FilterData;
                    end;
                }
                field("Floor Life Expired Items"; "Floor Life Expired Items")
                {
                    Caption = 'Floor Life Expired Items';
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FilterData;
                    end;
                }
                field("Floor Life To Be Expired Items"; "Floor Life To Be Expired Items")
                {
                    Caption = 'Floor Life To Be Expired Items';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FilterData;
                    end;
                }
            }
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Item Tracking"; Rec."Item Tracking")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Product Group Code Cust"; Rec."Product Group Code Cust")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Stock at Stores"; "Stock at Stores")
                {
                    Caption = 'Stock at Stores';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Stock at MCH"; "Stock at MCH")
                {
                    Caption = 'Stock at MCH';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Stock at RD Stores"; "Stock at RD Stores")
                {
                    Caption = 'Stock at RD Stores';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Stock at CS Stores"; "Stock at CS Stores")
                {
                    Caption = 'Stock at CS Stores';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field(MSL; MSL)
                {
                    Caption = 'MSL';
                    Editable = false;
                    OptionCaption = '" ,1,2,2A,3,4,5,5A,6"';
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Component Shelf Life(Years)"; Itm."Component Shelf Life(Years)")
                {
                    Caption = 'Component Shelf Life(Years)';
                    ApplicationArea = All;
                }
                field(ESD; ESD)
                {
                    Caption = 'ESD';
                    Editable = false;
                    OptionCaption = '" ,0,1A,1B,1C,2,3A,3B"';
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Component Floor Life(Years)"; "Component Floor Life(Years)")
                {
                    Caption = 'Component Floor Life(Years)';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Component Shelf Life(Hours)"; "Component Shelf Life(Hours)")
                {
                    Caption = 'Component Shelf Life(Hours)';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Comp Bake Hours(Defined)"; "Comp Bake Hours(Defined)")
                {
                    Caption = 'Comp Bake Hours(Defined)';
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("MFD Date"; Rec."MFD Date")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Recharge Cycles"; Rec."Recharge Cycles")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Floor Life"; Rec."Floor Life")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("MBB Packet Open DateTime"; Rec."MBB Packet Open DateTime")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("MBB Packet Close DateTime"; Rec."MBB Packet Close DateTime")
                {
                    Editable = false;
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("MBB Packed Date"; Rec."MBB Packed Date")
                {
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Baked Hours"; "Baked Hours")
                {
                    Caption = 'Baked Hours';
                    StyleExpr = ColorCode;
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        DateAndTime: DotNet DateAndTimeD;
                        DayofWeekInput: DotNet DayofWeekInputD;
                        WeekofYearInput: DotNet WeekofYearInputD;
                    begin
                        IF "Baked Hours" > 0 THEN BEGIN
                            IF Itm.GET(Rec."Item No.") THEN BEGIN
                                IF (Itm."Component Shelf Life(Years)" > 0) AND ((DateAndTime.DateDiff('YYYY', Rec."MFD Date", TODAY, DayofWeekInput, WeekofYearInput) >= Itm."Component Shelf Life(Years)")) THEN
                                    ERROR('You cannot bake already Shelf Life Expired Items!');
                                IF Rec."Recharge Cycles" >= 2 THEN
                                    ERROR('You cannot bake component more 2 times! 2 recharge Cycles already completed!');
                                IF (Itm."Floor Life at 25 C 40% RH" IN ['', ' ', 'INFINITE']) THEN
                                    ERROR('Do not need to bake the item as its floor life is INFINITE or not defined!');
                                IF NOT (Itm."Floor Life at 25 C 40% RH" IN ['', 'INFINITE']) THEN BEGIN
                                    EVALUATE(Itm_floor_life, Itm."Floor Life at 25 C 40% RH");
                                    IF Itm_floor_life > Rec."Floor Life" THEN
                                        ERROR('%1 hours of floor life still remaining. You cannot bake until then!', Itm_floor_life - Rec."Floor Life");
                                END;
                                IF (Itm."Bake Hours" > 0) AND (Itm."Bake Hours" <> "Baked Hours") THEN
                                    ERROR('Baked Hours must be equal to Bake hours defined in item card : %1 !', Itm."Bake Hours");
                                IF Rec."MBB Packed Date" = 0D THEN
                                    ERROR('Please enter MBB Packed Date first!');
                                Rec.MARK(TRUE);
                            END;
                        END ELSE BEGIN
                            Rec.MARK(FALSE);
                        END;
                    end;
                }
                field(Open; Rec.Open)
                {
                    CaptionML = ENU = 'Create Damage Request',
                                ENN = 'Open';
                    StyleExpr = ColorCode;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Open THEN BEGIN
                            IF NOT (Rec."Global Dimension 1 Code" IN ['S_Expired', 'R_Expired', 'S_EXPIRED', 'R_EXPIRED']) THEN BEGIN
                                Rec.Open := FALSE;
                                ERROR('You cannot Scrap the Item as it is not Expired!');
                            END
                        END;
                    end;
                }
            }
            group(Control1102152047)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152046)
                {
                    ShowCaption = false;
                    group(Control1102152045)
                    {
                        ShowCaption = false;
                        field("TotalItemsCount+FORMAT(Rec.COUNT)"; TotalItemsCount + FORMAT(Rec.COUNT))
                        {
                            Editable = false;
                            Style = Strong;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152041)
                    {
                        ShowCaption = false;
                        field(ShelfLifeExpColor; ShelfLifeExpColor)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152039)
                    {
                        ShowCaption = false;
                        field(FloorLifeExpColor; FloorLifeExpColor)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152049)
                    {
                        ShowCaption = false;
                        field(ToBeExpShelfLifeColor; ToBeExpShelfLifeColor)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152043)
                    {
                        ShowCaption = false;
                        field(ToBeExpFloorLifeColor; ToBeExpFloorLifeColor)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152053)
                    {
                        ShowCaption = false;
                        field(RechargeCyclesExColor; RechargeCyclesExColor)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Attention;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102152036; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1102152034; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Refresh Data")
            {
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    InsertRows;
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Update Bake Hours")
            {
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.MARKEDONLY(TRUE);
                    IF Rec.FINDSET THEN BEGIN
                        REPEAT
                            IF ILE.GET(Rec."Entry No.") THEN BEGIN
                                ILE."Floor Life" := 0;
                                ILE."Recharge Cycles" += 1;
                                ILE."MBB Packed Date" := Rec."MBB Packed Date";
                                ILE.MODIFY;
                            END;
                        UNTIL Rec.NEXT = 0;
                    END;
                    Rec.RESET;
                    "Baked Hours" := 0;
                    InsertRows;
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Create Damage Requests")
            {
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    MaterialIssueLine: Record "Material Issues Line";
                    USER: Record User;
                    ITEM1: Record Item;
                    LineNo_STR: Decimal;
                    LineNo_RD: Decimal;
                    LineNo_CS: Decimal;
                    LineNo_MCH: Decimal;
                    MIL: Record "Material Issues Line";
                    Requests: Text;
                begin
                    Rec.RESET;
                    Rec.SETRANGE(Open, TRUE);
                    IF Rec.FINDSET THEN BEGIN
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader_STR.RESET;
                        MaterialIssueHeader_STR.INIT;
                        MaterialIssueHeader_STR."No." := GetNextNo;
                        MaterialIssueHeader_STR."Receipt Date" := TODAY;
                        MaterialIssueHeader_STR."Transfer-from Code" := 'STR';
                        MaterialIssueHeader_STR."Transfer-to Code" := 'DAMAGE';
                        MaterialIssueHeader_STR.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader_STR.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader_STR."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader_STR.Status := MaterialIssueHeader_STR.Status::Open;
                        MaterialIssueHeader_STR."User ID" := USERID;
                        MaterialIssueHeader_STR."Resource Name" := USER."Full Name";
                        MaterialIssueHeader_STR."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader_STR.Remarks := 'Scraping Expired Items At STR';
                        MaterialIssueHeader_STR.INSERT;
                        LineNo_STR := 0;

                        MaterialIssueHeader_RD.RESET;
                        MaterialIssueHeader_RD.INIT;
                        MaterialIssueHeader_RD."No." := GetNextNo;
                        MaterialIssueHeader_RD."Receipt Date" := TODAY;
                        MaterialIssueHeader_RD."Transfer-from Code" := 'R&D STR';
                        MaterialIssueHeader_RD."Transfer-to Code" := 'DAMAGE';
                        MaterialIssueHeader_RD.VALIDATE("Prod. Order No.", 'EFF08R&D01');
                        MaterialIssueHeader_RD.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader_RD."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader_RD.Status := MaterialIssueHeader_RD.Status::Open;
                        MaterialIssueHeader_RD."User ID" := USERID;
                        MaterialIssueHeader_RD."Resource Name" := USER."Full Name";
                        MaterialIssueHeader_RD."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader_RD.Remarks := 'Scraping Expired Items At R&DSTR';
                        MaterialIssueHeader_RD.INSERT;
                        LineNo_RD := 0;

                        MaterialIssueHeader_CS.RESET;
                        MaterialIssueHeader_CS.INIT;
                        MaterialIssueHeader_CS."No." := GetNextNo;
                        MaterialIssueHeader_CS."Receipt Date" := TODAY;
                        MaterialIssueHeader_CS."Transfer-from Code" := 'CS STR';
                        MaterialIssueHeader_CS."Transfer-to Code" := 'DAMAGE';
                        MaterialIssueHeader_CS.VALIDATE("Prod. Order No.", 'EFF12CST01');
                        MaterialIssueHeader_CS.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader_CS."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader_CS.Status := MaterialIssueHeader_CS.Status::Open;
                        MaterialIssueHeader_CS."User ID" := USERID;
                        MaterialIssueHeader_CS."Resource Name" := USER."Full Name";
                        MaterialIssueHeader_CS."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader_CS.Remarks := 'Scraping Expired Items At CS STR';
                        MaterialIssueHeader_CS.INSERT;
                        LineNo_CS := 0;

                        MaterialIssueHeader_MCH.RESET;
                        MaterialIssueHeader_MCH.INIT;
                        MaterialIssueHeader_MCH."No." := GetNextNo;
                        MaterialIssueHeader_MCH."Receipt Date" := TODAY;
                        MaterialIssueHeader_MCH."Transfer-from Code" := 'MCH';
                        MaterialIssueHeader_MCH."Transfer-to Code" := 'DAMAGE';
                        MaterialIssueHeader_MCH.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader_MCH.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader_MCH."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader_MCH.Status := MaterialIssueHeader_MCH.Status::Open;
                        MaterialIssueHeader_MCH."User ID" := USERID;
                        MaterialIssueHeader_MCH."Resource Name" := USER."Full Name";
                        MaterialIssueHeader_MCH."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader_MCH.Remarks := 'Scraping Expired Items at MCH';
                        MaterialIssueHeader_MCH.INSERT;
                        LineNo_MCH := 0;

                        REPEAT
                            GetStockOfLot(Rec."Item No.", Rec."Lot No.");
                            IF ITEM1.GET(Rec."Item No.") THEN BEGIN
                                IF "Stock at Stores" > 0 THEN BEGIN
                                    MIL.RESET;
                                    MIL.SETRANGE("Document No.", MaterialIssueHeader_STR."No.");
                                    MIL.SETRANGE("Item No.", ITEM1."No.");
                                    IF NOT MIL.FINDFIRST THEN BEGIN
                                        LineNo_STR := LineNo_STR + 10000;
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader_STR."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo_STR;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at Stores");
                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        AssignTrackingSpec(MaterialIssueLine, Rec."Lot No.");
                                    END;
                                END;
                                IF "Stock at RD Stores" > 0 THEN BEGIN
                                    MIL.RESET;
                                    MIL.SETRANGE("Document No.", MaterialIssueHeader_RD."No.");
                                    MIL.SETRANGE("Item No.", ITEM1."No.");
                                    IF NOT MIL.FINDFIRST THEN BEGIN
                                        LineNo_RD := LineNo_RD + 10000;
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader_RD."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo_RD;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                        MaterialIssueLine."Prod. Order No." := 'EFF08R&D01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        AssignTrackingSpec(MaterialIssueLine, Rec."Lot No.");
                                    END;
                                END;
                                IF "Stock at CS Stores" > 0 THEN BEGIN
                                    MIL.RESET;
                                    MIL.SETRANGE("Document No.", MaterialIssueHeader_CS."No.");
                                    MIL.SETRANGE("Item No.", ITEM1."No.");
                                    IF NOT MIL.FINDFIRST THEN BEGIN
                                        LineNo_CS := LineNo_CS + 10000;
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader_CS."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo_CS;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at CS Stores");
                                        MaterialIssueLine."Prod. Order No." := 'EFF12CST01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        AssignTrackingSpec(MaterialIssueLine, Rec."Lot No.");
                                    END;
                                END;
                                IF "Stock at MCH" > 0 THEN BEGIN
                                    MIL.RESET;
                                    MIL.SETRANGE("Document No.", MaterialIssueHeader_MCH."No.");
                                    MIL.SETRANGE("Item No.", ITEM1."No.");
                                    IF NOT MIL.FINDFIRST THEN BEGIN
                                        LineNo_MCH := LineNo_MCH + 10000;
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader_MCH."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo_MCH;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at MCH");
                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        AssignTrackingSpec(MaterialIssueLine, Rec."Lot No.");
                                    END;
                                END;
                            END;
                        UNTIL Rec.NEXT = 0;
                        IF LineNo_STR < 10000 THEN
                            MaterialIssueHeader_STR.DELETE
                        ELSE BEGIN
                            "Release MaterialIssue Document".Release_Request(MaterialIssueHeader_STR);
                            Requests += MaterialIssueHeader_STR."No." + ', ';
                        END;
                        IF LineNo_RD < 10000 THEN
                            MaterialIssueHeader_RD.DELETE
                        ELSE BEGIN
                            "Release MaterialIssue Document".Release_Request(MaterialIssueHeader_RD);
                            Requests += MaterialIssueHeader_RD."No." + ', ';
                        END;
                        IF LineNo_CS < 10000 THEN
                            MaterialIssueHeader_CS.DELETE
                        ELSE BEGIN
                            "Release MaterialIssue Document".Release_Request(MaterialIssueHeader_CS);
                            Requests += MaterialIssueHeader_CS."No." + ', ';
                        END;
                        IF LineNo_MCH < 10000 THEN
                            MaterialIssueHeader_MCH.DELETE
                        ELSE BEGIN
                            "Release MaterialIssue Document".Release_Request(MaterialIssueHeader_MCH);
                            Requests += MaterialIssueHeader_MCH."No." + ', ';
                        END;
                    END;
                    MESSAGE('Damage Requests are created!\' + Requests);
                    Rec.RESET;
                    IF Rec.FINDSET THEN BEGIN
                        Rec.MODIFYALL(Open, FALSE);
                    END;
                    Rec.RESET;
                end;
            }
            action("Post Damage Requests")
            {
                Image = PostInventoryToGL;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Issue_Post: Codeunit "MaterialIssueOrde-Post Receipt";
                    MATERIAL_ISSUES_HEAER: Record "Material Issues Header";
                    Mat_Issue_sLine: Record "Material Issues Line";
                begin

                    MATERIAL_ISSUES_HEAER.RESET;
                    MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Transfer-to Code", 'DAMAGE');
                    MATERIAL_ISSUES_HEAER.SETFILTER(MATERIAL_ISSUES_HEAER."Transfer-from Code", 'STR|CS STR|R&D STR|MCH');
                    MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER.Status, MATERIAL_ISSUES_HEAER.Status::Released);
                    MATERIAL_ISSUES_HEAER.SETRANGE(MATERIAL_ISSUES_HEAER."Request for Authorization", 'EFFTRONICS\PADMASRI');
                    IF MATERIAL_ISSUES_HEAER.FINDSET THEN
                        REPEAT
                            MATERIAL_ISSUES_HEAER."Posting Date" := TODAY;
                            Issue_Post.Issues_Post(MATERIAL_ISSUES_HEAER);
                            Mat_Issue_sLine.RESET;
                            Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", MATERIAL_ISSUES_HEAER."No.");
                            IF Mat_Issue_sLine.FINDSET THEN
                                REPEAT
                                    Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                                    Mat_Issue_sLine.MODIFY;
                                UNTIL Mat_Issue_sLine.NEXT = 0;
                        UNTIL MATERIAL_ISSUES_HEAER.NEXT = 0;

                    InsertRows;
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(Document)
            {
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    HYPERLINK('\\erpserver\ErpAttachments\MSL_Process_User_Manual.pdf');
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        DateAndTime: DotNet DateAndTimeD;
        DayofWeekInput: DotNet DayofWeekInputD;
        WeekofYearInput: DotNet WeekofYearInputD;

    begin
        ColorCode := '';
        GetStockOfLot(Rec."Item No.", Rec."Lot No.");
        //GetStock(Rec."Item No.");
        IF Itm.GET(Rec."Item No.") THEN BEGIN
            "Component Floor Life(Years)" := Itm."Floor Life at 25 C 40% RH";
            "Component Shelf Life(Hours)" := Itm."Component Shelf Life(Years)";
            "Comp Bake Hours(Defined)" := Itm."Bake Hours";
            MSL := Itm.MSL;
            ESD := Itm."ESD Class";
            IF (Itm."Component Shelf Life(Years)" > 0) AND ((DateAndTime.DateDiff('M', Rec."MFD Date", TODAY, DayofWeekInput, WeekofYearInput) >= Itm."Component Shelf Life(Years)" * 12)) THEN
                ColorCode := 'Ambiguous';
            IF ColorCode = '' THEN BEGIN
                IF Rec."Recharge Cycles" >= 2 THEN
                    ColorCode := 'Attention';
                IF ColorCode = '' THEN
                    IF NOT (Itm."Floor Life at 25 C 40% RH" IN ['', 'INFINITE']) THEN BEGIN
                        EVALUATE(Itm_floor_life, Itm."Floor Life at 25 C 40% RH");
                        IF Itm_floor_life <= Rec."Floor Life" THEN
                            ColorCode := 'Unfavorable';
                        IF ColorCode = '' THEN BEGIN
                            IF Rec."Floor Life" >= ROUND(Itm_floor_life * 90 / 100, 1, '>') THEN
                                ColorCode := 'StrongAccent';
                        END;
                    END;
                IF ColorCode = '' THEN BEGIN
                    IF (Itm."Component Shelf Life(Years)" > 0) AND (Itm."Component Shelf Life(Years)" * 12 - DateAndTime.DateDiff('M', Rec."MFD Date", TODAY, DayofWeekInput, WeekofYearInput) <= 1) THEN
                        ColorCode := 'Favorable';
                END;
            END;
            Rec."External Document No." := ColorCode;
            Rec.MODIFY;
        END;
    end;

    trigger OnOpenPage();
    begin

        InsertRows;
    end;

    var
        ILE: Record "Item Ledger Entry";
        ItemLedgEnt: Record "Item Ledger Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        Itm: Record Item;
        IsExpired: Boolean;
        //  DateAndTime: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        //DayofWeekInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        // WeekofYearInput: DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";
        Itm_floor_life: Decimal;

        "Stock at MCH": Decimal;
        "Stock at CS Stores": Decimal;
        "Stock at RD Stores": Decimal;
        "Stock at Stores": Decimal;
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        "Baked Hours": Decimal;
        "Component Floor Life(Years)": Code[15];
        "Component Shelf Life(Hours)": Integer;
        MSL: Option " ","1","2","2A","3","4","5","5A","6";
        ESD: Option " ","1","2","2A","3","4","5","5A","6";
        "Comp Bake Hours(Defined)": Decimal;
        ShelfLifeExpColor: Label 'Shelf Life Expired Items';
        FloorLifeExpColor: Label 'Floor Life Expired Items';
        ToBeExpShelfLifeColor: Label 'To Be Expired Shelf Life Items';
        ToBeExpFloorLifeColor: Label 'To Be Expired Floor Life Items';
        TotalItemsCount: Label '"Total Items  :  "';
        ColorCode: Code[25];
        RechargeCyclesExColor: Label 'Recharge Cycles > 2';
        // SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        SQLQuery: Text;
        //  RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        RowCount: Integer;
        ConnectionOpen: Integer;
        MaterialIssueHeader_STR: Record "Material Issues Header";
        MaterialIssueHeader_RD: Record "Material Issues Header";
        MaterialIssueHeader_CS: Record "Material Issues Header";
        MaterialIssueHeader_MCH: Record "Material Issues Header";
        "Release MaterialIssue Document": Codeunit "Release MaterialIssue Document";
        "Shelf Life Expired Items": Boolean;
        "Recharge Cycles Exceeded Items": Boolean;
        "Shelf Life To Be Expired Items": Boolean;
        "Floor Life Expired Items": Boolean;
        "Floor Life To Be Expired Items": Boolean;


    procedure GetStock(Item: Code[30]);
    var
        ITEM1: Record Item;
    begin
        IF ITEM1.GET(Item) THEN BEGIN
            ITEM1.CALCFIELDS(ITEM1."Inventory at Stores");
            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection");
            ITEM1.CALCFIELDS(ITEM1."Quantity Rejected");
            ITEM1.CALCFIELDS(ITEM1."Stock At MCH Location");
            ITEM1.CALCFIELDS(ITEM1."Stock at CS Stores");
            ITEM1.CALCFIELDS(ITEM1."Stock at RD Stores");

            "Stock at MCH" := ITEM1."Stock At MCH Location";
            "Stock at CS Stores" := ITEM1."Stock at CS Stores";
            "Stock at RD Stores" := ITEM1."Stock at RD Stores";
            "Stock at Stores" := 0;

            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection", ITEM1."Quantity Rejected", ITEM1."Quantity Rework", ITEM1."Quantity Sent for Rework",
                             ITEM1."Stock At MCH Location", ITEM1."Stock at CS Stores", ITEM1."Stock at RD Stores", ITEM1."Stock at PROD Stores");

            IF (ITEM1."Quantity Under Inspection" = 0) AND (ITEM1."Quantity Rejected" = 0) AND (ITEM1."Quantity Rework" = 0) AND (ITEM1."Quantity Sent for Rework" = 0) THEN BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETRANGE("Location Code", 'STR');
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '<>%1', 0);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END ELSE BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETRANGE("Location Code", 'STR');
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                        IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                          (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                            ItemLedgEntry.MARK(FALSE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END;
            ItemLedgEntry.MARKEDONLY(TRUE);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT
                    "Stock at Stores" := "Stock at Stores" + ItemLedgEntry."Remaining Quantity";
                UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;


    local procedure InsertRows();
    begin
        // >>Variable Initialization
        "Baked Hours" := 0;
        "Stock at MCH" := 0;
        "Stock at CS Stores" := 0;
        "Stock at RD Stores" := 0;
        "Stock at Stores" := 0;
        IsExpired := FALSE;
        Itm_floor_life := 0;
        "Component Floor Life(Years)" := '';
        "Component Shelf Life(Hours)" := 0;
        "Comp Bake Hours(Defined)" := 0;
        ColorCode := '';
        MSL := 0;
        ESD := 0;
        // <<Variable Initialization
        Rec.RESET;
        IF Rec.FINDSET THEN
            Rec.DELETEALL;
        Rec.RESET;
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);//Rev01

         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);//Rev01*/

        RowCount := 0;
        /*IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=ERPServer;UID=report;PASSWORD=Efftronics@eff;SERVER:=erpserver;providerName=System.Data.SqlClient;';
            SQLConnection.Open;
            ConnectionOpen := 1;
        END;

        SQLQuery := ' SELECT  Details.No_, Details.[Lot No_], Details.Purch_Rcpt_Entry_No, Details.MSL, Details.[Floor Life at 25 C 40_ RH], ' +
        ' Details.[Bake Hours], Details.[Component Shelf Life(Years)], Details.[ESD Class], ' +
        '   ILETemp.[MBB Packed Date], ILETemp.[MFD Date], ILETemp.[Recharge Cycles], ILETemp.[Floor Life], ILETemp.[MBB Packet Open DateTime], ILETemp.[MBB Packet Close DateTime], ' +
        ' case when  Details.[Component Shelf Life(Years)] > 0 and (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102))  and ' +
        ' DATEDIFF(MONTH,ILETemp.[MFD Date],GETDATE()) >=  Details.[Component Shelf Life(Years)]*12 then ''S_Expired'' when ILETemp.[Recharge Cycles] >=2 then ''R_Expired'' ' +
        ' when  not Details.[Floor Life at 25 C 40_ RH] IN('''',''INFINITE'') and ILETemp.[Floor Life] >= Details.[Floor Life at 25 C 40_ RH] then ''F_Exipired'' ' +
        ' WHEN NOT Details.[Floor Life at 25 C 40_ RH] IN ('''', ''INFINITE'') AND ILETemp.[Floor Life] >= round(cast(Details.[Floor Life at 25 C 40_ RH] as decimal)*0.9,1) THEN ''F_T_Exipired'' ' +
        ' WHEN Details.[Component Shelf Life(Years)] > 0 AND (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102)) AND ' +
        ' Details.[Component Shelf Life(Years)]*12 - DATEDIFF(MONTH, ILETemp.[MFD Date], GETDATE()) <= 1 THEN ''S_T_Expired'' else ''F_Ok'' end as ShelfLifestatus ' +
        ' FROM (SELECT  Itm.No_, ILE.[Lot No_], ISNULL((SELECT  MIN([Entry No_]) AS EXPR1 FROM   [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS S_ILE WITH (nolock) ' +
        '  WHERE  ([Entry Type] = 0) AND ([Document Type] = 5) AND ([Item No_] = Itm.No_) AND ([Lot No_] = ILE.[Lot No_])), N'''') AS Purch_Rcpt_Entry_No, Itm.MSL, Itm.[Floor Life at 25 C 40_ RH], ' +
        '   Itm.[Bake Hours], Itm.[Component Shelf Life(Years)], Itm.[ESD Class]  FROM  [Efftronics Systems Pvt Ltd_,$Item] AS Itm WITH (nolock) INNER JOIN ' +
        '    [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS ILE WITH (nolock) ON Itm.No_ = ILE.[Item No_] ' +
        '  WHERE  (Itm.MSL <> 0) AND (Itm.Blocked = 0) AND (ILE.[Remaining Quantity] > 0) AND (ILE.[Location Code] IN (''STR'', ''CS STR'', ''R&D STR'', ''PRODSTR'', ''MCH'')) ' +
        '   GROUP BY Itm.No_, ILE.[Lot No_], Itm.MSL, Itm.[Floor Life at 25 C 40_ RH], Itm.[Bake Hours], Itm.[Component Shelf Life(Years)], Itm.[ESD Class]) AS Details INNER JOIN ' +
        '  [Efftronics Systems Pvt Ltd_,$Item Ledger Entry] AS ILETemp WITH (nolock) ON Details.Purch_Rcpt_Entry_No = ILETemp.[Entry No_] where ' +
        '  case when  Details.[Component Shelf Life(Years)] > 0 and (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102))  and  ' +
        ' DATEDIFF(MONTH,ILETemp.[MFD Date],GETDATE()) >=  Details.[Component Shelf Life(Years)]*12 then ''S_Expired'' when ILETemp.[Recharge Cycles] >=2 then ''R_Expired'' ' +
        ' when  not Details.[Floor Life at 25 C 40_ RH] IN('''',''INFINITE'') and ILETemp.[Floor Life] >= Details.[Floor Life at 25 C 40_ RH] then ''F_Exipired'' ' +
        ' WHEN NOT Details.[Floor Life at 25 C 40_ RH] IN ('''', ''INFINITE'') AND ILETemp.[Floor Life] >= round(cast(Details.[Floor Life at 25 C 40_ RH] as decimal)*0.9,1) ' +
        ' THEN ''F_T_Exipired'' WHEN Details.[Component Shelf Life(Years)] > 0 AND (ILETemp.[MFD Date] >= CONVERT(DATETIME, ''1990-04-01 00:00:00'', 102)) AND ' +
        ' Details.[Component Shelf Life(Years)]*12 - DATEDIFF(MONTH, ILETemp.[MFD Date], GETDATE()) <= 1 THEN ''S_T_Expired'' ' +
        ' else ''F_Ok'' end  in(''S_Expired'',''R_Expired'',''F_Exipired'',''F_T_Exipired'',''S_T_Expired'')';

        //MESSAGE(SQLQuery);
        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);

        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;

        WHILE NOT RecordSet.EOF DO BEGIN
            IF Itm.GET(FORMAT(RecordSet.Fields.Item('No_').Value)) THEN BEGIN
                ILE.RESET;
                IF ILE.GET(FORMAT(RecordSet.Fields.Item('Purch_Rcpt_Entry_No').Value)) THEN BEGIN
                    Rec.INIT;
                    Rec := ILE;
                    Rec.Description := Itm.Description;
                    Rec."Global Dimension 1 Code" := FORMAT(RecordSet.Fields.Item('ShelfLifestatus').Value);
                    Rec.Open := FALSE;
                    Rec.INSERT;
                    RowCount += 0;
                END;
            END;
            RecordSet.MoveNext;
        END;

        RecordSet.Close;
        SQLConnection.Close;
        ConnectionOpen := 0;
        Rec.RESET;*/
    end;


    procedure GetStockOfLot(Item: Code[30]; Lot: Code[30]);
    var
        ITEM1: Record Item;
    begin
        IF ITEM1.GET(Item) THEN BEGIN

            "Stock at MCH" := 0;
            "Stock at CS Stores" := 0;
            "Stock at RD Stores" := 0;
            "Stock at Stores" := 0;

            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection", ITEM1."Quantity Rejected", ITEM1."Quantity Rework", ITEM1."Quantity Sent for Rework",
                             ITEM1."Stock At MCH Location", ITEM1."Stock at CS Stores", ITEM1."Stock at RD Stores", ITEM1."Stock at PROD Stores", ITEM1."Inventory at Stores");

            IF (ITEM1."Quantity Under Inspection" = 0) AND (ITEM1."Quantity Rejected" = 0) AND (ITEM1."Quantity Rework" = 0) AND (ITEM1."Quantity Sent for Rework" = 0) THEN BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETFILTER("Location Code", 'STR|CS STR|R&D STR|MCH');
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Lot No.", Lot);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END ELSE BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETFILTER("Location Code", 'STR|CS STR|R&D STR|MCH');
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Lot No.", Lot);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                        IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                          (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                            ItemLedgEntry.MARK(FALSE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END;
            ItemLedgEntry.MARKEDONLY(TRUE);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT
                    CASE ItemLedgEntry."Location Code" OF
                        'STR':
                            "Stock at Stores" := "Stock at Stores" + ItemLedgEntry."Remaining Quantity";
                        'CS STR':
                            "Stock at CS Stores" := "Stock at CS Stores" + ItemLedgEntry."Remaining Quantity";
                        'R&D STR':
                            "Stock at RD Stores" := "Stock at RD Stores" + ItemLedgEntry."Remaining Quantity";
                        'MCH':
                            "Stock at MCH" := "Stock at MCH" + ItemLedgEntry."Remaining Quantity";
                    END;
                UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;


    procedure GetNextNo() NumberValue: Code[20];
    var
        DateValue: Text[30];
        MonthValue: Text[30];
        YearValue: Text[30];
        MaterialIssuesHeaderLocal: Record "Material Issues Header";
        PostedMatIssHeaderLocal: Record "Posted Material Issues Header";
        LastNumber: Code[20];
    begin
        IF DATE2DMY(WORKDATE, 1) < 10 THEN
            DateValue := '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            DateValue := FORMAT(DATE2DMY(WORKDATE, 1));

        IF DATE2DMY(WORKDATE, 2) < 10 THEN
            MonthValue := '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            MonthValue := FORMAT(DATE2DMY(WORKDATE, 2));

        IF DATE2DMY(WORKDATE, 2) <= 12 THEN
            YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
        //IF ((TODAY=010810D) OR (TODAY=010910D) OR (TODAY=011010D))THEN
        //  NumberValue := 'V'+YearValue+MonthValue+DateValue
        //ELSE
        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '0000';
        MaterialIssuesHeaderLocal.RESET;
        MaterialIssuesHeaderLocal.SETFILTER("No.", NumberValue + '*');
        IF MaterialIssuesHeaderLocal.FINDLAST THEN
            LastNumber := MaterialIssuesHeaderLocal."No.";

        PostedMatIssHeaderLocal.RESET;
        PostedMatIssHeaderLocal.SETCURRENTKEY("Material Issue No.");
        PostedMatIssHeaderLocal.SETFILTER("Material Issue No.", NumberValue + '*');
        IF PostedMatIssHeaderLocal.FINDLAST THEN
            IF LastNumber < PostedMatIssHeaderLocal."Material Issue No." THEN
                LastNumber := PostedMatIssHeaderLocal."Material Issue No.";

        NumberValue := INCSTR(LastNumber);
    end;


    local procedure AssignTrackingSpec(MILin: Record "Material Issues Line"; Lot: Code[30]);
    var
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        ITEM1: Record Item;
        MIH: Record "Material Issues Header";
    begin
        IF ITEM1.GET(MILin."Item No.") THEN BEGIN

            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection", ITEM1."Quantity Rejected", ITEM1."Quantity Rework", ITEM1."Quantity Sent for Rework",
                             ITEM1."Stock At MCH Location", ITEM1."Stock at CS Stores", ITEM1."Stock at RD Stores", ITEM1."Stock at PROD Stores", ITEM1."Inventory at Stores");

            IF (ITEM1."Quantity Under Inspection" = 0) AND (ITEM1."Quantity Rejected" = 0) AND (ITEM1."Quantity Rework" = 0) AND (ITEM1."Quantity Sent for Rework" = 0) THEN BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", MILin."Item No.");
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETFILTER("Location Code", MILin."Transfer-from Code");
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Lot No.", Lot);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END ELSE BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", MILin."Item No.");
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETFILTER("Location Code", MILin."Transfer-from Code");
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Lot No.", Lot);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                        IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                          (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                          (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                            ItemLedgEntry.MARK(FALSE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END;
            ItemLedgEntry.MARKEDONLY(TRUE);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT
                    Track(ItemLedgEntry, MILin);
                UNTIL ItemLedgEntry.NEXT = 0;
        END;
    end;


    local procedure Track(ILE: Record "Item Ledger Entry"; MILin: Record "Material Issues Line");
    var
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        ITEM1: Record Item;
        MIH: Record "Material Issues Header";
    begin
        TrackingSpecification.INIT;
        TrackingSpecification."Order No." := MILin."Document No.";
        TrackingSpecification."Order Line No." := MILin."Line No.";
        TrackingSpecification."Item No." := MILin."Item No.";
        TrackingSpecification."Location Code" := ILE."Location Code";
        TrackingSpecification."Lot No." := ILE."Lot No.";
        TrackingSpecification."Actual Quantity" := ILE."Remaining Quantity";
        TrackingSpecification."Actual Qty to Receive" := ILE."Remaining Quantity";
        TrackingSpecification.Description := MILin.Description;
        TrackingSpecification."Creation Date" := TODAY;
        TrackingSpecification."Appl.-to Item Entry" := ILE."Entry No.";
        TrackingSpecification."Warranty date" := ILE."Warranty Date";
        TrackingSpecification."Expiration Date" := ILE."Expiration Date";
        IF ITEM1.GET(MILin."Item No.") THEN
            TrackingSpecification."Product Group Code" := ITEM1."Product Group Code Cust";

        IF MIH.GET(MILin."Document No.") THEN BEGIN
            TrackingSpecification."Prod. Order No." := MIH."Prod. Order No.";
            TrackingSpecification."Prod. Order Line No." := MIH."Prod. Order Line No.";
        END;
        TrackingSpecification.Quantity := ILE."Remaining Quantity";
        TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
        TrackingSpecification.INSERT;
    end;


    local procedure FilterData();
    var
        FilterCodes: Text[55];
    begin
        FilterCodes := '';
        Rec.RESET;
        IF "Shelf Life Expired Items" THEN
            FilterCodes += 'S_EXPIRED|';
        IF "Recharge Cycles Exceeded Items" THEN
            FilterCodes += 'R_EXPIRED|';
        IF "Floor Life Expired Items" THEN
            FilterCodes += 'F_EXPIRED|';
        IF "Floor Life To Be Expired Items" THEN
            FilterCodes += 'F_T_EXPIRED|';
        IF "Shelf Life To Be Expired Items" THEN
            FilterCodes += 'S_T_EXPIRED|';
        IF FilterCodes <> '' THEN BEGIN
            FilterCodes := COPYSTR(FilterCodes, 1, STRLEN(FilterCodes) - 1);
            Rec.SETFILTER("Global Dimension 1 Code", FilterCodes);
        END;
        /*
        RESET;
        IF FINDSET THEN
        REPEAT
          IF "Shelf Life Expired Items" AND ("Global Dimension 1 Code" IN['S_EXPIRED']) THEN
            MARK(TRUE);
          IF "Recharge Cycles Exceeded Items" AND ("Global Dimension 1 Code" IN['R_EXPIRED']) THEN
            MARK(TRUE);
          IF "Floor Life Expired Items" AND ("Global Dimension 1 Code" IN['F_EXPIRED']) THEN
            MARK(TRUE);
        UNTIL NEXT=0;
        MARKEDONLY(TRUE);
        */
        CurrPage.UPDATE(FALSE);

    end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;
}

