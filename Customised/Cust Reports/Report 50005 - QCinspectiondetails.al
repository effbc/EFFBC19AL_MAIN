report 50005 "QCinspection details"
{
    //         avg:=0;
    //         avg1:=1;
    //          no:=0;
    DefaultLayout = RDLC;
    RDLCLayout = './QCinspectiondetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            DataItemTableView = WHERE("Location Code" = CONST('STR'));
            RequestFilterFields = "IDS creation Date", "Item No.";
            column(filter_Control1102154058; filter)
            {
            }
            column(Item_NameCaption_Control1102154045; Item_NameCaption_Control1102154045Lbl)
            {
            }
            column(Inspection_personCaption_Control1102154046; Inspection_personCaption_Control1102154046Lbl)
            {
            }
            column(Total_QtyCaption_Control1102154047; Total_QtyCaption_Control1102154047Lbl)
            {
            }
            column(Qty_AcceptedCaption_Control1102154048; Qty_AcceptedCaption_Control1102154048Lbl)
            {
            }
            column(Qty_RejectedCaption_Control1102154049; Qty_RejectedCaption_Control1102154049Lbl)
            {
            }
            column(Lot_No_Caption_Control1102154050; Lot_No_Caption_Control1102154050Lbl)
            {
            }
            column(Time_takenCaption_Control1102154051; Time_takenCaption_Control1102154051Lbl)
            {
            }
            column(DaysCaption_Control1102154055; DaysCaption_Control1102154055Lbl)
            {
            }
            column(HoursCaption_Control1102154056; HoursCaption_Control1102154056Lbl)
            {
            }
            column(Inward_DateCaption_Control1102154064; Inward_DateCaption_Control1102154064Lbl)
            {
            }
            column(Location_Code_Caption_Control1102154037; Location_Code_Caption_Control1102154037Lbl)
            {
            }
            column(SNO_Caption_Control1102154104; SNO_Caption_Control1102154104Lbl)
            {
            }
            column(UOMCaption_Control1102154109; UOMCaption_Control1102154109Lbl)
            {
            }
            column(Posting_DateCaption_Control1102154071; Posting_DateCaption_Control1102154071Lbl)
            {
            }
            column(Reason_for_pendingCaption_Control1102154152; Reason_for_pendingCaption_Control1102154152Lbl)
            {
            }
            column(filter_Control1102154072; filter)
            {
            }
            column(Qty_RejectedCaption_Control1102154052; Qty_RejectedCaption_Control1102154052Lbl)
            {
            }
            column(Item_NameCaption_Control1102154053; Item_NameCaption_Control1102154053Lbl)
            {
            }
            column(Inspection_personCaption_Control1102154060; Inspection_personCaption_Control1102154060Lbl)
            {
            }
            column(Total_QtyCaption_Control1102154063; Total_QtyCaption_Control1102154063Lbl)
            {
            }
            column(Qty_AcceptedCaption_Control1102154065; Qty_AcceptedCaption_Control1102154065Lbl)
            {
            }
            column(Lot_No_Caption_Control1102154066; Lot_No_Caption_Control1102154066Lbl)
            {
            }
            column(Time_takenCaption_Control1102154067; Time_takenCaption_Control1102154067Lbl)
            {
            }
            column(DaysCaption_Control1102154069; DaysCaption_Control1102154069Lbl)
            {
            }
            column(HoursCaption_Control1102154070; HoursCaption_Control1102154070Lbl)
            {
            }
            column(Inward_DateCaption_Control1102154074; Inward_DateCaption_Control1102154074Lbl)
            {
            }
            column(Location_Code_Caption_Control1102154075; Location_Code_Caption_Control1102154075Lbl)
            {
            }
            column(SNO_Caption_Control1102154105; SNO_Caption_Control1102154105Lbl)
            {
            }
            column(UOMCaption_Control1102154111; UOMCaption_Control1102154111Lbl)
            {
            }
            column(Posting_DateCaption_Control1102154057; Posting_DateCaption_Control1102154057Lbl)
            {
            }
            column(Reason_for_pendingCaption_Control1102154151; Reason_for_pendingCaption_Control1102154151Lbl)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column("filter"; filter)
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header___Location_Code_; "Inspection Receipt Header"."Location Code")
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(Inspection_personCaption; Inspection_personCaptionLbl)
            {
            }
            column(Total_QtyCaption; Total_QtyCaptionLbl)
            {
            }
            column(Qty_AcceptedCaption; Qty_AcceptedCaptionLbl)
            {
            }
            column(Qty_RejectedCaption; Qty_RejectedCaptionLbl)
            {
            }
            column(Lot_No_Caption; Lot_No_CaptionLbl)
            {
            }
            column(Time_takenCaption; Time_takenCaptionLbl)
            {
            }
            column(Inwards_ClearanceCaption; Inwards_ClearanceCaptionLbl)
            {
            }
            column(DaysCaption; DaysCaptionLbl)
            {
            }
            column(HoursCaption; HoursCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Inward_DateCaption; Inward_DateCaptionLbl)
            {
            }
            column(Location_Code_Caption; Location_Code_CaptionLbl)
            {
            }
            column(SNO_Caption; SNO_CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Reason_for_pendingCaption; Reason_for_pendingCaptionLbl)
            {
            }
            column(Inspection_Receipt_Header_No_; "No.")
            {
            }
            dataitem("Posted Inspect DatasheetHeader"; "Posted Inspect DatasheetHeader")
            {
                DataItemLink = "Inspection Receipt No." = FIELD("No.");
                DataItemTableView = SORTING("Inspection Receipt No.", "Item No.") WHERE("Source Type" = CONST("In Bound"), Location = CONST('STR'));
                column(PIDSBody1; PIDSBody1)
                {
                }
                column(Inspection_Receipt_Header___Item_Description_; "Inspection Receipt Header"."Item Description")
                {
                }
                column(Posted_Inspect_DatasheetHeader__Time_Taken_; "Time Taken")
                {
                }
                column(Posted_Inspect_DatasheetHeader__Lot_No__; "Lot No.")
                {
                }
                column(Inspection_Receipt_Header___Qty__Rejected_; "Inspection Receipt Header"."Qty. Rejected")
                {
                }
                column(Inspection_Receipt_Header___Qty__Accepted_; "Inspection Receipt Header"."Qty. Accepted")
                {
                }
                column(Inspection_Receipt_Header__Quantity; "Inspection Receipt Header".Quantity)
                {
                }
                column(name; name)
                {
                }
                column(day; day)
                {
                }
                column(hour; hour)
                {
                }
                column(Inspection_Receipt_Header___Posted_Date_; "Inspection Receipt Header"."Posted Date")
                {
                }
                column(Inspection_Receipt_Header___IDS_creation_Date_; "Inspection Receipt Header"."IDS creation Date")
                {
                }
                column(no; no)
                {
                }
                column(Inspection_Receipt_Header___Unit_Of_Measure_Code_; "Inspection Receipt Header"."Unit Of Measure Code")
                {
                }
                column(Posted_Inspect_DatasheetHeader__Posted_Inspect_DatasheetHeader___Reason_for_Pending_; "Posted Inspect DatasheetHeader"."Reason for Pending")
                {
                }
                column(Posted_Inspect_DatasheetHeader_No_; "No.")
                {
                }
                column(Tim1; tim1)
                {
                }
                column(Tim2; tim2)
                {
                }
                column(Posted_Inspect_DatasheetHeader_Inspection_Receipt_No_; "Inspection Receipt No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Rev01 Start
                    //Posted Inspect DatasheetHeader, Body (1) - OnPreSection()
                    PIDSBody1 := TRUE;
                    dat1 := "Posted Inspect DatasheetHeader"."Created Date";
                    dat2 := "Inspection Receipt Header"."Posted Date";
                    tim1 := "Posted Inspect DatasheetHeader"."Created Time";
                    tim2 := "Inspection Receipt Header"."Posted Time";
                    IF (tim1 > 0T) AND (tim2 > 0T) THEN BEGIN
                        IF (tim2 > tim1) THEN BEGIN
                            IF (dat1 > 0D) AND (dat2 > 0D) THEN BEGIN
                                day := (dat2 - dat1);
                                hour := ((tim2 - tim1) / 3604146);
                            END;
                        END
                        /* Minit:=(tim-tim1) MOD 3604146;
                         Minit:=Minit/60691;
                        */
                        ELSE BEGIN
                            day := (dat2 - dat1) - 1;
                            hour := (24 + (tim2 - tim1) / 3604146);
                        END;
                    END
                    /* ELSE IF (tim2=0T) and (tim1=0T) THEN
                     BEGIN
                     IF (TIME>tim3) THEN
                       BEGIN
                      day:=(TODAY-dat3);
                      hour:=((TIME-tim3)/3604146);
                      END
                      ELSE BEGIN
                       day:=(TODAY-dat1)-1;
                      hour:=(24+(TIME-tim1)/3604146);
                      END
                      END
                    */
                    ELSE BEGIN
                        IF (TIME > tim1) THEN BEGIN
                            day := (TODAY - dat1);
                            hour := ((TIME - tim1) / 3604146);
                        END ELSE BEGIN
                            day := (TODAY - dat1) - 1;
                            hour := (24 + (TIME - tim1) / 3604146);
                        END;
                        // CurrReport.SHOWOUTPUT(FALSE);
                        PIDSBody1 := FALSE;
                    END;

                    total := total + (24 * day + hour);
                    no += 1;
                    Row += 1;
                    IF EXCEL = TRUE THEN BEGIN
                        Entercell(Row, 1, FORMAT(no), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, "Inspection Receipt Header"."Item Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 3, FORMAT(name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 4, FORMAT("Inspection Receipt Header".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 5, FORMAT("Inspection Receipt Header"."Qty. Accepted"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 6, FORMAT("Inspection Receipt Header"."Qty. Accepted Under Deviation"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 7, FORMAT("Inspection Receipt Header"."Qty. Rejected"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 8, FORMAT("Inspection Receipt Header"."Unit Of Measure Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 9, FORMAT("Posted Inspect DatasheetHeader"."Lot No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 10, FORMAT("Posted Inspect DatasheetHeader"."Time Taken"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 11, FORMAT(day), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 12, FORMAT(hour), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 13, FORMAT("Inspection Receipt Header"."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 14, FORMAT("Inspection Receipt Header"."IDS creation Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 15, FORMAT("Posted Inspect DatasheetHeader"."Reason for Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 16, FORMAT("Inspection Receipt Header"."Location Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 17, FORMAT("Inspection Receipt Header"."Vendor Name"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 18, FORMAT("Inspection Receipt Header"."Product Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 19, FORMAT("Inspection Receipt Header"."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 20, FORMAT("Inspection Receipt Header"."Posted By"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 22, FORMAT("Inspection Receipt Header".Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        //ADDED BY VISHNU
                        Entercell(Row, 23, FORMAT("Inspection Receipt Header"."Issues For Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 24, FORMAT("Inspection Receipt Header"."Reason Description"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 25, FORMAT("Inspection Receipt Header"."Qty. Accepted UD Reason"), FALSE, Tempexcelbuffer."Cell Type"::Text);

                        PO.RESET;
                        PO.SETFILTER(PO."No.", "Inspection Receipt Header"."Order No.");
                        IF PO.FINDFIRST THEN
                            Entercell(Row, 21, FORMAT(PO."Sale Order No"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    END;
                    //Rev01 End

                end;

                trigger OnPreDataItem()
                begin
                    "Posted Inspect DatasheetHeader".SETRANGE("Posted Inspect DatasheetHeader"."Created Date", min, max);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*   IRL.SETRANGE(IRL."Inspection Persons",'<>%1','');
                    MESSAGE(FORMAT(IRL.COUNT));
                  IRL.SETFILTER(IRL."Document No.","Inspection Receipt Header"."No.");
                   MESSAGE(FORMAT(IRL.COUNT));
                   IF IRL.FIND('-') THEN  BEGIN
                   MESSAGE(FORMAT(IRL.COUNT));
                   MC.SETRANGE(MC."No.",IRL."Inspection Persons");
                   IF MC.FIND('-') THEN
                   name:=MC.Name;
                   END;
                */


                //Inspection Receipt Header, Body (2) - OnPreSection()

                //Rev01 Start
                /*MC.SETRANGE(MC."No.","Inspection Receipt Header"."Posted By");
                IF MC.FIND('-')THEN
                postby:=MC.Name;
                IRL.RESET;
                IRL.SETFILTER(IRL."Document No.","Inspection Receipt Header"."No.");
                IRL.SETFILTER(IRL."Inspection Persons",'<>%1','');
                IF IRL.FIND('-') THEN  BEGIN
                 MC.SETRANGE(MC."No.",IRL."Inspection Persons");
                 IF MC.FIND('-') THEN
                  name:=MC.Name;
                END ELSE
                  name:='';*/

                // added by sujani
                MC.SETRANGE(MC."User Name", "Inspection Receipt Header"."Posted By");
                IF MC.FIND('-') THEN
                    postby := MC."Full Name";
                IRL.RESET;
                IRL.SETFILTER(IRL."Document No.", "Inspection Receipt Header"."No.");
                IRL.SETFILTER(IRL."Inspection Persons", '<>%1', '');
                IF IRL.FIND('-') THEN BEGIN
                    //MC.SETRANGE(MC.EmployeeID, IRL."Inspection Persons");//B2Bupg
                    //MC.SETRANGE(Blocked, FALSE);//B2Bupg

                    IF MC.FIND('-') THEN
                        name := MC."Full Name";
                END ELSE
                    name := '';

                //Rev01 End

            end;

            trigger OnPostDataItem()
            begin
                //Inspection Receipt Header, Footer (3) - OnPreSection()
                IF no <> 0 THEN
                    avg := total / no;
                avg1 := avg / 24;
            end;

            trigger OnPreDataItem()
            begin


                "Inspection Receipt Header".SETFILTER("Inspection Receipt Header"."Source Type", 'In Bound');
                max := "Inspection Receipt Header".GETRANGEMAX("Inspection Receipt Header"."IDS creation Date");
                min := "Inspection Receipt Header".GETRANGEMIN("Inspection Receipt Header"."IDS creation Date");
                IRL.SETFILTER(IRL."Document No.", "Inspection Receipt Header"."No.");
                IF IRL.FIND('-') THEN BEGIN
                    //MC.SETRANGE(MC."No.",IRL."Inspection Persons");//B2Bupg
                    //MC.SETRANGE(MC.EmployeeID, IRL."Inspection Persons");//B2Bupg
                    //MC.SETRANGE(Blocked, FALSE);

                    IF MC.FIND('-') THEN
                        name := MC."Full Name";
                END;




                //Rev01 Start
                //Inspection Receipt Header, Header (1) - OnPreSection()
                Row += 1;
                IF EXCEL THEN BEGIN
                    EnterHeadings(Row, 1, 'SNO', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'ITEM NAME', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'INSPECTION PERSON', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'TOTAL QUNATITY', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'ACCEPTED QUANTITY', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'QTY ACCEPTED UNDER DEV', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'REJECTED QUNATITY', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'UNIT OF MEASURE', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'LOT NO.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'TIME TAKEN', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'DAYS', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'HOURS', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 13, 'POSTING DATE', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 14, 'INWARD DATE', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 15, 'REASON FOR PENDING', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 16, 'LOCATION', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 17, 'VENDOR NAME', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 18, 'PRODUCT GROUP CODE', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 19, 'ITEM SUB GROUP CODE', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 20, 'INSPECTION PERSON ID', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 21, 'SALE ORDER NO', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 22, 'MAKE', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    //ADDED BU VISHNUPRIYA
                    EnterHeadings(Row, 23, 'ISSUES FOR PENDING', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 24, 'REASON DESCRIPTION', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 25, 'QTY ACCEPTED UNDER DEVIATION', TRUE, Tempexcelbuffer."Cell Type"::Text);

                END;
                //Rev01 End
            end;
        }
        dataitem(IDS; "Inspection Datasheet Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Location = CONST('STR'));
            column(IDSBody1; IDSBody1)
            {
            }
            column(IDS_IDS__Item_Description_; IDS."Item Description")
            {
            }
            column(IDS__Lot_No__; "Lot No.")
            {
            }
            column(IDS_IDS_Quantity; IDS.Quantity)
            {
            }
            column(name_Control1102154123; name)
            {
            }
            column(day_Control1102154124; day)
            {
            }
            column(hour_Control1102154125; hour)
            {
            }
            column(IDS_IDS__Created_Date_; IDS."Created Date")
            {
            }
            column(no_Control1102154128; no)
            {
            }
            column(IDS_IDS__Unit_Of_Measure_Code_; IDS."Unit Of Measure Code")
            {
            }
            column(IDS_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01 Start
                //IDS, Body (1) - OnPreSection()
                IDSBody1 := TRUE;
                dat3 := IDS."Created Date";
                tim3 := IDS."Created Time";
                IF (TIME > tim3) THEN BEGIN
                    day := (TODAY - dat3);
                    hour := ((TIME - tim3) / 3604146);
                END ELSE BEGIN
                    day := (TODAY - dat1) - 1;
                    hour := (24 + (TIME - tim1) / 3604146);
                END;

                total := total + (24 * day + hour);
                //CurrReport.SHOWOUTPUT(FALSE);
                IDSBody1 := FALSE;

                no += 1;
                Row += 1;

                IF EXCEL = TRUE THEN BEGIN
                    Entercell(Row, 1, FORMAT(no), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 2, IDS."Item Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 3, FORMAT(name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 4, FORMAT(IDS.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row, 8, FORMAT(IDS."Unit Of Measure Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 9, FORMAT(IDS."Lot No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 11, FORMAT(day), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 12, FORMAT(hour), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 14, FORMAT(IDS."Created Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                    Entercell(Row, 16, FORMAT(IDS.Location), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 18, FORMAT(IDS."Product Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 19, FORMAT(IDS."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                    Entercell(Row, 20, FORMAT(IDS."Posted By"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 22, FORMAT(IDS.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    //ADDED BY VISHNU
                    Entercell(Row, 23, FORMAT(IDS."Issues For Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 24, FORMAT(IDS."Reason for Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    PO.RESET;
                    PO.SETFILTER(PO."No.", IDS."Order No.");
                    IF PO.FINDFIRST THEN
                        Entercell(Row, 21, FORMAT(PO."Sale Order No"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    //Entercell(Row,16,FORMAT("Inspection Receipt Header"."Vendor Name"),FALSE);
                END;




                //Rev01 End
            end;

            trigger OnPostDataItem()
            begin
                //IDS, Body (1) - OnPostSection()

                CNT1 += 1;
            end;

            trigger OnPreDataItem()
            begin
                IDS.SETRANGE(IDS."Created Date", min, max);
            end;
        }
        dataitem(int1; "Integer")
        {
            column(Int1Header; Int1Header)
            {
            }
            column(avg; avg)
            {
            }
            column(TextVar; TextVar)
            {
            }
            column(avg1; avg1)
            {
            }
            column(total; total)
            {
            }
            column(Average_Days_Caption; Average_Days_CaptionLbl)
            {
            }
            column(int1_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF i = 2 THEN
                    CurrReport.BREAK
                ELSE
                    i += 1;

                Int1Header := TRUE;

                //int1, Header (1) - OnPreSection()
                IF total <> 0 THEN BEGIN
                    IF no <> 0 THEN
                        avg := total / no;
                    avg1 := avg / 24;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    Int1Header := FALSE;
                //int1, Header (1) - OnPreSection()

                TextVar := avg1;
            end;

            trigger OnPostDataItem()
            begin
                i := 0;
            end;
        }
        dataitem(IR; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Location Code" = CONST('R&D STR'));
            column(IR_IR__Location_Code_; IR."Location Code")
            {
            }
            column(IRItemDescription_; IR."Item Description")
            {
            }
            column(IRQuantity_; IR.Quantity)
            {
            }
            column(IRQtyAccepted_; IR."Qty. Accepted")
            {
            }
            column(IRQtyRejected_; IR."Qty. Rejected")
            {
            }
            column(IRUOM_; IR."Unit Of Measure Code")
            {
            }
            column(IRPostedDate_; IR."Posted Date")
            {
            }
            column(IRCreatedDate_; IR."Created Date")
            {
            }
            column(IR_No_; "No.")
            {
            }
            dataitem(PIDS; "Posted Inspect DatasheetHeader")
            {
                DataItemLink = "Inspection Receipt No." = FIELD("No.");
                DataItemTableView = SORTING("Inspection Receipt No.", "Item No.") WHERE("Source Type" = CONST("In Bound"), Location = CONST('R&D STR'));
                column(PostedIDSBody1; PostedIDSBody1)
                {
                }
                column(PIDS__Lot_No__; "Lot No.")
                {
                }
                column(IR__Qty__Accepted_; IR."Qty. Accepted")
                {
                }
                column(name_Control1102154030; name)
                {
                }
                column(IR__Item_Description_; IR."Item Description")
                {
                }
                column(PIDS__Time_Taken_; "Time Taken")
                {
                }
                column(IR_Quantity; IR.Quantity)
                {
                }
                column(day_Control1102154034; day)
                {
                }
                column(hour_Control1102154035; hour)
                {
                }
                column(IR__Posted_Date_; IR."Posted Date")
                {
                }
                column(IR__IDS_creation_Date_; IR."IDS creation Date")
                {
                }
                column(no_Control1102154099; no)
                {
                }
                column(IR__Qty__Rejected_; IR."Qty. Rejected")
                {
                }
                column(IR__Unit_Of_Measure_Code_; IR."Unit Of Measure Code")
                {
                }
                column(PIDS_PIDS__Reason_for_Pending_; PIDS."Reason for Pending")
                {
                }
                column(PIDS_No_; "No.")
                {
                }
                column(PIDSTim1; tim1)
                {
                }
                column(PIDSTim2; tim2)
                {
                }
                column(PIDS_Inspection_Receipt_No_; "Inspection Receipt No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //Rev01 Start
                    //PIDS, Body (1) - OnPreSection()
                    PostedIDSBody1 := TRUE;
                    dat1 := PIDS."Created Date";
                    dat2 := IR."Posted Date";
                    tim1 := PIDS."Created Time";
                    tim2 := IR."Posted Time";
                    IF (tim1 > 0T) AND (tim2 > 0T) THEN BEGIN
                        IF (tim2 > tim1) THEN BEGIN
                            IF (dat1 > 0D) AND (dat2 > 0D) THEN BEGIN
                                day := (dat2 - dat1);
                                hour := ((tim2 - tim1) / 3604146);
                            END;
                        END
                        /* Minit:=(tim-tim1) MOD 3604146;
                         Minit:=Minit/60691;
                        */
                        ELSE BEGIN
                            day := (dat2 - dat1) - 1;
                            hour := (24 + (tim2 - tim1) / 3604146);
                        END;
                    END ELSE BEGIN
                        IF (TIME > tim1) THEN BEGIN
                            day := (TODAY - dat1);
                            hour := ((TIME - tim1) / 3604146);
                        END ELSE BEGIN
                            day := (TODAY - dat1) - 1;
                            hour := (24 + (TIME - tim1) / 3604146);
                        END;
                        //CurrReport.SHOWOUTPUT(FALSE);
                        PostedIDSBody1 := FALSE;
                    END;
                    total1 := total1 + (24 * day + hour);

                    no += 1;
                    Row += 1;
                    IF EXCEL = TRUE THEN BEGIN
                        Entercell(Row, 1, FORMAT(no), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, IR."Item Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 3, FORMAT(name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 4, FORMAT(IR.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 5, FORMAT(IR."Qty. Accepted"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 6, FORMAT(IR."Qty. Accepted Under Deviation"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 7, FORMAT(IR."Qty. Rejected"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 8, FORMAT(IR."Unit Of Measure Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 9, FORMAT(PIDS."Lot No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 10, FORMAT(PIDS."Time Taken"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 11, FORMAT(day), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 12, FORMAT(hour), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 13, FORMAT(IR."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 14, FORMAT(IR."IDS creation Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 15, FORMAT(PIDS."Reason for Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 16, FORMAT(IR."Location Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 17, FORMAT(IR."Vendor Name"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 18, FORMAT(IR."Product Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 19, FORMAT(IR."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 20, FORMAT(IR."Posted By"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 22, FORMAT(IR.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        //ADDED BY VISHNU
                        Entercell(Row, 23, FORMAT(IR."Issues For Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 24, FORMAT(IR."Reason Description"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 25, FORMAT(IR."Qty. Accepted Under Deviation"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        PO.RESET;
                        PO.SETFILTER(PO."No.", IR."Order No.");
                        IF PO.FINDFIRST THEN
                            Entercell(Row, 21, FORMAT(PO."Sale Order No"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    END;
                    //Rev01 End

                end;

                trigger OnPreDataItem()
                begin
                    PIDS.SETRANGE(PIDS."Created Date", min, max);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IRL.SETFILTER(IRL."Document No.", IR."No.");
                IF IRL.FIND('-') THEN BEGIN
                    //MC.SETRANGE(MC."No.",IRL."Inspection Persons");//B2Bupg
                    //MC.SETRANGE(MC.EmployeeID, IRL."Inspection Persons");//B2Bupg
                    //MC.SETRANGE(Blocked, FALSE);

                    IF MC.FIND('-') THEN
                        name := MC."Full Name";
                END;
            end;

            trigger OnPostDataItem()
            begin
                //Rev01 Start
                //IR, Footer (3) - OnPreSection()
                IF no <> 0 THEN
                    avg := total1 / no;
                avg2 := avg / 24;
                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                IR.SETRANGE(IR."IDS creation Date", min, max);
                max := IR.GETRANGEMAX(IR."IDS creation Date");
                min := IR.GETRANGEMIN(IR."IDS creation Date");
                no := 0;
            end;
        }
        dataitem(IDS1; "Inspection Datasheet Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Location = CONST('R&D STR'));
            column(IDS1Body1; IDS1Body1)
            {
            }
            column(IDS1_IDS1__Unit_Of_Measure_Code_; IDS1."Unit Of Measure Code")
            {
            }
            column(IDS1_IDS1__Item_Description_; IDS1."Item Description")
            {
            }
            column(IDS1__Lot_No__; "Lot No.")
            {
            }
            column(IDS1_IDS1_Quantity; IDS1.Quantity)
            {
            }
            column(name_Control1102154130; name)
            {
            }
            column(day_Control1102154131; day)
            {
            }
            column(hour_Control1102154132; hour)
            {
            }
            column(IDS1_IDS1__Created_Date_; IDS1."Created Date")
            {
            }
            column(no_Control1102154134; no)
            {
            }
            column(IDS1_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                //Rev01 Start
                //IDS1, Body (1) - OnPreSection()
                IDS1Body1 := TRUE;
                dat3 := IDS1."Created Date";
                tim3 := IDS1."Created Time";
                IF (TIME > tim3) THEN BEGIN
                    day := (TODAY - dat3);
                    hour := ((TIME - tim3) / 3604146);
                END ELSE BEGIN
                    day := (TODAY - dat1) - 1;
                    hour := (24 + (TIME - tim1) / 3604146);
                END;

                total1 := total1 + (24 * day + hour);
                //CurrReport.SHOWOUTPUT(FALSE);
                IDS1Body1 := FALSE;

                no += 1;
                Row += 1;
                IF EXCEL = TRUE THEN BEGIN
                    Entercell(Row, 1, FORMAT(no), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 2, IDS1."Item Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 3, FORMAT(name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 4, FORMAT(IDS1.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row, 8, FORMAT(IDS1."Unit Of Measure Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 9, FORMAT(IDS1."Lot No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 11, FORMAT(day), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 12, FORMAT(hour), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 14, FORMAT(IDS1."Created Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                    Entercell(Row, 16, FORMAT(IDS1.Location), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 18, FORMAT(IDS1."Product Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 19, FORMAT(IDS1."Item Sub Group Code"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                    Entercell(Row, 20, FORMAT(IDS1."Posted By"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 22, FORMAT(IDS1.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    //ADDED BY VISHNU
                    Entercell(Row, 23, FORMAT(IDS1."Issues For Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 24, FORMAT(IDS1."Reason for Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);

                    PO.RESET;
                    PO.SETFILTER(PO."No.", IDS1."Order No.");
                    IF PO.FINDFIRST THEN
                        Entercell(Row, 21, FORMAT(PO."Sale Order No"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                END;
                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                IDS1.SETRANGE(IDS1."Created Date", min, max);
            end;
        }
        dataitem(int2; "Integer")
        {
            column(Int2Header; Int2Header)
            {
            }
            column(avg2; avg2)
            {
            }
            column(Average_Days_Caption_Control1102154138; Average_Days_Caption_Control1102154138Lbl)
            {
            }
            column(Total1; total1)
            {
            }
            column(int2_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF i = 2 THEN
                    CurrReport.BREAK
                ELSE
                    i += 1;
            end;

            trigger OnPostDataItem()
            begin
                i := 0;
            end;

            trigger OnPreDataItem()
            begin

                //Rev01 Start
                //int2, Header (1) - OnPreSection()
                Int2Header := TRUE;
                IF total1 <> 0 THEN BEGIN
                    IF no <> 0 THEN
                        avg := total1 / no;
                    avg2 := avg / 24;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    Int2Header := FALSE;
                //Rev01 End
            end;
        }
        dataitem(IR1; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Location Code" = CONST('CS STR'));
            column(IR1_Filter; filter)
            {
            }
            column(IR1_IR1__Location_Code_; IR1."Location Code")
            {
            }
            column(IR1_No_; "No.")
            {
            }
            dataitem(PIDS1; "Posted Inspect DatasheetHeader")
            {
                DataItemLink = "Inspection Receipt No." = FIELD("No.");
                DataItemTableView = SORTING("Inspection Receipt No.", "Item No.") WHERE("Source Type" = CONST("In Bound"), Location = CONST('CS STR'));
                column(PIDS1Body1; PIDS1Body1)
                {
                }
                column(IR1__Item_Description_; IR1."Item Description")
                {
                }
                column(IR1__Qty__Rejected_; IR1."Qty. Rejected")
                {
                }
                column(PIDS1__Lot_No__; "Lot No.")
                {
                }
                column(IR1__Qty__Accepted_; IR1."Qty. Accepted")
                {
                }
                column(name_Control1102154080; name)
                {
                }
                column(PIDS1__Time_Taken_; "Time Taken")
                {
                }
                column(IR1_Quantity; IR1.Quantity)
                {
                }
                column(day_Control1102154083; day)
                {
                }
                column(hour_Control1102154084; hour)
                {
                }
                column(IR1__Posted_Date_; IR1."Posted Date")
                {
                }
                column(IR1__IDS_creation_Date_; IR1."IDS creation Date")
                {
                }
                column(no_Control1102154100; no)
                {
                }
                column(IR1__Unit_Of_Measure_Code_; IR1."Unit Of Measure Code")
                {
                }
                column(PIDS1_PIDS1__Reason_for_Pending_; PIDS1."Reason for Pending")
                {
                }
                column(PIDS1_No_; "No.")
                {
                }
                column(PIDS1Tim1; tim1)
                {
                }
                column(PIDS1Tim2; tim2)
                {
                }
                column(PIDS1_Inspection_Receipt_No_; "Inspection Receipt No.")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    //Rev01 Start
                    //PIDS1, Body (1) - OnPreSection()
                    PIDS1Body1 := TRUE;
                    dat1 := PIDS1."Created Date";
                    dat2 := IR1."Posted Date";
                    tim1 := PIDS1."Created Time";
                    tim2 := IR1."Posted Time";
                    IF (tim1 > 0T) AND (tim2 > 0T) THEN BEGIN
                        IF (tim2 > tim1) THEN BEGIN
                            IF (dat1 > 0D) AND (dat2 > 0D) THEN BEGIN
                                day := (dat2 - dat1);
                                hour := ((tim2 - tim1) / 3604146);
                            END;
                        END
                        /*
                         Minit:=(tim-tim1) MOD 3604146;
                         Minit:=Minit/60691;
                        */
                        ELSE BEGIN
                            day := (dat2 - dat1) - 1;
                            hour := (24 + (tim2 - tim1) / 3604146);
                        END;
                    END ELSE BEGIN
                        IF (TIME > tim1) THEN BEGIN
                            day := (TODAY - dat1);
                            hour := ((TIME - tim1) / 3604146);
                        END ELSE BEGIN
                            day := (TODAY - dat1) - 1;
                            hour := (24 + (TIME - tim1) / 3604146);
                        END;
                        //CurrReport.SHOWOUTPUT(FALSE);
                        PIDS1Body1 := FALSE;
                    END;
                    total2 := total2 + (24 * day + hour);

                    no += 1;
                    Row += 1;
                    IF EXCEL = TRUE THEN BEGIN
                        Entercell(Row, 1, FORMAT(no), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, IR1."Item Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 3, FORMAT(name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 4, FORMAT(IR1.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 5, FORMAT(IR1."Qty. Accepted"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 6, FORMAT(IR1."Qty. Accepted Under Deviation"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 7, FORMAT(IR1."Qty. Rejected"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 8, FORMAT(IR1."Unit Of Measure Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 9, FORMAT(PIDS1."Lot No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 10, FORMAT(PIDS1."Time Taken"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 11, FORMAT(day), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 12, FORMAT(hour), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 13, FORMAT(IR1."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 14, FORMAT(IR1."IDS creation Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 15, FORMAT(PIDS1."Reason for Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 16, FORMAT(IR1."Location Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 17, FORMAT(IR1."Vendor Name"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 22, FORMAT(IR1.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        //ADDED BY VISHNU
                        Entercell(Row, 23, FORMAT(IR1."Issues For Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 24, FORMAT(IR1."Reason Description"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 25, FORMAT(IR1."Qty. Accepted Under Deviation"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    END;
                    //Rev01 End

                end;

                trigger OnPreDataItem()
                begin
                    PIDS1.SETRANGE(PIDS1."Created Date", min, max);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IRL.SETFILTER(IRL."Document No.", IR1."No.");
                IF IRL.FIND('-') THEN BEGIN
                    //MC.SETRANGE(MC.EmployeeID, IRL."Inspection Persons");//B2Bupg
                    //MC.SETRANGE(Blocked, FALSE);//B2Bupg

                    IF MC.FIND('-') THEN
                        name := MC."Full Name";
                END;
            end;

            trigger OnPostDataItem()
            begin

                //Rev01 Start
                //IR1, Footer (3) - OnPreSection()
                IF no <> 0 THEN
                    avg := total2 / no;
                avg3 := avg / 24;

                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                IR1.SETRANGE(IR1."IDS creation Date", min, max);
                max := IR.GETRANGEMAX(IR."IDS creation Date");
                min := IR.GETRANGEMIN(IR."IDS creation Date");
                no := 0;
            end;
        }
        dataitem(IDS2; "Inspection Datasheet Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Location = CONST('CS STR'));
            column(IDS2Body1; IDS2Body1)
            {
            }
            column(IDS1_Quantity; IDS1.Quantity)
            {
            }
            column(IDS1__Unit_Of_Measure_Code_; IDS1."Unit Of Measure Code")
            {
            }
            column(IDS1__Item_Description_; IDS1."Item Description")
            {
            }
            column(IDS2__Lot_No__; "Lot No.")
            {
            }
            column(name_Control1102154139; name)
            {
            }
            column(day_Control1102154140; day)
            {
            }
            column(hour_Control1102154141; hour)
            {
            }
            column(IDS1__Created_Date_; IDS1."Created Date")
            {
            }
            column(no_Control1102154143; no)
            {
            }
            column(IDS2_No_; "No.")
            {
            }

            trigger OnPreDataItem()
            begin
                IDS2.SETRANGE(IDS2."Created Date", min, max);

                IDS2Body1 := TRUE;
                //IDS2, Body (1) - OnPreSection()


                dat3 := IDS2."Created Date";
                tim3 := IDS2."Created Time";
                IF (TIME > tim3) THEN BEGIN
                    IF dat3 <> 0D THEN
                        day := (TODAY - dat3);
                    IF tim3 <> 0T THEN
                        hour := ((TIME - tim3) / 3604146);
                END ELSE BEGIN
                    day := (TODAY - dat1) - 1;
                    hour := (24 + (TIME - tim1) / 3604146);
                END;
                //CurrReport.SHOWOUTPUT(FALSE);
                IDS2Body1 := FALSE;

                total2 := total2 + (24 * day + hour);

                no += 1;
                Row += 1;
                IF EXCEL = TRUE THEN BEGIN
                    Entercell(Row, 1, FORMAT(no), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 2, IDS2."Item Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 3, FORMAT(name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 4, FORMAT(IDS2.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row, 8, FORMAT(IDS2."Unit Of Measure Code"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 9, FORMAT(IDS2."Lot No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 11, FORMAT(day), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 12, FORMAT(hour), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 14, FORMAT(IDS2."Created Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                    Entercell(Row, 16, FORMAT(IDS2.Location), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 22, FORMAT(IDS2.Make), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    //ADDED BY VISHNU
                    Entercell(Row, 23, FORMAT(IDS2."Issues For Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 24, FORMAT(IDS2."Reason for Pending"), FALSE, Tempexcelbuffer."Cell Type"::Text);

                END;
                //Rev01 End
            end;
        }
        dataitem(int3; "Integer")
        {
            column(Int3Header; Int3Header)
            {
            }
            column(avg3; avg3)
            {
            }
            column(Average_Days_Caption_Control1102154087; Average_Days_Caption_Control1102154087Lbl)
            {
            }
            column(Total2; total2)
            {
            }
            column(int3_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF i = 2 THEN
                    CurrReport.BREAK
                ELSE
                    i += 1;

                //Rev01 Start
                //int3, Header (1) - OnPreSection()
                Int3Header := TRUE;
                IF total2 <> 0 THEN BEGIN
                    IF no <> 0 THEN
                        avg := total2 / no;
                    avg3 := avg / 24;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    Int3Header := FALSE;
                //Rev01 End
            end;

            trigger OnPostDataItem()
            begin
                i := 0;
            end;
        }
        dataitem("Inspection Datasheet Header"; "Inspection Datasheet Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Source Type" = CONST("In Bound"));
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Vendor_Name_; "Inspection Datasheet Header"."Vendor Name")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Item_Description_; "Inspection Datasheet Header"."Item Description")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header__Quantity; "Inspection Datasheet Header".Quantity)
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Created_Date_; "Inspection Datasheet Header"."Created Date")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header__Location; "Inspection Datasheet Header".Location)
            {
            }
            column(no_Control1102154101; no)
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Unit_Of_Measure_Code_; "Inspection Datasheet Header"."Unit Of Measure Code")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Reason_for_Pending_; "Inspection Datasheet Header"."Reason for Pending")
            {
            }
            column(Pending_ItemsCaption; Pending_ItemsCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Inward_DateCaption_Control1102154094; Inward_DateCaption_Control1102154094Lbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Location_CodeCaption; Location_CodeCaptionLbl)
            {
            }
            column(SNO_Caption_Control1102154106; SNO_Caption_Control1102154106Lbl)
            {
            }
            column(UOMCaption_Control1102154113; UOMCaption_Control1102154113Lbl)
            {
            }
            column(Reason_for_pendingCaption_Control1102154147; Reason_for_pendingCaption_Control1102154147Lbl)
            {
            }
            column(IDSSourceType_; "Inspection Datasheet Header"."Source Type")
            {
            }
            column(Inspection_Datasheet_Header_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Rev01 Start
                //Inspection Datasheet Header, Body (2) - OnPreSection()
                day := 0;
                hour := 0;

                //Inspection Datasheet Header, Body (2) - OnPostSection()
                no += 1;

                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                "Inspection Datasheet Header".SETRANGE("Inspection Datasheet Header"."Created Date", min, max);
                no := 0;
            end;
        }
        dataitem("<Inspection Receipt Header1>"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("No.") WHERE("Source Type" = CONST("In Bound"));
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Vendor_Name_; "<Inspection Receipt Header1>"."Vendor Name")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Item_Description_; "<Inspection Receipt Header1>"."Item Description")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1___Quantity; "<Inspection Receipt Header1>".Quantity)
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____IDS_creation_Date_; "<Inspection Receipt Header1>"."IDS creation Date")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Location_Code_; "<Inspection Receipt Header1>"."Location Code")
            {
            }
            column(no_Control1102154102; no)
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Unit_Of_Measure_Code_; "<Inspection Receipt Header1>"."Unit Of Measure Code")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Reason_for_Pending_; "<Inspection Receipt Header1>"."Reason for Pending")
            {
            }
            column(Inspection_Receipt_Header1__No_; "No.")
            {
            }
            column(IRSourceType_; "<Inspection Receipt Header1>"."Source Type")
            {
            }

            trigger OnAfterGetRecord()
            begin

                //Rev01 Start
                //<Inspection Receipt Header1>, Body (1) - OnPostSection()
                no += 1;
                //Rev01 End
            end;

            trigger OnPreDataItem()
            begin
                "<Inspection Receipt Header1>".SETRANGE("<Inspection Receipt Header1>"."IDS creation Date", min, max);
                "<Inspection Receipt Header1>".SETRANGE("<Inspection Receipt Header1>".Status, FALSE);
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
                    field(Excel; EXCEL)
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
        IF EXCEL THEN BEGIN
            /*
            Tempexcelbuffer.CreateBook('QC Inspection Details','');//B2B //EFFUPG
            Tempexcelbuffer.WriteSheet('QC Inspection Details',COMPANYNAME,USERID);//B2b
            Tempexcelbuffer.CloseBook; //Rev01
            Tempexcelbuffer.OpenExcel; //Rev01
            Tempexcelbuffer.GiveUserControl;
            */
            Tempexcelbuffer.CreateBookAndOpenExcel('', 'QC Inspection Details', 'QC Inspection Details', COMPANYNAME, USERID); //EFFUPG
        END;

    end;

    trigger OnPreReport()
    begin
        filter := "Inspection Receipt Header".GETFILTERS;
        IF EXCEL THEN BEGIN
            CLEAR(Tempexcelbuffer);
            Tempexcelbuffer.DELETEALL;
        END;
    end;

    var
        IRL: Record "Inspection Receipt Line";
        name: Text[80];
        MC: Record User;
        PDIS: Record "Posted Inspect DatasheetHeader";
        TT: Decimal;
        dat1: Date;
        dat2: Date;
        tim1: Time;
        tim2: Time;
        day: Integer;
        hour: Decimal;
        postby: Text[100];
        total: Decimal;
        "filter": Text[100];
        avg: Decimal;
        no: Integer;
        avg1: Decimal;
        cnt: Integer;
        "max": Date;
        "min": Date;
        avg2: Decimal;
        avg3: Decimal;
        total1: Decimal;
        total2: Decimal;
        tim3: Time;
        dat3: Date;
        FLAG: Boolean;
        CNT1: Integer;
        i: Integer;
        Tempexcelbuffer: Record "Excel Buffer";
        EXCEL: Boolean;
        Row: Integer;
        Item_NameCaptionLbl: Label 'Item Name';
        Inspection_personCaptionLbl: Label 'Inspection person';
        Total_QtyCaptionLbl: Label 'Total Qty';
        Qty_AcceptedCaptionLbl: Label 'Qty Accepted';
        Qty_RejectedCaptionLbl: Label 'Qty Rejected';
        Lot_No_CaptionLbl: Label 'Lot No.';
        Time_takenCaptionLbl: Label 'Time taken';
        Inwards_ClearanceCaptionLbl: Label 'Inwards Clearance';
        DaysCaptionLbl: Label 'Days';
        HoursCaptionLbl: Label 'Hours';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Inward_DateCaptionLbl: Label 'Inward Date';
        Location_Code_CaptionLbl: Label 'Location Code:';
        SNO_CaptionLbl: Label 'SNO.';
        UOMCaptionLbl: Label 'UOM';
        Reason_for_pendingCaptionLbl: Label 'Reason for pending';
        Average_Days_CaptionLbl: Label 'Average(Days)';
        Item_NameCaption_Control1102154045Lbl: Label 'Item Name';
        Inspection_personCaption_Control1102154046Lbl: Label 'Inspection person';
        Total_QtyCaption_Control1102154047Lbl: Label 'Total Qty';
        Qty_AcceptedCaption_Control1102154048Lbl: Label 'Qty Accepted';
        Qty_RejectedCaption_Control1102154049Lbl: Label 'Qty Rejected';
        Lot_No_Caption_Control1102154050Lbl: Label 'Lot No.';
        Time_takenCaption_Control1102154051Lbl: Label 'Time taken';
        DaysCaption_Control1102154055Lbl: Label 'Days';
        HoursCaption_Control1102154056Lbl: Label 'Hours';
        Inward_DateCaption_Control1102154064Lbl: Label 'Inward Date';
        Location_Code_Caption_Control1102154037Lbl: Label 'Location Code:';
        SNO_Caption_Control1102154104Lbl: Label 'SNO.';
        UOMCaption_Control1102154109Lbl: Label 'UOM';
        Posting_DateCaption_Control1102154071Lbl: Label 'Posting Date';
        Reason_for_pendingCaption_Control1102154152Lbl: Label 'Reason for pending';
        Average_Days_Caption_Control1102154138Lbl: Label 'Average(Days)';
        Qty_RejectedCaption_Control1102154052Lbl: Label 'Qty Rejected';
        Item_NameCaption_Control1102154053Lbl: Label 'Item Name';
        Inspection_personCaption_Control1102154060Lbl: Label 'Inspection person';
        Total_QtyCaption_Control1102154063Lbl: Label 'Total Qty';
        Qty_AcceptedCaption_Control1102154065Lbl: Label 'Qty Accepted';
        Lot_No_Caption_Control1102154066Lbl: Label 'Lot No.';
        Time_takenCaption_Control1102154067Lbl: Label 'Time taken';
        DaysCaption_Control1102154069Lbl: Label 'Days';
        HoursCaption_Control1102154070Lbl: Label 'Hours';
        Inward_DateCaption_Control1102154074Lbl: Label 'Inward Date';
        Location_Code_Caption_Control1102154075Lbl: Label 'Location Code:';
        SNO_Caption_Control1102154105Lbl: Label 'SNO.';
        UOMCaption_Control1102154111Lbl: Label 'UOM';
        Posting_DateCaption_Control1102154057Lbl: Label 'Posting Date';
        Reason_for_pendingCaption_Control1102154151Lbl: Label 'Reason for pending';
        Average_Days_Caption_Control1102154087Lbl: Label 'Average(Days)';
        Pending_ItemsCaptionLbl: Label 'Pending Items';
        QuantityCaptionLbl: Label 'Quantity';
        Inward_DateCaption_Control1102154094Lbl: Label 'Inward Date';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Location_CodeCaptionLbl: Label 'Location Code';
        SNO_Caption_Control1102154106Lbl: Label 'SNO.';
        UOMCaption_Control1102154113Lbl: Label 'UOM';
        Reason_for_pendingCaption_Control1102154147Lbl: Label 'Reason for pending';
        CellType: Option;
        TextVar: Decimal;
        "-Rev01-": Integer;
        PIDSBody1: Boolean;
        IDSBody1: Boolean;
        Int1Header: Boolean;
        IDS1Body1: Boolean;
        Int2Header: Boolean;
        PIDS1Body1: Boolean;
        IDS2Body1: Boolean;
        Int3Header: Boolean;
        PostedIDSBody1: Boolean;
        ItemGrec: Record Item;
        PO: Record "Purchase Header";


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


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option)
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
}

