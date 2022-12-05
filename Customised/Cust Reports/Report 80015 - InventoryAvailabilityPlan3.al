report 80015 "Inventory - Availability Plan3"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InventoryAvailabilityPlan3.rdl';
    Caption = 'Inventory - Availability Plan';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Material Issues Header"; "Material Issues Header")
        {
            DataItemTableView = SORTING("Prod. Order No.", "Prod. Order Line No.") ORDER(Ascending) WHERE("Transfer-from Code" = FILTER('STR | MCH'), Status = CONST(1));
            RequestFilterFields = "Prod. Order No.", "Prod. Order Line No.";

            trigger OnAfterGetRecord()
            begin
                IF Choice = Choice::Alternate THEN BEGIN
                    Change_Alternate_Items("Material Issues Header"."No.", "Material Issues Header"."Prod. Order No.");
                END ELSE
                    IF Choice = Choice::Assign THEN BEGIN
                        // CODEUNIT.RUN(60014,"Material Issues Header");      // Commented by Pranavi on 24-Mar-2017

                        //>>Added by Pranavi on 24-Mar-2017

                        Mat_Issue_sLine.RESET;
                        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "Material Issues Header"."No.");
                        IF Mat_Issue_sLine.FIND('-') THEN
                            REPEAT
                                Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                                Mat_Issue_sLine.VALIDATE("Qty. to Receive");
                                Mat_Issue_sLine.MODIFY;
                            UNTIL Mat_Issue_sLine.NEXT = 0;

                        AssingBatchManual.AssignBatchManual("Material Issues Header");

                        //<<Added by Pranavi on 24-Mar-2017

                    END ELSE
                        IF Choice = Choice::Post THEN BEGIN
                            /*  Mat_Issue_sLine.RESET;
                              Mat_Issue_sLine.SETRANGE("Document No.","Material Issues Header"."No.");
                              Mat_Issue_sLine.SETFILTER(Quantity,'<>0');
                              Mat_Issue_sLine.SETFILTER("Qty. to Receive",'<>0');
                              IF NOT Mat_Issue_sLine.FIND('-') THEN
                                CurrReport.SKIP; */

                            "Material Issues Header"."Posting Date" := TODAY;

                            Issue_Post.Issues_Post("Material Issues Header");
                            Mat_Issue_sLine.RESET;
                            Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "Material Issues Header"."No.");
                            IF Mat_Issue_sLine.FIND('-') THEN
                                REPEAT
                                    Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                                    Mat_Issue_sLine.MODIFY;
                                UNTIL Mat_Issue_sLine.NEXT = 0;

                        END;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(Choice; Choice)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Choice: Option Alternate,Assign,Post;
        Mat_Issue_sLine: Record "Material Issues Line";
        Alternate_items: Record "Alternate Items";
        item: Record Item;
        Production_Order: Record "Production Order";
        Product_Type: Code[20];
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Issue_Post: Codeunit "MaterialIssueOrde-Post Receipt";
        MaterialIssuesLine: Record "Material Issues Line";
        AssingBatchManual: Codeunit "Assign Batch No's";


    procedure Change_Alternate_Items("Material Issue No.": Code[20]; "Prod_Order_No.": Code[20])
    begin
        Production_Order.SETRANGE(Production_Order."No.", "Prod_Order_No.");
        IF Production_Order.FIND('-') THEN BEGIN
            IF item.GET(Production_Order."Source No.") THEN
                Product_Type := item."Item Sub Group Code";
        END;
        IF NOT (Product_Type IN ['', ' ']) THEN
            Product_Type := Product_Type + '|ALL PRODUCTS'
        ELSE
            Product_Type := 'ALL PRODUCTS';
        Mat_Issue_sLine.RESET;
        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "Material Issues Header"."No.");
        Mat_Issue_sLine.SETFILTER(Mat_Issue_sLine."Qty. to Receive", '>%1', 0);
        IF Mat_Issue_sLine.FIND('-') THEN
            REPEAT
                IF Net_Stock(Mat_Issue_sLine."Item No.", Mat_Issue_sLine."Transfer-from Code") < Mat_Issue_sLine."Qty. to Receive" THEN BEGIN
                    Alternate_items.RESET;
                    Alternate_items.SETCURRENTKEY(Alternate_items."Proudct Type",
                                                  Alternate_items."Item No.",
                                                  Alternate_items."Priority Order");
                    Alternate_items.SETFILTER(Alternate_items."Proudct Type", Product_Type);
                    Alternate_items.SETRANGE(Alternate_items."Item No.", Mat_Issue_sLine."Item No.");
                    IF Alternate_items.FINDSET THEN
                        REPEAT
                            IF Net_Stock(Alternate_items."Alternative Item No.",
                                        Mat_Issue_sLine."Transfer-from Code") > Mat_Issue_sLine."Qty. to Receive" THEN BEGIN
                                Mat_Issue_sLine.TESTFIELD(Mat_Issue_sLine."Quantity Received", 0);
                                Mat_Issue_sLine."Item No." := Alternate_items."Alternative Item No.";
                                IF item.GET(Alternate_items."Alternative Item No.") THEN BEGIN
                                    item.TESTFIELD(Blocked, FALSE);
                                    Mat_Issue_sLine.Description := item.Description;
                                    Mat_Issue_sLine.VALIDATE(Mat_Issue_sLine."Unit of Measure Code", item."Base Unit of Measure");
                                    Mat_Issue_sLine.VALIDATE(Mat_Issue_sLine."Description 2", item."Description 2");
                                    Mat_Issue_sLine."Item Category Code" := item."Product Group Code Cust";
                                    Mat_Issue_sLine."Product Group Code" := item."Product Group Code Cust";
                                    Mat_Issue_sLine.MODIFY;
                                    Alternate_items.FINDLAST;
                                END;
                            END;
                        UNTIL Alternate_items.NEXT = 0;
                END;
            UNTIL Mat_Issue_sLine.NEXT = 0;
    end;


    procedure Net_Stock("Item No.": Code[20]; lOCATION: Code[20]) "Stock Value": Decimal
    begin
        "Stock Value" := 0;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Location Code", lOCATION);
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
        IF ItemLedgerEntry.FIND('-') THEN
            REPEAT
                QualityItemLedgerEntry.SETRANGE("Entry No.", ItemLedgerEntry."Entry No.");
                IF NOT QualityItemLedgerEntry.FIND('-') THEN
                    "Stock Value" := "Stock Value" + ItemLedgerEntry.Quantity;
            UNTIL ItemLedgerEntry.NEXT = 0;
        MaterialIssuesLine.SETCURRENTKEY(MaterialIssuesLine."Prod. Order No.",
                                         MaterialIssuesLine."Prod. Order Line No.");
        MaterialIssuesLine.RESET;
        MaterialIssuesLine.SETFILTER(MaterialIssuesLine."Prod. Order No.",
                                     "Material Issues Header".GETFILTER("Material Issues Header"."Prod. Order No."));
        MaterialIssuesLine.SETFILTER(MaterialIssuesLine."Prod. Order Line No.",
                                     "Material Issues Header".GETFILTER("Material Issues Header"."Prod. Order Line No."));
        IF MaterialIssuesLine.FINDSET THEN
            REPEAT
                "Stock Value" -= (MaterialIssuesLine.Quantity - MaterialIssuesLine."Quantity Received");
            UNTIL MaterialIssuesLine.NEXT = 0;
        EXIT("Stock Value");
    end;
}

