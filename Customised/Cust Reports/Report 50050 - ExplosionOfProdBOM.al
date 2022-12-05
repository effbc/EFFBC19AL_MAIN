report 50050 "Explosion Of Prod. BOM"
{
    //     Entercell(ROW,1,"Production BOM Line"."No.",FALSE);
    //     Entercell(ROW,2,"Production BOM Line".Description,FALSE);
    //     Entercell(ROW,3,FORMAT("Production BOM Line".Quantity),FALSE);
    //     Entercell(ROW,4,"Production BOM Line"."Unit of Measure Code",FALSE);
    //     Entercell(ROW,5,FORMAT(Item."Safety Lead Time"),FALSE);
    //     Entercell(ROW,6,FORMAT(ROUND(UC)),FALSE);
    //     Entercell(ROW,7,FORMAT(ROUND(TC)),FALSE);
    //     Entercell(ROW,8,"Production BOM Line".Position,FALSE);
    //     Entercell(ROW,9,FORMAT(Item."Item Category Code"),FALSE);
    //     Entercell(ROW,10,FORMAT(Item."Product Group Code"),FALSE);
    //     Entercell(ROW,11,FORMAT(Item."Item Sub Group Code"),FALSE);
    //     Entercell(ROW,12,FORMAT(Item."Item Sub Sub Group Code"),FALSE);
    //     Entercell(ROW,13,FORMAT(Item."Type of Solder"),FALSE);
    //     Entercell(ROW,14,FORMAT(Item."No. of Pins"),FALSE);
    //     Entercell(ROW,15,FORMAT(Item."No. of Soldering Points"),FALSE);
    //     Entercell(ROW,16,FORMAT(Item.Make),FALSE);
    //     Entercell(ROW,17,FORMAT(Item."Operating Temperature"),FALSE);
    //     Entercell(ROW,18,FORMAT(Item."Storage Temperature"),FALSE);
    //     Entercell(ROW,19,FORMAT(Item.Humidity),FALSE);
    //     Entercell(ROW,20,FORMAT(Item."ESD Sensitive"),FALSE);
    //     Entercell(ROW,21,FORMAT(Item."Item Status"),FALSE);
    //     Entercell(ROW,22,FORMAT(Item."Soldering Temp."),FALSE);
    //     Entercell(ROW,23,FORMAT(Item."Soldering Time (Sec)"),FALSE);
    //     Entercell(ROW,24,FORMAT(Item."Work area Temp &  Humadity"),FALSE);
    //     Entercell(ROW,25,FORMAT(Item.ESD),FALSE);
    //     Entercell(ROW,26,Item.Package,FALSE);
    //     Entercell(ROW,27,Item."Part Number",FALSE);
    DefaultLayout = RDLC;
    RDLCLayout = './ExplosionOfProdBOM.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Production BOM Header"; "Production BOM Header")
        {
            RequestFilterFields = "No.";
            column(Prod_BOM_Head_ChoiceBomMod; ChoiceBomMod)
            {
            }
            column(Prod_BOM_Head_ChoiceERT; ChoiceERT)
            {
            }
            column(Prod_BOM_Head_ChoiceFForm; ChoiceFForm)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Production_BOM_Header__No__; "No.")
            {
            }
            column(Production_BOM_Header_Description; Description)
            {
            }
            column(Explosion_of_BOMCaption; Explosion_of_BOMCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Production_BOM_No_Caption; Production_BOM_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            dataitem("Production BOM Line"; "Production BOM Line")
            {
                DataItemLink = "Production BOM No." = FIELD("No.");
                DataItemTableView = SORTING("Tot Avg Cost") ORDER(Descending);
                column(Prod_BOM_Line_ChoiceItem; ChoiceItem)
                {
                }
                column(ROUND_TUC1_0_01__Control1102154177; ROUND(TUC1, 0.01))
                {
                }
                column(Prod_BOM_Line_ProdBomLineFooter5; ProdBomLineFooter5)
                {
                }
                column(Prod_BOM_Line_ChoiceBomMod; ChoiceBomMod)
                {
                }
                column(Prod_BOM_Line_ChoiceCategory; ChoiceCategory)
                {
                }
                column(Prod_BOM_Line_BOUT; BOUT)
                {
                }
                column(ISSGC; ISSGC)
                {
                }
                column(ISGC; ISGC)
                {
                }
                column(PGC; PGC)
                {
                }
                column(ICC; ICC)
                {
                }
                column(Production_BOM_Line_Description; Description)
                {
                }
                column(Production_BOM_Line__No__; "No.")
                {
                }
                column(Production_BOM_Line_Position; Position)
                {
                }
                column(ROUND_TC_0_01_; ROUND(TC, 0.01))
                {
                }
                column(ROUND_UC_0_01_; ROUND(UC, 0.01))
                {
                }
                column(Production_BOM_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Production_BOM_Line_Quantity; Quantity)
                {
                }
                column(Production_BOM_Line_Description_Control1000000055; Description)
                {
                }
                column(Production_BOM_Line__No___Control1000000056; "No.")
                {
                }
                column(Production_BOM_Line_Position_Control1000000061; Position)
                {
                }
                column(Item__Safety_Lead_Time_; Item."Safety Lead Time")
                {
                }
                column(ROUND_TUC1_0_01_; ROUND(TUC1, 0.01))
                {
                }
                column(Item_Sub_Sub_Group_CodeCaption; Item_Sub_Sub_Group_CodeCaptionLbl)
                {
                }
                column(Item_Sub_Group_codeCaption; Item_Sub_Group_codeCaptionLbl)
                {
                }
                column(Product_Group_CodeCaption; Product_Group_CodeCaptionLbl)
                {
                }
                column(Item_Category_CodeCaption; Item_Category_CodeCaptionLbl)
                {
                }
                column(DescriptionCaption_Control1000000100; DescriptionCaption_Control1000000100Lbl)
                {
                }
                column(ItemCaption; ItemCaptionLbl)
                {
                }
                column(PositionCaption; PositionCaptionLbl)
                {
                }
                column(ItemCaption_Control1000000029; ItemCaption_Control1000000029Lbl)
                {
                }
                column(DescriptionCaption_Control1000000030; DescriptionCaption_Control1000000030Lbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(Unit_of_MeasureCaption; Unit_of_MeasureCaptionLbl)
                {
                }
                column(Unit_CostCaption; Unit_CostCaptionLbl)
                {
                }
                column(Total_CostCaption; Total_CostCaptionLbl)
                {
                }
                column(PositionCaption_Control1000000067; PositionCaption_Control1000000067Lbl)
                {
                }
                column(Lead_TimeCaption; Lead_TimeCaptionLbl)
                {
                }
                column(TOTALCaption; TOTALCaptionLbl)
                {
                }
                column(Production_BOM_Line_Production_BOM_No_; "Production BOM No.")
                {
                }
                column(Production_BOM_Line_Version_Code; "Version Code")
                {
                }
                column(Production_BOM_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Rev01 Start

                    //Production BOM Line, Header (1) - OnPreSection()
                    //CurrReport.SHOWOUTPUT(Choice=Choice::Category); //Rev01
                    CurrReport.SHOWOUTPUT(ChoiceCategory);
                    //Production BOM Line, Header (1) - OnPreSection()

                    //Production BOM Line, Header (2) - OnPreSection()
                    //CurrReport.SHOWOUTPUT(NOT (Choice=Choice::Category)); //Rev01
                    //CurrReport.SHOWOUTPUT(NOT ChoiceCategory);
                    //Production BOM Line, Header (2) - OnPreSection()

                    //Production BOM Line, Body (3) - OnPreSection()
                    //IF Choice=Choice::Category THEN BEGIN //Rev01
                    IF ChoiceCategory THEN BEGIN
                        Item.SETRANGE(Item."No.", "Production BOM Line"."No.");
                        IF Item.FIND('-') THEN BEGIN
                            ICC := Item."Product Group Code Cust";
                            PGC := Item."Product Group Code Cust";
                            ISGC := Item."Item Sub Group Code";
                            ISSGC := Item."Item Sub Sub Group Code";
                        END;
                    END ELSE
                        //CurrReport.SHOWOUTPUT := FALSE;
                        //Production BOM Line, Body (3) - OnPreSection()

                        //Production BOM Line, Body (4) - OnPreSection()
                        UC := 0;
                    TC := 0;
                    //TUC1 := 0; //Rev01 //ADSK

                    //IF Choice=Choice::Item THEN BEGIN  //Rev01
                    IF ChoiceItem THEN BEGIN
                        IF PBH.GET("Production BOM Line"."No.") THEN BEGIN
                            UC := PRODUCTION_BOM_COST("Production BOM Line"."No.");
                            Temp := 'C'
                        END ELSE BEGIN
                            IF Item.GET("Production BOM Line"."No.") THEN
                                UC := Item."Item Final Cost";
                            Temp := 'E';
                        END;
                        TC := "Production BOM Line".Quantity * UC;
                        TUC1 += TC;
                        IF Want_Excel THEN BEGIN
                            ROW += 1;
                            Entercell(ROW, 1, "Production BOM Line"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 2, "Production BOM Line".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 3, FORMAT("Production BOM Line".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(ROW, 4, "Production BOM Line"."Unit of Measure Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 5, FORMAT(Item."Safety Lead Time"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                            IF With_Cost = TRUE THEN BEGIN
                                Entercell(ROW, 30, FORMAT(ROUND(UC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 31, FORMAT(ROUND(TC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            END;
                            Entercell(ROW, 25, "Production BOM Line".Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 26, "Production BOM Line"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 27, "Production BOM Line"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 28, "Production BOM Line"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(ROW, 29, FORMAT("Production BOM Line"."BOM Type"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                            IF Item.GET("Production BOM Line"."No.") THEN BEGIN
                                Entercell(ROW, 6, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 7, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 8, FORMAT(Item."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 9, FORMAT(Item."Item Sub Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 10, FORMAT(Item."Type of Solder"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 11, FORMAT(Item."No. of Pins"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 12, FORMAT(Item."No. of Soldering Points"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 13, FORMAT(Item.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 14, FORMAT(Item."Operating Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 15, FORMAT(Item."Storage Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 16, FORMAT(Item.Humidity), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 17, FORMAT(Item."ESD Sensitive"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 18, FORMAT(Item."Item Status"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 19, FORMAT(Item."Soldering Temp."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 20, FORMAT(Item."Soldering Time (Sec)"), FALSE, Tempexcelbuffer."Cell Type"::Time);
                                Entercell(ROW, 21, FORMAT(Item."Work area Temp &  Humadity"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 22, FORMAT(Item.ESD), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 23, Item.Package, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 24, Item."Part Number", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            END;
                        END;
                    END ELSE
                        ;
                    //CurrReport.SHOWOUTPUT := FALSE;

                    //Produmection BOM Line, Body (4) - OnPreSection()

                    //Rev01 End

                    //IF ((Choice=Choice::Item) AND (NOT BOUT)) THEN BEGIN //Rev01
                end;

                trigger OnPostDataItem()
                begin
                    //Production BOM Line, Footer (5) - OnPreSection()

                    "Bin Type".RESET;
                    "Bin Type".SETRANGE("Bin Type".Code, "Production BOM Header"."No.");
                    IF "Bin Type".FIND('-') THEN
                        BOUT := TRUE;
                    IF ((ChoiceItem) AND (NOT BOUT)) THEN BEGIN
                        ProdBomLineFooter5 := TRUE;
                        IF Want_Excel THEN BEGIN
                            ROW := ROW + 1;
                            //Entercell(ROW,7,FORMAT(TUC1),TRUE,Tempexcelbuffer."Cell Type" :: Text); //ADSK
                            IF With_Cost = TRUE THEN
                                Entercell(ROW, 30, FORMAT(ROUND(TUC1)), TRUE, Tempexcelbuffer."Cell Type"::Text); //ADSK
                                                                                                                  //added ROUND() by swathi on 19-Sep-13
                            ROW := ROW + 1;
                        END;
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        ProdBomLineFooter5 := FALSE;
                    //Production BOM Line, Footer (5) - OnPreSection()
                end;

                trigger OnPreDataItem()
                begin
                    //IF Choice=Choice::FForm THEN //Rev01
                    IF ChoiceFForm THEN
                        CurrReport.BREAK;

                    "Production BOM Line".SETRANGE("Production BOM Line"."Version Code", ActiveVersionCode);
                    Total := 0;
                    TUC2 := 0;
                end;
            }
            dataitem("<Production BOM Line3>"; "Production BOM Line")
            {
                DataItemLink = "Production BOM No." = FIELD("No.");
                DataItemTableView = SORTING("Production BOM No.", "Version Code", "Line No.") WHERE("No." = FILTER(<> ''));
                column(Prod_BOM_Line3_ChoiceFForm; ChoiceFForm)
                {
                }
                column(Production_BOM_Line3___No__; "No.")
                {
                }
                column(Production_BOM_Line3__Description; Description)
                {
                }
                column(Production_BOM_Line3__Quantity; Quantity)
                {
                }
                column(Production_BOM_Line3___Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Position1; Position1)
                {
                }
                column(Production_BOM_Line3___Description_2_; "Description 2")
                {
                }
                column(AIitem; AIitem)
                {
                }
                column(POSITIONCaption_Control1000000073; POSITIONCaption_Control1000000073Lbl)
                {
                }
                column(QUANTITYCaption_Control1000000074; QUANTITYCaption_Control1000000074Lbl)
                {
                }
                column(DESCRIPTIONCaption_Control1000000075; DESCRIPTIONCaption_Control1000000075Lbl)
                {
                }
                column(ITEMCaption_Control1000000076; ITEMCaption_Control1000000076Lbl)
                {
                }
                column(UNIT_OF_MEASURECaption_Control1000000066; UNIT_OF_MEASURECaption_Control1000000066Lbl)
                {
                }
                column(DESCRIPTION_2Caption; DESCRIPTION_2CaptionLbl)
                {
                }
                column(ALTERNATE_ITEMSCaption; ALTERNATE_ITEMSCaptionLbl)
                {
                }
                column(Production_BOM_Line3__Production_BOM_No_; "Production BOM No.")
                {
                }
                column(Production_BOM_Line3__Version_Code; "Version Code")
                {
                }
                column(Production_BOM_Line3__Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CNT += 1;
                    // Position:='';

                    //Rev01 Start

                    //<Production BOM Line3>, Header (1) - OnPreSection()
                    //IF Choice=Choice::FForm THEN BEGIN //Rev01
                    //<Production BOM Line3>, Header (1) - OnPreSection()

                    //<Production BOM Line3>, Body (2) - OnPreSection()
                    //CurrReport.SHOWOUTPUT(Choice=Choice::FForm); //Rev01
                    CurrReport.SHOWOUTPUT(ChoiceFForm);

                    IF ChoiceFForm THEN BEGIN
                        // MESSAGE(FORMAT(STRLEN("<Production BOM Line3>".Position+"<Production BOM Line3>"."Position 2"+
                        //                       "<Production BOM Line3>"."Position 3"+"<Production BOM Line3>"."Position 4") ));
                        // Length:=STRLEN("<Production BOM Line3>".Position+"<Production BOM Line3>"."Position 2"+
                        //          "<Production BOM Line3>"."Position 3"+"<Production BOM Line3>"."Position 4");

                        AIitem := '';                            //Modified on 7-Jul-09

                        itemno := "<Production BOM Line3>"."No.";
                        AI.RESET;
                        AI.SETRANGE(AI."Proudct Type", product);
                        AI.SETRANGE(AI."Item No.", itemno);
                        IF AI.FIND('-') THEN
                            REPEAT
                                AIitem += AI."Alternative Item Description";
                            UNTIL AI.NEXT = 0;

                        Position1 := "<Production BOM Line3>".Position;
                        Position1 += ' ' + "<Production BOM Line3>"."Position 2";
                        Position1 += ' ' + "<Production BOM Line3>"."Position 3";
                        Position1 += ' ' + "<Production BOM Line3>"."Position 4";
                        // MESSAGE("<Production BOM Line3>".Position);
                        // Length:=STRLEN(Position1);
                        IF Want_Excel THEN BEGIN
                            IF Length <= 60 THEN BEGIN
                                Entercell(ROW, 1, "<Production BOM Line3>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 2, "<Production BOM Line3>"."Description 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 3, AIitem, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 4, FORMAT("<Production BOM Line3>".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 5, "<Production BOM Line3>".Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 6, "<Production BOM Line3>"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 7, "<Production BOM Line3>"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 8, "<Production BOM Line3>"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                ROW += 1;
                            END ELSE BEGIN
                                i := 1;
                                WHILE Length > 60 DO BEGIN
                                    TMP_Position := COPYSTR(Position1, 1, 60);
                                    IF i = 1 THEN BEGIN
                                        Entercell(ROW, 1, "<Production BOM Line3>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 2, "<Production BOM Line3>"."Description 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 3, AIitem, FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 4, FORMAT("<Production BOM Line3>".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 5, TMP_Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        ROW += 1;
                                        i += 1;
                                        Length -= 60;
                                    END ELSE BEGIN
                                        TMP_Position := COPYSTR(Position1, ((i - 1) * 60) + 1, 60);
                                        Entercell(ROW, 5, TMP_Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        ROW += 1;
                                        Length -= 60;
                                        i += 1;
                                    END;
                                END;
                                TMP_Position := COPYSTR(Position1, ((i - 1) * 60) + 1, Length);
                                Entercell(ROW, 5, TMP_Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                // Entercell(ROW,4,FORMAT(Length),FALSE);
                                ROW += 1;
                            END;
                        END;
                    END;
                    //<Production BOM Line3>, Body (2) - OnPreSection()


                    //Rev01 End
                end;

                trigger OnPostDataItem()
                begin
                    //MESSAGE(FORMAT(CNT));
                end;

                trigger OnPreDataItem()
                begin
                    //IF Choice<>Choice::FForm THEN //Rev01
                    IF NOT ChoiceFForm THEN
                        CurrReport.BREAK;

                    TUC2 := 0;
                    //IF Fill_Form_Choice=Fill_Form_Choice::SMD THEN //Rev01
                    IF Fill_Form_ChoiceSMD THEN
                        "<Production BOM Line3>".SETRANGE("<Production BOM Line3>"."Type of Solder", "<Production BOM Line3>"."Type of Solder"::SMD)
                    //ELSE IF Fill_Form_Choice=Fill_Form_Choice::DIP THEN //Rev01
                    ELSE
                        IF Fill_Form_ChoiceDIP THEN
                            "<Production BOM Line3>".SETFILTER("<Production BOM Line3>"."Type of Solder", 'DIP|'' ''');



                    "<Production BOM Line3>".SETRANGE("<Production BOM Line3>"."Version Code", ActiveVersionCode);


                    IF ChoiceFForm THEN BEGIN
                        //CurrReport.SHOWOUTPUT := TRUE;//B2BUpg
                        ROW += 1;
                        IF Want_Excel THEN BEGIN
                            EnterHeadings(ROW, 1, 'Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 2, 'Description2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 3, 'Alternate Item', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 4, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 5, 'Position', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 6, 'Position2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 7, 'Position3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 8, 'Position4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            ROW += 1;
                        END;
                    END ELSE
                        ;
                    //CurrReport.SHOWOUTPUT := FALSE;//B2BUpg
                end;
            }
            dataitem("Bin Type"; "Bin Type")
            {
                DataItemLink = Code = FIELD("No.");
                DataItemTableView = SORTING(Code, "Item No") ORDER(Ascending);
                column(Bin_Type_ChoiceItem; ChoiceItem)
                {
                }
                column(ROUND_TC_0_01__Control1102154181; ROUND(TC, 0.01))
                {
                }
                column(ROUND_UC_0_01__Control1102154182; ROUND(UC, 0.01))
                {
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Bin_Type_QTY; QTY)
                {
                }
                column(Bin_Type_Description; Description)
                {
                }
                column(Bin_Type__Item_No_; "Item No")
                {
                }
                column(Item__Safety_Lead_Time__Control1102154188; Item."Safety Lead Time")
                {
                }
                column(TOTALCaption_Control1102154179; TOTALCaption_Control1102154179Lbl)
                {
                }
                column(Bin_Type_Code; Code)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Rev01 Start

                    //Bin Type, Body (2) - OnPreSection()
                    //IF (Choice=Choice::Item)  THEN BEGIN //Rev01
                    //TUC1 := 0; //Rev01
                    IF (ChoiceItem) THEN BEGIN
                        Item.RESET;
                        IF Item.GET("Bin Type"."Item No") THEN BEGIN
                            UC := Item."Item Final Cost";
                            TC := Item."Item Final Cost" * "Bin Type".QTY;
                            TUC1 += TC;
                            //IF (Choice=Choice::Item) AND Want_Excel THEN  //Rev01
                            IF (ChoiceItem) AND Want_Excel THEN BEGIN
                                ROW += 1;
                                Entercell(ROW, 1, "Bin Type"."Item No", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 2, "Bin Type".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 3, FORMAT("Bin Type".QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 4, Item."Base Unit of Measure", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 5, FORMAT(Item."Safety Lead Time"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                IF With_Cost = TRUE THEN BEGIN
                                    Entercell(ROW, 29, FORMAT(ROUND(UC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 30, FORMAT(ROUND(TC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                END;
                                //  Entercell(ROW,25,"Production BOM Line".Position,FALSE,Tempexcelbuffer."Cell Type" :: Text); // commented by sujani
                                Entercell(ROW, 26, "Production BOM Line"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 27, "Production BOM Line"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 28, "Production BOM Line"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 6, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 7, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 8, FORMAT(Item."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 9, FORMAT(Item."Item Sub Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 10, FORMAT(Item."Type of Solder"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 11, FORMAT(Item."No. of Pins"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 12, FORMAT(Item."No. of Soldering Points"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 13, FORMAT(Item.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 14, FORMAT(Item."Operating Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 15, FORMAT(Item."Storage Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 16, FORMAT(Item.Humidity), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 17, FORMAT(Item."ESD Sensitive"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 18, FORMAT(Item."Item Status"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 19, FORMAT(Item."Soldering Temp."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 20, FORMAT(Item."Soldering Time (Sec)"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 21, FORMAT(Item."Work area Temp &  Humadity"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 22, FORMAT(Item.ESD), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 23, Item.Package, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 24, Item."Part Number", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            END;
                        END;
                    END ELSE
                        ;
                    //CurrReport.SHOWOUTPUT := FALSE;//B2BUpg
                    //Bin Type, Body (2) - OnPreSection()

                    //Rev01
                end;

                trigger OnPostDataItem()
                begin
                    //Bin Type, Footer (3) - OnPreSection()
                    //IF (Choice=Choice::Item)  THEN BEGIN //Rev01
                    IF (ChoiceItem) THEN BEGIN
                        IF Want_Excel THEN BEGIN
                            ROW := ROW + 1;
                            IF With_Cost = TRUE THEN
                                Entercell(ROW, 30, FORMAT(ROUND(TUC1)), TRUE, Tempexcelbuffer."Cell Type"::Text); //ADSK
                            ROW := ROW + 1;
                        END;
                    END;
                    //Bin Type, Footer (3) - OnPreSection()
                    //Rev01 End
                end;
            }
            dataitem("<Production BOM Line1>"; "Production BOM Line")
            {
                DataItemLink = "Production BOM No." = FIELD("No.");
                DataItemTableView = SORTING("Tot Avg Cost") ORDER(Descending) WHERE("No." = FILTER(<> ''));
                column(Production_BOM_Line1___No__; "No.")
                {
                }
                column(Production_BOM_Line1__Description; Description)
                {
                }
                column(Production_BOM_No_Caption_Control1102154101; Production_BOM_No_Caption_Control1102154101Lbl)
                {
                }
                column(DescriptionCaption_Control1102154175; DescriptionCaption_Control1102154175Lbl)
                {
                }
                column(LEVEL_2Caption; LEVEL_2CaptionLbl)
                {
                }
                column(Production_BOM_Line1__Production_BOM_No_; "Production BOM No.")
                {
                }
                column(Production_BOM_Line1__Version_Code; "Version Code")
                {
                }
                column(Production_BOM_Line1__Line_No_; "Line No.")
                {
                }
                dataitem("<Production BOM Line6>"; "Production BOM Line")
                {
                    DataItemLink = "Production BOM No." = FIELD("No.");
                    DataItemTableView = SORTING("Tot Avg Cost");
                    column(Prod_BOM_Line6_ChoiceItem; ChoiceItem)
                    {
                    }
                    column(Production_BOM_Line6___No__; "No.")
                    {
                    }
                    column(Production_BOM_Line6__Description; Description)
                    {
                    }
                    column(Production_BOM_Line6__Quantity; Quantity)
                    {
                    }
                    column(Production_BOM_Line6___Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Item__Safety_Lead_Time__Control1102154382; Item."Safety Lead Time")
                    {
                    }
                    column(ROUND_UC_0_01__Control1102154385; ROUND(UC, 0.01))
                    {
                    }
                    column(ROUND_TC_0_01__Control1102154387; ROUND(TC, 0.01))
                    {
                    }
                    column(Production_BOM_Line6__Position; Position)
                    {
                    }
                    column(Total_String; Total_String)
                    {
                    }
                    column(ROUND_TUC2_0_01_; ROUND(TUC2, 0.01))
                    {
                    }
                    column(ItemCaption_Control1102154358; ItemCaption_Control1102154358Lbl)
                    {
                    }
                    column(DescriptionCaption_Control1102154360; DescriptionCaption_Control1102154360Lbl)
                    {
                    }
                    column(QuantityCaption_Control1102154362; QuantityCaption_Control1102154362Lbl)
                    {
                    }
                    column(Unit_of_MeasureCaption_Control1102154364; Unit_of_MeasureCaption_Control1102154364Lbl)
                    {
                    }
                    column(Lead_TimeCaption_Control1102154366; Lead_TimeCaption_Control1102154366Lbl)
                    {
                    }
                    column(Unit_CostCaption_Control1102154368; Unit_CostCaption_Control1102154368Lbl)
                    {
                    }
                    column(Total_CostCaption_Control1102154370; Total_CostCaption_Control1102154370Lbl)
                    {
                    }
                    column(PositionCaption_Control1102154372; PositionCaption_Control1102154372Lbl)
                    {
                    }
                    column(Production_BOM_Line6__Production_BOM_No_; "Production BOM No.")
                    {
                    }
                    column(Production_BOM_Line6__Version_Code; "Version Code")
                    {
                    }
                    column(Production_BOM_Line6__Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //Rev01 Start

                        //<Production BOM Line6>, Header (1) - OnPreSection()
                        //CurrReport.SHOWOUTPUT(Choice=Choice::Item); //Rev01
                        CurrReport.SHOWOUTPUT(ChoiceItem);
                        //<Production BOM Line6>, Header (1) - OnPreSection()

                        //<Production BOM Line6>, Body (2) - OnPreSection()
                        UC := 0;
                        TC := 0;
                        //IF Choice=Choice::Item THEN BEGIN //Rev01
                        IF ChoiceItem THEN BEGIN
                            IF PBH.GET("<Production BOM Line6>"."No.") THEN BEGIN
                                UC := PRODUCTION_BOM_COST("<Production BOM Line6>"."No.");
                                Temp := 'C'
                            END ELSE BEGIN
                                IF Item.GET("<Production BOM Line6>"."No.") THEN
                                    UC := Item."Item Final Cost";
                                Temp := 'E';
                            END;
                            TC := "<Production BOM Line6>".Quantity * UC;
                            TUC2 += TC;
                            IF Want_Excel THEN BEGIN
                                PRINT2 := TRUE;
                                ROW += 1;
                                Entercell(ROW, 1, "<Production BOM Line6>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 2, "<Production BOM Line6>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 3, FORMAT("<Production BOM Line6>".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 4, "<Production BOM Line6>"."Unit of Measure Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 5, FORMAT(Item."Safety Lead Time"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                IF With_Cost = TRUE THEN BEGIN
                                    Entercell(ROW, 29, FORMAT(ROUND(UC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 30, FORMAT(ROUND(TC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                END;
                                Entercell(ROW, 25, "<Production BOM Line6>".Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 26, "<Production BOM Line6>"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 27, "<Production BOM Line6>"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 28, "<Production BOM Line6>"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 6, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 7, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 8, FORMAT(Item."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 9, FORMAT(Item."Item Sub Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 10, FORMAT(Item."Type of Solder"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 11, FORMAT(Item."No. of Pins"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 12, FORMAT(Item."No. of Soldering Points"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                Entercell(ROW, 13, FORMAT(Item.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 14, FORMAT(Item."Operating Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 15, FORMAT(Item."Storage Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 16, FORMAT(Item.Humidity), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 17, FORMAT(Item."ESD Sensitive"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 18, FORMAT(Item."Item Status"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 19, FORMAT(Item."Soldering Temp."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 20, FORMAT(Item."Soldering Time (Sec)"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 21, FORMAT(Item."Work area Temp &  Humadity"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 22, FORMAT(Item.ESD), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 23, Item.Package, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(ROW, 24, Item."Part Number", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            END;
                        END ELSE
                            ;
                        //CurrReport.SHOWOUTPUT := FALSE;

                        //<Production BOM Line6>, Body (2) - OnPreSection()


                        //Rev01 End
                    end;

                    trigger OnPostDataItem()
                    begin
                        //<Production BOM Line6>, Footer (3) - OnPreSection()
                        IF (Want_Excel) AND (ChoiceItem) AND PRINT2 THEN BEGIN
                            ROW := ROW + 1;
                            IF With_Cost = TRUE THEN
                                Entercell(ROW, 30, FORMAT(ROUND(TUC2, 0.01)), TRUE, Tempexcelbuffer."Cell Type"::Number);
                            // ROW:=ROW+1;    commeted by swathi on 19-sep-13
                        END;
                        PRINT2 := FALSE;
                        Total_String := 'Total of ' + "<Production BOM Line1>".Description;
                        //<Production BOM Line6>, Footer (3) - OnPreSection()
                    end;

                    trigger OnPreDataItem()
                    begin
                        Total := 0;
                        TUC2 := 0;
                        //ActiveVersionCode1 := VersionMgt.GetBOMVersion("<Production BOM Line6>"."No.", WORKDATE, TRUE);//B2BUpg

                        "<Production BOM Line6>".SETRANGE("<Production BOM Line6>"."Version Code", ActiveVersionCode1);
                        TUC2 := 0;
                        //IF ChoiceItem THEN BEGIN  //added by swathi on 19-sep-13
                        //IF Want_Excel THEN BEGIN
                        //END;
                        //END ELSE
                        //  CurrReport.SHOWOUTPUT:=FALSE;

                        //added by swathi on 19-sep-13
                    end;
                }
                dataitem("<Production BOM Line2>"; "Production BOM Line")
                {
                    DataItemLink = "Production BOM No." = FIELD("No.");
                    DataItemTableView = SORTING("Tot Avg Cost");
                    column(Prod_BOM_Line2_ChoiceCategory; ChoiceCategory)
                    {
                    }
                    column(Last_Inward_Status_; "Last Inward Status")
                    {
                    }
                    column(Production_BOM_Line2__Position; Position)
                    {
                    }
                    column(ROUND_TC_0_01__Control1102154231; ROUND(TC, 0.01))
                    {
                    }
                    column(ROUND_UC_0_01__Control1102154233; ROUND(UC, 0.01))
                    {
                    }
                    column(Item__Safety_Lead_Time__Control1102154235; Item."Safety Lead Time")
                    {
                    }
                    column(Production_BOM_Line2___Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Production_BOM_Line2__Quantity; Quantity)
                    {
                    }
                    column(Production_BOM_Line2__Description; Description)
                    {
                    }
                    column(Production_BOM_Line2___No__; "No.")
                    {
                    }
                    column(Control1102154100Caption; Control1102154100CaptionLbl)
                    {
                    }
                    column(Control1102154103Caption; Control1102154103CaptionLbl)
                    {
                    }
                    column(Control1102154105Caption; Control1102154105CaptionLbl)
                    {
                    }
                    column(Item_Sub_Sub_Group_CodeCaption_Control1102154107; Item_Sub_Sub_Group_CodeCaption_Control1102154107Lbl)
                    {
                    }
                    column(Item_Sub_Group_codeCaption_Control1102154109; Item_Sub_Group_codeCaption_Control1102154109Lbl)
                    {
                    }
                    column(Product_Group_CodeCaption_Control1102154111; Product_Group_CodeCaption_Control1102154111Lbl)
                    {
                    }
                    column(Item_Category_CodeCaption_Control1102154115; Item_Category_CodeCaption_Control1102154115Lbl)
                    {
                    }
                    column(DescriptionCaption_Control1102154121; DescriptionCaption_Control1102154121Lbl)
                    {
                    }
                    column(ItemCaption_Control1102154123; ItemCaption_Control1102154123Lbl)
                    {
                    }
                    column(Production_BOM_Line2__Production_BOM_No_; "Production BOM No.")
                    {
                    }
                    column(Production_BOM_Line2__Version_Code; "Version Code")
                    {
                    }
                    column(Production_BOM_Line2__Line_No_; "Line No.")
                    {
                    }
                    dataitem("<Production BOM Line7>"; "Production BOM Line")
                    {
                        DataItemLink = "Production BOM No." = FIELD("No.");
                        DataItemTableView = SORTING("Tot Avg Cost") ORDER(Ascending);
                        column(Production_BOM_Line7___No__; "No.")
                        {
                        }
                        column(Production_BOM_Line7__Description; Description)
                        {
                        }
                        column(Production_BOM_Line7__Production_BOM_No_; "Production BOM No.")
                        {
                        }
                        column(Production_BOM_Line7__Version_Code; "Version Code")
                        {
                        }
                        column(Production_BOM_Line7__Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF ChoiceItem THEN BEGIN
                                UC4 := 0;
                                Item.RESET;
                                Item.SETRANGE(Item."No.", "<Production BOM Line7>"."No.");
                                IF Item.FIND('-') THEN
                                    UC4 := Item."Item Final Cost"
                                ELSE
                                    UC4 := PRODUCTION_BOM_COST("<Production BOM Line7>"."No."); //hack
                                                                                                //TC:=Item."Item Final Cost"*"<Production BOM Line4>".Quantity;
                                TC := UC4 * "<Production BOM Line7>".Quantity;
                                TUC3 += TC;
                                TUC2 += TC;

                                PRL.SETCURRENTKEY(PRL."No.");
                                PRL.SETRANGE(PRL."No.", "<Production BOM Line7>"."No.");
                                PRL.SETFILTER(PRL.Quantity, '>%1', 0);
                                IF PRL.FIND('-') THEN BEGIN
                                    IF PRL."Quantity Invoiced" = PRL.Quantity THEN
                                        "Last Inward Status" := 'Invoiced'
                                    ELSE
                                        "Last Inward Status" := 'Not Invoiced';
                                END;

                                IF Want_Excel THEN BEGIN
                                    PRINT3 := TRUE;
                                    ROW += 1;
                                    Entercell(ROW, 1, "<Production BOM Line7>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 2, "<Production BOM Line7>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 3, FORMAT("<Production BOM Line7>".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 4, "<Production BOM Line7>"."Unit of Measure Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 5, FORMAT(Item."Safety Lead Time"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    IF With_Cost = TRUE THEN BEGIN
                                        Entercell(ROW, 29, FORMAT(ROUND(UC4)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 30, FORMAT(ROUND(TC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    END;
                                    Entercell(ROW, 25, "<Production BOM Line7>".Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 26, "<Production BOM Line7>"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 27, "<Production BOM Line7>"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 28, "<Production BOM Line7>"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 6, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 7, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 8, FORMAT(Item."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 9, FORMAT(Item."Item Sub Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 10, FORMAT(Item."Type of Solder"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 11, FORMAT(Item."No. of Pins"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 12, FORMAT(Item."No. of Soldering Points"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 13, FORMAT(Item.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 14, FORMAT(Item."Operating Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 15, FORMAT(Item."Storage Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 16, FORMAT(Item.Humidity), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 17, FORMAT(Item."ESD Sensitive"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 18, FORMAT(Item."Item Status"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 19, FORMAT(Item."Soldering Temp."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 20, FORMAT(Item."Soldering Time (Sec)"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 21, FORMAT(Item."Work area Temp &  Humadity"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 22, FORMAT(Item.ESD), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 23, Item.Package, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 24, Item."Part Number", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                END;
                                //"Last Inward Status"

                            END ELSE
                                ;
                            //CurrReport.SHOWOUTPUT := FALSE;
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF (Want_Excel) AND PRINT3 THEN BEGIN
                                ROW := ROW + 1;
                                IF With_Cost = TRUE THEN
                                    Entercell(ROW, 30, FORMAT(ROUND(TUC3, 0.01)), TRUE, Tempexcelbuffer."Cell Type"::Number);
                                //ROW:=ROW+1;

                            END;
                            PRINT3 := FALSE;
                        end;
                    }
                    dataitem("<Production BOM Line4>"; "Production BOM Line")
                    {
                        DataItemLink = "Production BOM No." = FIELD("No."), "Version Code" = FIELD("Version Code");
                        DataItemTableView = SORTING("Production BOM No.", "Version Code", "No.") ORDER(Ascending);
                        column(Prod_BOM_Line4_ChoiceItem; ChoiceItem)
                        {
                        }
                        column(Production_BOM_Line2____No__; "<Production BOM Line2>"."No.")
                        {
                        }
                        column(Production_BOM_Line2___Description; "<Production BOM Line2>".Description)
                        {
                        }
                        column(Production_BOM_Line4___No__; "No.")
                        {
                        }
                        column(Production_BOM_Line4__Description; Description)
                        {
                        }
                        column(Production_BOM_Line4__Quantity; Quantity)
                        {
                        }
                        column(Production_BOM_Line4___Unit_of_Measure_Code_; "Unit of Measure Code")
                        {
                        }
                        column(Item__Safety_Lead_Time__Control1102154281; Item."Safety Lead Time")
                        {
                        }
                        column(ROUND_UC_0_01__Control1102154283; ROUND(UC4, 0.01))
                        {
                        }
                        column(ROUND_TC_0_01__Control1102154285; ROUND(TC, 0.01))
                        {
                        }
                        column(Last_Inward_Status__Control1102154288; "Last Inward Status")
                        {
                        }
                        column(Production_BOM_Line4__Position; Position)
                        {
                        }
                        column(ROUND_TUC3_0_01_; ROUND(TUC3, 0.01))
                        {
                        }
                        column(Total_String_Control1102154000; Total_String)
                        {
                        }
                        column(Production_BOM_No_Caption_Control1102154250; Production_BOM_No_Caption_Control1102154250Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1102154251; DescriptionCaption_Control1102154251Lbl)
                        {
                        }
                        column(LEVEL_3Caption; LEVEL_3CaptionLbl)
                        {
                        }
                        column(Last_Inward_StatusCaption; Last_Inward_StatusCaptionLbl)
                        {
                        }
                        column(PositionCaption_Control1102154061; PositionCaption_Control1102154061Lbl)
                        {
                        }
                        column(Total_CostCaption_Control1102154063; Total_CostCaption_Control1102154063Lbl)
                        {
                        }
                        column(Unit_CostCaption_Control1102154065; Unit_CostCaption_Control1102154065Lbl)
                        {
                        }
                        column(Lead_TimeCaption_Control1102154067; Lead_TimeCaption_Control1102154067Lbl)
                        {
                        }
                        column(Unit_of_MeasureCaption_Control1102154264; Unit_of_MeasureCaption_Control1102154264Lbl)
                        {
                        }
                        column(QuantityCaption_Control1102154266; QuantityCaption_Control1102154266Lbl)
                        {
                        }
                        column(DescriptionCaption_Control1102154268; DescriptionCaption_Control1102154268Lbl)
                        {
                        }
                        column(ItemCaption_Control1102154270; ItemCaption_Control1102154270Lbl)
                        {
                        }
                        column(Production_BOM_Line4__Production_BOM_No_; "Production BOM No.")
                        {
                        }
                        column(Production_BOM_Line4__Version_Code; "Version Code")
                        {
                        }
                        column(Production_BOM_Line4__Line_No_; "Line No.")
                        {
                        }
                        column(TotAvgCost; "<Production BOM Line4>"."Tot Avg Cost")
                        {
                        }
                        dataitem("<Production BOM Line8>"; "Production BOM Line")
                        {
                            DataItemLink = "Production BOM No." = FIELD("No.");
                            DataItemTableView = SORTING("Tot Avg Cost") ORDER(Ascending);
                            column(Production_BOM_Line8___No__; "No.")
                            {
                            }
                            column(Production_BOM_Line8__Description; Description)
                            {
                            }
                            column(Production_BOM_Line8__Production_BOM_No_; "Production BOM No.")
                            {
                            }
                            column(Production_BOM_Line8__Version_Code; "Version Code")
                            {
                            }
                            column(Production_BOM_Line8__Line_No_; "Line No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                UC5 := 0;
                                IF Item.GET("<Production BOM Line8>"."No.") THEN
                                    UC5 := Item."Item Final Cost"
                                ELSE
                                    UC5 := PRODUCTION_BOM_COST("<Production BOM Line8>"."No."); //hack
                                TC := UC5 * "<Production BOM Line8>".Quantity;
                                //TC:=Item."Item Final Cost"*"<Production BOM Line5>".Quantity;
                                TUC4 += TC;


                                PRL.SETCURRENTKEY(PRL."No.");
                                PRL.SETRANGE(PRL."No.", "<Production BOM Line8>"."No.");
                                PRL.SETFILTER(PRL.Quantity, '>%1', 0);
                                IF PRL.FINDFIRST THEN BEGIN
                                    IF PRL."Quantity Invoiced" = PRL.Quantity THEN
                                        "Last Inward Status" := 'Invoiced'
                                    ELSE
                                        "Last Inward Status" := 'Not Invoiced';
                                END;

                                IF Want_Excel THEN BEGIN
                                    PRINT4 := TRUE;
                                    ROW += 1;
                                    Entercell(ROW, 1, "<Production BOM Line8>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 2, "<Production BOM Line8>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 3, FORMAT("<Production BOM Line8>".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 4, "<Production BOM Line8>"."Unit of Measure Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 5, FORMAT(Item."Safety Lead Time"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    IF With_Cost = TRUE THEN BEGIN
                                        Entercell(ROW, 29, FORMAT(ROUND(UC5)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 30, FORMAT(ROUND(TC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    END;
                                    Entercell(ROW, 25, "<Production BOM Line8>".Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 26, "<Production BOM Line8>"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 27, "<Production BOM Line8>"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 29, "<Production BOM Line8>"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 6, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 7, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 8, FORMAT(Item."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 9, FORMAT(Item."Item Sub Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 10, FORMAT(Item."Type of Solder"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 11, FORMAT(Item."No. of Pins"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 12, FORMAT(Item."No. of Soldering Points"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    Entercell(ROW, 13, FORMAT(Item.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 14, FORMAT(Item."Operating Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 15, FORMAT(Item."Storage Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 16, FORMAT(Item.Humidity), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 17, FORMAT(Item."ESD Sensitive"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 18, FORMAT(Item."Item Status"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 19, FORMAT(Item."Soldering Temp."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 20, FORMAT(Item."Soldering Time (Sec)"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 21, FORMAT(Item."Work area Temp &  Humadity"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 22, FORMAT(Item.ESD), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 23, Item.Package, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(ROW, 24, Item."Part Number", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                END;
                                //<Production BOM Line5>, Body (3) - OnPreSection()

                                //<Production BOM Line5>, Footer (4) - OnPreSection()
                                Total_String := 'Total of ' + "<Production BOM Line8>".Description;
                                TUC3 += "<Production BOM Line8>".Quantity * TUC4;
                                //comment start
                                //  IF (Want_Excel)  THEN BEGIN
                                // ROW:=ROW+1;
                                // Entercell(ROW,9,FORMAT(TUC4),TRUE,Tempexcelbuffer."Cell Type" :: Text);
                                // ROW:=ROW+1;
                                // END;
                                //commented end by Swathi on 19-Sep-13

                                //<Production BOM Line5>, Footer (4) - OnPreSection()

                                //Rev01 End
                            end;

                            trigger OnPostDataItem()
                            begin
                                //entire code is added by swathi on 19-sep-13
                                IF (Want_Excel) AND PRINT4 THEN BEGIN
                                    ROW := ROW + 1;
                                    IF With_Cost = TRUE THEN
                                        Entercell(ROW, 30, FORMAT(ROUND(TUC4, 0.01)), TRUE, Tempexcelbuffer."Cell Type"::Number);

                                END;
                                PRINT4 := FALSE;
                            end;
                        }
                        dataitem("<Production BOM Line5>"; "Production BOM Line")
                        {
                            DataItemLink = "Production BOM No." = FIELD("No.");
                            DataItemTableView = SORTING("Production BOM No.", "Version Code", "Line No.") ORDER(Ascending);
                            column(Prod_BOM_Line5_ChoiceItem; ChoiceItem)
                            {
                            }
                            column(Production_BOM_Line4____No__; "<Production BOM Line4>"."No.")
                            {
                            }
                            column(Production_BOM_Line4___Description; "<Production BOM Line4>".Description)
                            {
                            }
                            column(Production_BOM_Line5___No__; "No.")
                            {
                            }
                            column(Production_BOM_Line5__Description; Description)
                            {
                            }
                            column(Production_BOM_Line5__Quantity; Quantity)
                            {
                            }
                            column(Production_BOM_Line5___Unit_of_Measure_Code_; "Unit of Measure Code")
                            {
                            }
                            column(Item__Safety_Lead_Time__Control1102154315; Item."Safety Lead Time")
                            {
                            }
                            column(ROUND_UC_0_01__Control1102154318; ROUND(UC5, 0.01))
                            {
                            }
                            column(ROUND_TC_0_01__Control1102154320; ROUND(TC, 0.01))
                            {
                            }
                            column(Last_Inward_Status__Control1102154322; "Last Inward Status")
                            {
                            }
                            column(Production_BOM_Line5__Position; Position)
                            {
                            }
                            column(Total_String_Control1102154332; Total_String)
                            {
                            }
                            column(ROUND_TUC4_0_01_; ROUND(TUC4, 0.01))
                            {
                            }
                            column(Production_BOM_No_Caption_Control1102154046; Production_BOM_No_Caption_Control1102154046Lbl)
                            {
                            }
                            column(DescriptionCaption_Control1102154047; DescriptionCaption_Control1102154047Lbl)
                            {
                            }
                            column(LEVEL_4Caption; LEVEL_4CaptionLbl)
                            {
                            }
                            column(ItemCaption_Control1102154054; ItemCaption_Control1102154054Lbl)
                            {
                            }
                            column(DescriptionCaption_Control1102154056; DescriptionCaption_Control1102154056Lbl)
                            {
                            }
                            column(QuantityCaption_Control1102154058; QuantityCaption_Control1102154058Lbl)
                            {
                            }
                            column(Unit_of_MeasureCaption_Control1102154068; Unit_of_MeasureCaption_Control1102154068Lbl)
                            {
                            }
                            column(Lead_TimeCaption_Control1102154092; Lead_TimeCaption_Control1102154092Lbl)
                            {
                            }
                            column(Unit_CostCaption_Control1102154294; Unit_CostCaption_Control1102154294Lbl)
                            {
                            }
                            column(Total_CostCaption_Control1102154301; Total_CostCaption_Control1102154301Lbl)
                            {
                            }
                            column(Last_Inward_StatusCaption_Control1102154303; Last_Inward_StatusCaption_Control1102154303Lbl)
                            {
                            }
                            column(PositionCaption_Control1102154305; PositionCaption_Control1102154305Lbl)
                            {
                            }
                            column(Production_BOM_Line5__Production_BOM_No_; "Production BOM No.")
                            {
                            }
                            column(Production_BOM_Line5__Version_Code; "Version Code")
                            {
                            }
                            column(Production_BOM_Line5__Line_No_; "Line No.")
                            {
                            }
                            dataitem("<Production BOM Line9>"; "Production BOM Line")
                            {
                                DataItemLink = "Production BOM No." = FIELD("No.");
                                DataItemTableView = SORTING("Tot Avg Cost") ORDER(Ascending);
                                column(Production_BOM_Line9___No__; "No.")
                                {
                                }
                                column(Production_BOM_Line9__Description; Description)
                                {
                                }
                                column(Production_BOM_Line9__Production_BOM_No_; "Production BOM No.")
                                {
                                }
                                column(Production_BOM_Line9__Version_Code; "Version Code")
                                {
                                }
                                column(Production_BOM_Line9__Line_No_; "Line No.")
                                {
                                }

                                trigger OnAfterGetRecord()
                                begin
                                    UC6 := 0;
                                    IF Item.GET("<Production BOM Line8>"."No.") THEN
                                        UC6 := Item."Item Final Cost"
                                    ELSE
                                        UC6 := PRODUCTION_BOM_COST("<Production BOM Line9>"."No."); //hack
                                    TC := UC6 * "<Production BOM Line9>".Quantity;
                                    //TC:=Item."Item Final Cost"*"<Production BOM Line5>".Quantity;
                                    TUC5 += TC;


                                    PRL.SETCURRENTKEY(PRL."No.");
                                    PRL.SETRANGE(PRL."No.", "<Production BOM Line9>"."No.");
                                    PRL.SETFILTER(PRL.Quantity, '>%1', 0);
                                    IF PRL.FINDFIRST THEN BEGIN
                                        IF PRL."Quantity Invoiced" = PRL.Quantity THEN
                                            "Last Inward Status" := 'Invoiced'
                                        ELSE
                                            "Last Inward Status" := 'Not Invoiced';
                                    END;

                                    IF Want_Excel THEN BEGIN
                                        PRINT5 := TRUE;
                                        ROW += 1;
                                        Entercell(ROW, 1, "<Production BOM Line9>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 2, "<Production BOM Line9>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 3, FORMAT("<Production BOM Line9>".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 4, "<Production BOM Line9>"."Unit of Measure Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 5, FORMAT(Item."Safety Lead Time"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        IF With_Cost = TRUE THEN BEGIN
                                            Entercell(ROW, 29, FORMAT(ROUND(UC5)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                            Entercell(ROW, 30, FORMAT(ROUND(TC)), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        END;
                                        Entercell(ROW, 25, "<Production BOM Line9>".Position, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 26, "<Production BOM Line9>"."Position 2", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 27, "<Production BOM Line9>"."Position 3", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 29, "<Production BOM Line9>"."Position 4", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 6, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 7, FORMAT(Item."Product Group Code Cust"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 8, FORMAT(Item."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 9, FORMAT(Item."Item Sub Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 10, FORMAT(Item."Type of Solder"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 11, FORMAT(Item."No. of Pins"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 12, FORMAT(Item."No. of Soldering Points"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        Entercell(ROW, 13, FORMAT(Item.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 14, FORMAT(Item."Operating Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 15, FORMAT(Item."Storage Temperature"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 16, FORMAT(Item.Humidity), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 17, FORMAT(Item."ESD Sensitive"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 18, FORMAT(Item."Item Status"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 19, FORMAT(Item."Soldering Temp."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 20, FORMAT(Item."Soldering Time (Sec)"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 21, FORMAT(Item."Work area Temp &  Humadity"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 22, FORMAT(Item.ESD), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 23, Item.Package, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        Entercell(ROW, 24, Item."Part Number", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    END;
                                    //<Production BOM Line5>, Body (3) - OnPreSection()

                                    //<Production BOM Line5>, Footer (4) - OnPreSection()
                                    Total_String := 'Total of ' + "<Production BOM Line9>".Description;
                                    TUC3 += "<Production BOM Line9>".Quantity * TUC4;
                                    //comment start
                                    //  IF (Want_Excel)  THEN BEGIN
                                    // ROW:=ROW+1;
                                    // Entercell(ROW,9,FORMAT(TUC4),TRUE,Tempexcelbuffer."Cell Type" :: Text);
                                    // ROW:=ROW+1;
                                    // END;
                                    //commented end by Swathi on 19-Sep-13

                                    //<Production BOM Line5>, Footer (4) - OnPreSection()

                                    //Rev01 End
                                end;

                                trigger OnPostDataItem()
                                begin
                                    IF (Want_Excel) AND PRINT5 THEN BEGIN
                                        ROW := ROW + 1;
                                        IF With_Cost = TRUE THEN
                                            Entercell(ROW, 30, FORMAT(ROUND(TUC5, 0.01)), TRUE, Tempexcelbuffer."Cell Type"::Number);
                                        //ROW:=ROW+1;

                                    END;
                                    PRINT5 := FALSE;
                                end;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                //Rev01 Start

                                //<Production BOM Line5>, Header (1) - OnPreSection()
                                //IF Choice=Choice::Item THEN BEGIN //Rev01

                                //<Production BOM Line5>, Body (3) - OnPreSection()
                                //ADSK


                                ExcelVar := 3;
                                TUC5 := 0;


                                IF ChoiceItem THEN BEGIN
                                    PBML.SETFILTER(PBML."Production BOM No.", "<Production BOM Line2>"."No.");
                                    IF PBML.FIND('-') THEN BEGIN


                                        IF (Want_Excel) AND (ExcelVar = 2) THEN BEGIN
                                            ROW += 2;
                                            EnterHeadings(ROW, 1, 'LEVEL', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 2, '5', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            ROW += 1;
                                            EnterHeadings(ROW, 1, 'BOM No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 2, "<Production BOM Line5>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);    //before <production BOM Line 2 now Line 4 changed by swathi on 19-sep-13
                                            ROW += 1;
                                            EnterHeadings(ROW, 1, 'Desription', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 2, "<Production BOM Line5>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                            ROW += 1;
                                            EnterHeadings(ROW, 1, 'Item No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 2, 'Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 3, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 4, 'Unit Of Measure', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 5, 'Lead Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 6, 'Product Group Code Cust', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 7, 'Product group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 8, 'Item sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 9, 'Item sub sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 10, 'Type of solder point', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 11, 'No of pins', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 12, 'No of solder points', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 13, 'Make', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 14, 'Operating Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 15, 'Storage Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 16, 'Humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 17, 'ESD Sensitive', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 18, 'Item status', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 19, 'Soldering Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 20, 'Soldering Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 21, 'Work area Temperature & humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 22, 'ESD', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 23, 'Package', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 24, 'Part.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 25, 'Position', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 26, 'Position 2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 27, 'Position 3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 28, 'Position 4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            IF With_Cost = TRUE THEN BEGIN
                                                EnterHeadings(ROW, 29, 'Unit Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                                EnterHeadings(ROW, 30, 'Total Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            END;
                                            ExcelVar := 0;
                                        END;
                                    END ELSE
                                        ;
                                    //CurrReport.SHOWOUTPUT := FALSE;//B2BUpg
                                END;
                                //<Production BOM Line5>, Header (1) - OnPreSection()
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ExcelVar := 2;
                            TUC4 := 0;


                            IF ChoiceItem THEN BEGIN
                                PBML.SETFILTER(PBML."Production BOM No.", "<Production BOM Line4>"."No.");
                                IF PBML.FIND('-') THEN BEGIN


                                    IF (Want_Excel) AND (ExcelVar = 2) THEN BEGIN
                                        ROW += 2;
                                        EnterHeadings(ROW, 1, 'LEVEL', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 2, '4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        ROW += 1;
                                        EnterHeadings(ROW, 1, 'BOM No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 2, "<Production BOM Line4>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);    //before <production BOM Line 2 now Line 4 changed by swathi on 19-sep-13
                                        ROW += 1;
                                        EnterHeadings(ROW, 1, 'Desription', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 2, "<Production BOM Line4>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        ROW += 1;
                                        EnterHeadings(ROW, 1, 'Item No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 2, 'Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 3, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 4, 'Unit Of Measure', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 5, 'Lead Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 6, 'Product Group Code Cust', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 7, 'Product group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 8, 'Item sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 9, 'Item sub sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 10, 'Type of solder point', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 11, 'No of pins', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 12, 'No of solder points', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 13, 'Make', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 14, 'Operating Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 15, 'Storage Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 16, 'Humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 17, 'ESD Sensitive', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 18, 'Item status', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 19, 'Soldering Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 20, 'Soldering Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 21, 'Work area Temperature & humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 22, 'ESD', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 23, 'Package', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 24, 'Part.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 25, 'Position', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 26, 'Position 2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 27, 'Position 3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 28, 'Position 4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        IF With_Cost = TRUE THEN BEGIN
                                            EnterHeadings(ROW, 29, 'Unit Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                            EnterHeadings(ROW, 30, 'Total Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        END;
                                        ExcelVar := 0;
                                    END;
                                END ELSE
                                    ;
                                //CurrReport.SHOWOUTPUT := FALSE;//B2Bupg
                            END;

                            //<Production BOM Line5>, Header (1) - OnPreSection()
                        end;

                        trigger OnPreDataItem()
                        begin
                            ExcelVar := 1; //Rev01
                            TUC3 := 0;  // cut and paste from afterget- line4
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //Rev01 Start


                        //<Production BOM Line2>, Header (1) - OnPreSection()
                        //CurrReport.SHOWOUTPUT(Choice=Choice::Category); //Rev01
                        CurrReport.SHOWOUTPUT(ChoiceCategory);
                        //<Production BOM Line2>, Header (1) - OnPreSection()

                        //<Production BOM Line2>, Body (2) - OnPreSection()
                        /*
                          UC:=0;
                          TC:=0;
                          IF ChoiceItem THEN BEGIN
                            Item.SETRANGE(Item."No.","<Production BOM Line2>"."No.");
                            IF Item.FIND('-') THEN
                              UC:=Item."Item Final Cost";
                            TC:=UC*"<Production BOM Line2>".Quantity;
                            TUC2+=TC;
                            ROW+=1;
                            IF Want_Excel THEN BEGIN
                              Entercell(ROW,1,"<Production BOM Line2>"."No.",FALSE);
                              Entercell(ROW,2,"<Production BOM Line2>".Description,FALSE);
                              Entercell(ROW,3,FORMAT("<Production BOM Line2>".Quantity),FALSE);
                              Entercell(ROW,4,"<Production BOM Line2>"."Unit of Measure Code",FALSE);
                              Entercell(ROW,5,FORMAT(Item."Safety Lead Time"),FALSE);
                              Entercell(ROW,6,FORMAT(UC),FALSE);
                              Entercell(ROW,7,FORMAT(TC),FALSE);
                              Entercell(ROW,8,"<Production BOM Line2>".Position+', '+"<Production BOM Line2>"."Position 2"+', '+
                              "<Production BOM Line2>"."Position 3"+', '+"<Production BOM Line2>"."Position 4",FALSE);
                              PRL.SETCURRENTKEY(PRL."No.");
                              PRL.SETRANGE(PRL."No.","<Production BOM Line2>"."No.");
                              PRL.SETFILTER(PRL.Quantity,'>%1',0);
                              IF PRL.FIND('-') THEN BEGIN
                                IF PRL."Quantity Invoiced"=PRL.Quantity THEN
                                  "Last Inward Status":='Invoiced'
                                ELSE
                                  "Last Inward Status":='Not Invoiced';
                              END;
                            END;
                          END ELSE
                        */

                        //CurrReport.SHOWOUTPUT := FALSE;//B2BUpg
                        //<Production BOM Line2>, Body (2) - OnPreSection()


                        //Rev01 End

                        ExcelVar := 1; //Rev01
                        TUC3 := 0;  // cut and paste from afterget- line4

                        IF ChoiceItem THEN BEGIN
                            PBML.SETFILTER(PBML."Production BOM No.", "<Production BOM Line2>"."No.");
                            IF PBML.FIND('-') THEN BEGIN

                                IF (Want_Excel) AND (ExcelVar = 1) THEN BEGIN
                                    ROW += 2;
                                    EnterHeadings(ROW, 1, 'LEVEL', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 2, '3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    ROW += 1;
                                    EnterHeadings(ROW, 1, 'BOM No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 2, "<Production BOM Line2>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    ROW += 1;
                                    EnterHeadings(ROW, 1, 'Desription', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 2, "<Production BOM Line2>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    ROW += 1;
                                    EnterHeadings(ROW, 1, 'Item No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 2, 'Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 3, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 4, 'Unit Of Measure', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 5, 'Lead Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 6, 'Product Group Code Cust', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 7, 'Product group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 8, 'Item sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 9, 'Item sub sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 10, 'Type of solder point', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 11, 'No of pins', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 12, 'No of solder points', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 13, 'Make', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 14, 'Operating Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 15, 'Storage Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 16, 'Humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 17, 'ESD Sensitive', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 18, 'Item status', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 19, 'Soldering Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 20, 'Soldering Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 21, 'Work area Temperature & humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 22, 'ESD', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 23, 'Package', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 24, 'Part.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 25, 'Position', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 26, 'Position 2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 27, 'Position 3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    EnterHeadings(ROW, 28, 'Position 4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    IF With_Cost = TRUE THEN BEGIN
                                        EnterHeadings(ROW, 29, 'Unit Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                        EnterHeadings(ROW, 30, 'Total Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                    END;
                                    //ExcelVar := 0; //Rev01
                                END;
                            END;
                        END ELSE
                            ;
                        //CurrReport.SHOWOUTPUT := FALSE;//B2BUpg

                    end;

                    trigger OnPostDataItem()
                    begin
                        /*
                        //IF Choice=Choice::Item THEN BEGIN //Rev01
                        IF ChoiceItem THEN BEGIN
                          Tempexcelbuffer.CreateBook;
                          Tempexcelbuffer.CreateSheet("Production BOM Header"."No.",'',COMPANYNAME,'');
                          Tempexcelbuffer.GiveUserControl;
                        END;
                        */

                    end;

                    trigger OnPreDataItem()
                    begin

                        Total := 0;
                        TUC2 := 0;
                        //ActiveVersionCode1 := VersionMgt.GetBOMVersion("<Production BOM Line1>"."No.", WORKDATE, TRUE);//B2BUpg
                        "<Production BOM Line2>".SETRANGE("<Production BOM Line2>"."Version Code", ActiveVersionCode1)
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //Rev01 Start

                    //<Production BOM Line1>, Body (1) - OnPreSection()
                    PBML.SETFILTER(PBML."Production BOM No.", "<Production BOM Line1>"."No.");
                    IF PBML.FIND('-') THEN BEGIN
                        IF Want_Excel THEN BEGIN
                            ROW += 1;

                            EnterHeadings(ROW, 1, 'LEVEL', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 2, '2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            ROW += 1;
                            EnterHeadings(ROW, 1, 'BOM No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 2, "<Production BOM Line1>"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            ROW += 1;
                            EnterHeadings(ROW, 1, 'Desription', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 2, "<Production BOM Line1>".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                            ROW += 1;
                            EnterHeadings(ROW, 1, 'Item No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 2, 'Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 3, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 4, 'Unit Of Measure', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 5, 'Lead Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 6, 'Product Group Code Cust', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 7, 'Product group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 8, 'Item sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 9, 'Item sub sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 10, 'Type of solder point', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 11, 'No of pins', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 12, 'No of solder points', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 13, 'Make', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 14, 'Operating Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 15, 'Storage Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 16, 'Humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 17, 'ESD Sensitive', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 18, 'Item status', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 19, 'Soldering Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 20, 'Soldering Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 21, 'Work area Temperature & humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 22, 'ESD', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 23, 'Package', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 24, 'Part.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 25, 'Position', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 26, 'Position 2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 27, 'Position 3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 28, 'Position 4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            IF With_Cost = TRUE THEN BEGIN
                                EnterHeadings(ROW, 29, 'Unit Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                                EnterHeadings(ROW, 30, 'Total Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            END;
                        END;
                    END ELSE
                        ;
                    //CurrReport.SHOWOUTPUT := FALSE;//B2BUpg



                    //<Production BOM Line1>, Body (1) - OnPreSection()
                    //Rev01 End
                end;

                trigger OnPreDataItem()
                begin
                    //IF (Choice<>Choice::Item) AND (Choice<>Choice::BOM) THEN //Rev01
                    IF (NOT ChoiceItem) AND (NOT ChoiceBOM) THEN
                        CurrReport.BREAK;

                    "<Production BOM Line1>".SETRANGE("<Production BOM Line1>"."Version Code", ActiveVersionCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //ActiveVersionCode := VersionMgt.GetBOMVersion("Production BOM Header"."No.", WORKDATE, TRUE);//B2BUpg

                //Rev01 Start

                //Production BOM Header, Body (2) - OnPreSection()
                IF Want_Excel THEN BEGIN
                    ROW := 0;
                    ROW += 1;
                    EnterHeadings(ROW, 1, 'BOM No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(ROW, 2, "Production BOM Header"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                    ROW += 1;
                    EnterHeadings(ROW, 1, 'Desription', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(ROW, 2, "Production BOM Header".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                END;
                //Production BOM Header, Body (2) - OnPreSection()
                //Production BOM Line, Header (2) - OnPostSection()
                IF ChoiceItem THEN BEGIN
                    IF Want_Excel THEN BEGIN
                        ROW += 1;
                        EnterHeadings(ROW, 1, 'Item No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 2, 'Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 3, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 4, 'Unit Of Measure', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 5, 'Lead Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 6, 'Product Group Code Cust', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 7, 'Product group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 8, 'Item sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 9, 'Item sub sub group code', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 10, 'Type of solder point', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 11, 'No of pins', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 12, 'No of solder points', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 13, 'Make', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 14, 'Operating Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 15, 'Storage Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 16, 'Humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 17, 'ESD Sensitive', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 18, 'Item status', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 19, 'Soldering Temperature', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 20, 'Soldering Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 21, 'Work area Temperature & humidity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 22, 'ESD', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 23, 'Package', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 24, 'Part.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 25, 'Position', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 26, 'Position 2', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 27, 'Position 3', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 28, 'Position 4', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        EnterHeadings(ROW, 29, 'Bom Type', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        IF With_Cost = TRUE THEN BEGIN
                            EnterHeadings(ROW, 30, 'Unit Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                            EnterHeadings(ROW, 31, 'Total Cost', TRUE, Tempexcelbuffer."Cell Type"::Text);
                        END;
                    END;
                END;

                //Production BOM Line, Header (2) - OnPostSection()

                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                //IF (Choice=Choice::BomMod) OR (Choice=Choice::ERT) THEN //Rev01
                IF (ChoiceBomMod) OR (ChoiceERT) THEN
                    CurrReport.BREAK;

                IF Want_Excel THEN BEGIN
                    CLEAR(Tempexcelbuffer);
                    Tempexcelbuffer.DELETEALL;
                    ROW += 1;
                END;
            end;
        }
        dataitem("Manufacturing Comment Line"; "Manufacturing Comment Line")
        {
            DataItemTableView = SORTING("Table Name", "No.", "Line No.") ORDER(Ascending) WHERE("Table Name" = CONST("Production BOM Header"));
            RequestFilterFields = Date, "Code";
            RequestFilterHeading = 'Bom Modifications';
            column(Manuf_Commt_Line_ChoiceBomMod; ChoiceBomMod)
            {
            }
            column(FORMAT_TODAY_0_4__Control1102154007; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO_Control1102154008; CurrReport.PAGENO)
            {
            }
            column(USERID_Control1102154009; USERID)
            {
            }
            column(COMPANYNAME_Control1102154013; COMPANYNAME)
            {
            }
            column(Manufacturing_Comment_Line_Date; Date)
            {
            }
            column(Manufacturing_Comment_Line_Code; Code)
            {
            }
            column(Manufacturing_Comment_Line_Comment; Comment)
            {
            }
            column(Manufacturing_Comment_Line__No__; "No.")
            {
            }
            column(Desc; Desc)
            {
            }
            column(CurrReport_PAGENO_Control1102154008Caption; CurrReport_PAGENO_Control1102154008CaptionLbl)
            {
            }
            column(Bom_Modification_StatusCaption; Bom_Modification_StatusCaptionLbl)
            {
            }
            column(CommentCaption; CommentCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(Modification_DateCaption; Modification_DateCaptionLbl)
            {
            }
            column(DescriptionCaption_Control1102154017; DescriptionCaption_Control1102154017Lbl)
            {
            }
            column(Production_Bom_No_Caption_Control1102154018; Production_Bom_No_Caption_Control1102154018Lbl)
            {
            }
            column(Manufacturing_Comment_Line_Table_Name; "Table Name")
            {
            }
            column(Manufacturing_Comment_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01 Start

                //Manufacturing Comment Line, Body (3) - OnPreSection()
                IF PBH.GET("Manufacturing Comment Line"."No.") THEN
                    Desc := PBH.Description;
                //Manufacturing Comment Line, Body (3) - OnPreSection()

                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                //IF Choice<>Choice::BomMod THEN //Rev01
                IF NOT ChoiceBomMod THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Tender Header"; "Tender Header")
        {
            RequestFilterFields = "Tender No.", "Released to Sales User ID", "Released to Sales Date", "Released to Design User ID", "Released to Design Date";
            RequestFilterHeading = 'Enquriy Response Time (Tender)';
            column(Tender_Header_ChoiceERT; ChoiceERT)
            {
            }
            column(FORMAT_TODAY_0_4__Control1102154025; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID_Control1102154026; USERID)
            {
            }
            column(CurrReport_PAGENO_Control1102154027; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME_Control1102154031; COMPANYNAME)
            {
            }
            column(Tendor_Relese_Person; Tendor_Relese_Person)
            {
            }
            column(Tender_Header__Released_to_Sales_Date_; "Released to Sales Date")
            {
            }
            column(sales_Relese_Person; sales_Relese_Person)
            {
            }
            column(Tender_Header__Released_to_Design_Date_; "Released to Design Date")
            {
            }
            column(Tender_Header__Tender_No__; "Tender No.")
            {
            }
            column(Tender_Header__Customer_Name_; "Customer Name")
            {
            }
            column(Tender_Header_City; City)
            {
            }
            column(CurrReport_PAGENO_Control1102154027Caption; CurrReport_PAGENO_Control1102154027CaptionLbl)
            {
            }
            column(Enquiry_Response_Time__Tender_Caption; Enquiry_Response_Time__Tender_CaptionLbl)
            {
            }
            column(Released_to_Sales__PersonCaption; Released_to_Sales__PersonCaptionLbl)
            {
            }
            column(Released_To_Sales_DateCaption; Released_To_Sales_DateCaptionLbl)
            {
            }
            column(Release_To_Deisgn_PersonCaption; Release_To_Deisgn_PersonCaptionLbl)
            {
            }
            column(Released_To_Design_DateCaption; Released_To_Design_DateCaptionLbl)
            {
            }
            column(Tender_No_Caption; Tender_No_CaptionLbl)
            {
            }
            column(Tender_Header__Customer_Name_Caption; FIELDCAPTION("Customer Name"))
            {
            }
            column(Tender_Header_CityCaption; FIELDCAPTION(City))
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01 Start

                //Tender Header, Body (3) - OnPreSection()
                IF User.GET("Tender Header"."Released to Sales User ID") THEN
                    Tendor_Relese_Person := User."User Name";
                IF User.GET("Tender Header"."Released to Design User ID") THEN
                    sales_Relese_Person := User."User Name";
                //Tender Header, Body (3) - OnPreSection()

                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                //IF (Choice<>Choice::ERT) AND ("Tender Header".GETFILTERS='') THEN //Rev01
                IF (NOT ChoiceERT) AND ("Tender Header".GETFILTERS = '') THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Released to Sales Date", "Released to Sales User ID", "Released to Design Date", "Released to Design User ID";
            RequestFilterHeading = 'Enquriy Response Time (Quote)';
            column(Sales_Header_ChoiceERT; ChoiceERT)
            {
            }
            column(FORMAT_TODAY_0_4__Control1102154084; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID_Control1102154085; USERID)
            {
            }
            column(CurrReport_PAGENO_Control1102154087; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME_Control1102154091; COMPANYNAME)
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Bill_to_Name_; "Bill-to Name")
            {
            }
            column(Sales_Header__Bill_to_City_; "Bill-to City")
            {
            }
            column(Sales_Header__Released_to_Design_Date_; "Released to Design Date")
            {
            }
            column(Sales_Header__Released_to_Sales_Date_; "Released to Sales Date")
            {
            }
            column(sales_Relese_Person_Control1102154078; sales_Relese_Person)
            {
            }
            column(Tendor_Relese_Person_Control1102154083; Tendor_Relese_Person)
            {
            }
            column(CurrReport_PAGENO_Control1102154087Caption; CurrReport_PAGENO_Control1102154087CaptionLbl)
            {
            }
            column(Enquiry_Response_Time__Quote_Caption; Enquiry_Response_Time__Quote_CaptionLbl)
            {
            }
            column(Released_to_Sales__PersonCaption_Control1102154069; Released_to_Sales__PersonCaption_Control1102154069Lbl)
            {
            }
            column(Released_To_Sales_DateCaption_Control1102154071; Released_To_Sales_DateCaption_Control1102154071Lbl)
            {
            }
            column(Release_To_Deisgn_PersonCaption_Control1102154072; Release_To_Deisgn_PersonCaption_Control1102154072Lbl)
            {
            }
            column(Released_To_Design_DateCaption_Control1102154073; Released_To_Design_DateCaption_Control1102154073Lbl)
            {
            }
            column(CityCaption; CityCaptionLbl)
            {
            }
            column(Custmoe_NameCaption; Custmoe_NameCaptionLbl)
            {
            }
            column(Quote_No_Caption; Quote_No_CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01 Start

                //Sales Header, Body (3) - OnPreSection()
                IF User.GET("Sales Header"."Released to Sales User ID") THEN
                    Tendor_Relese_Person := User."User Name";
                IF User.GET("Sales Header"."Released to Design User ID") THEN
                    sales_Relese_Person := User."User Name";
                //Sales Header, Body (3) - OnPreSection()

                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                //IF (Choice<>Choice::ERT) AND ("Sales Header".GETFILTERS='') THEN //Rev01
                IF (NOT ChoiceERT) AND ("Sales Header".GETFILTERS = '') THEN
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
                group(Options)
                {
                    Caption = 'Options';
                    group(Control1102152003)
                    {
                        ShowCaption = false;
                        field("Item Cost"; ChoiceItem)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF ChoiceItem = TRUE THEN BEGIN
                                    ChoiceBOM := FALSE;
                                    ChoiceFForm := FALSE;
                                    ChoiceCategory := FALSE;
                                    ChoiceBomMod := FALSE;
                                    ChoiceERT := FALSE;
                                    Fill_Form_ChoiceBoth := TRUE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152014)
                    {
                        ShowCaption = false;
                        field("BOM Cost"; ChoiceBOM)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF ChoiceBOM = TRUE THEN BEGIN
                                    ChoiceItem := FALSE;
                                    ChoiceFForm := FALSE;
                                    ChoiceCategory := FALSE;
                                    ChoiceBomMod := FALSE;
                                    ChoiceERT := FALSE;
                                    Fill_Form_ChoiceBoth := TRUE;
                                END;
                            end;
                        }
                    }
                    grid(Control1102152023)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152016)
                        {
                            //The GridLayout property is only supported on controls of type Grid
                            //GridLayout = Rows;
                            ShowCaption = false;
                            label("Filling Form1")
                            {
                                Caption = 'Filling Form';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field("Filling Form"; ChoiceFForm)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;

                                trigger OnValidate()
                                begin
                                    IF ChoiceFForm = TRUE THEN BEGIN
                                        ChoiceItem := FALSE;
                                        ChoiceBOM := FALSE;
                                        ChoiceCategory := FALSE;
                                        ChoiceBomMod := FALSE;
                                        ChoiceERT := FALSE;
                                        Fill_Form_ChoiceBoth := TRUE;
                                    END;
                                end;
                            }
                            label(Product1)
                            {
                                Caption = 'Product';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(product; product)
                            {
                                DrillDown = false;
                                Lookup = true;
                                LookupPageID = "Item Sub Group";
                                ShowCaption = false;
                                ApplicationArea = All;
                                //TableRelation = "Item Sub Group".Code WHERE("Product Group Code"=CONST(FPRODUCT));//B2BUpg
                            }
                        }
                    }
                    group(Control1102152007)
                    {
                        ShowCaption = false;
                        label(Control1102152024)
                        {
                            ShowCaption = false;
                            Visible = true;
                            ApplicationArea = All;
                        }
                        field(Both; Fill_Form_ChoiceBoth)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF Fill_Form_ChoiceBoth = TRUE THEN BEGIN
                                    Fill_Form_ChoiceSMD := FALSE;
                                    Fill_Form_ChoiceDIP := FALSE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152028)
                    {
                        ShowCaption = false;
                        field(SMD; Fill_Form_ChoiceSMD)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF Fill_Form_ChoiceSMD = TRUE THEN BEGIN
                                    Fill_Form_ChoiceBoth := FALSE;
                                    Fill_Form_ChoiceDIP := FALSE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152029)
                    {
                        ShowCaption = false;
                        field(DIP; Fill_Form_ChoiceDIP)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF Fill_Form_ChoiceDIP = TRUE THEN BEGIN
                                    Fill_Form_ChoiceBoth := FALSE;
                                    Fill_Form_ChoiceSMD := FALSE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152019)
                    {
                        ShowCaption = false;
                        field("Item Categories"; ChoiceCategory)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF ChoiceCategory = TRUE THEN BEGIN
                                    ChoiceItem := FALSE;
                                    ChoiceBOM := FALSE;
                                    ChoiceFForm := FALSE;
                                    ChoiceBomMod := FALSE;
                                    ChoiceERT := FALSE;
                                    Fill_Form_ChoiceBoth := TRUE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152020)
                    {
                        ShowCaption = false;
                        field("BOM Modifications"; ChoiceBomMod)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF ChoiceBomMod = TRUE THEN BEGIN
                                    ChoiceItem := FALSE;
                                    ChoiceBOM := FALSE;
                                    ChoiceFForm := FALSE;
                                    ChoiceCategory := FALSE;
                                    ChoiceERT := FALSE;
                                    Fill_Form_ChoiceBoth := TRUE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152021)
                    {
                        ShowCaption = false;
                        field("Enquiry Response Time"; ChoiceERT)
                        {
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF ChoiceERT = TRUE THEN BEGIN
                                    ChoiceItem := FALSE;
                                    ChoiceBOM := FALSE;
                                    ChoiceFForm := FALSE;
                                    ChoiceCategory := FALSE;
                                    ChoiceBomMod := FALSE;
                                    Fill_Form_ChoiceBoth := TRUE;
                                END;
                            end;
                        }
                    }
                    group(Control1102152018)
                    {
                        ShowCaption = false;
                        field(Excel; Want_Excel)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152026)
                    {
                        ShowCaption = false;
                        field(With_Cost; With_Cost)
                        {
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            With_Cost := FALSE;       // Added by Pranavi on 3-Mar-2016
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Want_Excel := TRUE;
        ChoiceItem := TRUE;
    end;

    trigger OnPostReport()
    begin
        /*
        IF Want_Excel THEN
        BEGIN
          Tempexcelbuffer.CreateBook('"Production BOM Header"."No."');
          Tempexcelbuffer.WriteSheet('"Production BOM Header"."No."',COMPANYNAME,USERID);
          Tempexcelbuffer.OpenExcel;
          Tempexcelbuffer.CloseBook;
          Tempexcelbuffer.GiveUserControl;
        END;
        */

        IF Want_Excel THEN BEGIN
            Tempexcelbuffer.CreateBookAndOpenExcel('', '"Production BOM Header"."No."', '"Production BOM Header"."No."', COMPANYNAME, USERID); //EFFUPG
            Tempexcelbuffer.SaveBom("Production BOM Header"."No.");
        END;

    end;

    var
        "Rejected Lots": array[100] of Code[15];
        i: Integer;
        cod: Code[10];
        "filter": Text[50];
        j: Integer;
        hhh: array[100] of Integer;
        "Actual Lot": Code[10];
        "item desc": Text[30];
        "max Qty": Decimal;
        qle: Record "Quality Ledger Entry";
        sno: Integer;
        "Accepted Quantity": Integer;
        "max": Date;
        "min": Date;
        "Company Information": Record "Company Information";
        Total: Decimal;
        PBML2: Record "Production BOM Line";
        PBML3: Record "Production BOM Line";
        PBML: Record "Production BOM Line";
        Item: Record Item;
        UC: Decimal;
        UC4: Decimal;
        UC5: Decimal;
        TC: Decimal;
        Choice: Option Item,BOM,FForm,Category,BomMod,ERT;
        TUC1: Decimal;
        TUC2: Decimal;
        Temp: Text[30];
        PBH: Record "Production BOM Header";
        ICC: Code[50];
        PGC: Code[50];
        ISGC: Code[50];
        ISSGC: Code[50];
        ROW: Integer;
        Tempexcelbuffer: Record "Excel Buffer" temporary;
        Position1: Text[1000];
        length: Integer;
        TMP_Position: Text[1000];
        CNT: Integer;
        Want_Excel: Boolean;
        Desc: Text[30];
        Tendor_Relese_Person: Text[30];
        sales_Relese_Person: Text[30];
        User: Record User;
        "Last Inward Status": Text[250];
        PRL: Record "Purch. Rcpt. Line";
        ver: Code[30];
        Fill_Form_Choice: Option BOTH,SMD,DIP;
        BOUT: Boolean;
        ActiveVersionCode: Code[20];
        //VersionMgt: Codeunit VersionManagement;//B2BUpg
        ActiveVersionCode1: Code[20];
        product: Code[20];
        itemno: Code[20];
        AI: Record "Alternate Items";
        AIitem: Text[100];
        TUC3: Decimal;
        Total_String: Text[70];
        TUC4: Decimal;
        Explosion_of_BOMCaptionLbl: Label 'Explosion of BOM';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Production_BOM_No_CaptionLbl: Label 'Production BOM No:';
        DescriptionCaptionLbl: Label 'Description';
        Item_Sub_Sub_Group_CodeCaptionLbl: Label 'Item Sub Sub Group Code';
        Item_Sub_Group_codeCaptionLbl: Label 'Item Sub Group code';
        Product_Group_CodeCaptionLbl: Label 'Product Group Code';
        Item_Category_CodeCaptionLbl: Label 'Product Group Code Cust';
        DescriptionCaption_Control1000000100Lbl: Label 'Description';
        ItemCaptionLbl: Label 'Item';
        PositionCaptionLbl: Label 'Position';
        ItemCaption_Control1000000029Lbl: Label 'Item';
        DescriptionCaption_Control1000000030Lbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_of_MeasureCaptionLbl: Label 'Unit of Measure';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        Total_CostCaptionLbl: Label 'Total Cost';
        PositionCaption_Control1000000067Lbl: Label 'Position';
        Lead_TimeCaptionLbl: Label 'Lead Time';
        TOTALCaptionLbl: Label 'TOTAL';
        POSITIONCaption_Control1000000073Lbl: Label 'POSITION';
        QUANTITYCaption_Control1000000074Lbl: Label 'QUANTITY';
        DESCRIPTIONCaption_Control1000000075Lbl: Label 'DESCRIPTION';
        ITEMCaption_Control1000000076Lbl: Label 'ITEM';
        UNIT_OF_MEASURECaption_Control1000000066Lbl: Label 'UNIT OF MEASURE';
        DESCRIPTION_2CaptionLbl: Label 'DESCRIPTION 2';
        ALTERNATE_ITEMSCaptionLbl: Label 'ALTERNATE ITEMS';
        TOTALCaption_Control1102154179Lbl: Label 'TOTAL';
        Production_BOM_No_Caption_Control1102154101Lbl: Label 'Production BOM No:';
        DescriptionCaption_Control1102154175Lbl: Label 'Description';
        LEVEL_2CaptionLbl: Label 'LEVEL 2';
        ItemCaption_Control1102154358Lbl: Label 'Item';
        DescriptionCaption_Control1102154360Lbl: Label 'Description';
        QuantityCaption_Control1102154362Lbl: Label 'Quantity';
        Unit_of_MeasureCaption_Control1102154364Lbl: Label 'Unit of Measure';
        Lead_TimeCaption_Control1102154366Lbl: Label 'Lead Time';
        Unit_CostCaption_Control1102154368Lbl: Label 'Unit Cost';
        Total_CostCaption_Control1102154370Lbl: Label 'Total Cost';
        PositionCaption_Control1102154372Lbl: Label 'Position';
        Control1102154100CaptionLbl: Label 'Label1102154100';
        Control1102154103CaptionLbl: Label 'Label1102154103';
        Control1102154105CaptionLbl: Label 'Label1102154105';
        Item_Sub_Sub_Group_CodeCaption_Control1102154107Lbl: Label 'Item Sub Sub Group Code';
        Item_Sub_Group_codeCaption_Control1102154109Lbl: Label 'Item Sub Group code';
        Product_Group_CodeCaption_Control1102154111Lbl: Label 'Product Group Code';
        Item_Category_CodeCaption_Control1102154115Lbl: Label 'Product Group Code Cust';
        DescriptionCaption_Control1102154121Lbl: Label 'Description';
        ItemCaption_Control1102154123Lbl: Label 'Item';
        Production_BOM_No_Caption_Control1102154250Lbl: Label 'Production BOM No:';
        DescriptionCaption_Control1102154251Lbl: Label 'Description';
        LEVEL_3CaptionLbl: Label 'LEVEL 3';
        Last_Inward_StatusCaptionLbl: Label 'Last Inward Status';
        PositionCaption_Control1102154061Lbl: Label 'Position';
        Total_CostCaption_Control1102154063Lbl: Label 'Total Cost';
        Unit_CostCaption_Control1102154065Lbl: Label 'Unit Cost';
        Lead_TimeCaption_Control1102154067Lbl: Label 'Lead Time';
        Unit_of_MeasureCaption_Control1102154264Lbl: Label 'Unit of Measure';
        QuantityCaption_Control1102154266Lbl: Label 'Quantity';
        DescriptionCaption_Control1102154268Lbl: Label 'Description';
        ItemCaption_Control1102154270Lbl: Label 'Item';
        Production_BOM_No_Caption_Control1102154046Lbl: Label 'Production BOM No:';
        DescriptionCaption_Control1102154047Lbl: Label 'Description';
        LEVEL_4CaptionLbl: Label 'LEVEL 4';
        ItemCaption_Control1102154054Lbl: Label 'Item';
        DescriptionCaption_Control1102154056Lbl: Label 'Description';
        QuantityCaption_Control1102154058Lbl: Label 'Quantity';
        Unit_of_MeasureCaption_Control1102154068Lbl: Label 'Unit of Measure';
        Lead_TimeCaption_Control1102154092Lbl: Label 'Lead Time';
        Unit_CostCaption_Control1102154294Lbl: Label 'Unit Cost';
        Total_CostCaption_Control1102154301Lbl: Label 'Total Cost';
        Last_Inward_StatusCaption_Control1102154303Lbl: Label 'Last Inward Status';
        PositionCaption_Control1102154305Lbl: Label 'Position';
        CurrReport_PAGENO_Control1102154008CaptionLbl: Label 'Page';
        Bom_Modification_StatusCaptionLbl: Label 'Bom Modification Status';
        CommentCaptionLbl: Label 'Comment';
        CodeCaptionLbl: Label 'Code';
        Modification_DateCaptionLbl: Label 'Modification Date';
        DescriptionCaption_Control1102154017Lbl: Label 'Description';
        Production_Bom_No_Caption_Control1102154018Lbl: Label 'Production Bom No.';
        CurrReport_PAGENO_Control1102154027CaptionLbl: Label 'Page';
        Enquiry_Response_Time__Tender_CaptionLbl: Label 'Enquiry Response Time (Tender)';
        Released_to_Sales__PersonCaptionLbl: Label 'Released to Sales  Person';
        Released_To_Sales_DateCaptionLbl: Label 'Released To Sales Date';
        Release_To_Deisgn_PersonCaptionLbl: Label 'Release To Deisgn Person';
        Released_To_Design_DateCaptionLbl: Label 'Released To Design Date';
        Tender_No_CaptionLbl: Label 'Tender No.';
        CurrReport_PAGENO_Control1102154087CaptionLbl: Label 'Page';
        Enquiry_Response_Time__Quote_CaptionLbl: Label 'Enquiry Response Time (Quote)';
        Released_to_Sales__PersonCaption_Control1102154069Lbl: Label 'Released to Sales  Person';
        Released_To_Sales_DateCaption_Control1102154071Lbl: Label 'Released To Sales Date';
        Release_To_Deisgn_PersonCaption_Control1102154072Lbl: Label 'Release To Deisgn Person';
        Released_To_Design_DateCaption_Control1102154073Lbl: Label 'Released To Design Date';
        CityCaptionLbl: Label 'City';
        Custmoe_NameCaptionLbl: Label 'Custmoe Name';
        Quote_No_CaptionLbl: Label 'Quote No.';
        "-Rev01-": Integer;
        ChoiceItem: Boolean;
        ChoiceBOM: Boolean;
        ChoiceFForm: Boolean;
        ChoiceCategory: Boolean;
        ChoiceBomMod: Boolean;
        ChoiceERT: Boolean;
        Fill_Form_ChoiceBoth: Boolean;
        Fill_Form_ChoiceSMD: Boolean;
        Fill_Form_ChoiceDIP: Boolean;
        ProdBomLineFooter5: Boolean;
        ExcelVar: Integer;
        TUC5: Decimal;
        UC6: Decimal;
        PRINT2: Boolean;
        PRINT3: Boolean;
        PRINT4: Boolean;
        PRINT5: Boolean;
        With_Cost: Boolean;


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option)
    begin
        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := CellValue;
        Tempexcelbuffer.Bold := bold;
        Tempexcelbuffer."Cell Type" := CellType; //Rev01

        Tempexcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; CellType: Option)
    begin
        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        Tempexcelbuffer.Bold := Bold;
        Tempexcelbuffer."Cell Type" := CellType; //Rev01

        Tempexcelbuffer.Formula := '';
        Tempexcelbuffer.INSERT;
    end;


    procedure "Entercell New"()
    begin
    end;


    procedure PRODUCTION_BOM_COST(BOM: Code[20]) BOM_VALUE: Decimal
    var
        Item: Record Item;
        BOM_Header: Record "Production BOM Header";
        BOM_Line: Record "Production BOM Line";
    begin
        //ActiveVersionCode := VersionMgt.GetBOMVersion(BOM, WORKDATE, TRUE);//B2BUpg
        BOM_Line.SETRANGE(BOM_Line."Production BOM No.", BOM);
        BOM_Line.SETRANGE(BOM_Line."Version Code", ActiveVersionCode);
        IF BOM_Line.FINDSET THEN
            REPEAT
                IF NOT BOM_Header.GET(BOM_Line."No.") THEN BEGIN
                    IF Item.GET(BOM_Line."No.") THEN
                        BOM_VALUE += BOM_Line.Quantity * Item."Item Final Cost";
                END ELSE
                    BOM_VALUE += BOM_Line.Quantity * PRODUCTION_BOM_COST(BOM_Line."No.");
            UNTIL BOM_Line.NEXT = 0;
    end;
}

