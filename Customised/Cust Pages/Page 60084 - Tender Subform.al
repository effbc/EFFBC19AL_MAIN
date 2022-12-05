page 60084 "Tender Subform"
{
    // version B2B1.0,DWS1.0,Rev01

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Tender Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Schedule Type"; Rec."Schedule Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Schedule No"; Rec."Schedule No")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Unit Price" < Rec."Unit Cost" THEN BEGIN
                            MESSAGE('Unit Price Must Be More Than Unit Cost');
                            Rec."Unit Price" := Rec."Unit Cost";
                        END;
                    end;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
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

                    trigger OnValidate();
                    begin
                        item.SETRANGE(item."No.", Rec."No.");
                        IF item.FINDFIRST THEN BEGIN
                            IF (Rec."Unit Cost" < item."Avg Unit Cost") THEN
                                ERROR('Unit cost must be greater than item unit Cost');
                        END;
                    end;
                }
                field("Production Bom No."; Rec."Production Bom No.")
                {
                    ApplicationArea = All;
                }
                field("Production Bom Version No."; Rec."Production Bom Version No.")
                {
                    ApplicationArea = All;
                }
                field("Design Cost"; Rec."Design Cost")
                {
                    ApplicationArea = All;
                }
                field("CRM Cost"; Rec."CRM Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Estimated Unit Cost"; Rec."Estimated Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Cust. Estimated Unit Cost"; Rec."Cust. Estimated Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Cust.Estimated Total Cost"; Rec."Cust.Estimated Total Cost")
                {
                    ApplicationArea = All;
                }
                field("L1 Quote Value"; Rec."L1 Quote Value")
                {
                    ApplicationArea = All;
                }
                field("L2 Quote Value"; Rec."L2 Quote Value")
                {
                    ApplicationArea = All;
                }
                field("L3 Quote Value"; Rec."L3 Quote Value")
                {
                    ApplicationArea = All;
                }
                field("L4 Quote Value"; Rec."L4 Quote Value")
                {
                    ApplicationArea = All;
                }
                field("L5 Quote Value"; Rec."L5 Quote Value")
                {
                    ApplicationArea = All;
                }
                field("Estimated Total Unit Cost"; Rec."Estimated Total Unit Cost")
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
                CaptionML = ENU = '&Line',
                            ENN = '&Line';
                Image = Line;
                action("Sc&hedule")
                {
                    Caption = 'Sc&hedule';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                        /*CurrPage.SalesLines.Page.*/
                        ShowSchedule;

                    end;
                }
            }
        }
    }

    trigger OnInit();
    begin
        SalesPerson.SETFILTER(SalesPerson."Salesperson/Purchaser", 'sale');
        // Rev01 >>
        // SalesPerson.SETRANGE(SalesPerson.Code,USERID);
        User.RESET;
        User.SETRANGE("User ID", USERID);
        IF User.FINDFIRST THEN
            SalesPerson.SETRANGE(SalesPerson.Code, User.EmployeeID);
        //SalesPerson.SETRANGE(SalesPerson.Code,MiscUser.ReturnTrimmedUserID(USERID));
        // Rev01 <<
        IF SalesPerson.FINDFIRST THEN;
    end;

    var
        Temp: Decimal;
        SalesPerson: Record "Salesperson/Purchaser";
        item: Record Item;
        //MiscUser: Codeunit 60036;
        User: Record "User Setup";


    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        /*
        //TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        
        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type",DesignWorksheetHeader."Document Type"::Tender);
        DesignWorksheetHeader.SETRANGE("Document No.","Document No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.","Line No.");
        Page.RUNMODAL(Page::"Design Worksheet",DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
        */
        ItemDesignWorksheetHeader.RESET;
        IF ItemDesignWorksheetHeader.GET(Rec."No.") THEN BEGIN
            DesignWorksheetHeader.INIT;
            DesignWorksheetHeader.TRANSFERFIELDS(ItemDesignWorksheetHeader);
            DesignWorksheetHeader."Document No." := Rec."Document No.";
            DesignWorksheetHeader."Document Line No." := Rec."Line No.";
            DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::Tender;
            IF DesignWorksheetHeader.INSERT THEN;
            ItemDesignWorksheetLine.RESET;
            ItemDesignWorksheetLine.SETRANGE(ItemDesignWorksheetLine."Item No", ItemDesignWorksheetHeader."Item No.");
            IF ItemDesignWorksheetLine.FINDSET THEN
                    REPEAT
                        DesignWorksheetLine.INIT;
                        DesignWorksheetLine.TRANSFERFIELDS(ItemDesignWorksheetLine);
                        DesignWorksheetLine."Document No." := Rec."Document No.";
                        DesignWorksheetLine."Document Line No." := Rec."Line No.";
                        DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::Tender;
                        IF DesignWorksheetLine.INSERT THEN;
                    UNTIL ItemDesignWorksheetLine.NEXT = 0;
        END;
        COMMIT;
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Tender);
        DesignWorksheetHeader.SETRANGE("Document No.", Rec."Document No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        DesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Line No.");
        PAGE.RUNMODAL(PAGE::"Design Worksheet", DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);

    end;


    procedure ShowSchedule2();
    var
        Schedule: Record Schedule2;
    begin
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Line No.");
        //Schedule.SETRANGE("Item No.","No.");
        //Schedule.SETRANGE(Quantity,Quantity);
        Schedule.FILTERGROUP(2);
        PAGE.RUN(60125, Schedule);
        Schedule.FILTERGROUP(0);
    end;


    procedure ShowSchedule3();
    var
        Schedule: Record Schedule2;
        TenderLine: Record "Tender Line";
    begin
        /*
        TenderLine.RESET;
        TenderLine.SETRANGE("Document No.","Document No.");
        TenderLine.SETRANGE("Line No.","Document Line No.");
        IF TenderLine.FINDFIRST THEN BEGIN
          Schedule.INITl
          VALIDATE("Item No.",TenderLine."No.");
          Quantity := TenderLine.Quantity;
          TenderLine.CALCFIELDS("Estimated Unit Cost");
          //"Estimated Total Unit Cost" := TenderLine."Estimated Total Unit Cost";
        END ELSE BEGIN
          SalesLine.RESET;
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","Document No.");
          SalesLine.SETRANGE("Line No.","Document Line No.");
          IF SalesLine.FINDFIRST THEN BEGIN
           VALIDATE("Item No.",SalesLine."No.");
            Quantity := SalesLine.Quantity;
          END
        END
        */
        TenderLine.RESET;
        TenderLine.SETRANGE("Document No.", Rec."Document No.");
        TenderLine.SETRANGE("Line No.", Rec."Line No.");
        IF TenderLine.FINDSET THEN
            REPEAT
                    Schedule.INIT;
                Schedule."Document Type" := Schedule."Document Type"::Tender;
                Schedule."Document No." := TenderLine."Document No.";
                Schedule."Document Line No." := TenderLine."Line No.";
                Schedule."Line No." := TenderLine."Line No.";
                Schedule.Type := Schedule.Type::Item;
                Schedule.VALIDATE("No.", TenderLine."No.");
                Schedule.Quantity := TenderLine.Quantity;
                //TenderLine.CALCFIELDS("Estimated Unit Cost");
                IF Schedule.INSERT THEN;
            UNTIL TenderLine.NEXT = 0;
        COMMIT;

        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Line No.");
        //Schedule.SETRANGE("Item No.","No.");
        //Schedule.SETRANGE(Quantity,Quantity);
        Schedule.FILTERGROUP(2);
        PAGE.RUN(60125, Schedule);

        Schedule.FILTERGROUP(0);

    end;


    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
        TenderLine: Record "Tender Line";
    begin
        /*
        TenderLine.RESET;
        TenderLine.SETRANGE("Document No.","Document No.");
        TenderLine.SETRANGE("Line No.","Document Line No.");
        IF TenderLine.FINDFIRST THEN BEGIN
          Schedule.INITl
          VALIDATE("Item No.",TenderLine."No.");
          Quantity := TenderLine.Quantity;
          TenderLine.CALCFIELDS("Estimated Unit Cost");
          //"Estimated Total Unit Cost" := TenderLine."Estimated Total Unit Cost";
        END ELSE BEGIN
          SalesLine.RESET;
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","Document No.");
          SalesLine.SETRANGE("Line No.","Document Line No.");
          IF SalesLine.FINDFIRST THEN BEGIN
           VALIDATE("Item No.",SalesLine."No.");
            Quantity := SalesLine.Quantity;
          END
        END
        */
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            TenderLine.RESET;
            TenderLine.SETRANGE("Document No.", Rec."Document No.");
            TenderLine.SETRANGE("Line No.", Rec."Line No.");
            IF TenderLine.FINDSET THEN
                    REPEAT
                        Schedule.INIT;
                        Schedule."Document Type" := Schedule."Document Type"::Tender;
                        Schedule."Document No." := TenderLine."Document No.";
                        Schedule."Document Line No." := TenderLine."Line No.";
                        Schedule."Line No." := TenderLine."Line No.";
                        Schedule.Type := Schedule.Type::Item;
                        Schedule.VALIDATE("No.", TenderLine."No.");
                        Schedule.Quantity := TenderLine.Quantity;
                        Schedule."Estimated Total Unit Price" := Schedule."Estimated Unit Price" * Rec.Quantity;
                        //TenderLine.CALCFIELDS("Estimated Unit Cost");
                        IF Schedule.INSERT THEN;
                    UNTIL TenderLine.NEXT = 0;
            COMMIT;

            Schedule.RESET;
            Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
            Schedule.SETRANGE("Document No.", Rec."Document No.");
            Schedule.SETRANGE("Document Line No.", Rec."Line No.");
            //Schedule.SETRANGE("Item No.","No.");
            //Schedule.SETRANGE(Quantity,Quantity);
            Schedule.FILTERGROUP(2);
            PAGE.RUN(60125, Schedule);

            Schedule.FILTERGROUP(0);
        END ELSE
            IF Rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
                Schedule.SETRANGE("Document No.", Rec."Document No.");
                Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);

            END;

    end;
}

