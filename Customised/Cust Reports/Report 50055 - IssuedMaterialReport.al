report 50055 "Issued Material Report"
{
    //      EnterHeadings(Row,21,'Vendor Name',TRUE);
    //      EnterHeadings(Row,22,'Inward Date',TRUE);
    //      EnterHeadings(Row,23,'Purchase Order No.',TRUE);
    //      EnterHeadings(Row,24, 'Vendor Shipment No.',TRUE);
    DefaultLayout = RDLC;
    RDLCLayout = './IssuedMaterialReport.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Posted Material Issues Header"; "Posted Material Issues Header")
        {
            DataItemTableView = SORTING("Prod. Order No.", "Prod. Order Line No.");
            RequestFilterFields = "Material Issue No.", "Posting Date", "Resource Name", "Reason Code", "Transfer-to Code", "Transfer-from Code", "Prod. Order No.", "User ID";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(COMPANYNAME_Control1102154003; COMPANYNAME)
            {
            }
            column(USERID_Control1102154016; USERID)
            {
            }
            column(TODAY_Control1102154017; TODAY)
            {
            }
            column(Posted_Material_Issues_Header__Prod__Order_No__; "Prod. Order No.")
            {
            }
            column(Project_Desc; Project_Desc)
            {
            }
            column(Project_Total_; "Project Total")
            {
            }
            column(R_D_total_; "R&D total")
            {
            }
            column(Total; Total)
            {
            }
            column(Total_Qty; Total_Qty)
            {
            }
            column(Material_IssuesCaption; Material_IssuesCaptionLbl)
            {
            }
            column(Project_CodeCaption; Project_CodeCaptionLbl)
            {
            }
            column(Requisition_NoCaption; Requisition_NoCaptionLbl)
            {
            }
            column(Item_Caption; Item_CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Reqested_DateCaption; Reqested_DateCaptionLbl)
            {
            }
            column(DeptCaption; DeptCaptionLbl)
            {
            }
            column(Quantity_RequestedCaption; Quantity_RequestedCaptionLbl)
            {
            }
            column(Quantity_ReceivedCaption; Quantity_ReceivedCaptionLbl)
            {
            }
            column(Unit_costCaption; Unit_costCaptionLbl)
            {
            }
            column(LOT_No_Caption; LOT_No_CaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(Bench_MarkCaption; Bench_MarkCaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Bill_No_Caption; Bill_No_CaptionLbl)
            {
            }
            column(Bill_DateCaption; Bill_DateCaptionLbl)
            {
            }
            column(Issued_Date_TimeCaption; Issued_Date_TimeCaptionLbl)
            {
            }
            column(Material_IssuesCaption_Control1102154002; Material_IssuesCaption_Control1102154002Lbl)
            {
            }
            column(Project_CodeCaption_Control1102154004; Project_CodeCaption_Control1102154004Lbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(Project_DescriptionCaption; Project_DescriptionCaptionLbl)
            {
            }
            column(Posted_Material_Issues_Header_No_; "No.")
            {
            }
            column(Choice3; Choice3)
            {
            }
            dataitem("Posted Material Issues Line"; "Posted Material Issues Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Item No.") WHERE(Quantity = FILTER(> 0));
                RequestFilterFields = "Item No.";
                column(Posted_Material_Issues_Header___Reason_Code_; "Posted Material Issues Header"."Reason Code")
                {
                }
                column(Posted_Material_Issues_Line__Material_Issue_No__; "Material Issue No.")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Description; "Posted Material Issues Line".Description)
                {
                }
                column(Posted_Material_Issues_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Posted_Material_Issues_Header___Resource_Name_; "Posted Material Issues Header"."Resource Name")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Issued_DateTime_; "Posted Material Issues Line"."Issued DateTime")
                {
                }
                column(Posted_Material_Issues_Header___Transfer_from_Code_; "Posted Material Issues Header"."Transfer-from Code")
                {
                }
                column(QTY; QTY)
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Quantity; "Posted Material Issues Line".Quantity)
                {
                }
                column(UC; UC)
                {
                }
                column(Posted_Material_Issues_Header___Released_Date_; "Posted Material Issues Header"."Released Date")
                {
                }
                column(Lot; Lot)
                {
                }
                column(Serial_no_; "Serial no")
                {
                }
                column(Bench_Mark_; "Bench-Mark")
                {
                }
                column(Reason; Reason)
                {
                }
                column(Posted_Material_Issues_Line__Material_Issue_No___Control1000000025; "Material Issue No.")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Description_Control1000000026; "Posted Material Issues Line".Description)
                {
                }
                column(Posted_Material_Issues_Line__Unit_of_Measure__Control1000000027; "Unit of Measure")
                {
                }
                column(Posted_Material_Issues_Header___Resource_Name__Control1000000028; "Posted Material Issues Header"."Resource Name")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Issued_DateTime__Control1000000029; "Posted Material Issues Line"."Issued DateTime")
                {
                }
                column(Posted_Material_Issues_Line__Transfer_to_Code_; "Transfer-to Code")
                {
                }
                column(QTY_Control1000000031; QTY)
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Quantity_Control1000000032; "Posted Material Issues Line".Quantity)
                {
                }
                column(UC_Control1000000033; UC)
                {
                }
                column(Posted_Material_Issues_Header___Released_Date__Control1000000036; "Posted Material Issues Header"."Released Date")
                {
                }
                column(Lot_Control1000000041; Lot)
                {
                }
                column(Serial_no__Control1000000042; "Serial no")
                {
                }
                column(Bench_Mark__Control1102154010; "Bench-Mark")
                {
                }
                column(Reason_Control1000000054; Reason)
                {
                }
                column(Posted_Material_Issues_Line__Material_Issue_No___Control1000000055; "Material Issue No.")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Description_Control1000000056; "Posted Material Issues Line".Description)
                {
                }
                column(Posted_Material_Issues_Line__Unit_of_Measure__Control1000000057; "Unit of Measure")
                {
                }
                column(Posted_Material_Issues_Header___Resource_Name__Control1000000058; "Posted Material Issues Header"."Resource Name")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Issued_DateTime__Control1000000059; "Posted Material Issues Line"."Issued DateTime")
                {
                }
                column(Posted_Material_Issues_Header___Transfer_from_Code__Control1000000060; "Posted Material Issues Header"."Transfer-from Code")
                {
                }
                column(QTY_Control1000000061; QTY)
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Quantity_Control1000000062; "Posted Material Issues Line".Quantity)
                {
                }
                column(UC_Control1000000063; UC)
                {
                }
                column(Posted_Material_Issues_Header___Released_Date__Control1000000037; "Posted Material Issues Header"."Released Date")
                {
                }
                column(Lot_Control1000000045; Lot)
                {
                }
                column(Serial_no__Control1000000046; "Serial no")
                {
                }
                column(Bench_Mark__Control1102154012; "Bench-Mark")
                {
                }
                column(Posted_Material_Issues_Line__Material_Issue_No___Control1000000015; "Material Issue No.")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Description_Control1000000013; "Posted Material Issues Line".Description)
                {
                }
                column(Posted_Material_Issues_Line__Unit_of_Measure__Control1000000012; "Unit of Measure")
                {
                }
                column(Posted_Material_Issues_Header___Resource_Name__Control1000000016; "Posted Material Issues Header"."Resource Name")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Issued_DateTime__Control1000000017; "Posted Material Issues Line"."Issued DateTime")
                {
                }
                column(Posted_Material_Issues_Line__Transfer_to_Code__Control1000000011; "Transfer-to Code")
                {
                }
                column(QTY_Control1000000018; QTY)
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line__Quantity_Control1000000010; "Posted Material Issues Line".Quantity)
                {
                }
                column(UC_Control1000000019; UC)
                {
                }
                column(Posted_Material_Issues_Header___Released_Date__Control1000000038; "Posted Material Issues Header"."Released Date")
                {
                }
                column(Lot_Control1000000047; Lot)
                {
                }
                column(Serial_no__Control1000000048; "Serial no")
                {
                }
                column(Posted_Material_Issues_Header___Prod__Order_No__; "Posted Material Issues Header"."Prod. Order No.")
                {
                }
                column(Bench_Mark__Control1102154015; "Bench-Mark")
                {
                }
                column(vendor; vendor)
                {
                }
                column(BILLNO__; "BILLNO.")
                {
                }
                column(BillDate; BillDate)
                {
                }
                column(DaysCaption; DaysCaptionLbl)
                {
                }
                column(DaysCaption_Control1102154011; DaysCaption_Control1102154011Lbl)
                {
                }
                column(DaysCaption_Control1102154013; DaysCaption_Control1102154013Lbl)
                {
                }
                column(DaysCaption_Control1102154018; DaysCaption_Control1102154018Lbl)
                {
                }
                column(Posted_Material_Issues_Line_Document_No_; "Document No.")
                {
                }
                column(Posted_Material_Issues_Line_Line_No_; "Line No.")
                {
                }
                column(Posted_Material_Issues_Line_Item_No_; "Item No.")
                {
                }
                column(Choice1; Choice1)
                {
                }
                column(GrpFVisible1; GrpFVisible1)
                {
                }
                column(GrpFVisible2; GrpFVisible2)
                {
                }
                column(GrpFVisible3; GrpFVisible3)
                {
                }
                column(GrpFVisible4; GrpFVisible4)
                {
                }
                column(GrpFVisible5; GrpFVisible5)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    GrpFVisible1 := TRUE;
                    GrpFVisible2 := TRUE;
                    GrpFVisible3 := TRUE;
                    GrpFVisible4 := TRUE;
                    GrpFVisible5 := TRUE;

                    UC := 0;
                    IF Choice1 = Choice1::Damage THEN BEGIN
                        IF NOT (("Posted Material Issues Header"."Reason Code" = 'Damage') OR ("Posted Material Issues Header"."Transfer-to Code" = 'DAMAGE')) THEN
                            CurrReport.SKIP;
                    END ELSE
                        IF Choice1 = Choice1::Normal THEN BEGIN
                            IF "Posted Material Issues Line"."Transfer-to Code" = 'DAMAGE' THEN BEGIN
                                CurrReport.SKIP;
                                //  MESSAGE("Posted Material Issues Line"."Item No.");
                            END;
                        END;
                    // copy code from Posted Material Issues Line, GroupHeader - OnPostSection() >>
                    IF PrevItemNo <> "Posted Material Issues Line"."Item No." THEN BEGIN
                        "Bench-Mark" := 0;
                        PrevItemNo := "Posted Material Issues Line"."Item No.";
                        QTY_Received := 0;
                    END;
                    // copy code from // Posted Material Issues Line, GroupHeader - OnPostSection() <<


                    // copy code from // Posted Material Issues Line, Body (2) - OnPostSection() >>
                    ILE.RESET;//Rev01
                    ILE.SETCURRENTKEY(ILE."Document No.", ILE."Item No.", ILE."Posting Date");
                    ILE.SETRANGE(ILE."Document No.", "Posted Material Issues Line"."Document No.");
                    ILE.SETRANGE(ILE."Item No.", "Posted Material Issues Line"."Item No.");
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    IF ILE.FIND('-') THEN
                        Lot := ILE."Lot No."
                    ELSE
                        Lot := 'no';
                    QTY_Received += "Posted Material Issues Line".Quantity;
                    // copy code from // Posted Material Issues Line, Body (2) - OnPostSection() <<
                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() >>
                    IF Choice3 = Choice3::Issue THEN BEGIN
                        IF Choice1 = Choice1::Damage THEN BEGIN
                            IF Choice2 = Choice2::Used THEN BEGIN
                                "Serial no" := '';
                                "material issues line".RESET;//Rev01
                                "material issues line".SETRANGE("material issues line"."Document No.", "Posted Material Issues Line"."Material Issue No.");
                                "material issues line".SETRANGE("material issues line"."Item No.", "Posted Material Issues Line"."Item No.");
                                IF "material issues line".FIND('-') THEN
                                    QTY := "material issues line".Quantity
                                ELSE
                                    QTY := "Posted Material Issues Line".Quantity;
                                IF "Posted Material Issues Header"."Reason Code" = '' THEN
                                    Reason := "Posted Material Issues Header"."Prod. Order No."
                                ELSE
                                    Reason := "Posted Material Issues Header"."Reason Code";
                                Item.RESET;//Rev01
                                Item.SETRANGE(Item."No.", "Posted Material Issues Line"."Item No.");
                                IF Item.FIND('-') THEN
                                    UC := Item."Avg Unit Cost";
                                //UC:="Posted Material Issues Line"."Avg. unit cost";
                                Total += "Posted Material Issues Line"."Quantity (Base)" * UC;
                                Lot := '';
                                RemainingQty := 0;
                                "Issued Date" := DT2DATE("Posted Material Issues Header"."Issued DateTime");
                                IF ("Posted Material Issues Header"."Released Date" > 0D) AND ("Issued Date" > 0D) THEN
                                    "Bench-Mark" := "Issued Date" - "Posted Material Issues Header"."Released Date";
                                ILE.RESET;//Rev01
                                ILE.SETCURRENTKEY(ILE."Document No.", ILE."Item No.", ILE."Posting Date");
                                ILE.SETFILTER(ILE."Location Code", 'STR');
                                ILE.SETRANGE(ILE."Document No.", "Posted Material Issues Line"."Document No.");
                                ILE.SETRANGE(ILE."Item No.", "Posted Material Issues Line"."Item No.");
                                IF ILE.FIND('-') THEN BEGIN
                                    Lot := ILE."Lot No.";
                                    "Serial no" := ILE."Serial No.";
                                    RemainingQty := ILE."Remaining Quantity"; //added by Vishnu priya
                                END;
                                GrpFVisible1 := TRUE; //Hack
                                Total_Qty += "Posted Material Issues Line".Quantity;
                            END ELSE
                                GrpFVisible1 := FALSE;
                        END ELSE
                            GrpFVisible1 := FALSE;
                    END ELSE
                        GrpFVisible1 := FALSE;
                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() <<

                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() >>
                    IF Choice3 = Choice3::Issue THEN BEGIN
                        IF Choice1 = Choice1::Return THEN BEGIN
                            "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-to Code", 'STR');//Hack
                            "material issues line".RESET;//Rev01
                            "material issues line".SETRANGE("material issues line"."Document No.", "Posted Material Issues Line"."Material Issue No.");
                            "material issues line".SETRANGE("material issues line"."Item No.", "Posted Material Issues Line"."Item No.");
                            IF "material issues line".FIND('-') THEN
                                QTY := "material issues line".Quantity
                            ELSE
                                QTY := "Posted Material Issues Line".Quantity;
                            IF "Posted Material Issues Header"."Reason Code" = '' THEN
                                Reason := "Posted Material Issues Header"."Prod. Order No."
                            ELSE
                                Reason := "Posted Material Issues Header"."Reason Code";
                            /*
                            Item.SETRANGE(Item."No.","Posted Material Issues Line"."Item No.") ;
                            IF Item.FIND('-') THEN
                            UC:=Item."Avg Unit Cost";
                            */
                            UC := "Posted Material Issues Line"."Avg. unit cost";
                            Lot := '';
                            "Serial no" := '';
                            RemainingQty := 0;
                            Total += "Posted Material Issues Line"."Quantity (Base)" * UC;
                            ILE.RESET;//Rwev01
                            ILE.SETCURRENTKEY(ILE."Document No.", ILE."Item No.", ILE."Posting Date");
                            ILE.SETFILTER(ILE."Location Code", 'STR');
                            ILE.SETRANGE(ILE."Document No.", "Posted Material Issues Line"."Document No.");
                            ILE.SETRANGE(ILE."Item No.", "Posted Material Issues Line"."Item No.");
                            IF ILE.FIND('-') THEN BEGIN
                                Lot := ILE."Lot No.";
                                "Serial no" := ILE."Serial No.";
                                RemainingQty := ILE."Remaining Quantity";
                            END;
                            Total_Qty += "Posted Material Issues Line".Quantity;
                            GrpFVisible2 := TRUE;
                        END ELSE
                            GrpFVisible2 := FALSE;
                    END ELSE
                        GrpFVisible2 := FALSE;
                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() <<

                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() >>
                    IF Choice3 = Choice3::Issue THEN BEGIN
                        IF Choice1 = Choice1::Damage THEN BEGIN
                            IF Choice2 = Choice2::NotUsed THEN BEGIN
                                GrpFVisible3 := TRUE;
                                "material issues line".RESET;//Rev01
                                "material issues line".SETRANGE("material issues line"."Document No.", "Posted Material Issues Line"."Material Issue No.");
                                "material issues line".SETRANGE("material issues line"."Item No.", "Posted Material Issues Line"."Item No.");
                                IF "material issues line".FIND('-') THEN
                                    QTY := "material issues line".Quantity
                                ELSE
                                    QTY := "Posted Material Issues Line".Quantity;
                                IF "Posted Material Issues Header"."Reason Code" = '' THEN
                                    Reason := "Posted Material Issues Header"."Prod. Order No."
                                ELSE
                                    Reason := "Posted Material Issues Header"."Reason Code";

                                UC := "Posted Material Issues Line"."Avg. unit cost";

                                IF UC = 0 THEN BEGIN
                                    IF Item.GET("Posted Material Issues Line"."Item No.") THEN
                                        UC := Item."Avg Unit Cost";
                                END;

                                Total += "Posted Material Issues Line"."Quantity (Base)" * UC;
                                "Project Total" += "Posted Material Issues Line"."Quantity (Base)" * UC;
                                Lot := '';
                                "Serial no" := '';
                                RemainingQty := 0;
                                ILE.RESET;//Rev01
                                ILE.SETCURRENTKEY(ILE."Document No.", ILE."Item No.", ILE."Posting Date");
                                ILE.SETFILTER(ILE."Location Code", 'STR');
                                ILE.SETRANGE(ILE."Document No.", "Posted Material Issues Line"."Document No.");
                                ILE.SETRANGE(ILE."Item No.", "Posted Material Issues Line"."Item No.");
                                IF ILE.FIND('-') THEN BEGIN
                                    Lot := ILE."Lot No.";
                                    "Serial no" := ILE."Serial No.";
                                    RemainingQty := ILE."Remaining Quantity";
                                END;
                                Total_Qty += "Posted Material Issues Line".Quantity;
                            END ELSE
                                GrpFVisible3 := FALSE;
                        END ELSE
                            GrpFVisible3 := FALSE;
                    END ELSE
                        GrpFVisible3 := FALSE;
                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() <<

                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() <<
                    IF Choice1 = Choice1::Normal THEN BEGIN
                        IF ("Posted Material Issues Header"."Transfer-to Code" = 'STR') OR ("Posted Material Issues Header"."Transfer-to Code" = 'DAMAGE') THEN BEGIN
                            GrpFVisible4 := FALSE
                        END ELSE BEGIN
                            "material issues line".RESET;//Rev01
                            "material issues line".SETRANGE("material issues line"."Document No.", "Posted Material Issues Line"."Material Issue No.");
                            "material issues line".SETRANGE("material issues line"."Item No.", "Posted Material Issues Line"."Item No.");
                            IF "material issues line".FIND('-') THEN
                                QTY := "material issues line".Quantity
                            ELSE
                                QTY := "Posted Material Issues Line".Quantity;


                            IF "Posted Material Issues Header"."Prod. Order No." = '' THEN
                                Reason := "Posted Material Issues Header"."Prod. Order No."
                            ELSE
                                Reason := "Posted Material Issues Header"."Reason Code";

                            Issued_Qty := 0;
                            Ret_Qty := 0;
                            Issued_Qty := "Posted Material Issues Line".Quantity;
                            // Total+="Posted Material Issues Line"."Quantity (Base)"*UC;
                            // ileref:='';
                            Lot := '';
                            "Serial no" := '';
                            "Prod. Order Description" := '';
                            PO.RESET;
                            PO.SETRANGE(PO."No.", "Posted Material Issues Line"."Prod. Order No.");
                            IF PO.FINDFIRST THEN
                                "Prod. Order Description" := PO.Description;
                            ILE.RESET;//Rev01
                            ILE.SETCURRENTKEY(ILE."Document No.", ILE."Item No.", ILE."Posting Date");
                            ILE.SETFILTER(ILE."Entry Type", 'Transfer');
                            //ILE.SETFILTER(ILE."Location Code","Posted Material Issues Line"."Transfer-to Code");
                            ILE.SETFILTER(ILE.Quantity, '>%1', 0);
                            ILE.SETRANGE(ILE."Document No.", "Posted Material Issues Line"."Document No.");
                            ILE.SETRANGE(ILE."Item No.", "Posted Material Issues Line"."Item No.");
                            IF ILE.FIND('-') THEN
                                REPEAT
                                    Lot := ILE."Lot No.";
                                    "Serial no" := ILE."Serial No.";
                                    IF Consider_Return THEN BEGIN
                                        Ret_Qty += ILE.Quantity - ILE."Remaining Quantity";
                                    END;
                                UNTIL ILE.NEXT = 0;
                            IF Consider_Return THEN BEGIN
                                Issued_Qty := Issued_Qty - Ret_Qty;
                            END;

                            UC := 0;

                            IF UC = 0 THEN BEGIN
                                IF Item.GET("Posted Material Issues Line"."Item No.") THEN
                                    UC := Item."Avg Unit Cost";
                            END;     //cometed by anil


                            Item_Batch.RESET;
                            Item_Batch.SETFILTER(Item_Batch."Item No.", "Posted Material Issues Line"."Item No.");
                            Item_Batch.SETFILTER(Item_Batch."Lot No.", Lot);
                            IF Item_Batch.FINDFIRST THEN BEGIN
                                UC := Item_Batch."Unit Cost";
                            END ELSE BEGIN
                                vendor := '';
                                "BILLNO." := '';
                                BillDate := 0D;
                                ileref := '';
                                TESTINV := 0;
                                ITEMLED.RESET;
                                ITEMLED.SETCURRENTKEY(ITEMLED."Item No.", ITEMLED."Lot No.", ITEMLED."ITL Doc No.");
                                ITEMLED.SETFILTER(ITEMLED."Entry Type", 'Purchase');
                                ITEMLED.SETRANGE(ITEMLED."Item No.", "Posted Material Issues Line"."Item No.");
                                //IF Lot <> '' THEN //Rev01
                                ITEMLED.SETRANGE(ITEMLED."Lot No.", Lot);
                                //IF "Serial no" <> '' THEN //Rev01
                                ITEMLED.SETRANGE(ITEMLED."Serial No.", "Serial no");
                                IF ITEMLED.FIND('-') THEN BEGIN
                                    PRL.RESET;
                                    PRL.SETRANGE(PRL."Document No.", ITEMLED."Document No.");
                                    PRL.SETRANGE(PRL."No.", ITEMLED."Item No.");
                                    IF PRL.FIND('-') THEN BEGIN
                                        ileref := ITEMLED."Document No.";//anil aded
                                        PRH.RESET;//Rev01
                                        PRH.SETRANGE(PRH."No.", PRL."Document No.");
                                        IF PRH.FIND('-') THEN BEGIN
                                            vendor := PRH."Buy-from Vendor Name";
                                            "BILLNO." := PRH."Vendor Shipment No.";
                                            BillDate := PRH."Posting Date";
                                            PIL.RESET;
                                            PIL.SETCURRENTKEY(PIL.Type, PIL."No.", PIL."Variant Code");
                                            PIL.SETRANGE(PIL."No.", PRL."No.");
                                            PIL.SETRANGE(PIL."Receipt No.", PRL."Document No.");
                                            PIL.SETFILTER(PIL.Quantity, '>%1', 0);  // pranavi
                                            IF PIL.FIND('-') THEN BEGIN
                                                UC := PIL."Amount To Vendor" / PIL.Quantity;
                                                IF PIL."Gen. Bus. Posting Group" = 'FOREIGN' THEN
                                                    UC := PIL."Unit Cost (LCY)"; //WRITEN BY ANIL
                                                TESTINV := 10;
                                                IF "BILLNO." = '' THEN
                                                    PIH.RESET;
                                                PIH.SETFILTER(PIH."No.", PIL."Document No.");
                                                IF PIH.FINDFIRST THEN
                                                    "BILLNO." := PIH."Vendor Invoice No.";
                                            END;
                                        END;
                                    END;
                                END
                                ELSE//sundar
                                BEGIN
                                    ITEMLED.RESET;
                                    ITEMLED.SETCURRENTKEY(ITEMLED."Item No.", ITEMLED."Lot No.", ITEMLED."ITL Doc No.");
                                    ITEMLED.SETFILTER(ITEMLED."Entry Type", 'Positive Adjmt.');
                                    ITEMLED.SETRANGE(ITEMLED."Item No.", "Posted Material Issues Line"."Item No.");
                                    ITEMLED.SETRANGE(ITEMLED."Lot No.", Lot);
                                    ITEMLED.SETRANGE(ITEMLED."Serial No.", "Serial no");
                                    IF ITEMLED.FIND('-') THEN BEGIN
                                        ileref := ITEMLED."Document No.";
                                        PIL.RESET;
                                        PIL.SETRANGE(PIL."No.", ITEMLED."Item No.");
                                        PIL.SETFILTER(PIL."Posting Date", '<%1', ITEMLED."Posting Date");
                                        PIL.SETFILTER(PIL.Quantity, '>%1', 0);
                                        IF PIL.FINDLAST THEN BEGIN
                                            UC := PIL."Amount To Vendor" / PIL.Quantity;
                                            IF PIL."Gen. Bus. Posting Group" = 'FOREIGN' THEN
                                                UC := PIL."Unit Cost (LCY)";
                                        END;
                                    END;
                                END;   //sundar
                            END;
                            "Issued Date" := DT2DATE("Posted Material Issues Header"."Issued DateTime");
                            IF ("Posted Material Issues Header"."Released Date" > 0D) AND ("Issued Date" > 0D) THEN
                                "Bench-Mark" := "Issued Date" - "Posted Material Issues Header"."Released Date";

                            // MESSAGE('%1',"Serial no");
                            IF EXCEL AND (Issued_Qty > 0) THEN BEGIN
                                Row += 1;
                                Entercell(Row, 1, "Posted Material Issues Header"."Prod. Order No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 2, "Prod. Order Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 3, "Posted Material Issues Line"."Material Issue No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 4, "Posted Material Issues Line".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 5, "Posted Material Issues Line"."Unit of Measure Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 6, "Posted Material Issues Header"."User ID", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 7, FORMAT("Posted Material Issues Header"."Released Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                Entercell(Row, 8, FORMAT("Posted Material Issues Header"."Issued DateTime"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                Entercell(Row, 9, "Posted Material Issues Header"."Transfer-to Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 10, FORMAT(QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(Row, 11, FORMAT(Issued_Qty), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(Row, 12, FORMAT(UC), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(Row, 13, FORMAT(UC * Issued_Qty), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(Row, 14, Lot, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 15, "Serial no", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 16, FORMAT("Bench-Mark"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                //added by Vishnu
                                ItmLedEnt.RESET;
                                ItmLedEnt.SETCURRENTKEY("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.", "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
                                ItmLedEnt.SETFILTER("Document No.", "Posted Material Issues Line"."Document No.");
                                ItmLedEnt.SETFILTER("Item No.", "Posted Material Issues Line"."Item No.");
                                ItmLedEnt.SETFILTER("Lot No.", Lot);
                                ItmLedEnt.SETFILTER("Serial No.", "Serial no");
                                ItmLedEnt.SETFILTER(Quantity, '>%1', 0);
                                IF ItmLedEnt.FINDFIRST THEN BEGIN
                                    RemainingQty := ItmLedEnt."Remaining Quantity";
                                    Entercell(Row, 30, FORMAT(RemainingQty), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                END;
                                //ended  by vishnu
                                // Entercell(Row,40,FORMAT(TESTINV),FALSE,Tempexcelbuffer."Cell Type"::Number);   // commented by Vishnu Priya on 10-07-2019
                                IF UC <> 0 THEN BEGIN
                                    Entercell(Row, 17, vendor, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 18, FORMAT("BILLNO."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 19, FORMAT(BillDate), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                END;
                                //  IF ITEMLED."Document No."<>'' THEN
                                Entercell(Row, 20, ileref, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 28, "Posted Material Issues Line".Remarks, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                // Entercell(Row,20,ITEMLED."Document No.",FALSE);
                                PRH.RESET;
                                PRH.SETRANGE(PRH."No.", ileref);
                                IF PRH.FIND('-') THEN BEGIN
                                    Entercell(Row, 21, PRH."Pay-to Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 22, FORMAT(PRH."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                    Entercell(Row, 23, FORMAT(PRH."Order No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 24, FORMAT(PRH."Vendor Shipment No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                END;
                                IF ("Posted Material Issues Header"."Transfer-from Code" = 'STR') AND
                                   ("Posted Material Issues Header"."Transfer-to Code" = 'CST') THEN BEGIN
                                    Entercell(Row, 31, FORMAT("Posted Material Issues Header"."Service Order No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 32, FORMAT("Posted Material Issues Header"."Service Item Description"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 33, FORMAT("Posted Material Issues Header"."Service Item Serial No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                END;
                                IF ("Posted Material Issues Header"."Transfer-to Code" IN ['SITE', 'CST', 'CS']) THEN BEGIN
                                    DV.RESET;
                                    DV.SETFILTER(DV."Dimension Code", 'LOCATIONS');
                                    DV.SETFILTER(DV.Code, "Posted Material Issues Header"."Shortcut Dimension 2 Code");
                                    //        IF DV.FINDFIRST THEN
                                    //           Entercell(Row,27,FORMAT(DV.Name),FALSE,Tempexcelbuffer."Cell Type"::Text);
                                END;

                                //iled place
                                Item.RESET;
                                Item.SETFILTER(Item."No.", "Posted Material Issues Line"."Item No.");
                                IF Item.FIND('-') THEN BEGIN
                                    Entercell(Row, 25, Item."Item Category Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 29, Item.Make, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                END;
                                Entercell(Row, 26, FORMAT("Posted Material Issues Header"."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                Reasoncode.RESET;
                                Reasoncode.SETFILTER(Reasoncode.Code, "Posted Material Issues Header"."Reason Code");
                                IF Reasoncode.FINDFIRST THEN
                                    Entercell(Row, 27, FORMAT(Reasoncode.Description), FALSE, Tempexcelbuffer."Cell Type"::Text);
                            END;

                            "Project Total" += Issued_Qty * UC;
                            Total_Qty += Issued_Qty;
                            Total += Issued_Qty * UC;
                        END;



                    END ELSE
                        GrpFVisible4 := FALSE;
                    GrpFVisible4 := ((Choice3 = Choice3::Issue) AND (Choice1 = Choice1::Normal) AND (Issued_Qty > 0));
                    // copy code from // Posted Material Issues Line, GroupFooter - OnPostSection() <<

                end;

                trigger OnPreDataItem()
                begin
                    PrevItemNo := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Copy code from //Posted Material Issues Header, GroupHead - OnPreSection() >>
                IF PrevProdOrderNo <> "Posted Material Issues Header"."Prod. Order No." THEN BEGIN
                    "Project Total" := 0;
                    PrevProdOrderNo := "Posted Material Issues Header"."Prod. Order No."
                END;
                // Copy code from //Posted Material Issues Header, GroupHead - OnPreSection() <<
            end;

            trigger OnPostDataItem()
            begin

                // copy code from // Posted Material Issues header, GroupFooter - OnPostSection() >>
                IF Choice3 = Choice3::Project THEN BEGIN
                    Project_Desc := '';
                    PO.SETRANGE(PO."No.", "Posted Material Issues Header"."Prod. Order No.");
                    IF PO.FIND('-') THEN
                        Project_Desc := PO.Description;
                    "R&D total" += "Project Total";
                END ELSE
                    GrpFVisible5 := FALSE;
                // copy code from // Posted Material Issues header, GroupFooter - OnPostSection() <<
            end;

            trigger OnPreDataItem()
            begin
                //IF Choice3<>Choice3::Issue THEN
                //  CurrReport.BREAK;
                PMINumbers := '';
                IF (Choice3 = Choice3::Summary) OR (Choice3 = Choice3::WRET) THEN
                    CurrReport.BREAK;

                IF Choice3 = Choice3::Issue THEN BEGIN
                    "Posted Material Issues Header".SETCURRENTKEY("Material Issue No.", "Posting Date", "Resource Name", "Reason Code",
                    "Prod. Order No.", "Transfer-to Code", "Transfer-from Code");
                    IF Choice1 = Choice1::Return THEN BEGIN
                        "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Transfer-to Code", 'STR|DAMAGE|SITE|MCH|CS STR|''R&D STR''');
                        // "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Reason Code",'<>%1','DAMAGE');
                    END ELSE
                        IF Choice1 = Choice1::Normal THEN BEGIN
                            IF "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Transfer-from Code") = '' THEN
                                "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Transfer-from Code", 'STR|MCH|CS|CS STR|''R&D STR''');
                            IF "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Transfer-to Code") = '' THEN
                                "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Transfer-to Code", '<>%1', 'DAMAGE');
                        END ELSE
                            IF Choice1 = Choice1::Damage THEN BEGIN
                                "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-to Code", 'DAMAGE');
                            END;
                    /*IF "Posted Material Issues Line".GETFILTER("Posted Material Issues Line"."Item No.")<>'' THEN
                    BEGIN
                      PMIL.RESET;
                      PMIL.SETCURRENTKEY("Document No.","Item No.");
                      PMIL.SETFILTER(PMIL."Item No.","Posted Material Issues Line".GETFILTER("Posted Material Issues Line"."Item No."));
                      IF PMIL.FINDSET THEN
                      REPEAT
                        PMINumbers := PMINumbers+PMIL."Document No."+'|';
                      UNTIL PMIL.NEXT=0;
                      PMINumbers1 := COPYSTR(PMINumbers,1,STRLEN(PMINumbers1)-1);
                      MESSAGE(PMINumbers1);
                      IF PMINumbers1 <> '' THEN
                        "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."No.",PMINumbers1);
                    END;*/

                END ELSE
                    SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");

                // Copy code from // Posted Material Issues Header, Header (1 - OnPostSection() >>
                //CurrReport.SHOWOUTPUT(Choice3=Choice3::Issue);
                IF EXCEL THEN BEGIN
                    Row += 1;
                    EnterHeadings(Row, 1, 'Production Order', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'Project', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Request No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Item', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Unit Of Measure', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Requested Employee', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Requested Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Issued Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Department', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Quantity Requeested', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'Quantity Received', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'Unit COst', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 13, 'Total Amount.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 14, 'Lot No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 15, 'Serial No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 16, 'Bench Mark', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 17, 'Vendor', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 18, 'Bill No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 19, 'Bill Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 20, 'Reference No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 21, 'Vendor Name', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 22, 'Inward Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 23, 'Purchase Order No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 24, 'Vendor Shipment No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 25, 'Item Category Code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 26, 'Posting Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 27, 'Reason Code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 28, 'Remarks', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 29, 'Make', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 30, 'ILE Remaining Qty', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 31, 'Service Order No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 32, 'Service Item Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 33, 'Service Item Serial No.', TRUE, Tempexcelbuffer."Cell Type"::Text);


                    // EnterHeadings(Row,26, 'Posting Date',TRUE,Tempexcelbuffer."Cell Type"::Text);
                    Row += 1;
                END;


                // Copy code from // Posted Material Issues Header, Header (1 - OnPostSection() <<

                PrevProdOrderNo := '';

            end;
        }
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.") WHERE("Location Code" = CONST('R&D'));
            column(Production_Order_Status; Status)
            {
            }
            column(Production_Order_No_; "No.")
            {
            }
            dataitem("<Posted Material Issues Line1>"; "Posted Material Issues Line")
            {
                DataItemLink = "Prod. Order No." = FIELD("No.");
                DataItemTableView = SORTING("Prod. Order No.", "Item No.") ORDER(Ascending) WHERE("Transfer-from Code" = FILTER('STR' | 'R&D STR'), Quantity = FILTER(> 0));
                RequestFilterHeading = 'Summerised Project wise Issues';
                column(COMPANYNAME_Control1102154031; COMPANYNAME)
                {
                }
                column(USERID_Control1102154035; USERID)
                {
                }
                column(TODAY_Control1102154036; TODAY)
                {
                }
                column(Posted_Material_Issues_Line1___Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Posted_Material_Issues_Line1___Item_No__; "Item No.")
                {
                }
                column(Ret_Qty; Ret_Qty)
                {
                }
                column(Value; Value)
                {
                }
                column(Posted_Material_Issues_Line1__Quantity; Quantity)
                {
                }
                column(Posted_Material_Issues_Line1__Description; Description)
                {
                }
                column(Total_Value_; "Total Value")
                {
                }
                column(Material_IssuesCaption_Control1102154030; Material_IssuesCaption_Control1102154030Lbl)
                {
                }
                column(Item_No_Caption; Item_No_CaptionLbl)
                {
                }
                column(ValueCaption_Control1102154033; ValueCaption_Control1102154033Lbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Issued_QtyCaption; Issued_QtyCaptionLbl)
                {
                }
                column(Return_QtyCaption; Return_QtyCaptionLbl)
                {
                }
                column(Posted_Material_Issues_Line1___Unit_of_Measure_Code_Caption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(Posted_Material_Issues_Line1__Document_No_; "Document No.")
                {
                }
                column(Posted_Material_Issues_Line1__Line_No_; "Line No.")
                {
                }
                column(Posted_Material_Issues_Line1__Prod__Order_No_; "Prod. Order No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PMIH.SETRANGE(PMIH."No.", "<Posted Material Issues Line1>"."Document No.");
                    IF PMIH.FIND('-') THEN BEGIN
                        IF PMIH."Posting Date" < 20080401D THEN
                            CurrReport.SKIP;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //IF Choice3<>Choice3::WRET THEN
                    //CurrReport.BREAK;
                end;
            }

            trigger OnPreDataItem()
            begin

                //IF Choice3<>Choice3::Project THEN
                //CurrReport.BREAK;
                IF Choice3 = Choice3::Summary THEN
                    CurrReport.BREAK;


                "Production Order".SETFILTER("Production Order"."No.",
                                             "Posted Material Issues Header".GETFILTER("Prod. Order No."));
                //}//commented by pranavi on 12-09-2015 for testing as report running very slow
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord()
            begin

                IF BREAKVar THEN
                    CurrReport.BREAK;
                IF ItemLotNumbers.NEXT = 0 THEN
                    CurrReport.BREAK;//BREAK:=TRUE;
            end;

            trigger OnPreDataItem()
            begin
                IF Choice3 <> Choice3::Summary THEN
                    CurrReport.BREAK;
                "Str Rdso report".DELETEALL;
                IF (Sales_Order_No <> '') AND (Item_No <> '') AND ((Posting_From_Date = 0D) AND (Posting_To_Date = 0D)) AND (Lot = '') THEN BEGIN
                    "Posted Material Issues Line".SETCURRENTKEY("Posted Material Issues Line"."Item No.",
                                                                "Posted Material Issues Line"."Transfer-from Code",
                                                                "Posted Material Issues Line"."Issued DateTime");
                    "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Item No.", Item_No);
                    "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Transfer-from Code", 'STR');
                    "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Transfer-to Code", 'PROD');
                    IF "Posted Material Issues Line".FIND('-') THEN
                        REPEAT
                            "Posted Material Issues Header".RESET;
                            "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."No.", "Posted Material Issues Line"."Document No.");
                            IF "Posted Material Issues Header".FIND('-') THEN BEGIN
                                PO.RESET;
                                PO.SETRANGE(PO."No.", "Posted Material Issues Header"."Prod. Order No.");
                                IF PO.FIND('-') THEN BEGIN
                                    IF Item.GET(PO."Source No.") AND (PO."Sales Order No." = Sales_Order_No) THEN BEGIN
                                        ILE.RESET;
                                        ILE.SETCURRENTKEY(ILE."Document No.", ILE."Item No.", ILE."Posting Date");
                                        ILE.SETRANGE(ILE."Document No.", "Posted Material Issues Line"."Document No.");
                                        ILE.SETRANGE(ILE."Item No.", Item_No);
                                        ILE.SETRANGE(ILE."Location Code", 'STR');
                                        IF ILE.FIND('-') THEN BEGIN
                                            /*  ItemLotNumbers.SETRANGE(ItemLotNumbers."Item No",Item_No);
                                               ItemLotNumbers.SETRANGE(ItemLotNumbers."Sales Order No.",Sales_Order_No);
                                               ItemLotNumbers.SETRANGE(ItemLotNumbers."Product Type",Item."Item Sub Group Code");
                                               ItemLotNumbers.SETRANGE(ItemLotNumbers."Suitable Vendor",ILE."Lot No.");
                                               IF ItemLotNumbers.FIND('-') THEN
                                               BEGIN
                                                 ItemLotNumbers.Shortage+="Posted Material Issues Line".Quantity;

                                                 IF ItemLotNumbers."Production Orders">"Posted Material Issues Line"."Prod. Order No." THEN
                                                    ItemLotNumbers."Production Orders":="Posted Material Issues Line"."Prod. Order No.";
                                                 IF ItemLotNumbers."Indent No."<"Posted Material Issues Line"."Prod. Order No." THEN
                                                    ItemLotNumbers."Indent No.":="Posted Material Issues Line"."Prod. Order No.";
                                                 ItemLotNumbers.MODIFY;
                                               END ELSE
                                               BEGIN
                                                 ItemLotNumbers.INIT;
                                                 ItemLotNumbers."Item No":="Posted Material Issues Line"."Item No.";
                                                 ItemLotNumbers.Description:="Posted Material Issues Line".Description;
                                                 ItemLotNumbers."Planned Purchase Date":=TODAY;
                                                 ItemLotNumbers."Production Order No.":="Posted Material Issues Line"."Prod. Order No.";
                                                 ItemLotNumbers."Sales Order No.":="Posted Material Issues Line".Saleorderno;
                                                 ItemLotNumbers."Product Type":=Item."Item Sub Group Code";
                                                 ItemLotNumbers.Product:="Production Order"."Source No.";
                                                 ItemLotNumbers.Shortage:="Posted Material Issues Line".Quantity;
                                                 ItemLotNumbers."Production Orders":="Posted Material Issues Line"."Prod. Order No.";
                                                 ItemLotNumbers."Indent No.":="Posted Material Issues Line"."Prod. Order No.";
                                                 ItemLotNumbers."Suitable Vendor":=ILE."Lot No.";
                                                 ItemLotNumbers.INSERT;
                                               END; */
                                            IF NOT ("Str Rdso report".GET("Posted Material Issues Line"."Document No.")) THEN BEGIN
                                                "Str Rdso report".INIT;
                                                "Str Rdso report"."Issue No." := "Posted Material Issues Line"."Document No.";
                                                "Str Rdso report"."Issue Line No." := "Posted Material Issues Line"."Line No.";
                                                "Str Rdso report"."Item No." := "Posted Material Issues Line"."Item No.";
                                                "Str Rdso report".Description := "Posted Material Issues Line".Description;
                                                "Str Rdso report"."Production Order" := "Posted Material Issues Header"."Prod. Order No.";
                                                "Str Rdso report"."Sales Order No." := PO."Sales Order No.";
                                                "Str Rdso report"."Product No." := "Production Order"."Source No.";
                                                "Str Rdso report"."Issued Qty" := "Posted Material Issues Line".Quantity;
                                                "Str Rdso report".Lot := ILE."Lot No.";
                                                "Str Rdso report".INSERT;
                                            END ELSE BEGIN
                                                "Str Rdso report"."Issued Qty" += "Posted Material Issues Line".Quantity;
                                                "Str Rdso report".MODIFY;
                                            END;

                                        END;
                                    END;
                                END;
                            END;
                        UNTIL "Posted Material Issues Line".NEXT = 0;
                END ELSE
                    IF (Sales_Order_No = '') AND (Item_No <> '') AND ((Posting_From_Date > 0D) AND (Posting_To_Date > 0D)) AND (Lot = '') THEN BEGIN
                        ILE.RESET;
                        ILE.SETCURRENTKEY(ILE."Item No.", ILE.Open, ILE."Variant Code", ILE.Positive, ILE."Location Code", ILE."Posting Date");
                        ILE.SETRANGE(ILE."Item No.", Item_No);
                        ILE.SETRANGE(ILE."Location Code", 'STR');
                        ILE.SETRANGE(ILE."Posting Date", Posting_From_Date, Posting_To_Date);
                        ILE.SETFILTER(ILE."Entry Type", 'Transfer');
                        IF ILE.FIND('-') THEN
                            REPEAT
                                "Posted Material Issues Line".RESET;
                                "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Document No.", ILE."Document No.");
                                "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Item No.", ILE."Item No.");
                                IF "Posted Material Issues Line".FIND('-') THEN BEGIN
                                    "Posted Material Issues Header".RESET;
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."No.", "Posted Material Issues Line"."Document No.");
                                    IF "Posted Material Issues Header".FIND('-') THEN BEGIN
                                        PO.RESET;
                                        PO.SETRANGE(PO."No.", "Posted Material Issues Header"."Prod. Order No.");
                                        IF PO.FIND('-') THEN BEGIN
                                            IF Item.GET(PO."Source No.") THEN BEGIN
                                                /*  ItemLotNumbers.SETRANGE(ItemLotNumbers."Item No",Item_No);
                                                   ItemLotNumbers.SETRANGE(ItemLotNumbers."Sales Order No.",PO."Sales Order No.");
                                                   ItemLotNumbers.SETRANGE(ItemLotNumbers."Product Type",Item."Item Sub Group Code");
                                                   ItemLotNumbers.SETRANGE(ItemLotNumbers."Suitable Vendor",ILE."Lot No.");
                                                   IF ItemLotNumbers.FIND('-') THEN
                                                   BEGIN
                                                     ItemLotNumbers.Shortage+="Posted Material Issues Line".Quantity;
                                                     IF ItemLotNumbers."Production Orders">"Posted Material Issues Line"."Prod. Order No." THEN
                                                        ItemLotNumbers."Production Orders":="Posted Material Issues Line"."Prod. Order No.";
                                                     IF ItemLotNumbers."Indent No."<"Posted Material Issues Line"."Prod. Order No." THEN
                                                        ItemLotNumbers."Indent No.":="Posted Material Issues Line"."Prod. Order No.";
                                                     ItemLotNumbers.MODIFY;
                                                   END ELSE
                                                   BEGIN
                                                     ItemLotNumbers.INIT;
                                                     ItemLotNumbers."Item No":="Posted Material Issues Line"."Item No.";
                                                     ItemLotNumbers.Description:="Posted Material Issues Line".Description;
                                                     ItemLotNumbers."Planned Purchase Date":=TODAY;
                                                     ItemLotNumbers."Production Order No.":="Posted Material Issues Line"."Prod. Order No.";
                                                     ItemLotNumbers."Sales Order No.":=PO."Sales Order No.";
                                                     ItemLotNumbers."Product Type":=Item."Item Sub Group Code";
                                                     ItemLotNumbers.Product:="Production Order"."Source No.";
                                                     ItemLotNumbers.Shortage:="Posted Material Issues Line".Quantity;
                                                     ItemLotNumbers."Production Orders":="Posted Material Issues Line"."Prod. Order No.";
                                                     ItemLotNumbers."Indent No.":="Posted Material Issues Line"."Prod. Order No.";
                                                     ItemLotNumbers."Suitable Vendor":=ILE."Lot No.";
                                                     ItemLotNumbers.INSERT;
                                                   END ; */
                                                IF NOT ("Str Rdso report".GET("Posted Material Issues Line"."Document No.")) THEN BEGIN
                                                    "Str Rdso report".INIT;
                                                    "Str Rdso report"."Issue No." := "Posted Material Issues Line"."Document No.";
                                                    "Str Rdso report"."Issue Line No." := "Posted Material Issues Line"."Line No.";
                                                    "Str Rdso report"."Item No." := "Posted Material Issues Line"."Item No.";
                                                    "Str Rdso report".Description := "Posted Material Issues Line".Description;
                                                    "Str Rdso report"."Production Order" := "Posted Material Issues Line"."Prod. Order No.";
                                                    "Str Rdso report"."Sales Order No." := PO."Sales Order No.";
                                                    "Str Rdso report"."Product No." := PO."Source No.";
                                                    "Str Rdso report"."Issued Qty" := "Posted Material Issues Line".Quantity;
                                                    "Str Rdso report".Lot := ILE."Lot No.";
                                                    "Str Rdso report".INSERT;
                                                END ELSE BEGIN
                                                    "Str Rdso report"."Issued Qty" += "Posted Material Issues Line".Quantity;
                                                    "Str Rdso report".MODIFY;
                                                END;

                                            END;
                                        END;
                                    END;
                                END;
                            UNTIL ILE.NEXT = 0;

                    END ELSE
                        IF (Sales_Order_No = '') AND (Item_No <> '') AND ((Posting_From_Date = 0D) AND (Posting_To_Date = 0D)) AND (Lot <> '') THEN BEGIN
                            ILE.RESET;
                            ILE.SETCURRENTKEY(ILE."Entry Type", ILE."Lot No.", ILE."Item No.");
                            ILE.SETFILTER(ILE."Entry Type", 'Transfer');
                            ILE.SETRANGE(ILE."Lot No.", Lot);
                            ILE.SETRANGE(ILE."Item No.", Item_No);
                            ILE.SETRANGE(ILE."Location Code", 'STR');
                            IF ILE.FIND('-') THEN
                                REPEAT
                                    "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Document No.", ILE."Document No.");
                                    "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Item No.", ILE."Item No.");
                                    IF "Posted Material Issues Line".FIND('-') THEN BEGIN
                                        "Posted Material Issues Header".RESET;
                                        "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."No.", "Posted Material Issues Line"."Document No.");
                                        IF "Posted Material Issues Header".FIND('-') THEN BEGIN
                                            PO.RESET;
                                            PO.SETRANGE(PO."No.", "Posted Material Issues Line"."Prod. Order No.");
                                            IF PO.FIND('-') THEN BEGIN
                                                IF Item.GET(PO."Source No.") THEN BEGIN
                                                    /*Sales_Order_No:=PO."Sales Order No.";
                                                      //ItemLotNumbers.RESET;
                                                      ItemLotNumbers.SETRANGE(ItemLotNumbers."Item No",Item_No);
                                                      ItemLotNumbers.SETRANGE(ItemLotNumbers."Sales Order No.",PO."Sales Order No.");
                                                      ItemLotNumbers.SETRANGE(ItemLotNumbers."Product Type",Item."Item Sub Group Code");
                                                      ItemLotNumbers.SETRANGE(ItemLotNumbers."Suitable Vendor",ILE."Lot No.");
                                                      IF NOT(ItemLotNumbers.FIND('-')) THEN
                                                      BEGIN
                                                        ItemLotNumbers.INIT;
                                                        ItemLotNumbers."Item No":=ILE."Item No.";
                                                        ItemLotNumbers.Description:="Posted Material Issues Line".Description;
                                                        ItemLotNumbers."Planned Purchase Date":=TODAY;
                                                        ItemLotNumbers."Production Order No.":=PO."No.";
                                                        ItemLotNumbers."Sales Order No.":=PO."Sales Order No.";
                                                        ItemLotNumbers."Product Type":=Item."Item Sub Group Code";
                                                        ItemLotNumbers.Product:="Production Order"."Source No.";
                                                        ItemLotNumbers.Shortage:=ABS(ILE.Quantity);
                                                        ItemLotNumbers."Production Orders":=PO."No.";
                                                        ItemLotNumbers."Indent No.":=PO."No.";
                                                        ItemLotNumbers."Suitable Vendor":=ILE."Lot No.";
                                                        ItemLotNumbers.INSERT;
                                                      END ELSE
                                                      BEGIN
                                                        ItemLotNumbers.Shortage+=ABS(ILE.Quantity);
                                                        IF ItemLotNumbers."Production Orders">PO."No." THEN
                                                           ItemLotNumbers."Production Orders":=PO."No.";
                                                        IF ItemLotNumbers."Indent No."<PO."No." THEN
                                                           ItemLotNumbers."Indent No.":=PO."No.";
                                                        ItemLotNumbers.MODIFY;
                                                     END;*/
                                                    IF NOT ("Str Rdso report".GET("Posted Material Issues Line"."Document No.")) THEN BEGIN
                                                        "Str Rdso report".INIT;
                                                        "Str Rdso report"."Issue No." := "Posted Material Issues Line"."Document No.";
                                                        "Str Rdso report"."Issue Line No." := "Posted Material Issues Line"."Line No.";
                                                        "Str Rdso report"."Item No." := "Posted Material Issues Line"."Item No.";
                                                        "Str Rdso report".Description := "Posted Material Issues Line".Description;
                                                        "Str Rdso report"."Production Order" := "Posted Material Issues Line"."Prod. Order No.";
                                                        "Str Rdso report"."Sales Order No." := PO."Sales Order No.";
                                                        "Str Rdso report"."Product No." := "Production Order"."Source No.";
                                                        "Str Rdso report"."Issued Qty" := "Posted Material Issues Line".Quantity;
                                                        "Str Rdso report".Lot := ILE."Lot No.";
                                                        "Str Rdso report".INSERT;
                                                    END ELSE BEGIN
                                                        "Str Rdso report"."Issued Qty" += "Posted Material Issues Line".Quantity;
                                                        "Str Rdso report".MODIFY;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END;
                                UNTIL ILE.NEXT = 0;

                        END ELSE
                            ERROR(' PLEASE ENTER CORRECT COMBINTAION OF I/P');

                ItemLotNumbers.RESET;//REV01
                IF ItemLotNumbers.FIND('-') THEN;
                Integer.SETRANGE(Integer.Number, 1, ItemLotNumbers.COUNT);

            end;
        }
        dataitem("Str Rdso report"; "Str Rdso report")
        {
            DataItemTableView = SORTING("Sales Order No.", "Product No.", Lot, "Production Order") ORDER(Ascending);
            column(Str_Rdso_report__Sales_Order_No__; "Sales Order No.")
            {
            }
            column(Str_Rdso_report__Production_Order_; "Production Order")
            {
            }
            column(Str_Rdso_report__Str_Rdso_report__Description; Description)
            {
            }
            column(Str_Rdso_report__Issued_Qty_; "Issued Qty")
            {
            }
            column(Str_Rdso_report_Lot; Lot)
            {
            }
            column(PO1; PO1)
            {
            }
            column(CONSUMPTION_SUMMARYCaption; CONSUMPTION_SUMMARYCaptionLbl)
            {
            }
            column(Sales_Order_NoCaption; Sales_Order_NoCaptionLbl)
            {
            }
            column(Production_OrdersCaption; Production_OrdersCaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(Issued_QtyCaption_Control1000000052; Issued_QtyCaption_Control1000000052Lbl)
            {
            }
            column(LOTCaption; LOTCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Str_Rdso_report_Issue_No_; "Issue No.")
            {
            }

            trigger OnPreDataItem()
            begin
                IF Choice3 <> Choice3::Summary THEN
                    CurrReport.BREAK;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(Choice3; Choice3)
                    {
                        Caption = 'Issues Wise';
                        ApplicationArea = All;
                    }
                    field(Choice1; Choice1)
                    {
                        Caption = 'Normal';
                        ApplicationArea = All;
                    }
                    field(Consider_Return; Consider_Return)
                    {
                        Caption = 'Consider Return';
                        ApplicationArea = All;
                    }
                    field(Choice2; Choice2)
                    {
                        Caption = 'If item need';
                        ApplicationArea = All;
                    }
                    field(EXCEL; EXCEL)
                    {
                        Caption = 'EXCEL';
                        ApplicationArea = All;
                    }
                    field(Sales_Order_No; Sales_Order_No)
                    {
                        Caption = 'Sales Order No';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF Choice3 <> Choice3::Summary THEN
                                ERROR('PLEASE SELECT THE SUMMARY OPTION');
                        end;
                    }
                    field(Item_No; Item_No)
                    {
                        Caption = 'Item No';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            IF Choice3 <> Choice3::Summary THEN
                                ERROR('PLEASE SELECT THE SUMMARY OPTION');
                        end;
                    }
                    field(Lot; Lot)
                    {
                        Caption = 'Lot';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin

                            IF Choice3 <> Choice3::Summary THEN
                                ERROR('PLEASE SELECT THE SUMMARY OPTION');
                        end;
                    }
                    field(Posting_From_Date; Posting_From_Date)
                    {
                        Caption = 'Posting From Date';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF Choice3 <> Choice3::Summary THEN
                                ERROR('PLEASE SELECT THE SUMMARY OPTION');

                            IF Posting_To_Date = 0D THEN
                                Posting_To_Date := Posting_From_Date;
                        end;
                    }
                    field(Posting_To_Date; Posting_To_Date)
                    {
                        Caption = 'Posting To Date';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF Choice3 <> Choice3::Summary THEN
                                ERROR('PLEASE SELECT THE SUMMARY OPTION');
                        end;
                    }
                    grid(Control1102152028)
                    {
                        GridLayout = Columns;
                        ShowCaption = false;
                        group(Control1102152027)
                        {
                            ShowCaption = false;
                            label("Considerations for Summary Report")
                            {
                                Caption = 'Considerations for Summary Report';
                                ShowCaption = false;
                                Style = Strong;
                                StyleExpr = TRUE;
                                ApplicationArea = All;
                            }
                            label("1) Before Entering the I/P in Summary Report I/P'S you must Select ""Summary Report"" Option")
                            {
                                Caption = '1) Before Entering the I/P in Summary Report I/P''S you must Select "Summary Report" Option';
                                ShowCaption = false;
                                Style = Strong;
                                StyleExpr = TRUE;
                                ApplicationArea = All;
                            }
                            label("2) There is 3 Combinations of I/P'S")
                            {
                                Caption = '2) There is 3 Combinations of I/P''S';
                                ShowCaption = false;
                                Style = Strong;
                                StyleExpr = TRUE;
                                ApplicationArea = All;
                            }
                            label("A) Sale Order No. and  Item No.")
                            {
                                Caption = 'A) Sale Order No. and  Item No.';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label("B) Item and  Lot No.")
                            {
                                Caption = 'B) Item and  Lot No.';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label("C) Item and  Posting Date")
                            {
                                Caption = 'C) Item and  Posting Date';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label("3) In Report we are Considering only Request which are Posted From STR - PROD")
                            {
                                Caption = '3) In Report we are Considering only Request which are Posted From STR - PROD';
                                ShowCaption = false;
                                Style = Strong;
                                StyleExpr = TRUE;
                                ApplicationArea = All;
                            }
                            label("4) Returns Should not Be Considered")
                            {
                                Caption = '4) Returns Should not Be Considered';
                                ShowCaption = false;
                                Style = Strong;
                                StyleExpr = TRUE;
                                ApplicationArea = All;
                            }
                        }
                    }
                }
            }
        }

        actions
        {
            area(creation)
            {
                group(Test1)
                {
                    action("RETURN TO STOCK")
                    {
                        Caption = 'RETURN TO STOCK';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin

                            IF (UPPERCASE(USERID) <> '93FD001') AND (UPPERCASE(USERID) <> 'SUPER') AND (UPPERCASE(USERID) <> '08PS002')
                              AND (UPPERCASE(USERID) <> '07PD007') THEN
                                ERROR('YOU DONT HAVE PERMISSION TO EXECUTE THIS FUNCTIONALIYT');
                            IF (RETURN_ITEM1 = '') THEN
                                ERROR('PLEASE ENTER THE ITEM');

                            IF PO_FILTER = '' THEN
                                ERROR('PLEASE ENTER THE PRODUCTION ORDER INFORMATION');
                            IF PO_LINE_NO = 0 THEN
                                ERROR('PLEASE ENTER THE CAR NO. ORDER INFORMATION');


                            PO.SETFILTER(PO."No.", PO_FILTER);
                            IF PO.FINDSET THEN
                                REPEAT
                                    ILE.RESET;
                                    ILE.SETCURRENTKEY("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.",
                                             "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
                                    ILE.SETRANGE("Entry Type", ILE."Entry Type"::Transfer);
                                    ILE.SETRANGE("Item No.", RETURN_ITEM1);
                                    ILE.SETRANGE("Location Code", 'PROD');
                                    ILE.SETRANGE(Open, TRUE);
                                    ILE.SETRANGE("ITL Doc No.", PO."No.");
                                    ILE.SETRANGE(ILE."ITL Doc Line No.", PO_LINE_NO);
                                    ILE.SETFILTER(ILE."Remaining Quantity", '>%1', 0);
                                    IF ILE.FINDLAST THEN              //anil added for last item
                                    BEGIN
                                        MATERIAL_ISSUES_HEADER.INIT;
                                        MATERIAL_ISSUES_HEADER."No." := GetNextNo;
                                        MATERIAL_ISSUES_HEADER.INSERT;
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'PROD');
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'STR');
                                        MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", ILE."ITL Doc No.");
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", ILE."ITL Doc Line No.");
                                        MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                        user.GET(USERID);
                                        MATERIAL_ISSUES_HEADER."Resource Name" := user."User Name";
                                        MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                                        MATERIAL_ISSUES_HEADER."Sales Order No." := PO."Sales Order No.";
                                        MATERIAL_ISSUES_HEADER.MODIFY;
                                        LineNo := 10000;
                                    END;
                                    REPEAT
                                        Item.GET(ILE."Item No.");
                                        MATERIAL_ISSUES_LINE.INIT;
                                        MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.", ILE."Item No.");
                                        MATERIAL_ISSUES_LINE."Line No." := LineNo;
                                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, REQUESTED_QTY);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", REQUESTED_QTY);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", REQUESTED_QTY);
                                        MATERIAL_ISSUES_LINE."Prod. Order No." := ILE."ITL Doc No.";
                                        MATERIAL_ISSUES_LINE."Prod. Order Line No." := ILE."ITL Doc Line No.";
                                        MATERIAL_ISSUES_LINE."Prod. Order Comp. Line No." := ILE."ITL Doc Ref Line No.";
                                        LineNo := LineNo + 10000;
                                        MATERIAL_ISSUES_LINE.INSERT;

                                        TrackingSpecification.INIT;
                                        TrackingSpecification."Order No." := MATERIAL_ISSUES_LINE."Document No.";
                                        TrackingSpecification."Order Line No." := MATERIAL_ISSUES_LINE."Line No.";
                                        TrackingSpecification."Item No." := MATERIAL_ISSUES_LINE."Item No.";
                                        TrackingSpecification."Location Code" := ILE."Location Code";
                                        TrackingSpecification."Lot No." := ILE."Lot No.";
                                        TrackingSpecification."Serial No." := ILE."Serial No.";
                                        TrackingSpecification."Actual Quantity" := MATERIAL_ISSUES_LINE.Quantity;
                                        TrackingSpecification."Actual Qty to Receive" := MATERIAL_ISSUES_LINE."Qty. to Receive";
                                        TrackingSpecification.Description := MATERIAL_ISSUES_LINE.Description;
                                        TrackingSpecification."Creation Date" := TODAY;
                                        TrackingSpecification."Appl.-to Item Entry" := ILE."Entry No.";
                                        TrackingSpecification."Warranty date" := ILE."Warranty Date";
                                        TrackingSpecification."Expiration Date" := ILE."Expiration Date";
                                        TrackingSpecification."Prod. Order No." := MATERIAL_ISSUES_LINE."Prod. Order No.";
                                        TrackingSpecification."Prod. Order Line No." := MATERIAL_ISSUES_LINE."Prod. Order Line No.";
                                        TrackingSpecification.Quantity := REQUESTED_QTY;
                                        TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                        TrackingSpecification.INSERT;
                                    UNTIL ILE.NEXT = 0;
                                    MATERIAL_ISSUES_LINE.RESET;
                                    MATERIAL_ISSUES_LINE.SETRANGE("Document No.", MATERIAL_ISSUES_HEADER."No.");
                                    MATERIAL_ISSUES_LINE.SETFILTER(Quantity, '<>0');
                                    IF NOT MATERIAL_ISSUES_LINE.FINDFIRST THEN
                                        ERROR(Text002, MATERIAL_ISSUES_HEADER."No.");
                                    MATERIAL_ISSUES_LINE.RESET;
                                    MATERIAL_ISSUES_HEADER.VALIDATE(Status, MATERIAL_ISSUES_HEADER.Status::Released);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released Date", WORKDATE);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released Time", TIME);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released By", USERID);
                                    MATERIAL_ISSUES_HEADER."Posting Date" := TODAY;
                                    IF MATERIAL_ISSUES_HEADER."Authorized Date" = 0D THEN
                                        MATERIAL_ISSUES_HEADER."Authorized Date" := TODAY;
                                    MATERIAL_ISSUES_HEADER.MODIFY;
                                    Issue_Post.Issues_Post(MATERIAL_ISSUES_HEADER);
                                UNTIL PO.NEXT = 0;
                        end;
                    }
                    action("POST DAMAGES")
                    {
                        Caption = 'POST DAMAGES';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin

                            IF (UPPERCASE(USERID) <> 'SUPER') THEN
                                ERROR('YOU DONT HAVE PERMISSION TO EXECUTE THIS FUNCTIONALIYT');

                            IF (RETURN_ITEM1 = '') THEN
                                ERROR('PLEASE ENTER THE ITEM');

                            IF PO_FILTER = '' THEN
                                ERROR('PLEASE ENTER THE PRODUCTION ORDER INFORMATION');
                            IF PO_LINE_NO = 0 THEN
                                ERROR('PLEASE ENTER THE CAR NO. ORDER INFORMATION');



                            PO.SETFILTER(PO."No.", PO_FILTER);
                            IF PO.FINDSET THEN
                                REPEAT
                                    ILE.RESET;
                                    ILE.SETCURRENTKEY("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.",
                                             "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
                                    ILE.SETRANGE("Entry Type", ILE."Entry Type"::Transfer);
                                    ILE.SETRANGE("Item No.", RETURN_ITEM1);
                                    ILE.SETRANGE("Location Code", 'PROD');
                                    ILE.SETRANGE(Open, TRUE);
                                    ILE.SETRANGE("ITL Doc No.", PO."No.");
                                    ILE.SETRANGE(ILE."ITL Doc Line No.", PO_LINE_NO);
                                    ILE.SETFILTER(ILE."Remaining Quantity", '>%1', 0);
                                    IF ILE.FINDSET THEN BEGIN
                                        MATERIAL_ISSUES_HEADER.INIT;
                                        MATERIAL_ISSUES_HEADER."No." := GetNextNo;
                                        MATERIAL_ISSUES_HEADER.INSERT;
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'PROD');
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'DAMAGE');
                                        MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", ILE."ITL Doc No.");
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", ILE."ITL Doc Line No.");
                                        MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                        user.GET(USERID);
                                        MATERIAL_ISSUES_HEADER."Resource Name" := user."User Name";
                                        MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                                        MATERIAL_ISSUES_HEADER."Sales Order No." := PO."Sales Order No.";
                                        MATERIAL_ISSUES_HEADER.MODIFY;
                                        LineNo := 10000;


                                        Item.GET(ILE."Item No.");
                                        MATERIAL_ISSUES_LINE.INIT;
                                        MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.", ILE."Item No.");
                                        MATERIAL_ISSUES_LINE."Line No." := LineNo;
                                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                        IF REQUESTED_QTY = 0 THEN BEGIN
                                            MATERIAL_ISSUES_LINE.VALIDATE(Quantity, ILE.Quantity);
                                            MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ILE.Quantity);
                                            MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", ILE.Quantity);

                                        END ELSE BEGIN
                                            MATERIAL_ISSUES_LINE.VALIDATE(Quantity, REQUESTED_QTY);
                                            MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", REQUESTED_QTY);
                                            MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", REQUESTED_QTY);
                                        END;
                                        MATERIAL_ISSUES_LINE."Prod. Order No." := ILE."ITL Doc No.";
                                        MATERIAL_ISSUES_LINE."Prod. Order Line No." := ILE."ITL Doc Line No.";
                                        MATERIAL_ISSUES_LINE."Prod. Order Comp. Line No." := ILE."ITL Doc Ref Line No.";
                                        LineNo := LineNo + 10000;
                                        MATERIAL_ISSUES_LINE.INSERT;

                                        TrackingSpecification.INIT;
                                        TrackingSpecification."Order No." := MATERIAL_ISSUES_LINE."Document No.";
                                        TrackingSpecification."Order Line No." := MATERIAL_ISSUES_LINE."Line No.";
                                        TrackingSpecification."Item No." := MATERIAL_ISSUES_LINE."Item No.";
                                        TrackingSpecification."Location Code" := ILE."Location Code";
                                        TrackingSpecification."Lot No." := ILE."Lot No.";
                                        TrackingSpecification."Serial No." := ILE."Serial No.";
                                        TrackingSpecification."Actual Quantity" := MATERIAL_ISSUES_LINE.Quantity;
                                        TrackingSpecification."Actual Qty to Receive" := MATERIAL_ISSUES_LINE."Qty. to Receive";
                                        TrackingSpecification.Description := MATERIAL_ISSUES_LINE.Description;
                                        TrackingSpecification."Creation Date" := TODAY;
                                        TrackingSpecification."Appl.-to Item Entry" := ILE."Entry No.";
                                        TrackingSpecification."Warranty date" := ILE."Warranty Date";
                                        TrackingSpecification."Expiration Date" := ILE."Expiration Date";
                                        TrackingSpecification."Prod. Order No." := MATERIAL_ISSUES_LINE."Prod. Order No.";
                                        TrackingSpecification."Prod. Order Line No." := MATERIAL_ISSUES_LINE."Prod. Order Line No.";
                                        IF REQUESTED_QTY = 0 THEN
                                            TrackingSpecification.Quantity := ILE.Quantity
                                        ELSE
                                            TrackingSpecification.Quantity := REQUESTED_QTY;
                                        TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                        TrackingSpecification.INSERT;

                                        MATERIAL_ISSUES_LINE.RESET;
                                        MATERIAL_ISSUES_LINE.SETRANGE("Document No.", MATERIAL_ISSUES_HEADER."No.");
                                        MATERIAL_ISSUES_LINE.SETFILTER(Quantity, '<>0');
                                        IF NOT MATERIAL_ISSUES_LINE.FINDFIRST THEN
                                            ERROR(Text002, MATERIAL_ISSUES_HEADER."No.");

                                        MATERIAL_ISSUES_LINE.RESET;
                                        MATERIAL_ISSUES_HEADER.VALIDATE(Status, MATERIAL_ISSUES_HEADER.Status::Released);
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Released Date", WORKDATE);
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Released Time", TIME);
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Released By", USERID);
                                        MATERIAL_ISSUES_HEADER."Posting Date" := TODAY;
                                        IF MATERIAL_ISSUES_HEADER."Authorized Date" = 0D THEN
                                            MATERIAL_ISSUES_HEADER."Authorized Date" := TODAY;
                                        MATERIAL_ISSUES_HEADER.MODIFY;
                                        Issue_Post.Issues_Post(MATERIAL_ISSUES_HEADER);

                                        /*    // CRETION OF NEW MATERIAL REQUEST
                                            MATERIAL_ISSUES_HEADER.RESET;
                                            MATERIAL_ISSUES_HEADER.INIT;
                                            MATERIAL_ISSUES_HEADER."No.":=GetNextNo;
                                            MATERIAL_ISSUES_HEADER.INSERT;
                                            MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code",'STR');
                                            MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code",'PROD');
                                            MATERIAL_ISSUES_HEADER."Receipt Date":=TODAY;
                                            MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", ILE."ITL Doc No.");
                                            MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.",ILE."ITL Doc Line No.");
                                            MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                            user.GET(USERID);
                                            MATERIAL_ISSUES_HEADER."Resource Name":=user.Name;
                                            MATERIAL_ISSUES_HEADER."Creation DateTime":=CURRENTDATETIME;
                                            MATERIAL_ISSUES_HEADER."Sales Order No.":=PO."Sales Order No.";
                                            MATERIAL_ISSUES_HEADER.MODIFY;
                                            LineNo:=10000;

                                            Item.GET(RETURN_ITEM1);
                                            MATERIAL_ISSUES_LINE.INIT;
                                            MATERIAL_ISSUES_LINE."Document No." :=MATERIAL_ISSUES_HEADER."No." ;
                                            MATERIAL_ISSUES_LINE.VALIDATE("Item No.",RETURN_ITEM1);
                                            MATERIAL_ISSUES_LINE."Line No." := LineNo ;
                                            MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
                                            MATERIAL_ISSUES_LINE.VALIDATE(Quantity,ILE.Quantity);
                                            MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ILE.Quantity);
                                            MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity",ILE.Quantity);
                                            MATERIAL_ISSUES_LINE."Prod. Order No." := ILE."ITL Doc No.";
                                            MATERIAL_ISSUES_LINE."Prod. Order Line No." :=ILE."ITL Doc Line No.";
                                            MATERIAL_ISSUES_LINE."Prod. Order Comp. Line No." := ILE."ITL Doc Ref Line No.";
                                            LineNo := LineNo + 10000;
                                            MATERIAL_ISSUES_LINE.INSERT;  */
                                    END;
                                UNTIL PO.NEXT = 0;

                        end;
                    }
                    action("CREATE SINGLE REQUESTS")
                    {
                        Caption = 'CREATE SINGLE REQUESTS';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin

                            IF (UPPERCASE(USERID) <> '93FD001') AND (UPPERCASE(USERID) <> 'SUPER') AND (UPPERCASE(USERID) <> '07PD007') THEN
                                ERROR('YOU DONT HAVE PERMISSION TO EXECUTE THIS FUNCTIONALIYT');

                            IF (RETURN_ITEM1 = '') THEN
                                ERROR('PLEASE ENTER THE ITEM');

                            IF REQUESTED_QTY = 0 THEN
                                ERROR('PLEASE ENTER THE REQUESTED QUANTITY');
                            IF PO_FILTER = '' THEN
                                ERROR('PLEASE ENTER THE PRODUCTION ORDER INFORMATION');
                            IF PO_LINE_NO = 0 THEN
                                ERROR('PLEASE ENTER THE CAR NO. ORDER INFORMATION');


                            PO.SETFILTER(PO."No.", PO_FILTER);
                            IF PO.FINDSET THEN
                                REPEAT
                                    MATERIAL_ISSUES_HEADER.INIT;
                                    MATERIAL_ISSUES_HEADER."No." := GetNextNo;
                                    MATERIAL_ISSUES_HEADER.INSERT;
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'STR');
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'PROD');
                                    MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", PO."No.");
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", PO_LINE_NO);
                                    MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                    user.GET(USERID);
                                    MATERIAL_ISSUES_HEADER."Resource Name" := user."User Name";
                                    MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                                    MATERIAL_ISSUES_HEADER."Sales Order No." := PO."Sales Order No.";
                                    MATERIAL_ISSUES_HEADER.MODIFY;
                                    LineNo := 10000;

                                    Item.GET(RETURN_ITEM1);
                                    MATERIAL_ISSUES_LINE.INIT;
                                    MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                                    MATERIAL_ISSUES_LINE.VALIDATE("Item No.", RETURN_ITEM1);
                                    MATERIAL_ISSUES_LINE."Line No." := LineNo;
                                    MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                    MATERIAL_ISSUES_LINE.VALIDATE(Quantity, REQUESTED_QTY);
                                    MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", REQUESTED_QTY);
                                    MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", REQUESTED_QTY);
                                    MATERIAL_ISSUES_LINE."Prod. Order No." := PO."No.";
                                    MATERIAL_ISSUES_LINE."Prod. Order Line No." := PO_LINE_NO;
                                    LineNo := LineNo + 10000;
                                    MATERIAL_ISSUES_LINE.INSERT;

                                    MATERIAL_ISSUES_LINE.RESET;
                                    MATERIAL_ISSUES_LINE.SETRANGE("Document No.", MATERIAL_ISSUES_HEADER."No.");
                                    MATERIAL_ISSUES_LINE.SETFILTER(Quantity, '<>0');
                                    IF NOT MATERIAL_ISSUES_LINE.FINDFIRST THEN
                                        ERROR(Text002, MATERIAL_ISSUES_HEADER."No.");

                                    MATERIAL_ISSUES_LINE.RESET;
                                    MATERIAL_ISSUES_HEADER.VALIDATE(Status, MATERIAL_ISSUES_HEADER.Status::Released);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released Date", WORKDATE);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released Time", TIME);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released By", USERID);
                                    MATERIAL_ISSUES_HEADER."Posting Date" := TODAY;
                                    IF MATERIAL_ISSUES_HEADER."Authorized Date" = 0D THEN
                                        MATERIAL_ISSUES_HEADER."Authorized Date" := TODAY;
                                    MATERIAL_ISSUES_HEADER.MODIFY;
                                UNTIL PO.NEXT = 0;
                        end;
                    }
                }
            }
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF EXCEL THEN BEGIN
            /*Tempexcelbuffer.CreateBook('Issued Material Report');//B2B
            Tempexcelbuffer.WriteSheet('Issued Material Report',COMPANYNAME,USERID);//B2b
            Tempexcelbuffer.CloseBook; //Rev01
            Tempexcelbuffer.OpenExcel; //Rev01
            Tempexcelbuffer.GiveUserControl;*/
            //Tempexcelbuffer.CreateBookAndOpenExcel('Issued Material Report','Issued Material sheet',COMPANYNAME,USERID,''); //EFFUPG
            Tempexcelbuffer.CreateBookAndOpenExcel('', 'Issued Material Report', 'Issued Material Report', COMPANYNAME, USERID); //EFFUPG
        END;

    end;

    trigger OnPreReport()
    begin
        IF EXCEL THEN BEGIN
            CLEAR(Tempexcelbuffer);
            Tempexcelbuffer.DELETEALL;
        END;
    end;

    var
        QTY: Decimal;
        "material issues line": Record "Material Issues Line";
        Reason: Code[100];
        Choice1: Option Normal,Damage,Return;
        Choice2: Option Used,NotUsed;
        ILE: Record "Item Ledger Entry";
        Lot: Code[100];
        Item: Record Item;
        UC: Decimal;
        Total: Decimal;
        "Serial no": Code[20];
        Choice3: Option Issue,Project,WRET,Summary;
        "Project Total": Decimal;
        Project_Desc: Text[100];
        PO: Record "Production Order";
        "R&D total": Decimal;
        ILE2: Record "Item Ledger Entry";
        Tempexcelbuffer: Record "Excel Buffer" temporary;
        EXCEL: Boolean;
        Row: Integer;
        "Prod. Order Description": Text[50];
        "Bench-Mark": Integer;
        "Issued Date": Date;
        Total_Qty: Decimal;
        PRL: Record "Purch. Rcpt. Line";
        ITEMLED: Record "Item Ledger Entry";
        vendor: Text[50];
        PRH: Record "Purch. Rcpt. Header";
        "BILLNO.": Code[35];
        BillDate: Date;
        Desc: Text[50];
        Value: Decimal;
        "Total Value": Decimal;
        Ret_Qty: Decimal;
        PMIL: Record "Posted Material Issues Line";
        PMIH: Record "Posted Material Issues Header";
        PIL: Record "Purch. Inv. Line";
        Consider_Return: Boolean;
        Issued_Qty: Decimal;
        ILE3: Record "Item Ledger Entry";
        RETURN_ITEM1: Code[20];
        RETURN_ITEM2: Code[20];
        RETURN_ITEM3: Code[20];
        RETURN_ITEM4: Code[20];
        PO_FILTER: Text[100];
        PO_LINE_NO: Integer;
        POR_LINE_CONFIRM: Boolean;
        MATERIAL_ISSUES_HEADER: Record "Material Issues Header";
        MATERIAL_ISSUES_LINE: Record "Material Issues Line";
        PO_FORM: Page "Released Production Order";
        user: Record User;
        REPLACE_ITEM_FILTER: Text[100];
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        LineNo: Integer;
        "Release MaterialIssue Document": Codeunit "Release MaterialIssue Document";
        Issue_Post: Codeunit "MaterialIssueOrde-Post Receipt";
        Text002: Label 'There is nothing to release for MaterialIssue order %1.';
        REQUESTED_QTY: Decimal;
        Sales_Order_No: Code[30];
        Item_No: Code[30];
        Posting_From_Date: Date;
        ItemLotNumbers: Record "Item Lot Numbers" temporary;
        BREAKVar: Boolean;
        PO1: Code[20];
        Posting_To_Date: Date;
        ileref: Code[30];
        DV: Record "Dimension Value";
        Item_Batch: Record Old_Pur_Invoices;
        Material_IssuesCaptionLbl: Label 'Material Issues';
        Project_CodeCaptionLbl: Label 'Project Code';
        Requisition_NoCaptionLbl: Label 'Requisition No';
        Item_CaptionLbl: Label 'Item ';
        UOMCaptionLbl: Label 'UOM';
        Employee_NameCaptionLbl: Label 'Employee Name';
        Reqested_DateCaptionLbl: Label 'Reqested Date';
        DeptCaptionLbl: Label 'Dept';
        Quantity_RequestedCaptionLbl: Label 'Quantity Requested';
        Quantity_ReceivedCaptionLbl: Label 'Quantity Received';
        Unit_costCaptionLbl: Label 'Unit cost';
        LOT_No_CaptionLbl: Label 'LOT No.';
        Serial_No_CaptionLbl: Label 'Serial No.';
        Bench_MarkCaptionLbl: Label 'Bench Mark';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Bill_No_CaptionLbl: Label 'Bill No.';
        Bill_DateCaptionLbl: Label 'Bill Date';
        Issued_Date_TimeCaptionLbl: Label 'Issued Date Time';
        Material_IssuesCaption_Control1102154002Lbl: Label 'Material Issues';
        Project_CodeCaption_Control1102154004Lbl: Label 'Project Code';
        ValueCaptionLbl: Label 'Value';
        Project_DescriptionCaptionLbl: Label 'Project Description';
        DaysCaptionLbl: Label 'Days';
        DaysCaption_Control1102154011Lbl: Label 'Days';
        DaysCaption_Control1102154013Lbl: Label 'Days';
        DaysCaption_Control1102154018Lbl: Label 'Days';
        Material_IssuesCaption_Control1102154030Lbl: Label 'Material Issues';
        Item_No_CaptionLbl: Label 'Item No.';
        ValueCaption_Control1102154033Lbl: Label 'Value';
        DescriptionCaptionLbl: Label 'Description';
        Issued_QtyCaptionLbl: Label 'Issued Qty';
        Return_QtyCaptionLbl: Label 'Return Qty';
        CONSUMPTION_SUMMARYCaptionLbl: Label 'CONSUMPTION SUMMARY';
        Sales_Order_NoCaptionLbl: Label 'Sales Order No';
        Production_OrdersCaptionLbl: Label 'Production Orders';
        ItemCaptionLbl: Label 'Item';
        Issued_QtyCaption_Control1000000052Lbl: Label 'Issued Qty';
        LOTCaptionLbl: Label 'LOT';
        EmptyStringCaptionLbl: Label '-';
        GrpFVisible1: Boolean;
        GrpFVisible2: Boolean;
        GrpFVisible3: Boolean;
        GrpFVisible4: Boolean;
        GrpFVisible5: Boolean;
        PrevProdOrderNo: Code[20];
        PrevItemNo: Code[20];
        PIH: Record "Purch. Inv. Header";
        QTY_Received: Decimal;
        TESTINV: Integer;
        Reasoncode: Record "Reason Code";
        PMINumbers: Text;
        PMINumbers1: Text;
        ItmLedEnt: Record "Item Ledger Entry";
        RemainingQty: Decimal;


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option)
    begin

        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := CellValue;
        Tempexcelbuffer.Bold := bold;
        Tempexcelbuffer."Cell Type" := CellType;
        Tempexcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option)
    begin
        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        Tempexcelbuffer.Bold := Bold;
        Tempexcelbuffer."Cell Type" := CellType;
        Tempexcelbuffer.Formula := '';
        Tempexcelbuffer.INSERT;
    end;


    procedure "Entercell New"()
    begin
    end;


    procedure GetNextNo() NumberValue: Code[20]
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

        //IF DATE2DMY(WORKDATE,3) < 99 THEN
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
}

