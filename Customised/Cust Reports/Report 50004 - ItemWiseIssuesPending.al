report 50004 "Item Wise Issues Pending"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemWiseIssuesPending.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Material Issues Header"; "Material Issues Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = CONST(Released));
            RequestFilterFields = "No.", "Prod. Order No.", "Reason Code", "Transfer-to Code", "Transfer-from Code", "User ID";
            column(MIH_Choice; Choice)
            {
            }

            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Tot_Pending_Qty; Tot_Pending_Qty)
            {
            }
            column(Item_Wise_Issues_PendingCaption; Item_Wise_Issues_PendingCaptionLbl)
            {
            }
            column(Page_No___Caption; Page_No___CaptionLbl)
            {
            }
            column(Project_CodeCaption; Project_CodeCaptionLbl)
            {
            }
            column(Req_NoCaption; Req_NoCaptionLbl)
            {
            }
            column(Material_Issues_Line__Item_No__Caption; "Material Issues Line".FIELDCAPTION("Item No."))
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Requested_dateCaption; Requested_dateCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(Requested_QuantityCaption; Requested_QuantityCaptionLbl)
            {
            }
            column(Qty__to_Receive_Caption; Qty__to_Receive_CaptionLbl)
            {
            }
            column(Material_Issues_Line__Qty__Received__Base__Caption; "Material Issues Line".FIELDCAPTION("Qty. Received (Base)"))
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Material_Issues_Header_No_; "No.")
            {
            }
            dataitem("Material Issues Line"; "Material Issues Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                RequestFilterFields = "Item No.", Rejected;
                column(Tot_Qty; Tot_Qty)
                {
                }
                column(MILBody1; MILBody1)
                {
                }
                column(Material_Issues_Line__Transfer_to_Code_; "Transfer-to Code")
                {
                }
                column(Material_Issues_Line_Quantity; Quantity)
                {
                }
                column(Material_Issues_Line__Qty__Received__Base__; "Qty. Received (Base)")
                {
                }
                column(Material_Issues_Line__Item_No__; "Item No.")
                {
                }
                column(Material_Issues_Header___Resource_Name_; "Material Issues Header"."Resource Name")
                {
                }
                column(Material_Issues_Line__Document_No__; "Document No.")
                {
                }
                column(Reason; Reason)
                {
                }
                column(Material_Issues_Line__Material_Issues_Line__Description; "Material Issues Line".Description)
                {
                }
                column(Item__Avg_Unit_Cost_; cost)
                {
                }
                column(Material_Issues_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Material_Issues_Header___Released_Date_; "Material Issues Header"."Released Date")
                {
                }
                column(Quantity__Qty__Received__Base__; Quantity - "Qty. Received (Base)")
                {
                }
                column(Material_Issues_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Rev01

                    //Material Issues Line, Body (1) - OnPreSection()
                    // MILBody1 := TRUE;
                    //Quantity_to_receive:=0;
                    //"Material Issues Line".CALCFIELDS("Material Issues Line"."Qty. to Receive");
                    //Quantity_to_receive:="Material Issues Line"."Qty. to Receive";
                    IF "Material Issues Line".Quantity = "Material Issues Line"."Quantity Received" THEN BEGIN
                        MILBody1 := TRUE;   //CurrReport.SHOWOUTPUT:=FALSE;
                    END
                    ELSE BEGIN
                        Reason := "Material Issues Header"."Prod. Order No.";
                        Tot_Pending_Qty += Quantity - "Qty. Received (Base)";
                        Tot_Qty := Tot_Qty + "Material Issues Line".Quantity;
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        MILBody1 := FALSE;
                        sno := sno + 1;
                        IF "Verify Requests" THEN BEGIN
                            "Posted Material Issues Line".RESET;
                            "Posted Material Issues Line".SETCURRENTKEY("Posted Material Issues Line"."Prod. Order No.",
                                                                        "Posted Material Issues Line"."Prod. Order Line No.",
                                                                        "Posted Material Issues Line"."Item No.");
                            "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Prod. Order No."
                                                                          , "Material Issues Line"."Prod. Order No.");
                            "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Prod. Order Line No.",
                                                                          "Material Issues Line"."Prod. Order Line No.");
                            "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Item No.", "Material Issues Line"."Item No.");
                            IF "Posted Material Issues Line".FIND('-') THEN BEGIN
                                "Material Issues Line".Rejected := TRUE;
                                "Material Issues Line".MODIFY;
                            END;
                        END;
                        Item.SETRANGE(Item."No.", "Material Issues Line"."Item No.");
                        IF Item.FINDFIRST THEN
                            cost := Item."Avg Unit Cost";
                        IF excel THEN BEGIN
                            Row += 1;
                            Entercell(Row, 1, "Material Issues Line"."Item No.", FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 2, "Material Issues Line".Description, FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 3, FORMAT("Material Issues Line".Quantity), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 4, FORMAT("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received"), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 5, FORMAT("Material Issues Line"."Qty. Received (Base)"), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 6, FORMAT(cost), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 7, "Material Issues Line"."Document No.", FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 8, FORMAT("Material Issues Header"."Released Date"), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 9, "Material Issues Header"."Prod. Order No.", FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 10, FORMAT("Material Issues Line"."Prod. Order Line No."), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 11, "Material Issues Line"."Unit of Measure", FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 12, "Material Issues Line"."Transfer-to Code", FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 13, "Material Issues Header"."Resource Name", FALSE, TempExcelbuffer."Cell Type"::Text);
                        END;
                    END;

                    //IF Item.GET("Material Issues Line"."Item No.") THEN

                    //sno:=sno+1;

                    //Material Issues Line, Body (1) - OnPreSection()
                end;

                trigger OnPreDataItem()
                begin
                    MILBody1 := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01

                //Material Issues Header, Header (1) - OnPreSection()
                /*sno:=0;
                IF excel THEN BEGIN
                  Row+=1;
                  EnterHeadings(Row,1,'Item No.',TRUE,TempExcelbuffer."Cell Type" :: Text);
                  EnterHeadings(Row,2,'Description',TRUE,TempExcelbuffer."Cell Type" :: Text);
                  EnterHeadings(Row,3,'Quantity Requested',TRUE,TempExcelbuffer."Cell Type" :: Text);
                  EnterHeadings(Row,4,'Quantity Pending',TRUE,TempExcelbuffer."Cell Type" :: Text);
                  EnterHeadings(Row,5,'Request No.',TRUE,TempExcelbuffer."Cell Type" :: Text);
                  EnterHeadings(Row,6,'Production Order',TRUE,TempExcelbuffer."Cell Type" :: Text);
                  EnterHeadings(Row,7,'Production Order Line',TRUE,TempExcelbuffer."Cell Type" :: Text);
                END; */
                //Material Issues Header, Header (1) - OnPreSection()

            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Prod THEN
                    CurrReport.BREAK;
                IF "Material Issues Header".GETFILTER("Material Issues Header"."Transfer-from Code") = '' THEN
                    "Material Issues Header".SETFILTER("Material Issues Header"."Transfer-from Code", 'STR|''R&D STR''|CS STR|MCH');
                sno := 0;
                IF excel THEN BEGIN
                    Row += 1;
                    EnterHeadings(Row, 1, 'Item No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'Description', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Quantity Requested', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Quantity Pending', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Quantity Received (Base)', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Unit Cost', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Request No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Released Date', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Production Order', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Production Order Line', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'UOM', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'Department', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 13, 'Employee Name', TRUE, TempExcelbuffer."Cell Type"::Text);
                END;
            end;
        }
        dataitem("Material Issues Line1"; "Material Issues Line")
        {
            DataItemTableView = SORTING("Item No.", "Prod. Order No.", "Prod. Order Line No.") ORDER(Ascending) WHERE("Item No." = FILTER(<> ''), Status = CONST(Released));
            RequestFilterFields = "Sales Order No.";
            RequestFilterHeading = 'Sale Order Wise Pending Items';
            column(MIL1_Choice; Choice)
            {
            }
            column(COMPANYNAME_Control1102154005; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO_Control1102154007; CurrReport.PAGENO)
            {
            }
            column(USERID_Control1102154019; USERID)
            {
            }
            column(TODAY_Control1102154020; TODAY)
            {
            }
            column(Material_Issues_Line1_Description; Description)
            {
            }
            column(Material_Issues_Line1__Unit_of_Measure_; "Unit of Measure")
            {
            }
            column(Tot_Pending_Qty_Control1102154029; Tot_Pending_Qty)
            {
            }
            column(Prod_Order_; "Prod.Order")
            {
            }
            column(STr; STr)
            {
            }
            column(RD; RD)
            {
            }
            column(Cs; Cs)
            {
            }
            column(sno; sno)
            {
            }
            column(Sale_Order_Wise_Issues_PendingCaption; Sale_Order_Wise_Issues_PendingCaptionLbl)
            {
            }
            column(Page_No___Caption_Control1102154008; Page_No___Caption_Control1102154008Lbl)
            {
            }
            column(Material_Issues_Line1_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(UOMCaption_Control1102154028; UOMCaption_Control1102154028Lbl)
            {
            }
            column(Pending_QuantityCaption; Pending_QuantityCaptionLbl)
            {
            }
            column(Production_OrdersCaption; Production_OrdersCaptionLbl)
            {
            }
            column(STRCaption; STRCaptionLbl)
            {
            }
            column(R_DCaption; R_DCaptionLbl)
            {
            }
            column(CSCaption; CSCaptionLbl)
            {
            }
            column(S_NoCaption; S_NoCaptionLbl)
            {
            }
            column(Material_Issues_Line1_Document_No_; "Document No.")
            {
            }
            column(Material_Issues_Line1_Line_No_; "Line No.")
            {
            }
            column(Material_Issues_Line1_Item_No_; "Item No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01

                //Material Issues Line1, GroupHeader (2) - OnPreSection()
                IF Prev_ItemNo <> ("Material Issues Line1"."Item No.") THEN BEGIN
                    Tot_Pending_Qty := 0;
                    Pending_value := 0;
                    UC := 0;
                    Item.RESET;
                    IF Item.GET("Material Issues Line1"."Item No.") THEN BEGIN
                        Item.CALCFIELDS(Item."Stock at CS Stores", Item."Stock at RD Stores");

                        UC := Item."Avg Unit Cost";
                        RD := Item."Stock at RD Stores";
                        STr := Item."Stock at Stores";
                        Cs := Item."Stock at CS Stores";
                    END;
                    "Prod.Order" := '';
                    Prev_ItemNo := "Material Issues Line1"."Item No.";
                END;
                //Material Issues Line1, GroupHeader (2) - OnPreSection()


                //Material Issues Line1, Body (3) - OnPreSection()
                Tot_Pending_Qty += ("Material Issues Line1".Quantity - "Material Issues Line1"."Quantity Received");
                //IF (STRLEN("Prod.Order")<90) AND (("Material Issues Line1".Quantity-"Material Issues Line1"."Quantity Received")>0) THEN
                IF (("Material Issues Line1".Quantity - "Material Issues Line1"."Quantity Received") > 0) THEN //ondition is not required for nav 2013
                    "Prod.Order" += "Material Issues Line1"."Prod. Order No." + ',';
                //Material Issues Line1, Body (3) - OnPreSection()

                //Material Issues Line1, GroupFooter (4) - OnPreSection()

                Pending_value := Tot_Pending_Qty * UC;
                Total_Pending_Value += Pending_value;
                IF Tot_Pending_Qty > 0 THEN BEGIN
                    sno += 1;
                    MILFOOT4 := TRUE;//CurrReport.SHOWOUTPUT:=TRUE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    MILFOOT4 := FALSE;//Material Issues Line1, GroupFooter (4) - OnPreSection()
            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Sale THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Posted Material Issues Line"; "Posted Material Issues Line")
        {
            DataItemTableView = SORTING("Prod. Order No.", "Prod. Order Line No.", "Item No.") ORDER(Ascending) WHERE("Material Issue No." = FILTER('A*|P*'));

            trigger OnAfterGetRecord()
            begin
                //Rev01

                //Posted Material Issues Line, GroupHeader - OnPreSection()
                IF Prev_ProdOrderNo <> "Posted Material Issues Line"."Prod. Order Line No." THEN BEGIN
                    "Material Issues Line".RESET;
                    "Material Issues Line".SETRANGE("Material Issues Line"."Prod. Order No.", "Posted Material Issues Line"."Prod. Order No.");
                    ;
                    "Material Issues Line".SETRANGE("Material Issues Line"."Prod. Order Line No.", "Posted Material Issues Line"."Prod. Order Line No.");
                    "Material Issues Line".SETRANGE("Material Issues Line"."Item No.", "Posted Material Issues Line"."Item No.");
                    IF "Material Issues Line".FIND('-') THEN
                        REPEAT
                            "Material Issues Line".Rejected := TRUE;
                            "Material Issues Line".MODIFY;
                        UNTIL "Material Issues Line".NEXT = 0;
                    Prev_ProdOrderNo := "Posted Material Issues Line"."Prod. Order Line No."
                END;
                //Posted Material Issues Line, GroupHeader - OnPreSection()
            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Del THEN
                    CurrReport.BREAK;
                "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Item No.", Del_Item);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(options)
                {
                    field(Choice; Choice)
                    {
                        ApplicationArea = All;
                    }
                    field(DeleteRejectedMaterial; DeleteRejectedMaterial)
                    {
                        Caption = 'Delete Rejected Material Requests';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            //Rev01
                            IF DeleteRejectedMaterial = TRUE THEN BEGIN
                                IF (USERID = 'SUPER') OR (USERID = '93FD001') THEN BEGIN
                                    "Material Issues Header".RESET;
                                    "Material Issues Header".SETRANGE("Material Issues Header".Rejected, TRUE);
                                    IF "Material Issues Header".FIND('-') THEN
                                        REPEAT
                                            "Material Issues Header".DELETE;
                                        UNTIL "Material Issues Header".NEXT = 0;
                                    "Material Issues Line".RESET;
                                    "Material Issues Line".SETRANGE("Material Issues Line".Rejected, TRUE);
                                    IF "Material Issues Line".FIND('-') THEN
                                        REPEAT
                                            "tRACKING SPECIFICATION".RESET;
                                            "tRACKING SPECIFICATION".SETRANGE("tRACKING SPECIFICATION"."Order No.", "Material Issues Line"."Document No.");
                                            "tRACKING SPECIFICATION".SETRANGE("tRACKING SPECIFICATION"."Order Line No.", "Material Issues Line"."Line No.");
                                            IF "tRACKING SPECIFICATION".FIND('-') THEN
                                                REPEAT
                                                    "tRACKING SPECIFICATION".DELETE;
                                                UNTIL "tRACKING SPECIFICATION".NEXT = 0;
                                            "Material Issues Line".DELETE;
                                        UNTIL "Material Issues Line".NEXT = 0;
                                END ELSE
                                    ERROR('YOU DONT HAVE SUFFCIENT RIGHTS');
                            END;
                        end;
                    }
                    field(Excel; excel)
                    {
                        ApplicationArea = All;
                    }
                    field("Verify Already Posted Requests"; "Verify Requests")
                    {
                        ApplicationArea = All;
                    }
                    field("Enter The Item No..."; Del_Item)
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

    trigger OnPostReport()
    begin
        /*
        IF excel THEN BEGIN
         TempExcelbuffer.CreateBook('Stock');//B2b
         TempExcelbuffer.WriteSheet('Stock',COMPANYNAME,USERID);
         TempExcelbuffer.OpenExcel;
         TempExcelbuffer.CloseBook;
         //TempExcelbuffer.CreateSheet('Stock','',COMPANYNAME,'');//B2B
         TempExcelbuffer.GiveUserControl;
        
        END;
        */

        //ADSK
        IF excel THEN BEGIN
            TempExcelbuffer.CreateBookAndOpenExcel('', 'Stock', 'Stock', COMPANYNAME, USERID); //EFFUPG
        END;
        //ADSK

    end;

    trigger OnPreReport()
    begin
        IF excel THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;
    end;

    var
        MIL: Record "Material Issues Line";
        QTY: Decimal;
        Reason: Code[30];
        sno: Integer;
        Tot_Qty: Decimal;
        Item: Record Item;
        Tot_Pending_Qty: Decimal;
        Choice: Option Prod,Sale,Del;
        Total_Pending_Value: Decimal;
        UC: Decimal;
        Pending_value: Decimal;
        "Prod.Order": Text[100];
        RD: Decimal;
        STr: Decimal;
        Cs: Decimal;
        TempExcelbuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        excel: Boolean;
        Del_Item: Code[20];
        "tRACKING SPECIFICATION": Record "Mat.Issue Track. Specification";
        "Verify Requests": Boolean;
        Item_Wise_Issues_PendingCaptionLbl: Label 'Item Wise Issues Pending';
        Page_No___CaptionLbl: Label 'Page No. :';
        Project_CodeCaptionLbl: Label 'Project Code';
        Req_NoCaptionLbl: Label 'Req No';
        Employee_NameCaptionLbl: Label 'Employee Name';
        Requested_dateCaptionLbl: Label 'Requested date';
        DepartmentCaptionLbl: Label 'Department';
        Requested_QuantityCaptionLbl: Label 'Requested Quantity';
        Qty__to_Receive_CaptionLbl: Label 'Qty. to Receive ';
        DescriptionCaptionLbl: Label 'Description';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        UOMCaptionLbl: Label 'UOM';
        Sale_Order_Wise_Issues_PendingCaptionLbl: Label 'Sale Order Wise Issues Pending';
        Page_No___Caption_Control1102154008Lbl: Label 'Page No. :';
        UOMCaption_Control1102154028Lbl: Label 'UOM';
        Pending_QuantityCaptionLbl: Label 'Pending Quantity';
        Production_OrdersCaptionLbl: Label 'Production Orders';
        STRCaptionLbl: Label 'STR';
        R_DCaptionLbl: Label 'R&D';
        CSCaptionLbl: Label 'CS';
        S_NoCaptionLbl: Label 'S.No';
        DeleteRejectedMaterial: Boolean;
        MILBody1: Boolean;
        RecVisibility: Boolean;
        Prev_ItemNo: Code[20];
        MILFOOT4: Boolean;
        Prev_ProdOrderNo: Integer;
        Quantity_to_receive: Decimal;
        cost: Decimal;


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;
        TempExcelbuffer."Cell Type" := CellType;

        TempExcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;
        TempExcelbuffer."Cell Type" := CellType;

        TempExcelbuffer.Formula := '';
        TempExcelbuffer.INSERT;
    end;


    procedure "Entercell New"()
    begin
    end;
}

