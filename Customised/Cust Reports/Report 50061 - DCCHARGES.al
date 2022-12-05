report 50061 "DC CHARGES"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DCCHARGES.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("DC Header"; "DC Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Type = CONST(Site), "No." = FILTER('CUS*'));
            RequestFilterFields = "Created Date", "Location Code";
            column(CURRENTDATETIME; CURRENTDATETIME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(DC_Header__GETFILTERS; "DC Header".GETFILTERS)
            {
            }
            column(DC_Header__No__; "No.")
            {
            }
            column(DC_Header__Created_Date_; "Created Date")
            {
            }
            column(DC_Header__Location_Name_; "Location Name")
            {
            }
            column(DC_Header__Mode_Of_Transport_; "Mode Of Transport")
            {
            }
            column(DC_Header__Reciver_Name_; "Reciver Name")
            {
            }
            column(DC_Header__L_R_Number_; "L.R Number")
            {
            }
            column(DC_Header_Charges; Charges)
            {
            }
            column(ZONE_NAME; ZONE_NAME)
            {
            }
            column(TOTAL_DC_CHARGES; TOTAL_DC_CHARGES)
            {
            }
            column(CHARGE_LESS_DC_S_; "CHARGE_LESS_DC'S")
            {
            }
            column(NO__OF_DC_S_; "NO. OF DC'S")
            {
            }
            column(MODE_OF_TRANSPORT_INFO_1_; MODE_OF_TRANSPORT_INFO[1])
            {
            }
            column(MODE_OF_TRANSPORT_INFO_2_; MODE_OF_TRANSPORT_INFO[2])
            {
            }
            column(MODE_OF_TRANSPORT_INFO_3_; MODE_OF_TRANSPORT_INFO[3])
            {
            }
            column(MODE_OF_TRANSPORT_INFO_4_; MODE_OF_TRANSPORT_INFO[4])
            {
            }
            column(MODE_OF_TRANSPORT_INFO_5_; MODE_OF_TRANSPORT_INFO[5])
            {
            }
            column(DataItem1102154022; MODE_OF_TRANSPORT_INFO[1] + MODE_OF_TRANSPORT_INFO[2] + MODE_OF_TRANSPORT_INFO[3] + MODE_OF_TRANSPORT_INFO[4] + MODE_OF_TRANSPORT_INFO[5])
            {
            }
            column(MODE_OF_TRANSPORT_CHARGES_1_; MODE_OF_TRANSPORT_CHARGES[1])
            {
            }
            column(MODE_OF_TRANSPORT_CHARGES_2_; MODE_OF_TRANSPORT_CHARGES[2])
            {
            }
            column(MODE_OF_TRANSPORT_CHARGES_3_; MODE_OF_TRANSPORT_CHARGES[3])
            {
            }
            column(MODE_OF_TRANSPORT_CHARGES_4_; MODE_OF_TRANSPORT_CHARGES[4])
            {
            }
            column(MODE_OF_TRANSPORT_CHARGES_5_; MODE_OF_TRANSPORT_CHARGES[5])
            {
            }
            column(TOTAL_DC_CHARGES_Control1102154048; TOTAL_DC_CHARGES)
            {
            }
            column(DC_CHARGES_Caption; DC_CHARGES_CaptionLbl)
            {
            }
            column(Reporting_Date_Time__Caption; Reporting_Date_Time__CaptionLbl)
            {
            }
            column(DC_NO_Caption; DC_NO_CaptionLbl)
            {
            }
            column(CREATED_ONCaption; CREATED_ONCaptionLbl)
            {
            }
            column(LOCATIONCaption; LOCATIONCaptionLbl)
            {
            }
            column(DC_Header__Mode_Of_Transport_Caption; FIELDCAPTION("Mode Of Transport"))
            {
            }
            column(Send_ToCaption; Send_ToCaptionLbl)
            {
            }
            column(DC_Header__L_R_Number_Caption; FIELDCAPTION("L.R Number"))
            {
            }
            column(DC_Header_ChargesCaption; FIELDCAPTION(Charges))
            {
            }
            column(ZONE_Caption; ZONE_CaptionLbl)
            {
            }
            column(NOTE__Caption; NOTE__CaptionLbl)
            {
            }
            column(There_is_no_Charges_Information_for_Caption; There_is_no_Charges_Information_for_CaptionLbl)
            {
            }
            column(No__of__DC_S_Out_of_Caption; No__of__DC_S_Out_of_CaptionLbl)
            {
            }
            column(DC_S_Caption; DC_S_CaptionLbl)
            {
            }
            column(BY_COURIER__Caption; BY_COURIER__CaptionLbl)
            {
            }
            column(BY_TRAIN_______Caption; BY_TRAIN_______CaptionLbl)
            {
            }
            column(BY_BUS___________Caption; BY_BUS___________CaptionLbl)
            {
            }
            column(BY_HAND________Caption; BY_HAND________CaptionLbl)
            {
            }
            column(BY_VRL__________Caption; BY_VRL__________CaptionLbl)
            {
            }
            column(REPORT__GENERATED_FROM_ERP_____Caption; REPORT__GENERATED_FROM_ERP_____CaptionLbl)
            {
            }
            column(There_is_no_Charges_for_the_DC_S_which_are_Sent__By_Hand___Caption; There_is_no_Charges_for_the_DC_S_which_are_Sent__By_Hand___CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "NO. OF DC'S" += 1;
                TOTAL_DC_CHARGES += "DC Header".Charges;
                IF "DC Header".Charges = 0 THEN
                    "CHARGE_LESS_DC'S" += 1;

                IF "DC Header"."Mode Of Transport" = 'Courier' THEN BEGIN
                    MODE_OF_TRANSPORT_INFO[1] += 1;
                    MODE_OF_TRANSPORT_CHARGES[1] += "DC Header".Charges;
                END ELSE
                    IF "DC Header"."Mode Of Transport" = 'Train' THEN BEGIN
                        MODE_OF_TRANSPORT_INFO[2] += 1;
                        MODE_OF_TRANSPORT_CHARGES[2] += "DC Header".Charges;
                    END ELSE
                        IF "DC Header"."Mode Of Transport" = 'Bus' THEN BEGIN
                            MODE_OF_TRANSPORT_INFO[3] += 1;
                            MODE_OF_TRANSPORT_CHARGES[3] += "DC Header".Charges;
                        END ELSE
                            IF "DC Header"."Mode Of Transport" = 'By Hand' THEN BEGIN
                                MODE_OF_TRANSPORT_INFO[4] += 1;
                                MODE_OF_TRANSPORT_CHARGES[4] += "DC Header".Charges;

                            END ELSE
                                IF "DC Header"."Mode Of Transport" = 'VRL' THEN BEGIN
                                    MODE_OF_TRANSPORT_INFO[5] += 1;
                                    MODE_OF_TRANSPORT_CHARGES[5] += "DC Header".Charges;
                                END;
                ZONE_NAME := '';
                DIVISION.RESET;
                DIVISION.SETRANGE(DIVISION.Code, "DC Header"."Location Code");
                IF DIVISION.FINDFIRST THEN BEGIN
                    IF ZONE.GET(DIVISION.Description) THEN
                        ZONE_NAME := ZONE.Description;
                END;

                IF excel THEN BEGIN
                    Row += 1;
                    Entercell(Row, 1, FORMAT("No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 2, FORMAT("Created Date"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 3, FORMAT("Location Name"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 4, FORMAT(ZONE_NAME), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 5, FORMAT("Mode Of Transport"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 6, FORMAT("L.R Number"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 7, FORMAT("Reciver Name"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 8, FORMAT(Charges), FALSE, TempExcelbuffer."Cell Type"::Text);
                END;
            end;

            trigger OnPostDataItem()
            begin

                IF excel THEN BEGIN
                    Row += 1;
                    Entercell(Row, 8, FORMAT(TOTAL_DC_CHARGES), TRUE, TempExcelbuffer."Cell Type"::Text);
                    Row += 2;
                    EnterHeadings(Row, 1, 'BY COURIER', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 1, 1, 'BY TRAIN', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 2, 1, 'BY BUS', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 3, 1, 'BY HAND', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 4, 1, 'TO VRL', TRUE, TempExcelbuffer."Cell Type"::Text);
                    FOR i := 1 TO 5 DO BEGIN
                        Entercell(Row + i - 1, 2, FORMAT(MODE_OF_TRANSPORT_INFO[i]), FALSE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row + i - 1, 3, FORMAT(MODE_OF_TRANSPORT_CHARGES[i]), FALSE, TempExcelbuffer."Cell Type"::Text);
                    END;
                    Entercell(Row + 5, 3, FORMAT(TOTAL_DC_CHARGES), TRUE, TempExcelbuffer."Cell Type"::Text);
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);


                IF excel THEN BEGIN
                    Row += 1;
                    EnterHeadings(Row, 1, 'DC No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'CREATED ON', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'LOCATION', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'ZONE', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'MODE OF TRANSPORT', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'L.R NUMBER', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'SEND TO', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'CHARGES', TRUE, TempExcelbuffer."Cell Type"::Text);
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
                group(Control1102152001)
                {
                    ShowCaption = false;
                    field(Excel; excel)
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

    trigger OnInitReport()
    begin
        excel := TRUE;
    end;

    trigger OnPostReport()
    begin
        /*IF excel THEN
        BEGIN
          TempExcelbuffer.CreateBook('');//B2B
          //TempExcelbuffer.CreateSheet('DC Charges','',COMPANYNAME,'');//B2B
          TempExcelbuffer.GiveUserControl;
        END;  */

        IF excel THEN BEGIN
            TempExcelbuffer.CreateBookAndOpenExcel('', 'DC CHARGES', 'DC CHARGES', COMPANYNAME, USERID); //EFFUPG
            TempExcelbuffer.SaveBom('DC CHARGES');
        END;

    end;

    trigger OnPreReport()
    begin
        IF excel THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;
    end;

    var
        "NO. OF DC'S": Integer;
        "CHARGE_LESS_DC'S": Integer;
        MODE_OF_TRANSPORT_INFO: array[5] of Integer;
        TOTAL_DC_CHARGES: Decimal;
        MODE_OF_TRANSPORT_CHARGES: array[5] of Decimal;
        DIVISION: Record "Employee Statistics Group";
        ZONE_NAME: Text[30];
        ZONE: Record "Cause of Inactivity";
        Row: Integer;
        TempExcelbuffer: Record "Excel Buffer" temporary;
        excel: Boolean;
        i: Integer;
        DC_CHARGES_CaptionLbl: Label 'DC CHARGES ';
        Reporting_Date_Time__CaptionLbl: Label 'Reporting Date Time :';
        DC_NO_CaptionLbl: Label 'DC NO.';
        CREATED_ONCaptionLbl: Label 'CREATED ON';
        LOCATIONCaptionLbl: Label 'LOCATION';
        Send_ToCaptionLbl: Label 'Send To';
        ZONE_CaptionLbl: Label 'ZONE ';
        NOTE__CaptionLbl: Label 'NOTE :';
        There_is_no_Charges_Information_for_CaptionLbl: Label 'There is no Charges Information for ';
        No__of__DC_S_Out_of_CaptionLbl: Label 'No. of  DC''S Out of ';
        DC_S_CaptionLbl: Label ' DC''S ';
        BY_COURIER__CaptionLbl: Label 'BY COURIER :';
        BY_TRAIN_______CaptionLbl: Label 'BY TRAIN      :';
        BY_BUS___________CaptionLbl: Label 'BY BUS          :';
        BY_HAND________CaptionLbl: Label 'BY HAND       :';
        BY_VRL__________CaptionLbl: Label 'BY VRL         :';
        REPORT__GENERATED_FROM_ERP_____CaptionLbl: Label '                              *** REPORT  GENERATED FROM ERP  ***';
        There_is_no_Charges_for_the_DC_S_which_are_Sent__By_Hand___CaptionLbl: Label '( There is no Charges for the DC''S which are Sent "By Hand" )';
        CompanyInfo: Record "Company Information";


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;
        TempExcelbuffer."Cell Type" := CellType; //Rev01

        TempExcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;
        TempExcelbuffer."Cell Type" := CellType; //Rev01

        TempExcelbuffer.Formula := '';
        TempExcelbuffer.INSERT;
    end;
}

