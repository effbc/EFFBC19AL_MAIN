table 60025 "Indent Line"
{
    // version B2B1.0,POAU

    // 2.0      UPGREV                        Code Reviewed and Variant code Trigger Code changed.

    LookupPageID = "Indent Line";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            TableRelation = "Indent Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Item)) Item WHERE("Product Group Code Cust" = FILTER(<> 'FPRODUCT' & <> 'CPCB'), Blocked = CONST(false)) ELSE
            IF (Type = CONST(Miscellaneous)) Make ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset";
            trigger OnValidate();
            begin
                TestStatusOpen;
                CASE Type OF
                    Type::Item:

                        IF Item.GET("No.") THEN BEGIN
                            Item.TESTFIELD(Blocked, FALSE);
                            //b2b EFF
                            IF NOT ((Item."Product Group Code Cust" = 'STATIONARY') OR (Item."Gen. Prod. Posting Group" = 'STATIONARY') OR (Item."Item Category Code" = 'OFFICE MAI')) THEN BEGIN
                                IF (FORMAT(Item."Gen. Prod. Posting Group") = '') OR
                                   (FORMAT(Item."Tax Group Code") = '') //OR
                                                                        //(FORMAT(Item."Excise Prod. Posting Group") = '') OR
                                                                        //(FORMAT(Item."VAT Prod. Posting Group") = '') 
                                   THEN BEGIN
                                    NEW_LINE := 10;
                                    Subject := Item.Description + ' (' + Item."No." + ')' + 'ITEM TAX INFORMATION PROBLEM ';
                                    Body += 'Item                        : ' + Item.Description + ' (' + Item."No." + ')';
                                    Body += FORMAT(NEW_LINE);
                                    Body += 'Gen. Prod. Posting Group    : ' + Item."Gen. Prod. Posting Group";
                                    Body += FORMAT(NEW_LINE);
                                    Body += 'Tax Group Code              : ' + Item."Tax Group Code";
                                    // Body += FORMAT(NEW_LINE);
                                    // Body += 'Excise Prod. Posting Group  : ' + Item."Excise Prod. Posting Group";
                                    // Body += FORMAT(NEW_LINE);
                                    //Body += 'VAT Product Posting Group   : ' + Item."VAT Prod. Posting Group";
                                    Body += FORMAT(NEW_LINE);
                                    Body += FORMAT(NEW_LINE);
                                    Body += '****  Auto Mail Generated From ERP  ****';
                                    //MESSAGE(Body);

                                    //Mail_To:='santhoshk@efftronics.net';
                                    /* Mail_To := 'sitarajyam@efftronics.com,anilkumar@efftronics.com,erp@efftronics.com';
                                    USER.RESET;
                                    USER.SETRANGE(USER."User Security ID", USERSECURITYID);// Changed User."User Id" to User."User Security ID" B2B
                                    IF USER.FIND('-') THEN BEGIN
                                        Mail_From := USER.MailID;// B2B
                                                                 //            Mail_To+=','+USER.MailID;B2B
                                    END;
                                    // MESSAGE(USER.MailID);
                                    SMTP_MAIL.CreateMessage(USER."User Name", Mail_From, Mail_To, Subject, Body, FALSE);// Changed User."Name" to User."User Name" B2B
                                    SMTP_MAIL.Send; */   //B2B UPG

                                    Recipients.Add('purchase@efftronics.com');
                                    Recipients.Add('anilkumar@efftronics.com');
                                    Recipients.Add('erp@efftronics.com');
                                    USER.RESET;
                                    USER.SETRANGE(USER."User ID", userid);
                                    //USER.SETRANGE(USER."User Security ID", USERSECURITYID);// Changed User."User Id" to User."User Security ID" B2B
                                    IF USER.FIND('-') THEN BEGIN
                                        Mail_From := USER.MailID;// B2B
                                                                 //            Mail_To+=','+USER.MailID;B2B
                                    END;
                                    // MESSAGE(USER.MailID);
                                    EmailMessage.Create(Recipients, Subject, Body, false);
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


                                    //   Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,''); //commented by sreenivas on 02-06-2010
                                    ERROR('THERE IS NO SUFFICIENT TAX INFORMATION FOR THIS ITEM ' + FORMAT("No.") + FORMAT(NEW_LINE) +
                                          'PLEASE CONTACT THE ONE WHO CREATED THE ITEM');
                                END;
                            END;

                            Item.CALCFIELDS("Inventory at Stores");
                            Item.CALCFIELDS(Item."Quantity Under Inspection", Item."Quantity Rejected", Item."Quantity Rework",
                            Item."Quantity Sent for Rework", Item."Inventory at Stores");
                            Stock := 0;
                            IF Item."QC Enabled" = TRUE THEN BEGIN
                                IF (Item."Quantity Under Inspection" = 0) AND (Item."Quantity Rejected" = 0) AND
                                   (Item."Quantity Rework" = 0) AND (Item."Quantity Sent for Rework" = 0) THEN BEGIN
                                    ItemLedgEntry.RESET;
                                    ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                                                                "Expiration Date", "Lot No.", "Serial No.");
                                    ItemLedgEntry.SETRANGE("Item No.", Item."No.");
                                    ItemLedgEntry.SETRANGE(Open, TRUE);
                                    ItemLedgEntry.SETRANGE("Location Code", 'STR');
                                    IF ItemLedgEntry.FIND('-') THEN
                                        REPEAT
                                            Stock += ItemLedgEntry."Remaining Quantity";
                                        UNTIL ItemLedgEntry.NEXT = 0;
                                END ELSE BEGIN
                                    Stock := 0;
                                    ItemLedgEntry.RESET;
                                    ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                                                                "Expiration Date", "Lot No.", "Serial No.");
                                    ItemLedgEntry.SETRANGE("Item No.", Item."No.");
                                    ItemLedgEntry.SETRANGE(Open, TRUE);
                                    ItemLedgEntry.SETRANGE("Location Code", 'STR');
                                    IF ItemLedgEntry.FIND('-') THEN
                                        REPEAT
                                            ItemLedgEntry.MARK(TRUE);
                                            IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                                                QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                                               (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                                               AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                                                ItemLedgEntry.MARK(FALSE);
                                        UNTIL ItemLedgEntry.NEXT = 0;
                                END;
                            END;
                            ItemLedgEntry.MARKEDONLY(TRUE);
                            IF ItemLedgEntry.FIND('-') THEN
                                REPEAT
                                    Stock := Stock + ItemLedgEntry."Remaining Quantity";
                                UNTIL ItemLedgEntry.NEXT = 0;

                            "Store Qty" := Stock;
                            //b2b EFF
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            "Due Date" := CALCDATE(Item."Lead Time Calculation", WORKDATE);
                            "Unit Cost" := Item."Unit Cost";
                            "Unit of Measure" := Item."Base Unit of Measure";
                            "Purchaser Code" := Item."Purchaser Code";
                        END;

                    Type::Miscellaneous:
                        IF Stationary.GET("No.") THEN BEGIN
                            Description := Stationary."Created By";
                            //  "Unit of Measure" := Stationary."Unit Of Measure";
                            //  "Unit Cost" := Stationary."Entry Date Time";
                            "Due Date" := IndentHeader."Due Date";
                            //  "G/L Account" := Stationary."G/L Account";
                            //  "Purchaser Code" := Stationary."Purchaser Code";
                        END;
                    // Need to add to G/L Account
                    Type::"G/L Account":
                        IF GLA.GET("No.") THEN BEGIN
                            Description := GLA.Name;
                            "Due Date" := IndentHeader."Due Date";
                        END;
                    Type::"Fixed Asset":
                        IF FA.GET("No.") THEN BEGIN
                            Description := FA.Description;
                            "Description 2" := FA."Description 2";
                            "Due Date" := IndentHeader."Due Date";
                        END;
                // Need to add to G/L Account

                END;
                IndentHeader.GET("Document No.");
                Make := IndentHeader.Make;
                "ICN No." := IndentHeader."ICN No.";
                "Project Description" := IndentHeader."Project Description";
                "Production Order Description" := IndentHeader."Production Order Description";
                "Production Start date" := IndentHeader."Production Start date";
                "Sale Order No." := IndentHeader."Sale Order No.";
                "Sale Order Description" := IndentHeader."Sales Order Description";
                "Delivery Location" := IndentHeader."Delivery Location";
                Contact := IndentHeader."Contact Person";
            end;
        }
        field(4; Description; Text[50])
        {

            trigger OnValidate();
            begin
                TestStatusOpen;
                IF Type = Type::Description THEN BEGIN
                    IndentHeader.GET("Document No.");
                    Make := IndentHeader.Make;
                    "ICN No." := IndentHeader."ICN No.";
                    "Project Description" := IndentHeader."Project Description";
                    "Production Order Description" := IndentHeader."Production Order Description";
                    "Production Start date" := IndentHeader."Production Start date";
                    "Sale Order No." := IndentHeader."Sale Order No.";
                    "Sale Order Description" := IndentHeader."Sales Order Description";
                    "Delivery Location" := IndentHeader."Delivery Location";
                    Contact := IndentHeader."Contact Person";
                END;
            end;
        }
        field(5; Quantity; Decimal)
        {
            MinValue = 0;

            trigger OnValidate();
            begin
                TestStatusOpen;
                IF "Quantity To Be Ordered" < 0 THEN
                    "Quantity To Be Ordered" := 0;
            end;
        }
        field(7; "Quantity To Be Ordered"; Decimal)
        {

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(8; "Weight To Be Ordered"; Decimal)
        {

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(9; Make; Code[50])
        {

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(10; "Due Date"; Date)
        {
            Caption = 'Released Date';

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(11; "Delivery Location"; Code[20])
        {
            TableRelation = IF ("Delivery Place" = CONST(Customer)) Customer ELSE
            IF ("Delivery Place" = CONST(Store)) Location;

            trigger OnValidate();
            begin
                TestStatusOpen;
                IF cust.GET("Delivery Location") THEN
                    Contact := cust.Name;
                IF loc.GET("Delivery Location") THEN
                    Contact := loc.Name;
            end;
        }
        field(12; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(13; Contact; Text[50])
        {

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(14; "Delivery Place"; Option)
        {
            OptionMembers = Store,Customer;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(17; "Indent Status"; Option)
        {
            Editable = true;
            Enabled = true;
            OptionCaption = 'Indent,Enquiry,Offer,Order,Cancel,Closed';
            OptionMembers = Indent,Enquiry,Offer,"Order",Cancel,Closed;
        }
        field(18; "Indent Reference"; Text[50])
        {
        }
        field(20; "Sale Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order | "Blanket Order"));

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(22; "Production Order"; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(23; "Production Order Line No."; Integer)
        {
        }
        field(24; "Max Quantity On Any Quote"; Decimal)
        {
            Editable = false;
        }
        field(25; "Quantity On Order"; Decimal)
        {
            Editable = false;
        }
        field(26; "Quantity On Inspection"; Decimal)
        {
            Editable = false;
        }
        field(27; "Quantity On Receipt"; Decimal)
        {
            Editable = false;
        }
        field(30; Type; Option)
        {
            OptionCaption = 'Item,Miscellaneous,Description, ,G/L Account,Fixed Asset';
            OptionMembers = Item,Miscellaneous,Description," ","G/L Account","Fixed Asset";

            trigger OnValidate();
            begin
                TestStatusOpen;
                "Due Date" := WORKDATE;
                IndentHeader.GET("Document No.");
                "ICN No." := IndentHeader."ICN No.";
            end;
        }
        field(31; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account" WHERE("PL Income Expenditure" = FILTER(<> 'Income'));

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(32; "Unit Cost"; Decimal)
        {
        }
        field(35; "Set Selection"; Boolean)
        {
        }
        field(36; "Release Status"; Option)
        {
            OptionMembers = Open,Released,Cancel,Closed;
        }
        field(37; "Description 2"; Text[50])
        {
        }
        field(38; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));

            trigger OnValidate();
            begin
                TestStatusOpen;
                TESTFIELD(Type, Type::Item);
                IF "Variant Code" = '' THEN
                    IF Type = Type::Item THEN BEGIN
                        Item.GET("No.");
                        Description := Item.Description;
                        "Description 2" := Item."Description 2";
                    END;
                //UPGREV2.0>>
                //ItemVariant.GET("No.","Variant Code");
                ItemVariant.RESET;
                ItemVariant.SETRANGE("Item No.", "No.");
                ItemVariant.SETRANGE(Code, "Variant Code");
                IF ItemVariant.FINDFIRST THEN
                    //UPGREV2.0<<
                    Description := ItemVariant.Description;
                //"Description 2" := ItemVariant."Description 2";//B2B
            end;
        }
        field(39; Remarks; Text[50])
        {
        }
        field(40; "Purchaser Code"; Code[20])
        {

            trigger OnValidate();
            begin
                //SalesPurchase.SETRANGE(SalesPurchase."Navision User ID",USERID);//B2B Commented
                SalesPurchase.SETRANGE(SalesPurchase."Salesperson/Purchaser", SalesPurchase."Salesperson/Purchaser"::Purchase);
                IF NOT SalesPurchase.FIND('-') THEN
                    ERROR('Only Purchaser can allot');
            end;
        }
        field(41; "Drawing No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(42; "Operation No."; Code[20])
        {
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE("Prod. Order No." = FIELD("Production Order"), "Routing Reference No." = FIELD("Production Order Line No."), "Routing No." = FIELD("Routing No."));

            trigger OnValidate();
            begin
                TestStatusOpen;
                IF ProdOrderRoutingLine.GET(ProdOrderRoutingLine.Status::Released, "Production Order", "Production Order Line No.",
                  "Routing No.", "Operation No.") THEN
                    "Operation Description" := ProdOrderRoutingLine.Description;
                IF "Operation No." = '' THEN
                    "Operation Description" := '';
            end;
        }
        field(43; "Routing No."; Code[20])
        {
            TableRelation = "Routing Line"."Routing No.";

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(44; "Operation Description"; Text[30])
        {
        }
        field(45; "Quantity Invoiced"; Decimal)
        {
        }
        field(50; "ICN No."; Code[20])
        {
            Editable = true;

            trigger OnValidate();
            begin
                TestStatusOpen;
                IndentLine.RESET;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FIND('-') THEN
                    REPEAT
                        IndentLine."ICN No." := "ICN No.";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(60000; "Store Qty"; Decimal)
        {
            Description = 'Editable=No';
        }
        field(60001; "Order Mail"; Boolean)
        {
        }
        field(60100; "Project Description"; Text[50])
        {
        }
        field(60101; "Production Order Description"; Text[50])
        {
        }
        field(60102; "Production Start date"; Date)
        {
        }
        field(60103; "Sale Order Description"; Text[50])
        {
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."), "Order Line No." = FIELD("Line No."), "Entry Type" = FILTER(Accepted)));
            Editable = false;

        }
        field(33000252; "Quantity Rework"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Quality Ledger Entry"."Remaining Quantity" WHERE("Order No." = FIELD("Document No."), "Order Line No." = FIELD("Line No."), "Entry Type" = FILTER(Rework)));
            Editable = false;
        }
        field(33000254; "Quantity Rejected"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."), "Order Line No." = FIELD("Line No."), "Entry Type" = FILTER(Reject)));
            Editable = false;

        }
        field(33000255; "Purchase Remarks"; Code[50])
        {
        }
        field(33000256; "Suitable Vendor"; Code[20])
        {
            TableRelation = Vendor WHERE(Blocked = FILTER(<> All));
        }
        field(33000257; "Production Order Comp Line No."; Integer)
        {
        }
        field(33000258; Earliest_Req_day; Date)
        {
        }
        field(33000259; "Purchase Order Number"; Code[20])
        {
            Description = 'added by vishnu priya to get the Purchase order number';
        }
        field(33000260; "Purchase Order Line Number"; Integer)
        {
            Description = 'added by vishnu priya to get the Purchase order line number';
        }
        field(33000261; "Base Indent Number"; Code[20])
        {
            Description = 'added by vishnu priya to know the base indent number in the Purchase Order';
        }
        field(33000262; "Base Indent Line Number"; Integer)
        {
            Description = 'added by vishnu priya to know the base indent Line number in the Purchase Order';
        }
        field(33000263; "Part Number"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'added by vishnu priya to know the base indent Line number in the Purchase Order';
        }
    }

    keys
    {
        key(Key1; "Document No.", "No.", Description, "Line No.")
        {
        }
        key(Key2; "No.")
        {
        }
        key(Key3; "No.", Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin

        IndentHeader.GET("Document No.");
        IndentHeader.TESTFIELD("Released Status", IndentHeader."Released Status"::Open);
    end;

    trigger OnInsert();
    begin
        TestStatusOpen;
    end;

    trigger OnModify();
    begin
        //TestStatusOpen;    //anil
    end;

    var
        IndentHeader: Record "Indent Header";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        Stationary: Record Make;
        cust: Record Customer;
        loc: Record Location;
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        changeIndentLine: Boolean;
        SalesPurchase: Record "Salesperson/Purchaser";
        PurchaseLine: Record "Purchase Line";
        IndentLine: Record "Indent Line";
        Stock: Decimal;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        USER: Record "User setup";
        Body: Text[1000];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit Mail;
        Subject: Text[250];
        NEW_LINE: Char;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        GLA: Record "G/L Account";
        FA: Record "Fixed Asset";
        EmailMessage: Codeunit "Email Message";

        Email: Codeunit Email;
        Recipients: List of [Text];


    local procedure TestStatusOpen();
    begin
        //MESSAGE(FORMAT("Document No."));
        IndentHeader.GET("Document No.");
        IndentHeader.TESTFIELD("Released Status", IndentHeader."Released Status"::Open);
        IndentHeader."Last Date Modified" := TODAY;
        IndentHeader.MODIFY;
    end;


    procedure ChangePurchaser();
    begin
        changeIndentLine := TRUE;
        MESSAGE('fun %1', changeIndentLine);
    end;
}

