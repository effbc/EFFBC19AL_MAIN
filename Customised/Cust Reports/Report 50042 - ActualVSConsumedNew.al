report 50042 "Actual VS Consumed(New)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ActualVSConsumedNew.rdl';
    Caption = 'Prod. Order - Precalc. Time';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Shipment Line";
        "Sales Shipment Line")
        {
            DataItemTableView = SORTING("Order No.", "Order Line No.") ORDER(Ascending) WHERE(Quantity = FILTER(> 0), "Order No." = FILTER(<> ''), Type = CONST(Item));
            RequestFilterFields = "Order No.", "Shipment Date", "No.";
            column(SO_Mat_PlannedCost; SO_Mat_PlannedCost)
            {
            }
            column(SO_Mat_Actual_Cost; SO_Mat_Actual_Cost)
            {
            }
            column(SO_Mat_Excess_Cost; SO_Mat_Excess_Cost)
            {
            }
            column(SO_Mat_Remaining_Cost; SO_Mat_Remaining_Cost)
            {
            }
            column(SO_Mat_Return_Cost; SO_Mat_Return_Cost)
            {
            }
            column(SO_Mat_Damage_Cost; SO_Mat_Damage_Cost)
            {
            }
            column(SO_Mat_Intrest; SO_Mat_Intrest)
            {
            }
            column(SO_BOUT_Planned_Cost; SO_BOUT_Planned_Cost)
            {
            }
            column(SO_BOUT_Actual_Cost; SO_BOUT_Actual_Cost)
            {
            }
            column(PREV_SAL_ORDER; PREV_SAL_ORDER)
            {
            }
            column(SO_Man_Difference_Cost; SO_Man_Difference_Cost)
            {
            }
            column(SO_Man_Differece_Time_60; SO_Man_Differece_Time / 60)
            {
            }
            column(SO_Man_Actual_Cost; SO_Man_Actual_Cost)
            {
            }
            column(SO_Man_Actual_TIme_60; SO_Man_Actual_TIme / 60)
            {
            }
            column(SO_Man_Planned_Cost; SO_Man_Planned_Cost)
            {
            }
            column(SO_Man_Planned_Time_60; SO_Man_Planned_Time / 60)
            {
            }
            column(SO_BOUT_INTREST; SO_BOUT_INTREST)
            {
            }
            column(Sales_Shipment_Line_Description; Description)
            {
            }
            column(Sales_Shipment_Line_Quantity; Quantity)
            {
            }
            column(SL_BOUT_Actual_Cost; SL_BOUT_Actual_Cost)
            {
            }
            column(SL_Mat_PlannedCost; SL_Mat_PlannedCost)
            {
            }
            column(SL_Mat_Actual_Cost; SL_Mat_Actual_Cost)
            {
            }
            column(SL_Mat_Excess_Cost; SL_Mat_Excess_Cost)
            {
            }
            column(SL_Mat_Remaining_Cost; SL_Mat_Remaining_Cost)
            {
            }
            column(SL_Mat_Return_Cost; SL_Mat_Return_Cost)
            {
            }
            column(SL_Mat_Damage_Cost; SL_Mat_Damage_Cost)
            {
            }
            column(SL_Mat_Intrest; SL_Mat_Intrest)
            {
            }
            column(SL_BOUT_Planned_Cost; SL_BOUT_Planned_Cost)
            {
            }
            column(SL_Man_Difference_Cost; SL_Man_Difference_Cost)
            {
            }
            column(SL_Man_Differece_Time_60; SL_Man_Differece_Time / 60)
            {
            }
            column(SL_Man_Actual_Cost; SL_Man_Actual_Cost)
            {
            }
            column(SL_Man_Actual_TIme_60; SL_Man_Actual_TIme / 60)
            {
            }
            column(SL_Man_Planned_Cost; SL_Man_Planned_Cost)
            {
            }
            column(SL_Man_Planned_Time_60; SL_Man_Planned_Time / 60)
            {
            }
            column(SL_BOUT_INTREST; SL_BOUT_INTREST)
            {
            }
            column(Sales_Shipment_Line_Description_Control1102154769; Description)
            {
            }
            column(Sales_Shipment_Line_Quantity_Control1102154770; Quantity)
            {
            }
            column(SL_BOUT_Actual_Cost_Control1102154771; SL_BOUT_Actual_Cost)
            {
            }
            column(SL_Mat_PlannedCost_Control1102154772; SL_Mat_PlannedCost)
            {
            }
            column(SL_Mat_Actual_Cost_Control1102154773; SL_Mat_Actual_Cost)
            {
            }
            column(SL_Mat_Excess_Cost_Control1102154774; SL_Mat_Excess_Cost)
            {
            }
            column(SL_Mat_Remaining_Cost_Control1102154775; SL_Mat_Remaining_Cost)
            {
            }
            column(SL_Mat_Return_Cost_Control1102154776; SL_Mat_Return_Cost)
            {
            }
            column(SL_Mat_Damage_Cost_Control1102154777; SL_Mat_Damage_Cost)
            {
            }
            column(SL_Mat_Intrest_Control1102154778; SL_Mat_Intrest)
            {
            }
            column(SL_BOUT_Planned_Cost_Control1102154779; SL_BOUT_Planned_Cost)
            {
            }
            column(SL_Man_Difference_Cost_Control1102154386; SL_Man_Difference_Cost)
            {
            }
            column(SL_Man_Differece_Time_60_Control1102154398; SL_Man_Differece_Time / 60)
            {
            }
            column(SL_Man_Actual_Cost_Control1102154686; SL_Man_Actual_Cost)
            {
            }
            column(SL_Man_Actual_TIme_60_Control1102154688; SL_Man_Actual_TIme / 60)
            {
            }
            column(SL_Man_Planned_Cost_Control1102154692; SL_Man_Planned_Cost)
            {
            }
            column(SL_Man_Planned_Time_60_Control1102154694; SL_Man_Planned_Time / 60)
            {
            }
            column(SL_BOUT_INTREST_Control1102154696; SL_BOUT_INTREST)
            {
            }
            column(SO_Mat_PlannedCost_Control1102154805; SO_Mat_PlannedCost)
            {
            }
            column(SO_Mat_Actual_Cost_Control1102154806; SO_Mat_Actual_Cost)
            {
            }
            column(SO_Mat_Excess_Cost_Control1102154807; SO_Mat_Excess_Cost)
            {
            }
            column(SO_Mat_Remaining_Cost_Control1102154808; SO_Mat_Remaining_Cost)
            {
            }
            column(SO_Mat_Return_Cost_Control1102154809; SO_Mat_Return_Cost)
            {
            }
            column(SO_Mat_Damage_Cost_Control1102154810; SO_Mat_Damage_Cost)
            {
            }
            column(SO_Mat_Intrest_Control1102154811; SO_Mat_Intrest)
            {
            }
            column(SO_BOUT_Planned_Cost_Control1102154812; SO_BOUT_Planned_Cost)
            {
            }
            column(SO_BOUT_Actual_Cost_Control1102154813; SO_BOUT_Actual_Cost)
            {
            }
            column(Sales_Shipment_Line__Sales_Shipment_Line___Order_No__; "Sales Shipment Line"."Order No.")
            {
            }
            column(SO_Man_Difference_Cost_Control1102154667; SO_Man_Difference_Cost)
            {
            }
            column(SO_Man_Differece_Time_60_Control1102154668; SO_Man_Differece_Time / 60)
            {
            }
            column(SO_Man_Actual_Cost_Control1102154675; SO_Man_Actual_Cost)
            {
            }
            column(SO_Man_Actual_TIme_60_Control1102154689; SO_Man_Actual_TIme / 60)
            {
            }
            column(SO_Man_Planned_Cost_Control1102154710; SO_Man_Planned_Cost)
            {
            }
            column(SO_Man_Planned_Time_60_Control1102154712; SO_Man_Planned_Time / 60)
            {
            }
            column(SO_BOUT_INTREST_Control1102154725; SO_BOUT_INTREST)
            {
            }
            column(Overall_Man_Difference_Cost; Overall_Man_Difference_Cost)
            {
            }
            column(Overall_Man_Differece_Time_60; Overall_Man_Differece_Time / 60)
            {
            }
            column(Overall_Man_Actual_Cost; Overall_Man_Actual_Cost)
            {
            }
            column(Overall_Man_Actual_TIme_60; Overall_Man_Actual_TIme / 60)
            {
            }
            column(Overall_Man_Planned_Cost; Overall_Man_Planned_Cost)
            {
            }
            column(Overall_Man_Planned_Time_60; Overall_Man_Planned_Time / 60)
            {
            }
            column(Overall_BOUT_INTREST; Overall_BOUT_INTREST)
            {
            }
            column(Overall_BOUT_Actual_Cost; Overall_BOUT_Actual_Cost)
            {
            }
            column(Overall_BOUT_Planned_Cost; Overall_BOUT_Planned_Cost)
            {
            }
            column(Overall_Mat_Intrest; Overall_Mat_Intrest)
            {
            }
            column(Overall_Mat_Damage_Cost; Overall_Mat_Damage_Cost)
            {
            }
            column(Overall_Mat_Return_Cost; Overall_Mat_Return_Cost)
            {
            }
            column(Overall_Mat_Remaining_Cost; Overall_Mat_Remaining_Cost)
            {
            }
            column(Overall_Mat_Excess_Cost; Overall_Mat_Excess_Cost)
            {
            }
            column(Overall_Mat_Actual_Cost; Overall_Mat_Actual_Cost)
            {
            }
            column(Overall_Mat_PlannedCost; Overall_Mat_PlannedCost)
            {
            }
            column(ACTUAL_Vs_CONSUMEDCaption; ACTUAL_Vs_CONSUMEDCaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(Planned_CostCaption; Planned_CostCaptionLbl)
            {
            }
            column(Actual_CostCaption; Actual_CostCaptionLbl)
            {
            }
            column(Excess_CostCaption; Excess_CostCaptionLbl)
            {
            }
            column(Remaining_CostCaption; Remaining_CostCaptionLbl)
            {
            }
            column(Return_CostCaption; Return_CostCaptionLbl)
            {
            }
            column(Damage_CostCaption; Damage_CostCaptionLbl)
            {
            }
            column(IntrestCaption; IntrestCaptionLbl)
            {
            }
            column(PlanedCaption; PlanedCaptionLbl)
            {
            }
            column(ActualCaption; ActualCaptionLbl)
            {
            }
            column(Planned_TimeCaption; Planned_TimeCaptionLbl)
            {
            }
            column(Planned_CostCaption_Control1102154834; Planned_CostCaption_Control1102154834Lbl)
            {
            }
            column(Actual_TimeCaption; Actual_TimeCaptionLbl)
            {
            }
            column(Actual_CostCaption_Control1102154836; Actual_CostCaption_Control1102154836Lbl)
            {
            }
            column(Difference_TimeCaption; Difference_TimeCaptionLbl)
            {
            }
            column(Difference_CostCaption; Difference_CostCaptionLbl)
            {
            }
            column(MaterialCaption; MaterialCaptionLbl)
            {
            }
            column(BOUTCaption; BOUTCaptionLbl)
            {
            }
            column(Raw_MaterialCaption; Raw_MaterialCaptionLbl)
            {
            }
            column(Man_PowerCaption; Man_PowerCaptionLbl)
            {
            }
            column(IntrestCaption_Control1102154843; IntrestCaption_Control1102154843Lbl)
            {
            }
            column(OVERALLCaption; OVERALLCaptionLbl)
            {
            }
            column(Sales_Shipment_Line_Document_No_; "Document No.")
            {
            }
            column(Sales_Shipment_Line_Line_No_; "Line No.")
            {
            }
            column(Sales_Shipment_Line_Order_Line_No_; "Order Line No.")
            {
            }
            dataitem("Item Entry Relation"; "Item Entry Relation")
            {
                DataItemLink = "Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No.");
                DataItemTableView = SORTING("Source ID", "Source Type", "Source Subtype", "Source Ref. No.", "Source Prod. Order Line", "Source Batch Name") ORDER(Ascending) WHERE("Source Type" = CONST(111), "Source Subtype" = CONST(0));
                column(Item_Entry_Relation_Item_Entry_No_; "Item Entry No.")
                {
                }
                column(Item_Entry_Relation_Source_ID; "Source ID")
                {
                }
                column(Item_Entry_Relation_Source_Ref__No_; "Source Ref. No.")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Item Entry No.");
                    DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = FILTER(Sale));
                    column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Item_No_; "Item No.")
                    {
                    }
                    column(Item_Ledger_Entry_Serial_No_; "Serial No.")
                    {
                    }
                    dataitem("Item Ledger Entry2"; "Item Ledger Entry")
                    {
                        DataItemLink = "Item No." = FIELD("Item No."), "Serial No." = FIELD("Serial No.");
                        DataItemTableView = SORTING("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.", "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.") ORDER(Ascending) WHERE("Entry Type" = CONST(Output));
                        column(Item_Ledger_Entry2_Entry_No_; "Entry No.")
                        {
                        }
                        column(Item_Ledger_Entry2_Item_No_; "Item No.")
                        {
                        }
                        column(Item_Ledger_Entry2_Serial_No_; "Serial No.")
                        {
                        }
                        column(Item_Ledger_Entry2_Order_No_; "Order No.")
                        {
                        }
                        dataitem("Production Order"; "Production Order")
                        {
                            DataItemLink = "No." = FIELD("Order No.");
                            DataItemTableView = SORTING("Sales Order No.", "Item Sub Group Code") ORDER(Ascending) WHERE("Location Code" = FILTER('PROD'));
                            column(Production_Order_Description; Description)
                            {
                            }
                            column(Production_Order__No__; "No.")
                            {
                            }
                            column(Production_Order__Source_No__; "Source No.")
                            {
                            }
                            column(Production_Order__Item_Sub_Group_Code_; "Item Sub Group Code")
                            {
                            }
                            column(Production_Order__Prod_Start_date_; "Prod Start date")
                            {
                            }
                            column(Production_Order__Finished_Date_; "Finished Date")
                            {
                            }
                            column(Production_Order_Description_Control1102154223; Description)
                            {
                            }
                            column(Production_Order__No___Control1102154224; "No.")
                            {
                            }
                            column(Production_Order__Source_No___Control1102154225; "Source No.")
                            {
                            }
                            column(Production_Order__Item_Sub_Group_Code__Control1102154301; "Item Sub Group Code")
                            {
                            }
                            column(Production_Order__Prod_Start_date__Control1102154312; "Prod Start date")
                            {
                            }
                            column(Production_Order__Finished_Date__Control1102154314; "Finished Date")
                            {
                            }
                            column(Production_Order_No___Caption; Production_Order_No___CaptionLbl)
                            {
                            }
                            column(Description___Caption; Description___CaptionLbl)
                            {
                            }
                            column(Product_Configuration__Caption; Product_Configuration__CaptionLbl)
                            {
                            }
                            column(Product_Type__Caption; Product_Type__CaptionLbl)
                            {
                            }
                            column(Start_Date__Caption; Start_Date__CaptionLbl)
                            {
                            }
                            column(Finished_Date__Caption; Finished_Date__CaptionLbl)
                            {
                            }
                            column(Production_Order_No___Caption_Control1102154226; Production_Order_No___Caption_Control1102154226Lbl)
                            {
                            }
                            column(Description___________________Caption; Description___________________CaptionLbl)
                            {
                            }
                            column(Product_Configuration__Caption_Control1102154310; Product_Configuration__Caption_Control1102154310Lbl)
                            {
                            }
                            column(Product_Type_______________Caption; Product_Type_______________CaptionLbl)
                            {
                            }
                            column(Satrt_Date___________________Caption; Satrt_Date___________________CaptionLbl)
                            {
                            }
                            column(Finish_Date___________________Caption; Finish_Date___________________CaptionLbl)
                            {
                            }
                            column(Production_Order_Status; Status)
                            {
                            }
                            dataitem("Prod. Order Line"; "Prod. Order Line")
                            {
                                DataItemLink = "Prod. Order No." = FIELD("No.");
                                DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.") ORDER(Ascending);
                                RequestFilterFields = "Line No.";
                                column(Prod__Order_Line__Item_No__; "Item No.")
                                {
                                }
                                column(Prod__Order_Line_Description; Description)
                                {
                                }
                                column(Prod__Order_Line_Quantity; Quantity)
                                {
                                }
                                column(Prod__Order_Line_Description_Control1102154169; Description)
                                {
                                }
                                column(Prod__Order_Line_Quantity_Control1102154193; Quantity)
                                {
                                }
                                column(Line_Planned_Cost; Line_Planned_Cost)
                                {
                                }
                                column(Line_Actual_Cost; Line_Actual_Cost)
                                {
                                }
                                column(Line_Excess_Cost; Line_Excess_Cost)
                                {
                                }
                                column(Line_Return_Cost; Line_Return_Cost)
                                {
                                }
                                column(Line_Damage_Cost; Line_Damage_Cost)
                                {
                                }
                                column(Line_Intrest; Line_Intrest)
                                {
                                }
                                column(Line_Remaining_Cost; Line_Remaining_Cost)
                                {
                                }
                                column(Prod_Time_P_60; Prod_Time_P / 60)
                                {
                                }
                                column(Prod_TIme_A_60; Prod_TIme_A / 60)
                                {
                                }
                                column(Mpr_Time_P_60; Mpr_Time_P / 60)
                                {
                                }
                                column(Mpr_Time_A_60; Mpr_Time_A / 60)
                                {
                                }
                                column(Prod_Time_P__Prod_Hour_Cost; (Prod_Time_P) * Prod_Hour_Cost)
                                {
                                }
                                column(Prod_TIme_A__Prod_Hour_Cost; (Prod_TIme_A) * Prod_Hour_Cost)
                                {
                                }
                                column(Mpr_Time_P__MPR_Hour_Cost; (Mpr_Time_P) * MPR_Hour_Cost)
                                {
                                }
                                column(Qas_Time_P_60; Qas_Time_P / 60)
                                {
                                }
                                column(Qas_Time_A_60; Qas_Time_A / 60)
                                {
                                }
                                column(Shf_Time_P_60; Shf_Time_P / 60)
                                {
                                }
                                column(Shf_Time_A_60; Shf_Time_A / 60)
                                {
                                }
                                column(Line_Planned_Time_60; Line_Planned_Time / 60)
                                {
                                }
                                column(Line_Actual_Time_60; Line_Actual_Time / 60)
                                {
                                }
                                column(Line_Actual_Time_Cost; Line_Actual_Time_Cost)
                                {
                                }
                                column(Line_Planned_Time_Cost; Line_Planned_Time_Cost)
                                {
                                }
                                column(Shf_Time_A__SHF_Hour_COst; (Shf_Time_A) * SHF_Hour_COst)
                                {
                                }
                                column(Shf_Time_P__SHF_Hour_COst; (Shf_Time_P) * SHF_Hour_COst)
                                {
                                }
                                column(Qas_Time_A__QAS_Hour_Cost; (Qas_Time_A) * QAS_Hour_Cost)
                                {
                                }
                                column(Qas_Time_P__QAS_Hour_Cost; (Qas_Time_P) * QAS_Hour_Cost)
                                {
                                }
                                column(Mpr_Time_A__MPR_Hour_Cost; (Mpr_Time_A) * MPR_Hour_Cost)
                                {
                                }
                                column(Line_Difference_Cost; Line_Difference_Cost)
                                {
                                }
                                column(Line_Difference_60; Line_Difference / 60)
                                {
                                }
                                column(ROUND_Line_Intrest_0_01_; ROUND(Line_Intrest, 0.01))
                                {
                                }
                                column(ROUND_Line_Damage_Cost_0_01_; ROUND(Line_Damage_Cost, 0.01))
                                {
                                }
                                column(ROUND_Line_Return_Cost_0_01_; ROUND(Line_Return_Cost, 0.01))
                                {
                                }
                                column(ROUND_Line_Excess_Cost_0_01_; ROUND(Line_Excess_Cost, 0.01))
                                {
                                }
                                column(ROUND_Line_Actual_Cost_0_01_; ROUND(Line_Actual_Cost, 0.01))
                                {
                                }
                                column(ROUND_Line_Planned_Cost_0_01_; ROUND(Line_Planned_Cost, 0.01))
                                {
                                }
                                column(ROUND_Line_Remaining_Cost_0_01_; ROUND(Line_Remaining_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Mat_Intrest_0_01_; ROUND(PO_Mat_Intrest, 0.01))
                                {
                                }
                                column(ROUND_PO_Mat_Damage_Cost_0_01_; ROUND(PO_Mat_Damage_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Mat_Return_Cost_0_01_; ROUND(PO_Mat_Return_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Mat_Excess_Cost_0_01_; ROUND(PO_Mat_Excess_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Mat_Actual_Cost_0_01_; ROUND(PO_Mat_Actual_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Mat_PlannedCost_0_01_; ROUND(PO_Mat_PlannedCost, 0.01))
                                {
                                }
                                column(Prod__Order_Line__Prod__Order_Line___Prod__Order_No__; "Prod. Order Line"."Prod. Order No.")
                                {
                                }
                                column(ROUND_PO_Mat_Remaining_Cost_0_01_; ROUND(PO_Mat_Remaining_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Man_Planned_Cost_0_01_; ROUND(PO_Man_Planned_Cost, 0.01))
                                {
                                }
                                column(ROUND_PO_Man_Actual_Cost_0_01_; ROUND(PO_Man_Actual_Cost, 0.01))
                                {
                                }
                                column(PO_Man_Planned_Time_60; PO_Man_Planned_Time / 60)
                                {
                                }
                                column(PO_Man_Actual_TIme_60; PO_Man_Actual_TIme / 60)
                                {
                                }
                                column(ROUND_PO_Man_SHF_Plan_Time_SHF_Hour_COst_0_01_; ROUND(PO_Man_SHF_Plan_Time * SHF_Hour_COst, 0.01))
                                {
                                }
                                column(ROUND_PO_Man_SHF_Actual_Time_SHF_Hour_COst_0_01_; ROUND(PO_Man_SHF_Actual_Time * SHF_Hour_COst, 0.01))
                                {
                                }
                                column(ROUND_PO_Man_Difference_Cost_0_01_; ROUND(PO_Man_Difference_Cost, 0.01))
                                {
                                }
                                column(PO_Man_Differece_Time_60; PO_Man_Differece_Time / 60)
                                {
                                }
                                column(ROUND__PO_Man_SHF_Plan_Time_PO_Man_SHF_Actual_Time__SHF_Hour_COst_0_01_; ROUND((PO_Man_SHF_Plan_Time - PO_Man_SHF_Actual_Time) * SHF_Hour_COst, 0.01))
                                {
                                }
                                column(SHF_Hour_COst_60; SHF_Hour_COst * 60)
                                {
                                }
                                column(PO_Man_SHF_Plan_Time_60; PO_Man_SHF_Plan_Time / 60)
                                {
                                }
                                column(PO_Man_SHF_Actual_Time_60; PO_Man_SHF_Actual_Time / 60)
                                {
                                }
                                column(PO_Man_SHF_Plan_Time_PO_Man_SHF_Actual_Time__60; (PO_Man_SHF_Plan_Time - PO_Man_SHF_Actual_Time) / 60)
                                {
                                }
                                column(ROUND__PO_Man_QAS_Plan_Time_QAS_Hour_Cost__0_01_; ROUND((PO_Man_QAS_Plan_Time * QAS_Hour_Cost), 0.01))
                                {
                                }
                                column(ROUND_PO_Man_QAS_Actual_Time_QAS_Hour_Cost_0_01_; ROUND(PO_Man_QAS_Actual_Time * QAS_Hour_Cost, 0.01))
                                {
                                }
                                column(ROUND__PO_Man_QAS_Plan_Time_PO_Man_QAS_Actual_Time__QAS_Hour_Cost_0_01_; ROUND((PO_Man_QAS_Plan_Time - PO_Man_QAS_Actual_Time) * QAS_Hour_Cost, 0.01))
                                {
                                }
                                column(QAS_Hour_Cost_60; QAS_Hour_Cost * 60)
                                {
                                }
                                column(PO_Man_QAS_Plan_Time_60; PO_Man_QAS_Plan_Time / 60)
                                {
                                }
                                column(PO_Man_QAS_Actual_Time_60; PO_Man_QAS_Actual_Time / 60)
                                {
                                }
                                column(PO_Man_QAS_Plan_Time_PO_Man_QAS_Actual_Time__60; (PO_Man_QAS_Plan_Time - PO_Man_QAS_Actual_Time) / 60)
                                {
                                }
                                column(ROUND__PO_Man_MPR_Plan_Time_MPR_Hour_Cost__0_01_; ROUND((PO_Man_MPR_Plan_Time * MPR_Hour_Cost), 0.01))
                                {
                                }
                                column(ROUND_PO_Man_MPR_Actual_Time_MPR_Hour_Cost_0_01_; ROUND(PO_Man_MPR_Actual_Time * MPR_Hour_Cost, 0.01))
                                {
                                }
                                column(ROUND__PO_Man_MPR_Plan_Time_PO_Man_MPR_Actual_Time__MPR_Hour_Cost_0_01_; ROUND((PO_Man_MPR_Plan_Time - PO_Man_MPR_Actual_Time) * MPR_Hour_Cost, 0.01))
                                {
                                }
                                column(MPR_Hour_Cost_60; MPR_Hour_Cost * 60)
                                {
                                }
                                column(PO_Man_MPR_Plan_Time_60; PO_Man_MPR_Plan_Time / 60)
                                {
                                }
                                column(PO_Man_MPR_Actual_Time_60; PO_Man_MPR_Actual_Time / 60)
                                {
                                }
                                column(PO_Man_MPR_Plan_Time_PO_Man_MPR_Actual_Time__60; (PO_Man_MPR_Plan_Time - PO_Man_MPR_Actual_Time) / 60)
                                {
                                }
                                column(ROUND__PO_Man_PROD_Plan_Time_Prod_Hour_Cost__0_01_; ROUND((PO_Man_PROD_Plan_Time * Prod_Hour_Cost), 0.01))
                                {
                                }
                                column(ROUND_PO_Man_PROD_Actula_Time_Prod_Hour_Cost_0_01_; ROUND(PO_Man_PROD_Actula_Time * Prod_Hour_Cost, 0.01))
                                {
                                }
                                column(ROUND__PO_Man_PROD_Plan_Time_PO_Man_PROD_Actula_Time__Prod_Hour_Cost_0_01_; ROUND((PO_Man_PROD_Plan_Time - PO_Man_PROD_Actula_Time) * Prod_Hour_Cost, 0.01))
                                {
                                }
                                column(Prod_Hour_Cost_60; Prod_Hour_Cost * 60)
                                {
                                }
                                column(PO_Man_PROD_Plan_Time_60; PO_Man_PROD_Plan_Time / 60)
                                {
                                }
                                column(PO_Man_PROD_Actula_Time_60; PO_Man_PROD_Actula_Time / 60)
                                {
                                }
                                column(PO_Man_PROD_Plan_Time_PO_Man_PROD_Actula_Time__60; (PO_Man_PROD_Plan_Time - PO_Man_PROD_Actula_Time) / 60)
                                {
                                }
                                column(ROUND_PO_Mat_PlannedCost_1_; ROUND(PO_Mat_PlannedCost, 1))
                                {
                                }
                                column(ROUND_PO_Mat_Actual_Cost_1_; ROUND(PO_Mat_Actual_Cost, 1))
                                {
                                }
                                column(ROUND_PO_Mat_Excess_Cost_1_; ROUND(PO_Mat_Excess_Cost, 1))
                                {
                                }
                                column(ROUND_PO_Mat_Remaining_Cost_1_; ROUND(PO_Mat_Remaining_Cost, 1))
                                {
                                }
                                column(ROUND_PO_Mat_Damage_Cost_1_; ROUND(PO_Mat_Damage_Cost, 1))
                                {
                                }
                                column(ROUND_PO_Mat_Return_Cost_1_; ROUND(PO_Mat_Return_Cost, 1))
                                {
                                }
                                column(ROUND_PO_Mat_Intrest_1_; ROUND(PO_Mat_Intrest, 1))
                                {
                                }
                                column(ROUND__PO_Man_PROD_Plan_Time_60__0_01_; ROUND((PO_Man_PROD_Plan_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_PROD_Plan_Time_Prod_Hour_Cost__1_; ROUND((PO_Man_PROD_Plan_Time * Prod_Hour_Cost), 1))
                                {
                                }
                                column(ROUND__PO_Man_PROD_Actula_Time_60__0_01_; ROUND((PO_Man_PROD_Actula_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_PROD_Actula_Time_Prod_Hour_Cost__1_; ROUND((PO_Man_PROD_Actula_Time * Prod_Hour_Cost), 1))
                                {
                                }
                                column(ROUND__PO_Man_MPR_Plan_Time_60__0_01_; ROUND((PO_Man_MPR_Plan_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_MPR_Plan_Time_MPR_Hour_Cost__1_; ROUND((PO_Man_MPR_Plan_Time * MPR_Hour_Cost), 1))
                                {
                                }
                                column(ROUND__PO_Man_MPR_Actual_Time_60__0_01_; ROUND((PO_Man_MPR_Actual_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_MPR_Actual_Time_MPR_Hour_Cost__1_; ROUND((PO_Man_MPR_Actual_Time * MPR_Hour_Cost), 1))
                                {
                                }
                                column(ROUND__PO_Man_QAS_Plan_Time_60__0_01_; ROUND((PO_Man_QAS_Plan_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_QAS_Plan_Time_QAS_Hour_Cost__1_; ROUND((PO_Man_QAS_Plan_Time * QAS_Hour_Cost), 1))
                                {
                                }
                                column(ROUND__PO_Man_QAS_Actual_Time_60__0_01_; ROUND((PO_Man_QAS_Actual_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_QAS_Actual_Time_QAS_Hour_Cost__1_; ROUND((PO_Man_QAS_Actual_Time * QAS_Hour_Cost), 1))
                                {
                                }
                                column(ROUND__PO_Man_SHF_Plan_Time_60__0_01_; ROUND((PO_Man_SHF_Plan_Time / 60), 0.01))
                                {
                                }
                                column(ROUND__PO_Man_SHF_Plan_Time_SHF_Hour_COst__1_; ROUND((PO_Man_SHF_Plan_Time * SHF_Hour_COst), 1))
                                {
                                }
                                column(PO_Man_SHF_Actual_Time_60_Control1102154904; PO_Man_SHF_Actual_Time / 60)
                                {
                                }
                                column(ROUND_PO_Man_SHF_Actual_Time_SHF_Hour_COst_1_; ROUND(PO_Man_SHF_Actual_Time * SHF_Hour_COst, 1))
                                {
                                }
                                column(PO_Man_Actual_TIme_60_Control1102154906; PO_Man_Actual_TIme / 60)
                                {
                                }
                                column(ROUND_PO_Man_Actual_Cost_1_; ROUND(PO_Man_Actual_Cost, 1))
                                {
                                }
                                column(PO_Man_Differece_Time_60_Control1102154908; PO_Man_Differece_Time / 60)
                                {
                                }
                                column(ROUND_PO_Man_Difference_Cost_1_; ROUND(PO_Man_Difference_Cost, 1))
                                {
                                }
                                column(PO_Man_Planned_Time_60_Control1102154910; PO_Man_Planned_Time / 60)
                                {
                                }
                                column(ROUND_PO_Man_Planned_Cost_1_; ROUND(PO_Man_Planned_Cost, 1))
                                {
                                }
                                column(Production_Order___No__; "Production Order"."No.")
                                {
                                }
                                column(ItemCaption_Control1102154435; ItemCaption_Control1102154435Lbl)
                                {
                                }
                                column(QTYCaption_Control1102154436; QTYCaption_Control1102154436Lbl)
                                {
                                }
                                column(Planned_CostCaption_Control1102154566; Planned_CostCaption_Control1102154566Lbl)
                                {
                                }
                                column(Actual_CostCaption_Control1102154567; Actual_CostCaption_Control1102154567Lbl)
                                {
                                }
                                column(Excess_CostCaption_Control1102154568; Excess_CostCaption_Control1102154568Lbl)
                                {
                                }
                                column(Return_CostCaption_Control1102154569; Return_CostCaption_Control1102154569Lbl)
                                {
                                }
                                column(Damage_CostCaption_Control1102154570; Damage_CostCaption_Control1102154570Lbl)
                                {
                                }
                                column(ValueCaption; ValueCaptionLbl)
                                {
                                }
                                column(MaterialCaption_Control1102154572; MaterialCaption_Control1102154572Lbl)
                                {
                                }
                                column(Man_PowerCaption_Control1102154573; Man_PowerCaption_Control1102154573Lbl)
                                {
                                }
                                column(Rem__CostCaption; Rem__CostCaptionLbl)
                                {
                                }
                                column(TimeCaption; TimeCaptionLbl)
                                {
                                }
                                column(IntrestCaption_Control1102154585; IntrestCaption_Control1102154585Lbl)
                                {
                                }
                                column(ProductionCaption; ProductionCaptionLbl)
                                {
                                }
                                column(MPRCaption; MPRCaptionLbl)
                                {
                                }
                                column(QASCaption; QASCaptionLbl)
                                {
                                }
                                column(SHFCaption; SHFCaptionLbl)
                                {
                                }
                                column(TOTALCaption; TOTALCaptionLbl)
                                {
                                }
                                column(TimeCaption_Control1102154600; TimeCaption_Control1102154600Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154602; ValueCaption_Control1102154602Lbl)
                                {
                                }
                                column(PLANEDCaption_Control1102154604; PLANEDCaption_Control1102154604Lbl)
                                {
                                }
                                column(ACTUALCaption_Control1102154605; ACTUALCaption_Control1102154605Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154608; TimeCaption_Control1102154608Lbl)
                                {
                                }
                                column(PLANEDCaption_Control1102154610; PLANEDCaption_Control1102154610Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154612; ValueCaption_Control1102154612Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154614; TimeCaption_Control1102154614Lbl)
                                {
                                }
                                column(ACTUALCaption_Control1102154616; ACTUALCaption_Control1102154616Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154618; ValueCaption_Control1102154618Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154620; TimeCaption_Control1102154620Lbl)
                                {
                                }
                                column(PLANEDCaption_Control1102154622; PLANEDCaption_Control1102154622Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154624; ValueCaption_Control1102154624Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154626; TimeCaption_Control1102154626Lbl)
                                {
                                }
                                column(ACTUALCaption_Control1102154628; ACTUALCaption_Control1102154628Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154630; ValueCaption_Control1102154630Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154632; TimeCaption_Control1102154632Lbl)
                                {
                                }
                                column(PLANEDCaption_Control1102154634; PLANEDCaption_Control1102154634Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154636; ValueCaption_Control1102154636Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154638; TimeCaption_Control1102154638Lbl)
                                {
                                }
                                column(ACTUALCaption_Control1102154640; ACTUALCaption_Control1102154640Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154642; ValueCaption_Control1102154642Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154644; TimeCaption_Control1102154644Lbl)
                                {
                                }
                                column(PLANEDCaption_Control1102154646; PLANEDCaption_Control1102154646Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154650; TimeCaption_Control1102154650Lbl)
                                {
                                }
                                column(ACTUALCaption_Control1102154652; ACTUALCaption_Control1102154652Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154654; ValueCaption_Control1102154654Lbl)
                                {
                                }
                                column(DIFFERENCECaption; DIFFERENCECaptionLbl)
                                {
                                }
                                column(ValueCaption_Control1102154218; ValueCaption_Control1102154218Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154221; TimeCaption_Control1102154221Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154648; ValueCaption_Control1102154648Lbl)
                                {
                                }
                                column(ItemCaption_Control1102154010; ItemCaption_Control1102154010Lbl)
                                {
                                }
                                column(Unit_Of_MeasureCaption; Unit_Of_MeasureCaptionLbl)
                                {
                                }
                                column(PlannedCaption; PlannedCaptionLbl)
                                {
                                }
                                column(Planned_QtyCaption; Planned_QtyCaptionLbl)
                                {
                                }
                                column(Unit_Cost__BOM_Caption; Unit_Cost__BOM_CaptionLbl)
                                {
                                }
                                column(Total_Cost_Caption; Total_Cost_CaptionLbl)
                                {
                                }
                                column(IssuedCaption; IssuedCaptionLbl)
                                {
                                }
                                column(Issued_QTYCaption; Issued_QTYCaptionLbl)
                                {
                                }
                                column(Issued__ValueCaption; Issued__ValueCaptionLbl)
                                {
                                }
                                column(Unit_Cost__INV_or_Item_Card_Caption; Unit_Cost__INV_or_Item_Card_CaptionLbl)
                                {
                                }
                                column(Planned_Vs_IssuedCaption; Planned_Vs_IssuedCaptionLbl)
                                {
                                }
                                column(Excess__QTYCaption; Excess__QTYCaptionLbl)
                                {
                                }
                                column(ValueCaption_Control1102154030; ValueCaption_Control1102154030Lbl)
                                {
                                }
                                column(Compound_Description__Caption; Compound_Description__CaptionLbl)
                                {
                                }
                                column(Item_Code_Caption; Item_Code_CaptionLbl)
                                {
                                }
                                column(Quantity__Caption; Quantity__CaptionLbl)
                                {
                                }
                                column(IntrestCaption_Control1102154041; IntrestCaption_Control1102154041Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154043; ValueCaption_Control1102154043Lbl)
                                {
                                }
                                column(Deviated_TimeCaption; Deviated_TimeCaptionLbl)
                                {
                                }
                                column(Return___DamagedCaption; Return___DamagedCaptionLbl)
                                {
                                }
                                column(ValueCaption_Control1102154035; ValueCaption_Control1102154035Lbl)
                                {
                                }
                                column(Damage_QTYCaption; Damage_QTYCaptionLbl)
                                {
                                }
                                column(ValueCaption_Control1102154034; ValueCaption_Control1102154034Lbl)
                                {
                                }
                                column(Return_QTYCaption; Return_QTYCaptionLbl)
                                {
                                }
                                column(ValueCaption_Control1102154255; ValueCaption_Control1102154255Lbl)
                                {
                                }
                                column(Remaining_QTYCaption; Remaining_QTYCaptionLbl)
                                {
                                }
                                column(COMPONENTSCaption; COMPONENTSCaptionLbl)
                                {
                                }
                                column(TOTALSCaption; TOTALSCaptionLbl)
                                {
                                }
                                column(TOTALCaption_Control1102154437; TOTALCaption_Control1102154437Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154440; ValueCaption_Control1102154440Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154447; TimeCaption_Control1102154447Lbl)
                                {
                                }
                                column(HrsCaption; HrsCaptionLbl)
                                {
                                }
                                column(HrsCaption_Control1102154451; HrsCaption_Control1102154451Lbl)
                                {
                                }
                                column(Rs__Per_HourCaption; Rs__Per_HourCaptionLbl)
                                {
                                }
                                column(SHFCaption_Control1102154455; SHFCaption_Control1102154455Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154463; ValueCaption_Control1102154463Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154468; HrsCaption_Control1102154468Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154475; TimeCaption_Control1102154475Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154476; HrsCaption_Control1102154476Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154477; HrsCaption_Control1102154477Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154478; HrsCaption_Control1102154478Lbl)
                                {
                                }
                                column(Rs__Per_HourCaption_Control1102154484; Rs__Per_HourCaption_Control1102154484Lbl)
                                {
                                }
                                column(QASCaption_Control1102154485; QASCaption_Control1102154485Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154491; ValueCaption_Control1102154491Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154501; TimeCaption_Control1102154501Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154502; HrsCaption_Control1102154502Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154503; HrsCaption_Control1102154503Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154504; HrsCaption_Control1102154504Lbl)
                                {
                                }
                                column(MPRCaption_Control1102154508; MPRCaption_Control1102154508Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154515; ValueCaption_Control1102154515Lbl)
                                {
                                }
                                column(Rs__Per_HourCaption_Control1102154519; Rs__Per_HourCaption_Control1102154519Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154524; TimeCaption_Control1102154524Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154525; HrsCaption_Control1102154525Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154526; HrsCaption_Control1102154526Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154527; HrsCaption_Control1102154527Lbl)
                                {
                                }
                                column(ProductionCaption_Control1102154532; ProductionCaption_Control1102154532Lbl)
                                {
                                }
                                column(ValueCaption_Control1102154539; ValueCaption_Control1102154539Lbl)
                                {
                                }
                                column(Rs__Per_HourCaption_Control1102154543; Rs__Per_HourCaption_Control1102154543Lbl)
                                {
                                }
                                column(TimeCaption_Control1102154549; TimeCaption_Control1102154549Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154550; HrsCaption_Control1102154550Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154551; HrsCaption_Control1102154551Lbl)
                                {
                                }
                                column(HrsCaption_Control1102154552; HrsCaption_Control1102154552Lbl)
                                {
                                }
                                column(PlannedCaption_Control1102154559; PlannedCaption_Control1102154559Lbl)
                                {
                                }
                                column(ActualCaption_Control1102154560; ActualCaption_Control1102154560Lbl)
                                {
                                }
                                column(DifferenceCaption_Control1102154561; DifferenceCaption_Control1102154561Lbl)
                                {
                                }
                                column(EmptyStringCaption; EmptyStringCaptionLbl)
                                {
                                }
                                column(CriteriaCaption; CriteriaCaptionLbl)
                                {
                                }
                                column(DepartmentCaption; DepartmentCaptionLbl)
                                {
                                }
                                column(Prod__Order_Line_Status; Status)
                                {
                                }
                                column(Prod__Order_Line_Line_No_; "Line No.")
                                {
                                }
                                dataitem("Posted Material Issues Line"; "Posted Material Issues Line")
                                {
                                    DataItemLink = "Prod. Order No." = FIELD("Prod. Order No."), "Prod. Order Line No." = FIELD("Line No.");
                                    DataItemTableView = SORTING("Prod. Order No.", "Prod. Order Line No.", "Item No.") ORDER(Ascending) WHERE("Transfer-from Code" = FILTER('STR'));
                                    column(ROUND__Planned_Unit__Cost__0_01_; ROUND("Planned Unit  Cost", 0.01))
                                    {
                                    }
                                    column(Planned_Quantity_; "Planned Quantity")
                                    {
                                    }
                                    column(Posted_Material_Issues_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                                    {
                                    }
                                    column(Posted_Material_Issues_Line_Description; Description)
                                    {
                                    }
                                    column(Posted_Material_Issues_Line_Quantity; Quantity)
                                    {
                                    }
                                    column(ROUND__Planned_Unit__Cost___Planned_Quantity__0_01_; ROUND("Planned Unit  Cost" * "Planned Quantity", 0.01))
                                    {
                                    }
                                    column(Return_Qty; Return_Qty)
                                    {
                                    }
                                    column(Damage_Qty; Damage_Qty)
                                    {
                                    }
                                    column(ROUND_Actual_Unit_Cost_0_01_; ROUND(Actual_Unit_Cost, 0.01))
                                    {
                                    }
                                    column(Posted_Material_Issues_Line_Quantity_Control1102154064; Quantity)
                                    {
                                    }
                                    column(ROUND_Quantity_Actual_Unit_Cost_0_01_; ROUND(Quantity * Actual_Unit_Cost, 0.01))
                                    {
                                    }
                                    column(ROUND_Actual_Unit_Cost_Return_Qty_0_01_; ROUND(Actual_Unit_Cost * Return_Qty, 0.01))
                                    {
                                    }
                                    column(ROUND_Actual_Unit_Cost_Damage_Qty_0_01_; ROUND(Actual_Unit_Cost * Damage_Qty, 0.01))
                                    {
                                    }
                                    column(Deviation_Days; Deviation_Days)
                                    {
                                    }
                                    column(ROUND_Intrest_Value_; ROUND(Intrest_Value))
                                    {
                                    }
                                    column(ROUND_Excee_Cost_0_01_; ROUND(Excee_Cost, 0.01))
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
                                    column(Posted_Material_Issues_Line_Prod__Order_No_; "Prod. Order No.")
                                    {
                                    }
                                    column(Posted_Material_Issues_Line_Prod__Order_Line_No_; "Prod. Order Line No.")
                                    {
                                    }

                                    trigger OnAfterGetRecord()
                                    begin
                                        // START
                                        // VERIFY THAT WHETHER IN SALE ORDER SCHEDULE OR NOT
                                        Sales_Schedule_Iss.RESET;
                                        Sales_Schedule_Iss.SETRANGE(Sales_Schedule_Iss."Document No.", "Sales Shipment Line"."Order No.");
                                        Sales_Schedule_Iss.SETRANGE(Sales_Schedule_Iss."Document Line No.", "Sales Shipment Line"."Order Line No.");
                                        Sales_Schedule_Iss.SETRANGE(Sales_Schedule_Iss."No.", "Posted Material Issues Line"."Item No.");
                                        IF Sales_Schedule_Iss.FIND('-') THEN
                                            CurrReport.SKIP;

                                        // VERIFY THAT WHETHER IN SALE ORDER SCHEDULE OR NOT
                                        // END;

                                        // START
                                        // VERIFY THAT WHETHER IN SALE ORDER  OR NOT
                                        sales_shipment_line2.RESET;
                                        sales_shipment_line2.SETRANGE(sales_shipment_line2."Order No.", "Sales Shipment Line"."Order No.");
                                        sales_shipment_line2.SETRANGE(sales_shipment_line2."No.", "Posted Material Issues Line"."Item No.");
                                        IF sales_shipment_line2.FIND('-') THEN
                                            CurrReport.SKIP;

                                        // VERIFY THAT WHETHER IN SALE ORDER  OR NOT
                                        // END;



                                        // Start
                                        // Code For Verfiy Whether the Issued Item Planned or Not

                                        Prod_Order_Cmpnt.RESET;
                                        Prod_Order_Cmpnt.SETCURRENTKEY(Prod_Order_Cmpnt.Status, Prod_Order_Cmpnt."Prod. Order No.",
                                                                       Prod_Order_Cmpnt."Prod. Order Line No.", Prod_Order_Cmpnt."Item No.", Prod_Order_Cmpnt."Line No.");
                                        Prod_Order_Cmpnt.SETRANGE(Prod_Order_Cmpnt."Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
                                        Prod_Order_Cmpnt.SETRANGE(Prod_Order_Cmpnt."Prod. Order Line No.", "Prod. Order Line"."Line No.");
                                        Prod_Order_Cmpnt.SETRANGE(Prod_Order_Cmpnt."Item No.", "Posted Material Issues Line"."Item No.");
                                        IF Prod_Order_Cmpnt.FIND('-') THEN BEGIN
                                            CurrReport.SKIP;
                                        END;

                                        // Code For Planned Cost & Quantity Calculation
                                        // END;
                                    end;

                                    trigger OnPreDataItem()
                                    begin
                                        IF (Choice = Choice::ManPower) OR Only_Routings THEN
                                            CurrReport.BREAK;
                                    end;
                                }
                                dataitem("Prod. Order Component"; "Prod. Order Component")
                                {
                                    CalcFields = "Qty. in Posted Material Issues";
                                    DataItemLink = "Prod. Order No." = FIELD("Prod. Order No."), "Prod. Order Line No." = FIELD("Line No.");
                                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Item No.", "Line No.") ORDER(Ascending);
                                    column(ROUND_Intrest_Value_0_01_; ROUND(Intrest_Value, 0.01))
                                    {
                                    }
                                    column(Deviation_Days_Control1102154082; Deviation_Days)
                                    {
                                    }
                                    column(ROUND_Actual_Unit_Cost_Damage_Qty_0_01__Control1102154078; ROUND(Actual_Unit_Cost * Damage_Qty, 0.01))
                                    {
                                    }
                                    column(Damage_Qty_Control1102154045; Damage_Qty)
                                    {
                                    }
                                    column(ROUND_Actual_Unit_Cost_Return_Qty_0_01__Control1102154077; ROUND(Actual_Unit_Cost * Return_Qty, 0.01))
                                    {
                                    }
                                    column(Return_Qty_Control1102154047; Return_Qty)
                                    {
                                    }
                                    column(ROUND_Excee_Cost_0_01__Control1102154051; ROUND(Excee_Cost, 0.01))
                                    {
                                    }
                                    column(Excess_Qty; Excess_Qty)
                                    {
                                    }
                                    column(ROUND__Qty__in_Posted_Material_Issues__Actual_Unit_Cost_0_01_; ROUND("Qty. in Posted Material Issues" * Actual_Unit_Cost, 0.01))
                                    {
                                    }
                                    column(ROUND_Actual_Unit_Cost_0_01__Control1102154058; ROUND(Actual_Unit_Cost, 0.01))
                                    {
                                    }
                                    column(Prod__Order_Component__Prod__Order_Component___Qty__in_Posted_Material_Issues_; "Prod. Order Component"."Qty. in Posted Material Issues")
                                    {
                                    }
                                    column(ROUND__Prod__Order_Component___AVG_Unit_cost___Prod__Order_Component___Expected_Quantity__0_01_; ROUND("Prod. Order Component"."AVG Unit cost" * "Prod. Order Component"."Expected Quantity", 0.01))
                                    {
                                    }
                                    column(ROUND__Prod__Order_Component___AVG_Unit_cost__0_01_; ROUND("Prod. Order Component"."AVG Unit cost", 0.01))
                                    {
                                    }
                                    column(Prod__Order_Component__Prod__Order_Component___Expected_Quantity_; "Prod. Order Component"."Expected Quantity")
                                    {
                                    }
                                    column(Prod__Order_Component__Unit_of_Measure_Code_; "Unit of Measure Code")
                                    {
                                    }
                                    column(Prod__Order_Component_Description; Description)
                                    {
                                    }
                                    column(ROUND_Remaining_value_0_01_; ROUND(Remaining_value, 0.01))
                                    {
                                    }
                                    column(Remaining_Qty; Remaining_Qty)
                                    {
                                    }
                                    column(Prod__Order_Component_Status; Status)
                                    {
                                    }
                                    column(Prod__Order_Component_Prod__Order_No_; "Prod. Order No.")
                                    {
                                    }
                                    column(Prod__Order_Component_Prod__Order_Line_No_; "Prod. Order Line No.")
                                    {
                                    }
                                    column(Prod__Order_Component_Line_No_; "Line No.")
                                    {
                                    }
                                    column(Prod__Order_Component_Item_No_; "Item No.")
                                    {
                                    }

                                    trigger OnPreDataItem()
                                    begin
                                        IF (Choice = Choice::ManPower) OR (Only_Routings) THEN
                                            CurrReport.BREAK;
                                    end;
                                }
                                dataitem("Capacity Ledger Entry"; "Capacity Ledger Entry")
                                {
                                    DataItemLink = "Order No." = FIELD("Prod. Order No."), "Order Line No." = FIELD("Line No.");
                                    DataItemTableView = SORTING("Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line") ORDER(Ascending);
                                    column(Prod__Order_Line__Description; "Prod. Order Line".Description)
                                    {
                                    }
                                    column(Prod__Order_Line__Quantity; "Prod. Order Line".Quantity)
                                    {
                                    }
                                    column(Prod__Order_Line___Item_No__; "Prod. Order Line"."Item No.")
                                    {
                                    }
                                    column(Capacity_Ledger_Entry_Description; Description)
                                    {
                                    }
                                    column(Capacity_Ledger_Entry__Operation_Description_; "Operation Description")
                                    {
                                    }
                                    column(Capacity_Ledger_Entry__No__; "No.")
                                    {
                                    }
                                    column(Planned_Time; Planned_Time)
                                    {
                                    }
                                    column(Capacity_Ledger_Entry__Run_Time_; "Run Time")
                                    {
                                    }
                                    column(Planned_Time___Run_Time_; (Planned_Time) - "Run Time")
                                    {
                                    }
                                    column(Line_Difference_60_Control1102154206; Line_Difference / 60)
                                    {
                                    }
                                    column(Line_Actual_Time_60_Control1102154207; Line_Actual_Time / 60)
                                    {
                                    }
                                    column(Line_Planned_Time_60_Control1102154208; Line_Planned_Time / 60)
                                    {
                                    }
                                    column(Prod_Time_P_60_Control1102154234; Prod_Time_P / 60)
                                    {
                                    }
                                    column(Prod_TIme_A_60_Control1102154235; Prod_TIme_A / 60)
                                    {
                                    }
                                    column(Mpr_Time_P_60_Control1102154236; Mpr_Time_P / 60)
                                    {
                                    }
                                    column(Mpr_Time_A_60_Control1102154237; Mpr_Time_A / 60)
                                    {
                                    }
                                    column(Qas_Time_P_60_Control1102154239; Qas_Time_P / 60)
                                    {
                                    }
                                    column(Qas_Time_A_60_Control1102154240; Qas_Time_A / 60)
                                    {
                                    }
                                    column(Shf_Time_P_60_Control1102154242; Shf_Time_P / 60)
                                    {
                                    }
                                    column(Shf_Time_A_60_Control1102154243; Shf_Time_A / 60)
                                    {
                                    }
                                    column(Shf_Time_P_Shf_Time_A__60; (Shf_Time_P - Shf_Time_A) / 60)
                                    {
                                    }
                                    column(Qas_Time_P_Qas_Time_A__60; (Qas_Time_P - Qas_Time_A) / 60)
                                    {
                                    }
                                    column(Mpr_Time_P_Mpr_Time_A__60; (Mpr_Time_P - Mpr_Time_A) / 60)
                                    {
                                    }
                                    column(Prod_Time_P_Prod_TIme_A__60; (Prod_Time_P - Prod_TIme_A) / 60)
                                    {
                                    }
                                    column(Line_Planned_Time_Cost_Control1102154277; Line_Planned_Time_Cost)
                                    {
                                    }
                                    column(Line_Actual_Time_Cost_Control1102154278; Line_Actual_Time_Cost)
                                    {
                                    }
                                    column(Line_Difference_Cost_Control1102154279; Line_Difference_Cost)
                                    {
                                    }
                                    column(Prod_Hour_Cost_60_Control1102154280; Prod_Hour_Cost * 60)
                                    {
                                    }
                                    column(MPR_Hour_Cost_60_Control1102154281; MPR_Hour_Cost * 60)
                                    {
                                    }
                                    column(QAS_Hour_Cost_60_Control1102154282; QAS_Hour_Cost * 60)
                                    {
                                    }
                                    column(SHF_Hour_COst_60_Control1102154283; SHF_Hour_COst * 60)
                                    {
                                    }
                                    column(DifferenceCaption_Control1102154159; DifferenceCaption_Control1102154159Lbl)
                                    {
                                    }
                                    column(Planned_TimeCaption_Control1102154160; Planned_TimeCaption_Control1102154160Lbl)
                                    {
                                    }
                                    column(Actual_TimeCaption_Control1102154161; Actual_TimeCaption_Control1102154161Lbl)
                                    {
                                    }
                                    column(ROUTINGCaption; ROUTINGCaptionLbl)
                                    {
                                    }
                                    column(Resource_NameCaption; Resource_NameCaptionLbl)
                                    {
                                    }
                                    column(ActivityCaption; ActivityCaptionLbl)
                                    {
                                    }
                                    column(No_Caption; No_CaptionLbl)
                                    {
                                    }
                                    column(Compound_Description__Caption_Control1102154183; Compound_Description__Caption_Control1102154183Lbl)
                                    {
                                    }
                                    column(Quantity__Caption_Control1102154184; Quantity__Caption_Control1102154184Lbl)
                                    {
                                    }
                                    column(Item_Code_Caption_Control1102154189; Item_Code_Caption_Control1102154189Lbl)
                                    {
                                    }
                                    column(TOTALSCaption_Control1102154205; TOTALSCaption_Control1102154205Lbl)
                                    {
                                    }
                                    column(HrsCaption_Control1102154230; HrsCaption_Control1102154230Lbl)
                                    {
                                    }
                                    column(HrsCaption_Control1102154231; HrsCaption_Control1102154231Lbl)
                                    {
                                    }
                                    column(HrsCaption_Control1102154232; HrsCaption_Control1102154232Lbl)
                                    {
                                    }
                                    column(ProductionCaption_Control1102154233; ProductionCaption_Control1102154233Lbl)
                                    {
                                    }
                                    column(MPRCaption_Control1102154238; MPRCaption_Control1102154238Lbl)
                                    {
                                    }
                                    column(QASCaption_Control1102154241; QASCaption_Control1102154241Lbl)
                                    {
                                    }
                                    column(SHFCaption_Control1102154244; SHFCaption_Control1102154244Lbl)
                                    {
                                    }
                                    column(Rs__Per_HourCaption_Control1102154284; Rs__Per_HourCaption_Control1102154284Lbl)
                                    {
                                    }
                                    column(Rs__Per_HourCaption_Control1102154285; Rs__Per_HourCaption_Control1102154285Lbl)
                                    {
                                    }
                                    column(Rs__Per_HourCaption_Control1102154286; Rs__Per_HourCaption_Control1102154286Lbl)
                                    {
                                    }
                                    column(Rs__Per_HourCaption_Control1102154287; Rs__Per_HourCaption_Control1102154287Lbl)
                                    {
                                    }
                                    column(Capacity_Ledger_Entry_Entry_No_; "Entry No.")
                                    {
                                    }
                                    column(Capacity_Ledger_Entry_Operation_No_; "Operation No.")
                                    {
                                    }
                                    column(Capacity_Ledger_Entry_Order_No_; "Order No.")
                                    {
                                    }
                                    column(Capacity_Ledger_Entry_Order_Line_No_; "Order Line No.")
                                    {
                                    }

                                    trigger OnPreDataItem()
                                    begin
                                        IF Choice = Choice::Material THEN
                                            CurrReport.BREAK;
                                    end;
                                }

                                trigger OnPreDataItem()
                                begin
                                    Compund := FALSE;
                                    IF item.GET("Item Ledger Entry2"."Item No.") THEN BEGIN
                                        IF item."Product Group Code Cust" = 'CPCB' THEN BEGIN
                                            "Prod. Order Line".SETRANGE("Prod. Order Line"."Line No.", "Item Ledger Entry2"."Order Line No.");
                                            Compund := TRUE;
                                        END;
                                    END;
                                end;
                            }

                            trigger OnPreDataItem()
                            begin
                                // CurrReport.BREAK;
                            end;
                        }
                    }

                    trigger OnPreDataItem()
                    begin
                        // CurrReport.BREAK;
                        IF Choice = Choice::Brief THEN BEGIN
                            IF "Sales Shipment Line"."Posting Group" = 'MPBI-FINIS' THEN
                                CurrReport.NEWPAGEPERRECORD := TRUE
                            ELSE BEGIN
                                CurrReport.NEWPAGEPERRECORD := FALSE;
                                CurrReport.SKIP;
                            END;
                        END;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                Shipment_Header.SETRANGE(Shipment_Header."No.", "Sales Shipment Line"."Document No.");
                IF Shipment_Header.FIND('-') THEN
                    Order_Date := Shipment_Header."Order Date";

                NEW_ORDER := FALSE;
                IF PREV_SAL_ORDER <> "Sales Shipment Line"."Order No." THEN BEGIN
                    NEW_ORDER := TRUE;
                    // PREV_SAL_ORDER:="Sales Shipment Line"."Order No.";
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF EXCEL THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;
    end;

    trigger OnPostReport()
    begin
        IF EXCEL THEN BEGIN
            TempExcelbuffer.CreateBook('', '');//B2B //EFFUPG
                                               //TempExcelbuffer.CreateSheet('Stock','',COMPANYNAME,'');//B2B
                                               //TempExcelbuffer.GiveUserControl;
        END;
    end;

    trigger OnPreReport()
    begin
        IF EXCEL THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;

        Work_Center.RESET;
        Work_Center.SETRANGE(Work_Center."No.", 'P1');
        IF Work_Center.FIND('-') THEN
            Prod_Hour_Cost := Work_Center."Direct Unit Cost";


        Work_Center.RESET;
        Work_Center.SETRANGE(Work_Center."No.", 'QAS');
        IF Work_Center.FIND('-') THEN
            QAS_Hour_Cost := Work_Center."Direct Unit Cost";



        Work_Center.RESET;
        Work_Center.SETRANGE(Work_Center."No.", 'SHF');
        IF Work_Center.FIND('-') THEN
            SHF_Hour_COst := Work_Center."Direct Unit Cost";


        Work_Center.RESET;
        Work_Center.SETRANGE(Work_Center."No.", 'MPR');
        IF Work_Center.FIND('-') THEN
            MPR_Hour_Cost := Work_Center."Direct Unit Cost";
    end;

    var
        ProdOrderFilter: Text[250];
        InRouting: Boolean;
        InBOM: Boolean;
        total: Decimal;
        item: Record Item;
        UnitCost: Decimal;
        "Expected Cost": Decimal;
        "Consumed Cost": Decimal;
        "Damage Cost": Decimal;
        "Damage Quantity": Decimal;
        ILE: Record "Item Ledger Entry";
        PRL: Record "Purch. Rcpt. Line";
        PIL: Record "Purch. Inv. Line";
        ILE2: Record "Item Ledger Entry";
        PMH: Record "Posted Material Issues Header";
        Temp: Decimal;
        "Total Damage": Decimal;
        "Total Expected": Decimal;
        "Total Consumed": Decimal;
        pml: Record "Posted Material Issues Line";
        Choice: Option Material,ManPower,Brief,SOBrief;
        Overall_Expected: Decimal;
        Overall_Consumed: Decimal;
        Overall_Damage: Decimal;
        "Previous Order": Code[30];
        Temp_Item: Record Item temporary;
        "Planned Quantity": Decimal;
        "Planned Unit  Cost": Decimal;
        Prod_Order_Cmpnt: Record "Prod. Order Component";
        Posted_Material_Issues_Iss: Record "Posted Material Issues Line";
        Posted_Material_Issues_Ret: Record "Posted Material Issues Line";
        Posted_Material_Issues_Dmg: Record "Posted Material Issues Line";
        Return_Qty: Decimal;
        Damage_Qty: Decimal;
        ItemLedgerEntry_InvCost: Record "Item Ledger Entry";
        IterLedgerEntry_Rcpt: Record "Item Ledger Entry";
        Purch_Rcpt_Line: Record "Purch. Rcpt. Line";
        Purch_Inv_Line: Record "Purch. Inv. Line";
        Actual_Unit_Cost: Decimal;
        Deviation_Days: Integer;
        Intrest_Value: Decimal;
        Excee_Cost: Decimal;
        Excess_Qty: Decimal;
        Remaining_Qty: Decimal;
        Remaining_value: Decimal;
        Line_Planned_Cost: Decimal;
        Line_Actual_Cost: Decimal;
        Line_Excess_Cost: Decimal;
        Line_Remaining_Cost: Decimal;
        Line_Return_Cost: Decimal;
        Line_Damage_Cost: Decimal;
        Line_Intrest: Decimal;
        Line_Actual_Time: Decimal;
        Line_Planned_Time: Decimal;
        Line_Difference: Decimal;
        Line_ManPower_Cost_Planned: Decimal;
        Line_ManPower_Cost_Actual: Decimal;
        Line_ManPower_Cost_Difference: Decimal;
        PO_Mat_Actual_Cost: Decimal;
        PO_Mat_PlannedCost: Decimal;
        PO_Mat_Excess_Cost: Decimal;
        PO_Mat_Remaining_Cost: Decimal;
        PO_Mat_Damage_Cost: Decimal;
        PO_Mat_Return_Cost: Decimal;
        PO_Mat_Intrest: Decimal;
        PO_Man_Planned_Time: Decimal;
        PO_Man_Planned_Cost: Decimal;
        PO_Man_Actual_TIme: Decimal;
        PO_Man_Actual_Cost: Decimal;
        PO_Man_PROD_Plan_Time: Decimal;
        PO_Man_PROD_Actula_Time: Decimal;
        PO_Man_MPR_Plan_Time: Decimal;
        PO_Man_MPR_Actual_Time: Decimal;
        PO_Man_QAS_Plan_Time: Decimal;
        PO_Man_QAS_Actual_Time: Decimal;
        PO_Man_SHF_Plan_Time: Decimal;
        PO_Man_SHF_Actual_Time: Decimal;
        PO_Man_Differece_Time: Decimal;
        PO_Man_Difference_Cost: Decimal;
        Prod_Hour_Cost: Decimal;
        MPR_Hour_Cost: Decimal;
        QAS_Hour_Cost: Decimal;
        SHF_Hour_COst: Decimal;
        Work_Center: Record "Work Center";
        Prod_Time_P: Decimal;
        Prod_TIme_A: Decimal;
        Mpr_Time_P: Decimal;
        Mpr_Time_A: Decimal;
        Shf_Time_P: Decimal;
        Shf_Time_A: Decimal;
        Qas_Time_P: Decimal;
        Qas_Time_A: Decimal;
        Line_Planned_Time_Cost: Decimal;
        Line_Actual_Time_Cost: Decimal;
        Line_Difference_Cost: Decimal;
        Sales_Schedule_Iss: Record Schedule2;
        sales_shipment_line2: Record "Sales Shipment Line";
        Item_Ledger_Entry_BOUT: Record "Item Ledger Entry";
        Schedule_BOUT: Record Schedule2;
        BOUT_LOT: Code[20];
        LOT_STR_LENGTH: Integer;
        I: Integer;
        BOUT_LOT_ARRAY: array[10] of Code[30];
        BOUT_LOT_POINT: Integer;
        LOT_AVAILABLE: Boolean;
        BOUT_LOT_QUANTITY: array[10] of Integer;
        J: Integer;
        SO_BOUT_INTREST: Decimal;
        SO_Mat_Actual_Cost: Decimal;
        SO_Mat_PlannedCost: Decimal;
        SO_Mat_Excess_Cost: Decimal;
        SO_Mat_Remaining_Cost: Decimal;
        SO_Mat_Damage_Cost: Decimal;
        SO_Mat_Return_Cost: Decimal;
        SO_Mat_Intrest: Decimal;
        SO_Man_Planned_Time: Decimal;
        SO_Man_Planned_Cost: Decimal;
        SO_Man_Actual_TIme: Decimal;
        SO_Man_Actual_Cost: Decimal;
        SO_Man_Differece_Time: Decimal;
        SO_Man_Difference_Cost: Decimal;
        SL_BOUT_INTREST: Decimal;
        SL_Mat_Actual_Cost: Decimal;
        SL_Mat_PlannedCost: Decimal;
        SL_Mat_Excess_Cost: Decimal;
        SL_Mat_Remaining_Cost: Decimal;
        SL_Mat_Damage_Cost: Decimal;
        SL_Mat_Return_Cost: Decimal;
        SL_Mat_Intrest: Decimal;
        SL_Man_Planned_Time: Decimal;
        SL_Man_Planned_Cost: Decimal;
        SL_Man_Actual_TIme: Decimal;
        SL_Man_Actual_Cost: Decimal;
        SL_Man_Differece_Time: Decimal;
        SL_Man_Difference_Cost: Decimal;
        SL_BOUT_Planned_Cost: Decimal;
        SL_BOUT_Actual_Cost: Decimal;
        SO_BOUT_Planned_Cost: Decimal;
        SO_BOUT_Actual_Cost: Decimal;
        PREV_SAL_ORDER: Code[30];
        NEW_ORDER: Boolean;
        Overall_Mat_Actual_Cost: Decimal;
        Overall_Mat_PlannedCost: Decimal;
        Overall_Mat_Excess_Cost: Decimal;
        Overall_Mat_Remaining_Cost: Decimal;
        Overall_Mat_Damage_Cost: Decimal;
        Overall_Mat_Return_Cost: Decimal;
        Overall_Mat_Intrest: Decimal;
        Overall_Man_Planned_Time: Decimal;
        Overall_Man_Planned_Cost: Decimal;
        Overall_Man_Actual_TIme: Decimal;
        Overall_Man_Actual_Cost: Decimal;
        Overall_Man_Differece_Time: Decimal;
        Overall_Man_Difference_Cost: Decimal;
        Overall_BOUT_INTREST: Decimal;
        Overall_BOUT_Planned_Cost: Decimal;
        Overall_BOUT_Actual_Cost: Decimal;
        Shipment_Header: Record "Sales Shipment Header";
        Order_Date: Date;
        Compund: Boolean;
        Item_Entry_Relation2: Record "Item Entry Relation";
        Only_Routings: Boolean;
        Planned_Time: Decimal;
        TempExcelbuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        EXCEL: Boolean;
        ACTUAL_Vs_CONSUMEDCaptionLbl: Label 'ACTUAL Vs CONSUMED';
        ItemCaptionLbl: Label 'Item';
        QtyCaptionLbl: Label 'Qty';
        Planned_CostCaptionLbl: Label 'Planned Cost';
        Actual_CostCaptionLbl: Label 'Actual Cost';
        Excess_CostCaptionLbl: Label 'Excess Cost';
        Remaining_CostCaptionLbl: Label 'Remaining Cost';
        Return_CostCaptionLbl: Label 'Return Cost';
        Damage_CostCaptionLbl: Label 'Damage Cost';
        IntrestCaptionLbl: Label 'Intrest';
        PlanedCaptionLbl: Label 'Planed';
        ActualCaptionLbl: Label 'Actual';
        Planned_TimeCaptionLbl: Label 'Planned Time';
        Planned_CostCaption_Control1102154834Lbl: Label 'Planned Cost';
        Actual_TimeCaptionLbl: Label 'Actual Time';
        Actual_CostCaption_Control1102154836Lbl: Label 'Actual Cost';
        Difference_TimeCaptionLbl: Label 'Difference Time';
        Difference_CostCaptionLbl: Label 'Difference Cost';
        MaterialCaptionLbl: Label 'Material';
        BOUTCaptionLbl: Label 'BOUT';
        Raw_MaterialCaptionLbl: Label 'Raw Material';
        Man_PowerCaptionLbl: Label 'Man Power';
        IntrestCaption_Control1102154843Lbl: Label 'Intrest';
        OVERALLCaptionLbl: Label 'OVERALL';
        Production_Order_No___CaptionLbl: Label 'Production Order No. :';
        Description___CaptionLbl: Label 'Description  :';
        Product_Configuration__CaptionLbl: Label 'Product Configuration :';
        Product_Type__CaptionLbl: Label 'Product Type :';
        Start_Date__CaptionLbl: Label 'Start Date :';
        Finished_Date__CaptionLbl: Label 'Finished Date :';
        Production_Order_No___Caption_Control1102154226Lbl: Label 'Production Order No. :';
        Description___________________CaptionLbl: Label 'Description                  :';
        Product_Configuration__Caption_Control1102154310Lbl: Label 'Product Configuration :';
        Product_Type_______________CaptionLbl: Label 'Product Type              :';
        Satrt_Date___________________CaptionLbl: Label 'Satrt Date                  :';
        Finish_Date___________________CaptionLbl: Label 'Finish Date                  :';
        ItemCaption_Control1102154435Lbl: Label 'Item';
        QTYCaption_Control1102154436Lbl: Label 'QTY';
        Planned_CostCaption_Control1102154566Lbl: Label 'Planned Cost';
        Actual_CostCaption_Control1102154567Lbl: Label 'Actual Cost';
        Excess_CostCaption_Control1102154568Lbl: Label 'Excess Cost';
        Return_CostCaption_Control1102154569Lbl: Label 'Return Cost';
        Damage_CostCaption_Control1102154570Lbl: Label 'Damage Cost';
        ValueCaptionLbl: Label 'Value';
        MaterialCaption_Control1102154572Lbl: Label 'Material';
        Man_PowerCaption_Control1102154573Lbl: Label 'Man Power';
        Rem__CostCaptionLbl: Label 'Rem. Cost';
        TimeCaptionLbl: Label 'Time';
        IntrestCaption_Control1102154585Lbl: Label 'Intrest';
        ProductionCaptionLbl: Label 'Production';
        MPRCaptionLbl: Label 'MPR';
        QASCaptionLbl: Label 'QAS';
        SHFCaptionLbl: Label 'SHF';
        TOTALCaptionLbl: Label 'TOTAL';
        TimeCaption_Control1102154600Lbl: Label 'Time';
        ValueCaption_Control1102154602Lbl: Label 'Value';
        PLANEDCaption_Control1102154604Lbl: Label 'PLANED';
        ACTUALCaption_Control1102154605Lbl: Label 'ACTUAL';
        TimeCaption_Control1102154608Lbl: Label 'Time';
        PLANEDCaption_Control1102154610Lbl: Label 'PLANED';
        ValueCaption_Control1102154612Lbl: Label 'Value';
        TimeCaption_Control1102154614Lbl: Label 'Time';
        ACTUALCaption_Control1102154616Lbl: Label 'ACTUAL';
        ValueCaption_Control1102154618Lbl: Label 'Value';
        TimeCaption_Control1102154620Lbl: Label 'Time';
        PLANEDCaption_Control1102154622Lbl: Label 'PLANED';
        ValueCaption_Control1102154624Lbl: Label 'Value';
        TimeCaption_Control1102154626Lbl: Label 'Time';
        ACTUALCaption_Control1102154628Lbl: Label 'ACTUAL';
        ValueCaption_Control1102154630Lbl: Label 'Value';
        TimeCaption_Control1102154632Lbl: Label 'Time';
        PLANEDCaption_Control1102154634Lbl: Label 'PLANED';
        ValueCaption_Control1102154636Lbl: Label 'Value';
        TimeCaption_Control1102154638Lbl: Label 'Time';
        ACTUALCaption_Control1102154640Lbl: Label 'ACTUAL';
        ValueCaption_Control1102154642Lbl: Label 'Value';
        TimeCaption_Control1102154644Lbl: Label 'Time';
        PLANEDCaption_Control1102154646Lbl: Label 'PLANED';
        TimeCaption_Control1102154650Lbl: Label 'Time';
        ACTUALCaption_Control1102154652Lbl: Label 'ACTUAL';
        ValueCaption_Control1102154654Lbl: Label 'Value';
        DIFFERENCECaptionLbl: Label 'DIFFERENCE';
        ValueCaption_Control1102154218Lbl: Label 'Value';
        TimeCaption_Control1102154221Lbl: Label 'Time';
        ValueCaption_Control1102154648Lbl: Label 'Value';
        ItemCaption_Control1102154010Lbl: Label 'Item';
        Unit_Of_MeasureCaptionLbl: Label 'Unit Of Measure';
        PlannedCaptionLbl: Label 'Planned';
        Planned_QtyCaptionLbl: Label 'Planned Qty';
        Unit_Cost__BOM_CaptionLbl: Label 'Unit Cost (BOM)';
        Total_Cost_CaptionLbl: Label 'Total Cost ';
        IssuedCaptionLbl: Label 'Issued';
        Issued_QTYCaptionLbl: Label 'Issued QTY';
        Issued__ValueCaptionLbl: Label 'Issued _Value';
        Unit_Cost__INV_or_Item_Card_CaptionLbl: Label 'Unit Cost (INV or Item Card)';
        Planned_Vs_IssuedCaptionLbl: Label 'Planned Vs Issued';
        Excess__QTYCaptionLbl: Label 'Excess  QTY';
        ValueCaption_Control1102154030Lbl: Label 'Value';
        Compound_Description__CaptionLbl: Label 'Compound Description  ';
        Item_Code_CaptionLbl: Label 'Item Code ';
        Quantity__CaptionLbl: Label 'Quantity  ';
        IntrestCaption_Control1102154041Lbl: Label 'Intrest';
        ValueCaption_Control1102154043Lbl: Label 'Value';
        Deviated_TimeCaptionLbl: Label 'Deviated Time';
        Return___DamagedCaptionLbl: Label 'Return & Damaged';
        ValueCaption_Control1102154035Lbl: Label 'Value';
        Damage_QTYCaptionLbl: Label 'Damage QTY';
        ValueCaption_Control1102154034Lbl: Label 'Value';
        Return_QTYCaptionLbl: Label 'Return QTY';
        ValueCaption_Control1102154255Lbl: Label 'Value';
        Remaining_QTYCaptionLbl: Label 'Remaining QTY';
        COMPONENTSCaptionLbl: Label 'COMPONENTS';
        TOTALSCaptionLbl: Label 'TOTALS';
        TOTALCaption_Control1102154437Lbl: Label 'TOTAL';
        ValueCaption_Control1102154440Lbl: Label 'Value';
        TimeCaption_Control1102154447Lbl: Label 'Time';
        HrsCaptionLbl: Label 'Hrs';
        HrsCaption_Control1102154451Lbl: Label 'Hrs';
        Rs__Per_HourCaptionLbl: Label 'Rs. Per Hour';
        SHFCaption_Control1102154455Lbl: Label 'SHF';
        ValueCaption_Control1102154463Lbl: Label 'Value';
        HrsCaption_Control1102154468Lbl: Label 'Hrs';
        TimeCaption_Control1102154475Lbl: Label 'Time';
        HrsCaption_Control1102154476Lbl: Label 'Hrs';
        HrsCaption_Control1102154477Lbl: Label 'Hrs';
        HrsCaption_Control1102154478Lbl: Label 'Hrs';
        Rs__Per_HourCaption_Control1102154484Lbl: Label 'Rs. Per Hour';
        QASCaption_Control1102154485Lbl: Label 'QAS';
        ValueCaption_Control1102154491Lbl: Label 'Value';
        TimeCaption_Control1102154501Lbl: Label 'Time';
        HrsCaption_Control1102154502Lbl: Label 'Hrs';
        HrsCaption_Control1102154503Lbl: Label 'Hrs';
        HrsCaption_Control1102154504Lbl: Label 'Hrs';
        MPRCaption_Control1102154508Lbl: Label 'MPR';
        ValueCaption_Control1102154515Lbl: Label 'Value';
        Rs__Per_HourCaption_Control1102154519Lbl: Label 'Rs. Per Hour';
        TimeCaption_Control1102154524Lbl: Label 'Time';
        HrsCaption_Control1102154525Lbl: Label 'Hrs';
        HrsCaption_Control1102154526Lbl: Label 'Hrs';
        HrsCaption_Control1102154527Lbl: Label 'Hrs';
        ProductionCaption_Control1102154532Lbl: Label 'Production';
        ValueCaption_Control1102154539Lbl: Label 'Value';
        Rs__Per_HourCaption_Control1102154543Lbl: Label 'Rs. Per Hour';
        TimeCaption_Control1102154549Lbl: Label 'Time';
        HrsCaption_Control1102154550Lbl: Label 'Hrs';
        HrsCaption_Control1102154551Lbl: Label 'Hrs';
        HrsCaption_Control1102154552Lbl: Label 'Hrs';
        PlannedCaption_Control1102154559Lbl: Label 'Planned';
        ActualCaption_Control1102154560Lbl: Label 'Actual';
        DifferenceCaption_Control1102154561Lbl: Label 'Difference';
        EmptyStringCaptionLbl: Label '\';
        CriteriaCaptionLbl: Label 'Criteria';
        DepartmentCaptionLbl: Label 'Department';
        DifferenceCaption_Control1102154159Lbl: Label 'Difference';
        Planned_TimeCaption_Control1102154160Lbl: Label 'Planned Time';
        Actual_TimeCaption_Control1102154161Lbl: Label 'Actual Time';
        ROUTINGCaptionLbl: Label 'ROUTING';
        Resource_NameCaptionLbl: Label 'Resource Name';
        ActivityCaptionLbl: Label 'Activity';
        No_CaptionLbl: Label 'No.';
        Compound_Description__Caption_Control1102154183Lbl: Label 'Compound Description  ';
        Quantity__Caption_Control1102154184Lbl: Label 'Quantity  ';
        Item_Code_Caption_Control1102154189Lbl: Label 'Item Code ';
        TOTALSCaption_Control1102154205Lbl: Label 'TOTALS';
        HrsCaption_Control1102154230Lbl: Label 'Hrs';
        HrsCaption_Control1102154231Lbl: Label 'Hrs';
        HrsCaption_Control1102154232Lbl: Label 'Hrs';
        ProductionCaption_Control1102154233Lbl: Label 'Production';
        MPRCaption_Control1102154238Lbl: Label 'MPR';
        QASCaption_Control1102154241Lbl: Label 'QAS';
        SHFCaption_Control1102154244Lbl: Label 'SHF';
        Rs__Per_HourCaption_Control1102154284Lbl: Label 'Rs. Per Hour';
        Rs__Per_HourCaption_Control1102154285Lbl: Label 'Rs. Per Hour';
        Rs__Per_HourCaption_Control1102154286Lbl: Label 'Rs. Per Hour';
        Rs__Per_HourCaption_Control1102154287Lbl: Label 'Rs. Per Hour';


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;

        TempExcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;

        TempExcelbuffer.Formula := '';
        TempExcelbuffer.INSERT;
    end;


    procedure "Entercell New"()
    begin
    end;
}

