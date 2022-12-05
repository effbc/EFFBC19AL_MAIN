report 33000250 "Inspection Data Sheet"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Inspection Data Sheet.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(InspectDataHeader; "Inspection Datasheet Header")
        {
            RequestFilterFields = "No.", "Inspection Group Code", "Vendor No.", "Posting Date";
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(InspectDataHeader_Quantity; Quantity)
            {
            }
            column(InspectDataHeader__Item_Description_; "Item Description")
            {
            }
            column(InspectDataHeader__Item_No__; "Item No.")
            {
            }
            column(InspectDataHeader__Order_No__; "Order No.")
            {
            }
            column(InspectDataHeader__Posting_Date_; "Posting Date")
            {
            }
            column(InspectDataHeader__Document_Date_; "Document Date")
            {
            }
            column(InspectDataHeader__Vendor_Address_; "Vendor Address")
            {
            }
            column(InspectDataHeader__Spec_ID_; "Spec ID")
            {
            }
            column(InspectDataHeader__Receipt_No__; "Receipt No.")
            {
            }
            column(InspectDataHeader__Vendor_Name_; "Vendor Name")
            {
            }
            column(InspectDataHeader_Description; Description)
            {
            }
            column(InspectDataHeader__Vendor_No__; "Vendor No.")
            {
            }
            column(InspectDataHeader__No__; "No.")
            {
            }
            column(InspectDataHeader__Inspection_Group_Code_; "Inspection Group Code")
            {
            }
            column(Inspection_Data_SheetCaption; Inspection_Data_SheetCaptionLbl)
            {
            }
            column(InspectDataHeader_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(InspectDataHeader__Item_Description_Caption; FIELDCAPTION("Item Description"))
            {
            }
            column(InspectDataHeader__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(InspectDataHeader__Order_No__Caption; FIELDCAPTION("Order No."))
            {
            }
            column(InspectDataHeader__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(InspectDataHeader__Document_Date_Caption; FIELDCAPTION("Document Date"))
            {
            }
            column(InspectDataHeader__Vendor_Address_Caption; FIELDCAPTION("Vendor Address"))
            {
            }
            column(InspectDataHeader__Spec_ID_Caption; FIELDCAPTION("Spec ID"))
            {
            }
            column(InspectDataHeader__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(InspectDataHeader__Vendor_Name_Caption; FIELDCAPTION("Vendor Name"))
            {
            }
            column(InspectDataHeader_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(InspectDataHeader__Vendor_No__Caption; FIELDCAPTION("Vendor No."))
            {
            }
            column(InspectDataHeader__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(InspectDataHeader__Inspection_Group_Code_Caption; FIELDCAPTION("Inspection Group Code"))
            {
            }
            dataitem("Inspection Datasheet Line"; "Inspection Datasheet Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Character Code", "Character Group No.");
                column(Inspection_Datasheet_Line__Normal_Value__Text__; "Normal Value (Text)")
                {
                }
                column(Inspection_Datasheet_Line__Sampling_Plan_Code_; "Sampling Plan Code")
                {
                }
                column(Inspection_Datasheet_Line_Description; Description)
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Num__; "Normal Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Unit_Of_Measure_Code_; "Unit Of Measure Code")
                {
                }
                column(Inspection_Datasheet_Line__Character_Code_; "Character Code")
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Text__; "Min. Value (Text)")
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Num__; "Min. Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Text__; "Max. Value (Text)")
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Num__; "Max. Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Text___Control1000000029; "Max. Value (Text)")
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Text___Control1000000031; "Min. Value (Text)")
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Text___Control1000000033; "Normal Value (Text)")
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Num___Control1000000035; "Normal Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Num___Control1000000036; "Min. Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Num___Control1000000037; "Max. Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Unit_Of_Measure_Code__Control1000000038; "Unit Of Measure Code")
                {
                }
                column(Inspection_Datasheet_Line_Description_Control1000000043; Description)
                {
                }
                column(Inspection_Datasheet_Line__Sampling_Plan_Code__Control1000000045; "Sampling Plan Code")
                {
                }
                column(Inspection_Datasheet_Line__Character_Code__Control1000000047; "Character Code")
                {
                }
                column(Inspection_Datasheet_Line__Actual_Value__Num__; "Actual Value (Num)")
                {
                }
                column(Inspection_Datasheet_Line__Actual__Value__Text__; "Actual  Value (Text)")
                {
                }
                column(SampleNo; SampleNo)
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Text__Caption; FIELDCAPTION("Normal Value (Text)"))
                {
                }
                column(Inspection_Datasheet_Line__Sampling_Plan_Code_Caption; FIELDCAPTION("Sampling Plan Code"))
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Text__Caption; FIELDCAPTION("Min. Value (Text)"))
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Text__Caption; FIELDCAPTION("Max. Value (Text)"))
                {
                }
                column(Inspection_Datasheet_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Num__Caption; FIELDCAPTION("Max. Value (Num)"))
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Num__Caption; FIELDCAPTION("Min. Value (Num)"))
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Num__Caption; FIELDCAPTION("Normal Value (Num)"))
                {
                }
                column(Inspection_Datasheet_Line__Unit_Of_Measure_Code_Caption; FIELDCAPTION("Unit Of Measure Code"))
                {
                }
                column(Inspection_Datasheet_Line__Character_Code_Caption; FIELDCAPTION("Character Code"))
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Text___Control1000000029Caption; FIELDCAPTION("Max. Value (Text)"))
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Text___Control1000000031Caption; FIELDCAPTION("Min. Value (Text)"))
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Text___Control1000000033Caption; FIELDCAPTION("Normal Value (Text)"))
                {
                }
                column(Inspection_Datasheet_Line__Min__Value__Num___Control1000000036Caption; FIELDCAPTION("Min. Value (Num)"))
                {
                }
                column(Inspection_Datasheet_Line__Normal_Value__Num___Control1000000035Caption; FIELDCAPTION("Normal Value (Num)"))
                {
                }
                column(Inspection_Datasheet_Line__Unit_Of_Measure_Code__Control1000000038Caption; FIELDCAPTION("Unit Of Measure Code"))
                {
                }
                column(Inspection_Datasheet_Line__Max__Value__Num___Control1000000037Caption; FIELDCAPTION("Max. Value (Num)"))
                {
                }
                column(Inspection_Datasheet_Line_Description_Control1000000043Caption; FIELDCAPTION(Description))
                {
                }
                column(Inspection_Datasheet_Line__Sampling_Plan_Code__Control1000000045Caption; FIELDCAPTION("Sampling Plan Code"))
                {
                }
                column(Inspection_Datasheet_Line__Character_Code__Control1000000047Caption; FIELDCAPTION("Character Code"))
                {
                }
                column(Actual_Value__Num_Caption; Actual_Value__Num_CaptionLbl)
                {
                }
                column(Actual__Value__Text_Caption; Actual__Value__Text_CaptionLbl)
                {
                }
                column(S_NoCaption; S_NoCaptionLbl)
                {
                }
                column(Inspection_Datasheet_Line_Document_No_; "Document No.")
                {
                }
                column(Inspection_Datasheet_Line_Line_No_; "Line No.")
                {
                }
                column(Inspection_Datasheet_Line_Character_Group_No_; "Character Group No.")
                {
                }
            }
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

    var
        SampleNo: Integer;
        Inspection_Data_SheetCaptionLbl: Label 'Inspection Data Sheet';
        Actual_Value__Num_CaptionLbl: Label 'Actual Value (Num)';
        Actual__Value__Text_CaptionLbl: Label 'Actual  Value (Text)';
        S_NoCaptionLbl: Label 'S.No';
}

