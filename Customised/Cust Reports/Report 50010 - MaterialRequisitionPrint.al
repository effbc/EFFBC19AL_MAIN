report 50010 "Material Requisition Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MaterialRequisitionPrint.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Material Issues Header"; "Material Issues Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code", "Prod. Order No.", "Prod. Order Line No.", "Prod. BOM No.", "Posting Date";
            RequestFilterHeading = 'Material Issue';
            column(CURRENTDATETIME_Control1000000106; CURRENTDATETIME)
            {
            }
            column(ISSUE_DATE___TIMECaption; ISSUE_DATE___TIMECaptionLbl)
            {
            }
            column(Codes; Codes)
            {
            }
            column(PROJECT_CODESCaption; PROJECT_CODESCaptionLbl)
            {
            }
            column(DESCRIPTION_2Caption; DESCRIPTION_2CaptionLbl)
            {
            }
            column(TOCaption; TOCaptionLbl)
            {
            }
            column(PRODUCTION_ORDERSCaption; PRODUCTION_ORDERSCaptionLbl)
            {
            }
            column(SER_NO_Caption_Control1000000079; SER_NO_Caption_Control1000000079Lbl)
            {
            }
            column(LOT_NOCaption; LOT_NOCaptionLbl)
            {
            }
            column(ITEMCaption_Control1000000082; ITEMCaption_Control1000000082Lbl)
            {
            }
            column(QTY_SET_Caption; QTY_SET_CaptionLbl)
            {
            }
            column(UOMCaption_Control1000000127; UOMCaption_Control1000000127Lbl)
            {
            }
            column(QTYCaption; QTYCaptionLbl)
            {
            }
            column(REQUEST_BYCaption; REQUEST_BYCaptionLbl)
            {
            }
            column(REQUEST_DATE___TIMECaption; REQUEST_DATE___TIMECaptionLbl)
            {
            }
            column(DEPT_Caption; DEPT_CaptionLbl)
            {
            }
            column(REQUISATION_SCaption; REQUISATION_SCaptionLbl)
            {
            }
            column(Material_Issues_Head_Choice; Choice)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CURRENTDATETIME; CURRENTDATETIME)
            {
            }
            column(Material_Issues_Header__Material_Issues_Header___Released_Date_; "Material Issues Header"."Released Date")
            {
            }
            column(Material_Issues_Header__Material_Issues_Header___Released_Time_; "Material Issues Header"."Released Time")
            {
            }
            column(Material_Issues_Header__Material_Issues_Header___Posting_Date_; "Material Issues Header"."Posting Date")
            {
            }
            column(LocationsCode; LocationsCode)
            {
            }
            column(COMPANYNAME_Control1102154043; COMPANYNAME)
            {
            }
            column(CURRENTDATETIME_Control1102154053; CURRENTDATETIME)
            {
            }
            column(Sets_Heading_; "Sets Heading")
            {
            }
            column(Material_Issues_Header__No__; "No.")
            {
            }
            column(Material_Issues_Header__Transfer_from_Code_; "Transfer-from Code")
            {
            }
            column(Material_Issues_Header__Prod__Order_No__; "Prod. Order No.")
            {
            }
            column(Material_Issues_Header__Transfer_to_Code_; "Transfer-to Code")
            {
            }
            column(Material_Issues_Header__Material_Issues_Header___Resource_Name_; "Material Issues Header"."Resource Name")
            {
            }
            column(PCB_description_; "PCB description")
            {
            }
            column(Material_Issues_Header__Material_Issues_Header___User_ID_; "Material Issues Header"."User ID")
            {
            }
            column(Material_RequestCaption; Material_RequestCaptionLbl)
            {
            }
            column(To_Provide_Insight_For_Enhancing_WealthCaption; To_Provide_Insight_For_Enhancing_WealthCaptionLbl)
            {
            }
            column(Released_Date___TimeCaption; Released_Date___TimeCaptionLbl)
            {
            }
            column(To_Provide_Insight_For_Enhancing_WealthCaption_Control1102154046; To_Provide_Insight_For_Enhancing_WealthCaption_Control1102154046Lbl)
            {
            }
            column(Requested__By_Caption; Requested__By_CaptionLbl)
            {
            }
            column(Requisition_NoCaption; Requisition_NoCaptionLbl)
            {
            }
            column(Material_Issues_Header__Transfer_from_Code_Caption; FIELDCAPTION("Transfer-from Code"))
            {
            }
            column(Material_Issues_Header__Prod__Order_No__Caption; FIELDCAPTION("Prod. Order No."))
            {
            }
            column(Material_Issues_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
            {
            }
            column(PCB_DescriptionCaption; PCB_DescriptionCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154021; EmptyStringCaption_Control1102154021Lbl)
            {
            }
            dataitem("Material Issues Line"; "Material Issues Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE("Item No." = FILTER(<> ''));
                RequestFilterFields = "Item No.";
                column(MatIssueLineBody4; MatIssueLineBody4)
                {
                }
                column(MatIssueLineBody5; MatIssueLineBody5)
                {
                }
                column(Material_Issues_Line_Qty_to_Receive; "Material Issues Line"."Qty. to Receive")
                {
                }
                column(Material_Issue_Line_CS; CS)
                {
                }
                column(Material_Issues_Line__Material_Issues_Line__Quantity; "Material Issues Line".Quantity)
                {
                }
                column(Material_Issues_Line__Material_Issues_Line___Unit_of_Measure_Code_; "Material Issues Line"."Unit of Measure Code")
                {
                }
                column(rem; rem)
                {
                }
                column(Desc2; Desc2)
                {
                }
                column(desc1; desc1)
                {
                }
                column(desc1_Control1102152034; desc1)
                {
                }
                column(Material_Issues_Line__Material_Issues_Line__Quantity_Control1102152035; "Material Issues Line".Quantity)
                {
                }
                column(rem_Control1102152047; rem)
                {
                }
                column(Material_Issues_Header___Resource_Name_; "Material Issues Header"."Resource Name")
                {
                }
                column(Username; Username)
                {
                }
                column(Shortage_Items; Shortage_Items)
                {
                }
                column(Item_Count; Item_Count)
                {
                }
                column(Item_Count_Shortage_Items; Item_Count - Shortage_Items)
                {
                }
                column(ITEMCaption; ITEMCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(QUANTITY_ISSUEDCaption; QUANTITY_ISSUEDCaptionLbl)
                {
                }
                column(QUANTITYCaption; QUANTITYCaptionLbl)
                {
                }
                column(SER_NO_Caption; SER_NO_CaptionLbl)
                {
                }
                column(LOT_NO_Caption; LOT_NO_CaptionLbl)
                {
                }
                column(REMAINING_QTY__Caption; REMAINING_QTY__CaptionLbl)
                {
                }
                column(DESCRIPTION2Caption; DESCRIPTION2CaptionLbl)
                {
                }
                column(ITEMCaption_Control1102152001; ITEMCaption_Control1102152001Lbl)
                {
                }
                column(QUANTITYCaption_Control1102152004; QUANTITYCaption_Control1102152004Lbl)
                {
                }
                column(QUANTITY_ISSUEDCaption_Control1102152005; QUANTITY_ISSUEDCaption_Control1102152005Lbl)
                {
                }
                column(REMAINING_QTY__Caption_Control1102152006; REMAINING_QTY__Caption_Control1102152006Lbl)
                {
                }
                column(LOT_NO_Caption_Control1102152007; LOT_NO_Caption_Control1102152007Lbl)
                {
                }
                column(SER_NO_Caption_Control1102152008; SER_NO_Caption_Control1102152008Lbl)
                {
                }
                column(USED_InCaption; USED_InCaptionLbl)
                {
                }
                column(USED_InCaption_Control1102152036; USED_InCaption_Control1102152036Lbl)
                {
                }
                column(USED_InCaption_Control1102152037; USED_InCaption_Control1102152037Lbl)
                {
                }
                column(ITEMCaption_Control1000000017; ITEMCaption_Control1000000017Lbl)
                {
                }
                column(UOMCaption_Control1000000019; UOMCaption_Control1000000019Lbl)
                {
                }
                column(SER_NO_Caption_Control1000000004; SER_NO_Caption_Control1000000004Lbl)
                {
                }
                column(LOT_NO_Caption_Control1000000059; LOT_NO_Caption_Control1000000059Lbl)
                {
                }
                column(QUANTITY_ISSUEDCaption_Control1102154016; QUANTITY_ISSUEDCaption_Control1102154016Lbl)
                {
                }
                column(QUANTITYCaption_Control1102154087; QUANTITYCaption_Control1102154087Lbl)
                {
                }
                column(REMAINING_QTY__Caption_Control1102154088; REMAINING_QTY__Caption_Control1102154088Lbl)
                {
                }
                column(DESCRIPTION2Caption_Control1102154006; DESCRIPTION2Caption_Control1102154006Lbl)
                {
                }
                column(Authorised_ByCaption; Authorised_ByCaptionLbl)
                {
                }
                column(Received_byCaption; Received_byCaptionLbl)
                {
                }
                column(Issued_ByCaption; Issued_ByCaptionLbl)
                {
                }
                column(Shortage_ItemsCaption; Shortage_ItemsCaptionLbl)
                {
                }
                column(Issued_itemsCaption; Issued_itemsCaptionLbl)
                {
                }
                column(Total_ItemsCaption; Total_ItemsCaptionLbl)
                {
                }
                column(Issued_Date_Time_Caption; Issued_Date_Time_CaptionLbl)
                {
                }
                column(Material_Issues_Line_Document_No_; "Document No.")
                {
                }
                column(Material_Issues_Line_Line_No_; "Line No.")
                {
                }
                column(Material_Issues_Line_Item_No_; "Item No.")
                {
                }
                column(BINAddress; BINAddress)
                {
                }
                dataitem("Mat.Issue Track. Specification"; "Mat.Issue Track. Specification")
                {
                    DataItemLink = "Order No." = FIELD("Document No."), "Order Line No." = FIELD("Line No."), "Item No." = FIELD("Item No.");
                    DataItemTableView = SORTING("Order No.", "Order Line No.", "Item No.", "Location Code", "Lot No.", "Serial No.", "Appl.-to Item Entry");
                    column(MatIssueSpecBody1; MatIssueSpecBody1)
                    {
                    }
                    column(MatIssueSpecBody2; MatIssueSpecBody2)
                    {
                    }
                    column(MatIssueSpecBody3; MatIssueSpecBody3)
                    {
                    }
                    column(MatIssueSpecBody4; MatIssueSpecBody4)
                    {
                    }
                    column(Mat_Issue_Track_Spec_Choice; Choice)
                    {
                    }
                    column(Mat_Issue_Track_Specification_COUNT; "Mat.Issue Track. Specification".COUNT)
                    {
                    }
                    column(Mat_Issue_Track_Specification_RPT; RPT)
                    {
                    }
                    column(Mat_Issue_Track_Specification_CS; CS)
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Serial_No__; "Mat.Issue Track. Specification"."Serial No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Lot_No__; "Mat.Issue Track. Specification"."Lot No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification__Quantity; "Mat.Issue Track. Specification".Quantity)
                    {
                    }
                    column(Material_Issues_Line__Quantity; "Material Issues Line".Quantity)
                    {
                    }
                    column(Material_Issues_Line___Unit_of_Measure_Code_; "Material Issues Line"."Unit of Measure Code")
                    {
                    }
                    column(rem_Control1102154001; rem)
                    {
                    }
                    column(Desc2_Control1102154009; Desc2)
                    {
                    }
                    column(desc1_Control1102154012; desc1)
                    {
                    }
                    column(desc1_Control1102152009; desc1)
                    {
                    }
                    column(Material_Issues_Line__Quantity_Control1102152011; "Material Issues Line".Quantity)
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification__Quantity_Control1102152012; "Mat.Issue Track. Specification".Quantity)
                    {
                    }
                    column(rem_Control1102152013; rem)
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Lot_No___Control1102152014; "Mat.Issue Track. Specification"."Lot No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Serial_No___Control1102152015; "Mat.Issue Track. Specification"."Serial No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Serial_No___Control1000000061; "Mat.Issue Track. Specification"."Serial No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Lot_No___Control1000000060; "Mat.Issue Track. Specification"."Lot No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification__Quantity_Control1102154079; "Mat.Issue Track. Specification".Quantity)
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification__Quantity_Control1102152002; "Mat.Issue Track. Specification".Quantity)
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Lot_No___Control1102152003; "Mat.Issue Track. Specification"."Lot No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification__Mat_Issue_Track__Specification___Serial_No___Control1102152010; "Mat.Issue Track. Specification"."Serial No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification_Order_No_; "Order No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification_Order_Line_No_; "Order Line No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification_Item_No_; "Item No.")
                    {
                    }
                    column(Mat_Issue_Track__Specification_Location_Code; "Location Code")
                    {
                    }
                    column(Mat_Issue_Track__Specification_Appl__to_Item_Entry; "Appl.-to Item Entry")
                    {
                    }
                    column(BINAddressTracking; BINAddressTracking)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        //Rev01 Start
                        MatIssueSpecBody1 := TRUE;
                        MatIssueSpecBody2 := TRUE;
                        MatIssueSpecBody3 := TRUE;
                        MatIssueSpecBody4 := TRUE;
                        BINAddressTracking := '';
                        //Mat.Issue Track. Specification, Body (1) - OnPreSection() >>

                        IF (Choice = Choice::Req) AND ("Material Issues Line"."Qty. to Receive" > 0) AND (CS = FALSE) THEN BEGIN
                            desc1 := "Material Issues Line".Description;
                            Desc2 := "Material Issues Line"."Description 2";

                            item.SETRANGE(item."No.", "Material Issues Line"."Item No.");

                            BEGIN
                                IF item.FIND('-') THEN
                                    // shelf:=item."Shelf No.";
                                    SLNO += 1;
                            END;

                            RPT := FALSE;

                            IF "Material Issues Line".Quantity = "Material Issues Line"."Quantity Received" THEN
                                rem := ''
                            ELSE
                                IF ("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received") > 0 THEN
                                    rem := FORMAT("Material Issues Line".Quantity - ("Material Issues Line"."Quantity Received" + "Material Issues Line"."Qty. to Receive (Base)"));

                            item.RESET;
                            IF item.GET("Material Issues Line"."Item No.") THEN BEGIN
                                Desc2 := item."Description 2";
                                BINAddressTracking := item."BIN Address";
                            END;

                            IF Previous = "Material Issues Line"."Item No." THEN BEGIN
                                RPT := TRUE;
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                MatIssueSpecBody1 := FALSE;
                            END ELSE
                                Previous := "Material Issues Line"."Item No.";
                        END ELSE
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            MatIssueSpecBody1 := FALSE;
                        //Mat.Issue Track. Specification, Body (1) - OnPreSection() <<


                        //Mat.Issue Track. Specification, Body (2) - OnPreSection() >>
                        IF (Choice = Choice::Req) AND ("Material Issues Line"."Qty. to Receive" > 0) AND (CS = TRUE) THEN BEGIN
                            desc1 := "Material Issues Line".Description;
                            Desc2 := "Material Issues Line"."Description 2";

                            item.SETRANGE(item."No.", "Material Issues Line"."Item No.");

                            BEGIN
                                IF item.FIND('-') THEN
                                    //shelf:=item."Shelf No.";
                                    SLNO += 1;
                            END;
                            RPT := FALSE;

                            IF "Material Issues Line".Quantity = "Material Issues Line"."Quantity Received" THEN
                                rem := ''
                            ELSE
                                IF ("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received") > 0 THEN
                                    rem := FORMAT("Material Issues Line".Quantity - ("Material Issues Line"."Quantity Received" + "Material Issues Line"."Qty. to Receive (Base)"));

                            item.RESET;
                            IF item.GET("Material Issues Line"."Item No.") THEN BEGIN
                                Desc2 := item."Description 2";
                                BINAddressTracking := item."BIN Address";
                            END;

                            IF Previous = "Material Issues Line"."Item No." THEN BEGIN
                                RPT := TRUE;
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                MatIssueSpecBody2 := FALSE;
                            END ELSE
                                Previous := "Material Issues Line"."Item No.";
                        END ELSE
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            MatIssueSpecBody2 := FALSE;
                        //Mat.Issue Track. Specification, Body (2) - OnPreSection() <<


                        //Mat.Issue Track. Specification, Body (3) - OnPreSection() >>
                        IF ("Mat.Issue Track. Specification".COUNT > 1) AND (RPT) AND (CS = FALSE) THEN BEGIN
                        END ELSE
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            MatIssueSpecBody3 := FALSE;
                        //Mat.Issue Track. Specification, Body (3) - OnPreSection() <<


                        //Mat.Issue Track. Specification, Body (4) - OnPreSection() >>
                        IF ("Mat.Issue Track. Specification".COUNT > 1) AND (RPT) AND (CS = TRUE) THEN BEGIN
                        END ELSE
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            MatIssueSpecBody4 := FALSE;
                        //Mat.Issue Track. Specification, Body (4) - OnPreSection() <<

                        //Material Issues Line, Footer (7) - OnPreSection() >>
                        //CurrReport.SHOWOUTPUT(Choice=Choice::Req);
                        /*
                        IF User.GET(userid) THEN BEGIN
                          Username := User.Name;
                        END;
                        */
                        IF User.GET(USERSECURITYID) THEN BEGIN
                            Username := User."User Name";
                        END;
                        //Material Issues Line, Footer (7) - OnPreSection() <<

                        //Rev01 End

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    //  SLNO := SLNO+1;


                    /*ReservationEntry.SETRANGE("Source Type",DATABASE::"Item Journal Line");
                    ReservationEntry.SETRANGE("Source ID",'Transfer');
                    ReservationEntry.SETRANGE("Source Ref. No.","Line No.");
                    IF ReservationEntry.FIND('-') THEN;*/

                    // Material Issues Line, Header (1) - OnPreSection() >>
                    LOT := '';
                    SERIAL := '';
                    CurrReport.SHOWOUTPUT((Choice = Choice::Req) AND (CS = FALSE));
                    // Material Issues Line, Header (1) - OnPreSection() <<

                    // Material Issues Line, Header (2) - OnPreSection() >>
                    LOT := '';
                    SERIAL := '';
                    CurrReport.SHOWOUTPUT((Choice = Choice::Req) AND (CS = TRUE));
                    // Material Issues Line, Header (2) - OnPreSection() <<

                    //Material Issues Line, TransHeader (3) - OnPreSection()
                    LOT := '';
                    SERIAL := '';
                    CurrReport.SHOWOUTPUT(Choice = Choice::Req);
                    //Material Issues Line, TransHeader (3) - OnPreSection()


                    // Material Issues Line, Body (4) - OnPreSection() >>
                    MatIssueLineBody4 := TRUE;
                    IF CS = TRUE THEN
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        MatIssueLineBody4 := FALSE;

                    IF "Material Issues Line".Quantity = "Material Issues Line"."Quantity Received" THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        MatIssueLineBody4 := FALSE;
                    END ELSE BEGIN
                        //MatIssueLineBody4 := TRUE;
                        MTS.SETRANGE(MTS."Order No.", "Material Issues Header"."No.");
                        MTS.SETRANGE(MTS."Order Line No.", "Material Issues Line"."Line No.");
                        IF MTS.FIND('-') THEN
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            MatIssueLineBody4 := FALSE;

                        item.RESET;
                        IF item.GET("Material Issues Line"."Item No.") THEN BEGIN
                            desc1 := item.Description;
                            Desc2 := item."Description 2";
                            BINAddress := '';
                            BINAddress := item."BIN Address";
                        END;

                        IF ("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received") > 0 THEN
                            rem := FORMAT("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received")
                        ELSE
                            rem := '';
                    END;
                    // Material Issues Line, Body (4) - OnPreSection() <<



                    // Material Issues Line, Body (5) - OnPreSection() >>

                    MatIssueLineBody5 := TRUE;
                    IF CS = FALSE THEN
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        MatIssueLineBody5 := FALSE;

                    IF "Material Issues Line".Quantity = "Material Issues Line"."Quantity Received" THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        MatIssueLineBody5 := FALSE;
                    END ELSE BEGIN
                        //MatIssueLineBody5 := TRUE;
                        MTS.SETRANGE(MTS."Order No.", "Material Issues Header"."No.");
                        MTS.SETRANGE(MTS."Order Line No.", "Material Issues Line"."Line No.");
                        IF MTS.FIND('-') THEN
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            MatIssueLineBody5 := FALSE;

                        item.RESET;
                        IF item.GET("Material Issues Line"."Item No.") THEN BEGIN
                            desc1 := item.Description;
                            Desc2 := item."Description 2";
                        END;

                        IF ("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received") > 0 THEN
                            rem := FORMAT("Material Issues Line".Quantity - "Material Issues Line"."Quantity Received")
                        ELSE
                            rem := '';
                    END;
                    // Material Issues Line, Body (5) - OnPreSection() <<

                end;

                trigger OnPreDataItem()
                begin
                    SLNO := 0;
                    IF Choice <> Choice::Req THEN
                        CurrReport.BREAK;
                    Item_Count := "Material Issues Line".COUNT;
                    /* "Material Issues Line".SETRANGE("Material Issues Line"."Qty. to Receive",0);
                     Shortage_Items:= "Material Issues Line".COUNT;
                     "Material Issues Line".RESET; */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF First THEN BEGIN
                    "order no's" += FORMAT("Material Issues Header"."No.") + '..';
                    First := FALSE;
                END;
                coun := coun + 1;
                Pol.SETRANGE(Pol."Prod. Order No.", "Material Issues Header"."Prod. Order No.");
                Pol.SETRANGE(Pol."Line No.", "Material Issues Header"."Prod. Order Line No.");
                IF Pol.FIND('-') THEN
                    "PCB description" := Pol.Description;
                LOT := '';

                // Material Issues Header, Header (1) - OnPreSection() >>
                //CurrReport.SHOWOUTPUT(Choice=Choice::Req);
                // Material Issues Header, Header (1) - OnPreSection() <<

                // Material Issues Header, Header (2) - OnPreSection() >>
                //CurrReport.SHOWOUTPUT(Choice=Choice::Set);
                Pol.RESET;
                Pol.SETRANGE(Pol."Prod. Order No.", "Material Issues Header"."Prod. Order No.");
                Pol.SETRANGE(Pol."Line No.", "Material Issues Header"."Prod. Order Line No.");
                IF Pol.FIND('-') THEN
                    "Sets Heading" := '"' + Pol.Description + '"' + '-' + FORMAT("Material Issues Header".COUNT) + ' Sets Material';
                // Material Issues Header, Header (2) - OnPreSection() <<

                // Material Issues Header, Header (3) - OnPostSection() >>
                IF Choice = Choice::Req THEN BEGIN
                    // >>Added by Pranavi on 29-07-2017 for not allowing print for cs site material
                    IF ("Material Issues Header"."Transfer-to Code" = 'SITE') AND ("Material Issues Header"."Transfer-from Code" <> 'CS') THEN
                        ERROR('Print not allowed for SITE material!\You Should Post & Print!');
                    //<<
                    //Added by Pranavi on 23-08-2015 for posting date mandatory for cs str to site print as it is needed at manual DC at CST
                    IF ("Material Issues Header"."Transfer-from Code" = 'CS STR') AND ("Material Issues Header"."Transfer-to Code" = 'SITE')
                       AND (FORMAT("Material Issues Header"."Posting Date") = '') THEN
                        ERROR('Please select Posting Date!\As it is required while DC at CS');
                    //End by Pranavi
                    Pol.RESET;
                    Pol.SETRANGE(Pol."Prod. Order No.", "Material Issues Header"."Prod. Order No.");
                    Pol.SETRANGE(Pol."Line No.", "Material Issues Header"."Prod. Order Line No.");
                    IF Pol.FIND('-') THEN
                        "PCB description" := Pol.Description;
                END;
                LocationsCode := '';
                dimValue.RESET;
                dimValue.SETFILTER(dimValue.Code, "Material Issues Header"."Shortcut Dimension 2 Code");
                IF dimValue.FINDFIRST THEN
                    LocationsCode := dimValue.Name;

                //END ELSE
                //CurrReport.SHOWOUTPUT:=FALSE;
                // Material Issues Header, Header (3) - OnPostSection() <<
            end;

            trigger OnPostDataItem()
            begin
                "order no's" += FORMAT("Material Issues Header"."No.");
            end;

            trigger OnPreDataItem()
            begin
                /* CompanyInfo.GET();
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                  IF CompanyInfo.FIND('-') THEN
                  CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                
                */

                First := TRUE;

            end;
        }
        dataitem(MTS1; "Mat.Issue Track. Specification")
        {
            DataItemTableView = SORTING("Item No.", "Lot No.", "Order No.");
            RequestFilterFields = "Lot No.";
            column(MTS1_Material_Issues_Header__No__; "Material Issues Header"."No.")
            {
            }
            column(MTS1_SER_LEN; SER_LEN)
            {
            }
            column(MTS1_Choice; Choice)
            {
            }
            column(order_no_s_; "order no's")
            {
            }
            column(Material_Issues_Header___Resource_Name__Control1000000086; "Material Issues Header"."Resource Name")
            {
            }
            column(Material_Issues_Header___Released_Date_; "Material Issues Header"."Released Date")
            {
            }
            column(Material_Issues_Header___Transfer_to_Code_; "Material Issues Header"."Transfer-to Code")
            {
            }
            column(Material_Issues_Header___Released_Time_; "Material Issues Header"."Released Time")
            {
            }
            column(Material_Issues_Header___User_ID_; "Material Issues Header"."User ID")
            {
            }
            column(Material_Issues_Header___Transfer_from_Code_; "Material Issues Header"."Transfer-from Code")
            {
            }
            column(Prod__Orders_; "Prod. Orders")
            {
            }
            column(Ser_No_; "Ser No")
            {
            }
            column(MTS1__Lot_No__; "Lot No.")
            {
            }
            column(MTS1_Quantity; Quantity)
            {
            }
            column(Item_Desc; Item_Desc)
            {
            }
            column(UOM; UOM)
            {
            }
            column(indqty; indqty)
            {
            }
            column(Desc2_Control1102154059; Desc2)
            {
            }
            column(Ser_No__Control1102154024; "Ser No")
            {
            }
            column(Prod__Orders__Control1102154025; "Prod. Orders")
            {
            }
            column(MTS1__Lot_No___Control1102154026; "Lot No.")
            {
            }
            column(MTS1_Quantity_Control1102154027; Quantity)
            {
            }
            column(Item_Desc_Control1102154028; Item_Desc)
            {
            }
            column(UOM_Control1102154036; UOM)
            {
            }
            column(indqty_Control1102154037; indqty)
            {
            }
            column(Desc2_Control1102154060; Desc2)
            {
            }
            column(Item_Count_Control1102154050; Item_Count)
            {
            }
            column(Shortage_Items_Control1102154051; Shortage_Items)
            {
            }
            column(Item_Count_Control1102154052; Item_Count)
            {
            }
            column(EmptyStringCaption_Control1102154062; EmptyStringCaption_Control1102154062Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154063; EmptyStringCaption_Control1102154063Lbl)
            {
            }
            column(MTS1_Order_No_; "Order No.")
            {
            }
            column(MTS1_Order_Line_No_; "Order Line No.")
            {
            }
            column(MTS1_Item_No_; "Item No.")
            {
            }
            column(MTS1_Location_Code; "Location Code")
            {
            }
            column(MTS1_Serial_No_; "Serial No.")
            {
            }
            column(MTS1_Appl__to_Item_Entry; "Appl.-to Item Entry")
            {
            }
            column(TOTAL_ITEMSCaption_Control1102154049; TOTAL_ITEMSCaption_Control1102154049Lbl)
            {
            }
            column(Issued_itemsCaption_Control1102154040; Issued_itemsCaption_Control1102154040Lbl)
            {
            }
            column(Shortage_ItemsCaption_Control1102154048; Shortage_ItemsCaption_Control1102154048Lbl)
            {
            }
            column(Received_By_Caption; Received_By_CaptionLbl)
            {
            }
            column(Issuesd_By__Caption; Issuesd_By__CaptionLbl)
            {
            }
            column(Issued_Date_Time_Caption_Control1102154045; Issued_Date_Time_Caption_Control1102154045Lbl)
            {
            }
            column(BINAddressSets; BINAddressSets)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TEMP := MTS1."Lot No.";
                BINAddressSets := '';

                /*
                NextMatIssTrSpecGRec.RESET;
                NextMatIssTrSpecGRec.SETCURRENTKEY("Item No.","Lot No.","Order No.");
                NextMatIssTrSpecGRec.GET(MTS1."Order No.",MTS1."Order Line No.",MTS1."Item No.",MTS1."Location Code",MTS1."Lot No.",MTS1."Serial No.",MTS1."Appl.-to Item Entry");
                */
                /*
                NextMatIssTrSpecGRec.SETRANGE("Item No.",MTS1."Item No.");
                NextMatIssTrSpecGRec.SETFILTER("Lot No. 1",'=%1',MTS1."Lot No. 1");
                NextMatIssTrSpecGRec.SETRANGE("Order No.",MTS1."Order No.");
                NextMatIssTrSpecGRec.SETRANGE("Order Line No.",MTS1."Order Line No.");
                NextMatIssTrSpecGRec.SETRANGE("Location Code",MTS1."Location Code");
                NextMatIssTrSpecGRec.SETRANGE("Serial No. 1",MTS1."Serial No. 1");
                NextMatIssTrSpecGRec.SETRANGE("Appl.-to Item Entry",MTS1."Appl.-to Item Entry");
                //NextMatIssTrSpecGRec.SETFILTER("Lot No.",MTS1."Lot No.");
                NextMatIssTrSpecGRec.FINDFIRST;
                
                NextMatIssTrSpecGRec.NEXT;
                
                */

                NextMatIssTrSpecGRec.RESET;
                NextMatIssTrSpecGRec.SETCURRENTKEY("Item No.", "Lot No.", "Order No.");
                NextMatIssTrSpecGRec.SETRANGE("Item No.", MTS1."Item No.");
                NextMatIssTrSpecGRec.SETFILTER("Lot No.", '=%1', MTS1."Lot No.");
                NextMatIssTrSpecGRec.SETRANGE("Order No.", MTS1."Order No.");
                NextMatIssTrSpecGRec.SETRANGE("Order Line No.", MTS1."Order Line No.");
                NextMatIssTrSpecGRec.SETRANGE("Location Code", MTS1."Location Code");
                NextMatIssTrSpecGRec.SETRANGE("Serial No.", MTS1."Serial No.");
                NextMatIssTrSpecGRec.SETRANGE("Appl.-to Item Entry", MTS1."Appl.-to Item Entry");

                NextMatIssTrSpecGRec.NEXT;


                IF LOT1 = '' THEN
                    LOT1 := MTS1."Lot No."
                ELSE
                    IF LOT1 <> MTS1."Lot No." THEN BEGIN
                        LOT1 := MTS1."Lot No.";
                        "Prod. Orders" := '';
                        "Ser No" := '';
                    END;

                IF Item_Temp <> MTS1."Item No." THEN BEGIN
                    Item_Temp := MTS1."Item No.";
                    Item_Count += 1;
                END;

                //Rev01 Start



                //MTS1, Header (1) - OnPreSection()
                //IF Choice<>Choice::Set THEN
                //CurrReport.SHOWOUTPUT:=FALSE;
                //MTS1, Header (1) - OnPreSection()

                //MTS1, Header (2) - OnPreSection()
                //CurrReport.SHOWOUTPUT(Choice<>Choice::Req);
                IF Excel THEN BEGIN
                    EnterHeadings(Row, 1, 'Item', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'Shelf No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Quantity', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Quantity (Set)', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Unit Of Measure', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Item Category', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Lot No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Serial No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Production Orders', TRUE, TempExcelbuffer."Cell Type"::Text);
                END;
                //MTS1, Header (2) - OnPreSection()

                //MTS1, GroupHeader (3) - OnPreSection()
                IF PrevLotNo <> MTS1."Lot No." THEN BEGIN
                    AR_LEN := 1;
                    FOR i := 1 TO 20 DO
                        PRD_AR[i] := ' ';
                END;
                //MTS1, GroupHeader (3) - OnPreSection()

                //MTS1, Body (4) - OnPreSection()
                IF Choice <> Choice::Req THEN BEGIN
                    MIH.SETRANGE(MIH."No.", MTS1."Order No.");
                    IF MIH.FIND('-') THEN BEGIN
                        IF item.GET(MTS1."Item No.") THEN BEGIN
                            UOM := item."Sales Unit of Measure";
                            //shelf:=item."Shelf No.";
                            IF item."product group code cust" = 'PCB' THEN BEGIN
                                Available := FALSE;
                                IF AR_LEN = 1 THEN BEGIN
                                    PRD_AR[AR_LEN] := FORMAT(MIH."Prod. Order No.");
                                    AR_LEN += 1;
                                END ELSE BEGIN
                                    FOR i := 1 TO AR_LEN DO BEGIN
                                        IF PRD_AR[i] = MIH."Prod. Order No." THEN
                                            Available := TRUE;
                                    END;

                                    IF NOT Available THEN BEGIN
                                        AR_LEN += 1;
                                        PRD_AR[AR_LEN] := FORMAT(MIH."Prod. Order No.");
                                    END;
                                END;
                                "Ser No" := FORMAT(MTS1."Serial No.") + ',';
                            END;
                        END;
                    END;
                    //CurrReport.SHOWOUTPUT(SER_LEN<50);
                    //END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                END;

                //MTS1, Body (4) - OnPreSection()

                //MTS1, GroupFooter (5) - OnPreSection()
                //CurrReport.SHOWOUTPUT(Choice<>Choice::Req);
                CLEAR(GroupQty);
                IF MTS1."Lot No." <> NextMatIssTrSpecGRec."Lot No." THEN BEGIN
                    IF item.GET(MTS1."Item No.") THEN BEGIN
                        BEGIN
                            Item_Desc := item.Description;
                            BINAddressSets := item."BIN Address";
                        END;

                        IF Item_Temp <> Item_Desc THEN
                            Item_Temp := Item_Desc
                        ELSE
                            Item_Desc := '';

                        indqty := MTS1.Quantity / coun;

                        item.RESET;
                        IF item.GET("Material Issues Line"."Item No.") THEN BEGIN
                            Desc2 := item."Description 2";
                            BINAddressSets := item."BIN Address";
                        END;

                        IF item."Item Tracking Code" = 'LOTSERIAL' THEN BEGIN
                            FOR i := 1 TO AR_LEN DO
                                "Prod. Orders" += PRD_AR[i] + ' ';
                        END;

                        SER_LEN := STRLEN("Prod. Orders");

                        GroupQty += MTS1.Quantity;

                        IF (SER_LEN < 15) AND Excel THEN BEGIN
                            Row += 1;
                            Entercell(Row, 1, item.Description, FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 2, shelf, FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 3, FORMAT(MTS1.Quantity), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 4, FORMAT(indqty), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 5, item."Base Unit of Measure", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 6, item."Product Group Code Cust", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 7, MTS1."Lot No.", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 8, "Ser No", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 9, "Prod. Orders", FALSE, TempExcelbuffer."Cell Type"::Number);
                        END;
                    END;
                END;
                //CurrReport.SHOWOUTPUT(SER_LEN<15);


                //MTS1, GroupFooter (5) - OnPreSection()

                //MTS1, GroupFooter (6) - OnPreSection()
                //CurrReport.SHOWOUTPUT(SER_LEN>15);
                IF MTS1."Lot No." <> NextMatIssTrSpecGRec."Lot No." THEN BEGIN
                    IF (SER_LEN < 15) AND Excel THEN BEGIN
                        item.RESET;
                        IF item.GET("Material Issues Line"."Item No.") THEN BEGIN
                            Desc2 := item."Description 2";
                            BINAddressSets := item."BIN Address";
                        END;

                        IF item.GET(MTS1."Item No.") THEN BEGIN
                            Row += 1;
                            Entercell(Row, 1, item.Description, FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 2, shelf, FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 3, FORMAT(MTS1.Quantity), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 4, FORMAT(indqty), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 5, item."Base Unit of Measure", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 6, item."Product Group Code cust", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 7, MTS1."Lot No.", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 8, "Ser No", FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 9, "Prod. Orders", FALSE, TempExcelbuffer."Cell Type"::Number);
                        END;
                    END;
                END;
                //MTS1, GroupFooter (6) - OnPreSection()

            end;

            trigger OnPreDataItem()
            begin
                IF Choice = Choice::Req THEN
                    CurrReport.BREAK;

                Codes := "Material Issues Header".GETFILTER("Material Issues Header"."Prod. Order No.");

                IF Codes <> '' THEN
                    MTS1.SETFILTER(MTS1."Prod. Order No.", Codes);

                Compound := "Material Issues Header".GETFILTER("Material Issues Header"."Prod. Order Line No.");

                IF Compound <> '' THEN
                    MTS1.SETFILTER(MTS1."Prod. Order Line No.", Compound);

                cnt := MTS1.COUNT;

                Item_Temp := MTS1."Item No.";
                CLEAR(PrevLotNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Choice)
                {
                    field("Select Option"; Choice)
                    {
                        Caption = 'Select Option';
                        ApplicationArea = All;
                    }
                    field(CS; CS)
                    {
                        Caption = 'CS';
                        ApplicationArea = All;
                    }
                    field(Excel; Excel)
                    {
                        Caption = 'Excel';
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
        IF Excel THEN BEGIN
            TempExcelbuffer.CreateBook('Stock', '');//Rev01 //EFFUPG
            TempExcelbuffer.WriteSheet('Stock', COMPANYNAME, USERID);//Rev01
            TempExcelbuffer.CloseBook; //Rev01
            TempExcelbuffer.OpenExcel; //Rev01
            //TempExcelbuffer.GiveUserControl;//Rev01
        END;
    end;

    trigger OnPreReport()
    begin
        IF Excel THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;
    end;

    var
        CompanyInfo: Record "Company Information";
        //FormatAddr: Codeunit 365;
        CompanyAddr: array[8] of Text[50];
        SLNO: Integer;
        Username: Text[50];
        User: Record User;
        desc1: Text[50];
        MTS: Record "Mat.Issue Track. Specification";
        LOT: Text[1000];
        SERIAL: Code[30];
        item: Record Item;
        shelf: Code[30];
        Pol: Record "Prod. Order Line";
        "PCB description": Text[100];
        "Prod. Orders": Text[1000];
        LOT1: Code[20];
        MIH: Record "Material Issues Header";
        TEMP: Text[30];
        "Ser No": Text[100];
        "order no's": Text[1000];
        pos: Integer;
        Item_Desc: Text[30];
        Choice: Option Req,Set;
        cnt: Integer;
        Codes: Text[1000];
        coun: Integer;
        indqty: Decimal;
        Item_Temp: Text[50];
        Item_Count: Integer;
        Compound: Text[1000];
        "Transfer-From Code": Code[30];
        "Transfer-To-Code": Code[30];
        "Posting Date": Text[30];
        Desc2: Text[50];
        SER_LEN: Integer;
        Shortage_Items: Integer;
        First: Boolean;
        "Sets Heading": Text[100];
        UOM: Code[10];
        PRD_AR: array[20] of Code[15];
        AR_LEN: Integer;
        Available: Boolean;
        i: Integer;
        rem: Text[30];
        RPT: Boolean;
        Previous: Code[20];
        TempExcelbuffer: Record "Excel Buffer";
        Row: Integer;
        Excel: Boolean;
        CS: Boolean;
        Material_RequestCaptionLbl: Label 'Material Request';
        To_Provide_Insight_For_Enhancing_WealthCaptionLbl: Label 'To Provide Insight For Enhancing Wealth';
        Released_Date___TimeCaptionLbl: Label 'Released Date & Time';
        To_Provide_Insight_For_Enhancing_WealthCaption_Control1102154046Lbl: Label 'To Provide Insight For Enhancing Wealth';
        Requested__By_CaptionLbl: Label 'Requested  By:';
        Requisition_NoCaptionLbl: Label 'Requisition No';
        PCB_DescriptionCaptionLbl: Label 'PCB Description';
        EmptyStringCaptionLbl: Label ')';
        EmptyStringCaption_Control1102154021Lbl: Label '(';
        ITEMCaptionLbl: Label 'ITEM';
        UOMCaptionLbl: Label 'UOM';
        QUANTITY_ISSUEDCaptionLbl: Label 'QUANTITY ISSUED';
        QUANTITYCaptionLbl: Label 'QUANTITY';
        SER_NO_CaptionLbl: Label 'SER NO.';
        LOT_NO_CaptionLbl: Label 'LOT NO.';
        REMAINING_QTY__CaptionLbl: Label 'REMAINING QTY. ';
        DESCRIPTION2CaptionLbl: Label 'DESCRIPTION2';
        ITEMCaption_Control1102152001Lbl: Label 'ITEM';
        QUANTITYCaption_Control1102152004Lbl: Label 'QUANTITY';
        QUANTITY_ISSUEDCaption_Control1102152005Lbl: Label 'QUANTITY ISSUED';
        REMAINING_QTY__Caption_Control1102152006Lbl: Label 'REMAINING QTY. ';
        LOT_NO_Caption_Control1102152007Lbl: Label 'LOT NO.';
        SER_NO_Caption_Control1102152008Lbl: Label 'SER NO.';
        USED_InCaptionLbl: Label 'USED In';
        USED_InCaption_Control1102152036Lbl: Label 'USED In';
        USED_InCaption_Control1102152037Lbl: Label 'USED In';
        ITEMCaption_Control1000000017Lbl: Label 'ITEM';
        UOMCaption_Control1000000019Lbl: Label 'UOM';
        SER_NO_Caption_Control1000000004Lbl: Label 'SER NO.';
        LOT_NO_Caption_Control1000000059Lbl: Label 'LOT NO.';
        QUANTITY_ISSUEDCaption_Control1102154016Lbl: Label 'QUANTITY ISSUED';
        QUANTITYCaption_Control1102154087Lbl: Label 'QUANTITY';
        REMAINING_QTY__Caption_Control1102154088Lbl: Label 'REMAINING QTY. ';
        DESCRIPTION2Caption_Control1102154006Lbl: Label 'DESCRIPTION2';
        Authorised_ByCaptionLbl: Label 'Authorised By';
        Received_byCaptionLbl: Label 'Received by';
        Issued_ByCaptionLbl: Label 'Issued By';
        Shortage_ItemsCaptionLbl: Label 'Shortage Items';
        Issued_itemsCaptionLbl: Label ' Issued items';
        Total_ItemsCaptionLbl: Label 'Total Items';
        Issued_Date_Time_CaptionLbl: Label 'Issued Date Time:';
        REQUISATION_SCaptionLbl: Label 'REQUISATION''S';
        REQUEST_BYCaptionLbl: Label 'REQUEST BY';
        REQUEST_DATE___TIMECaptionLbl: Label 'REQUEST DATE & TIME';
        DEPT_CaptionLbl: Label 'DEPT:';
        PROJECT_CODESCaptionLbl: Label 'PROJECT CODES';
        ISSUE_DATE___TIMECaptionLbl: Label 'ISSUE DATE & TIME';
        EmptyStringCaption_Control1102154062Lbl: Label '(';
        EmptyStringCaption_Control1102154063Lbl: Label ')';
        TOCaptionLbl: Label 'TO';
        PRODUCTION_ORDERSCaptionLbl: Label 'PRODUCTION ORDERS';
        SER_NO_Caption_Control1000000079Lbl: Label 'SER NO.';
        LOT_NOCaptionLbl: Label 'LOT NO';
        ITEMCaption_Control1000000082Lbl: Label 'ITEM';
        QTY_SET_CaptionLbl: Label 'QTY(SET)';
        UOMCaption_Control1000000127Lbl: Label 'UOM';
        QTYCaptionLbl: Label 'QTY';
        DESCRIPTION_2CaptionLbl: Label 'DESCRIPTION 2';
        Received_By_CaptionLbl: Label 'Received By:';
        Issued_itemsCaption_Control1102154040Lbl: Label ' Issued items';
        Shortage_ItemsCaption_Control1102154048Lbl: Label 'Shortage Items';
        TOTAL_ITEMSCaption_Control1102154049Lbl: Label 'TOTAL ITEMS';
        Issuesd_By__CaptionLbl: Label 'Issuesd By :';
        Issued_Date_Time_Caption_Control1102154045Lbl: Label 'Issued Date Time:';
        MatIssueSpecBody1: Boolean;
        MatIssueSpecBody2: Boolean;
        MatIssueSpecBody3: Boolean;
        MatIssueSpecBody4: Boolean;
        MatIssueLineBody4: Boolean;
        MatIssueLineBody5: Boolean;
        "-Rev01-": Integer;
        PrevLotNo: Code[20];
        NextMatIssTrSpecGRec: Record "Mat.Issue Track. Specification";
        GroupQty: Decimal;
        LocationsCode: Code[100];
        dimValue: Record "Dimension Value";
        BINAddress: Code[30];
        BINAddressTracking: Code[30];
        BINAddressSets: Code[30];


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

