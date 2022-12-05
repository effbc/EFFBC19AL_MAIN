page 50019 "Sales Line Details"
{
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document No." = FILTER('<>EFF/AMC/*'), "Outstanding Quantity" = FILTER(> 0), MainCategory = FILTER('<>Temp-Closed'),
                                  "Sell-to Customer No." = FILTER('<>CUST02007'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field("Product Group Code Cust"; Rec."Product Group Code Cust")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    DrillDown = false;
                    Editable = false;
                    Lookup = true;
                    LookupPageID = "Sales Order";
                    TableRelation = "Sales Header" WHERE(Status = FILTER(Released), "No." = FIELD("Document No."));
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    TableRelation = "Sales Header"."Sell-to Customer Name" WHERE("No." = FIELD("Document No."));
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    Visible = false;
                    Width = 1;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    Editable = false;
                    Visible = false;
                    Width = 1;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ProductGroup; Rec.ProductGroup)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Vertical; Rec.Vertical)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
                {
                    ApplicationArea = All;
                }
                field(MainCategory; Rec.MainCategory)
                {
                    ApplicationArea = All;
                }
                field("Reg/Non reg Product"; Rec."Reg/Non reg Product")
                {
                    ApplicationArea = All;

                }
                field(SubCategory; Rec.SubCategory)
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Call Letter Status"; Rec."Call Letter Status")
                {
                    ApplicationArea = All;
                }
                field("Call Letter Exp Date"; Rec."Call Letter Exp Date")
                {
                    Caption = 'Customer Expected Date';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Prod Start Date"; Rec."Prod Start Date")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Date"; Rec."Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("Deviated Dispatch Date"; Rec."Deviated Dispatch Date")
                {
                    ApplicationArea = All;
                }
                field("RDSO Number"; Rec."RDSO Number")
                {
                    ApplicationArea = All;
                }
                field("Tentative RDSO Date"; Rec."Tentative RDSO Date")
                {
                    ApplicationArea = All;
                }
                field("CL_CNSGN  rcvd Date1"; Rec."CL_CNSGN  rcvd Date1")
                {
                    ApplicationArea = All;
                }
                field("CL_CNSGN  rcvd Qty"; Rec."CL_CNSGN  rcvd Qty")
                {
                    ApplicationArea = All;
                }
                field("Production Stage"; Rec."Production Stage")
                {
                    ApplicationArea = All;
                }
                field("Product ready Date Committed"; Rec."Product ready Date Committed")
                {
                    ApplicationArea = All;
                }
                field("Product ready Date (Revised)"; Rec."Product ready Date (Revised)")
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;

                }
                field("Non Regular Stages"; Rec."Non Regular Stages")
                {
                    ApplicationArea = All;

                }
                field("Responsible Dept"; Rec."Responsible Dept")
                {
                    ApplicationArea = All;

                }
                field("M Stage"; Rec."M Stage")
                {
                    ApplicationArea = All;

                }
                field("Reg Stages"; "Reg Stages")
                {
                    ApplicationArea = All;
                }
                field(Stages; Stages)
                {
                    ApplicationArea = All;
                }
                field("Completion Date"; "Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; "Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Site Details"; "Site Details")
                {
                    ApplicationArea = All;
                }
                field("Review Status"; "Review Status")
                {
                    ApplicationArea = All;
                }
                field("Stage Wise Remarks"; "Stage Wise Remarks")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        /*CUS.RESET;
        CUS.SETFILTER("No.",Rec."Sell-to Customer No.");
        IF CUS.FINDSET THEN
          BEGIN
            Rec."Sell-to Customer Name" := CUS.Name;
            Rec.MODIFY;
            END;*/

        CUS.RESET;
        CUS.SETFILTER("No.", Rec."Sell-to Customer No.");
        IF CUS.FINDSET THEN BEGIN
            Rec."Sell-to Customer Name" := CUS.Name;
            IF Rec."RDSO Inspection Required" = TRUE THEN BEGIN
                SH.RESET;
                SH.SETFILTER("No.", Rec."Document No.");
                IF SH.FINDFIRST THEN
                    Rec."Call Letter Status" := SH."Call letters Status";
            END;
            Rec.MODIFY;
        END;


        /*SH.RESET;
        SH.SETFILTER("No.","Document No.");
        IF SH.FINDSET THEN
          REPEAT
            BEGIN
            "Call Letter Status1" := FORMAT(SH."Call letters Status");
            END;
          UNTIL SH.NEXT = 0;
          */

    end;

    trigger OnOpenPage();
    begin
        IF NOT ("Custom Events".Permission_Checking(USERID, 'SALES_LINE_DETAILS'))
          THEN
            ERROR('You Don"t have Permissions');

        SH.RESET;
        SH.SETFILTER("No.", Rec."Document No.");
        SH.SETFILTER(Status, 'Released');
        SH.SETFILTER("Order Status", '<>%1', 9);
        Rec.SETFILTER(Type, FORMAT(Rec.Type::Item));
        // Rec.SETFILTER("Product Group Code ", '<> %1', '');
        //Rec.SETFILTER("Document Type",'%1|%2',Rec."Document Type"::Order,Rec."Document Type"::"Blanket Order");
        Rec.SETFILTER("Document Type", '%1', Rec."Document Type"::Order);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Stage.Key := Stage.Key + 1;
        SETCURRENTKEY("Document No.", "Line No.");
        Stage."Document No." := Rec."Document No.";
        Stage."Line No." := Rec."Line No.";
        Stage."No." := Rec."No.";
        Stage.Description := Rec.Description;
        Stage.Quantity := Rec.Quantity;
        Stage."Outstanding Quantity" := Rec."Outstanding Quantity";
        Stage.SubCategory := Rec.Stages;
        Stage."Reg Stages" := Rec."Reg Stages";
        Stage.Status := Rec.Status;
        Stage."Completion Date" := Rec."Completion Date";
        Stage."Creation Date" := CURRENTDATETIME;
        Stage."Stage Wise Remarks" := Rec."Stage Wise Remarks";
        Stage.INSERT;
    end;


    var
        // SMTP_MAIL: Codeunit "SMTP Mail";
        "Custom Events": Codeunit "Custom Events";
        SH: Record "Sales Header";
        "Order Release Date": Date;
        CUS: Record Customer;
        "Call Letter Status1": Code[10];
        SAL_ORDER_NO: Code[30];

        Stage: Record "Order Stage";
    // Stage: Record 33000940;

}

