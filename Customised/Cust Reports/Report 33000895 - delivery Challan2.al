report 33000895 "delivery Challan2"
{
    // version Rev01,Eff02

    DefaultLayout = RDLC;
    RDLCLayout = './delivery Challan2.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("DC Header"; "DC Header")
        {
            column(companyinfo_Name; companyinfo.Name)
            {
            }
            column(companyinfo_Address; companyinfo.Address)
            {
            }
            column(companyinfo__Address_2_; companyinfo."Address 2")
            {
            }
            column(CompPic; companyinfo.Picture)
            {
            }
            column(Returnable_Text; Returnable_Text)
            {
            }
            column(FORMAT__From_Date__0___Day_2___Month_Text_3___Year_2___; FORMAT("From Date", 0, '<Day,2>-<Month Text,3>-<Year,2>'))
            {
            }
            column(DC_Header___Sell_to_Customer_Name__________DC_Header___Location_Name_; "DC Header"."Sell-to Customer Name" + ' ,  ' + "DC Header"."Location Name")
            {
            }
            column(DC_Header__No__; "No.")
            {
            }
            column(DC_Header_SessionCode; SessionCode)
            {
            }
            column(companyinfo_Name_Control1102152006; companyinfo.Name)
            {
            }
            column(companyinfo_Address_Control1102152007; companyinfo.Address)
            {
            }
            column(companyinfo__Address_2__Control1102152008; companyinfo."Address 2")
            {
            }
            column(DC_Header___Sell_to_Customer_Name__________DC_Header___Location_Name__Control1102152015; "DC Header"."Sell-to Customer Name" + ' ,  ' + "DC Header"."Location Name")
            {
            }
            column(DC_Header_Returnable; Returnable)
            {
            }
            column(DC_Header_SessionCode_Control1102152019; SessionCode)
            {
            }
            column(FORMAT__From_Date__0___Day_2___Month_Text_3___Year_2____Control1102152023; FORMAT("From Date", 0, '<Day,2>-<Month Text,3>-<Year,2>'))
            {
            }
            column(DC_Header__No___Control1102152024; "No.")
            {
            }
            column(DC_Header__Reciver_Name_; "Reciver Name")
            {
            }
            column(DC_Header__Receptionist_Name_; "Receptionist Name")
            {
            }
            column(DC_Header__StoreIncharge_Name_; "StoreIncharge Name")
            {
            }
            column(DC_Header__Reciver_Name__Control1102154084; "Reciver Name")
            {
            }
            column(DC_Header__Receptionist_Name__Control1102154086; "Receptionist Name")
            {
            }
            column(Auth_Name; Auth_Name)
            {
            }
            column(DC_Header__StoreIncharge_Name__Control1102152002; "StoreIncharge Name")
            {
            }
            column(DELIVERY_CHALLANCaption; DELIVERY_CHALLANCaptionLbl)
            {
            }
            column(SYSTEMS_PVT__LTD_Caption; SYSTEMS_PVT__LTD_CaptionLbl)
            {
            }
            column(Ph____91_866__249_3375___FAX____91_866_247_4097Caption; Ph____91_866__249_3375___FAX____91_866_247_4097CaptionLbl)
            {
            }
            column(e_mail__info_efftronics_netCaption; e_mail__info_efftronics_netCaptionLbl)
            {
            }
            column(Website__efftronics_comCaption; Website__efftronics_comCaptionLbl)
            {
            }
            column(Returnable__Caption; Returnable__CaptionLbl)
            {
            }
            column(Challan_No_Caption; Challan_No_CaptionLbl)
            {
            }
            column(Section_Code__Caption; Section_Code__CaptionLbl)
            {
            }
            column(M_s_Caption; M_s_CaptionLbl)
            {
            }
            column(Please_receive_the_following_goods_in_good_order_and_condition_Caption; Please_receive_the_following_goods_in_good_order_and_condition_CaptionLbl)
            {
            }
            column(Date__Caption; Date__CaptionLbl)
            {
            }
            column(SYSTEMS_PVT__LTD_Caption_Control1102152003; SYSTEMS_PVT__LTD_Caption_Control1102152003Lbl)
            {
            }
            column(DELIVERY_CHALLANCaption_Control1102152005; DELIVERY_CHALLANCaption_Control1102152005Lbl)
            {
            }
            column(Ph____91_866__249_3375___FAX____91_866_247_4097Caption_Control1102152009; Ph____91_866__249_3375___FAX____91_866_247_4097Caption_Control1102152009Lbl)
            {
            }
            column(e_mail__info_efftronics_netCaption_Control1102152010; e_mail__info_efftronics_netCaption_Control1102152010Lbl)
            {
            }
            column(Website__efftronics_comCaption_Control1102152011; Website__efftronics_comCaption_Control1102152011Lbl)
            {
            }
            column(Returnable__Caption_Control1102152012; Returnable__Caption_Control1102152012Lbl)
            {
            }
            column(Section_Code__Caption_Control1102152013; Section_Code__Caption_Control1102152013Lbl)
            {
            }
            column(M_s_Caption_Control1102152014; M_s_Caption_Control1102152014Lbl)
            {
            }
            column(Please_receive_the_following_goods_in_good_order_and_condition_Caption_Control1102152020; Please_receive_the_following_goods_in_good_order_and_condition_Caption_Control1102152020Lbl)
            {
            }
            column(Challan_No_Caption_Control1102152021; Challan_No_Caption_Control1102152021Lbl)
            {
            }
            column(Date__Caption_Control1102152022; Date__Caption_Control1102152022Lbl)
            {
            }
            column(PURPOSECaption; PURPOSECaptionLbl)
            {
            }
            column(SERIAL_LOT_NoCaption; SERIAL_LOT_NoCaptionLbl)
            {
            }
            column(UNIT_RATE_Rs_Caption; UNIT_RATE_Rs_CaptionLbl)
            {
            }
            column(QTY_Caption; QTY_CaptionLbl)
            {
            }
            column(PARTICULARSCaption; PARTICULARSCaptionLbl)
            {
            }
            column(ITEM_NOCaption; ITEM_NOCaptionLbl)
            {
            }
            column(TIN_No__28350166764Caption; TIN_No__28350166764CaptionLbl)
            {
            }
            column(TinNo; TNo)
            {
            }
            column(CSTNo; CSTNo)
            {
            }
            column(GSTNo; GSTNo)
            {
            }
            column(CST_No__VJ2_07_1_1976_02_05_1988Caption; CST_No__VJ2_07_1_1976_02_05_1988CaptionLbl)
            {
            }
            column(Signature_of_ReceiverCaption; Signature_of_ReceiverCaptionLbl)
            {
            }
            column(with_Rubber_stamp_Caption; with_Rubber_stamp_CaptionLbl)
            {
            }
            column(N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_Caption; N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_CaptionLbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(Receptionist_Caption; Receptionist_CaptionLbl)
            {
            }
            column(SignatureCaption_Control1102152032; SignatureCaption_Control1102152032Lbl)
            {
            }
            column(Authorized_By_Caption; Authorized_By_CaptionLbl)
            {
            }
            column(SignatureCaption_Control1102152035; SignatureCaption_Control1102152035Lbl)
            {
            }
            column(Stores_Incharge_Caption; Stores_Incharge_CaptionLbl)
            {
            }
            column(SignatureCaption_Control1102154023; SignatureCaption_Control1102154023Lbl)
            {
            }
            column(Stores_Incharge_Caption_Control1102154024; Stores_Incharge_Caption_Control1102154024Lbl)
            {
            }
            column(SignatureCaption_Control1102154021; SignatureCaption_Control1102154021Lbl)
            {
            }
            column(Authorized_By_Caption_Control1102154022; Authorized_By_Caption_Control1102154022Lbl)
            {
            }
            column(SignatureCaption_Control1102154019; SignatureCaption_Control1102154019Lbl)
            {
            }
            column(Receptionist_Caption_Control1102154020; Receptionist_Caption_Control1102154020Lbl)
            {
            }
            column(Signature_of_ReceiverCaption_Control1102154017; Signature_of_ReceiverCaption_Control1102154017Lbl)
            {
            }
            column(with_Rubber_stamp_Caption_Control1102154018; with_Rubber_stamp_Caption_Control1102154018Lbl)
            {
            }
            column(N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_Caption_Control1102154085; N_B_Control1102154085Lbl)
            {
            }
            dataitem("DC Line"; "DC Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DC_Line__DC_Line___No__; "DC Line"."No.")
                {
                }
                column(DC_Line__DC_Line__Description; "DC Line".Description)
                {
                }
                column(DC_Line__DC_Line__Quantity; "DC Line".Quantity)
                {
                }
                column(DC_Line__DC_Line___Unit_Cost_; "DC Line"."Unit Cost")
                {
                }
                column(Sno; Sno)
                {
                }
                column(Purpose; Purpose)
                {
                }
                column(d1_1__1_; d1[1] [1])
                {
                }
                column(d1_1__2_; d1[1] [2])
                {
                }
                column(d1_1__3_; d1[1] [3])
                {
                }
                column(d1_1__5_; d1[1] [5])
                {
                }
                column(d1_2__1_; d1[2] [1])
                {
                }
                column(d1_3__1_; d1[3] [1])
                {
                }
                column(d1_4__1_; d1[4] [1])
                {
                }
                column(d1_5__1_; d1[5] [1])
                {
                }
                column(d1_6__1_; d1[6] [1])
                {
                }
                column(d1_7__1_; d1[7] [1])
                {
                }
                column(d1_8__1_; d1[8] [1])
                {
                }
                column(d1_2__2_; d1[2] [2])
                {
                }
                column(d1_3__2_; d1[3] [2])
                {
                }
                column(d1_4__2_; d1[4] [2])
                {
                }
                column(d1_5__2_; d1[5] [2])
                {
                }
                column(d1_6__2_; d1[6] [2])
                {
                }
                column(d1_7__2_; d1[7] [2])
                {
                }
                column(d1_8__2_; d1[8] [2])
                {
                }
                column(d1_2__3_; d1[2] [3])
                {
                }
                column(d1_3__3_; d1[3] [3])
                {
                }
                column(d1_4__3_; d1[4] [3])
                {
                }
                column(d1_5__3_; d1[5] [3])
                {
                }
                column(d1_6__3_; d1[6] [3])
                {
                }
                column(d1_7__3_; d1[7] [3])
                {
                }
                column(d1_8__3_; d1[8] [3])
                {
                }
                column(d1_8__4_; d1[8] [4])
                {
                }
                column(d1_7__4_; d1[7] [4])
                {
                }
                column(d1_6__4_; d1[6] [4])
                {
                }
                column(d1_5__4_; d1[5] [4])
                {
                }
                column(d1_4__4_; d1[4] [4])
                {
                }
                column(d1_3__4_; d1[3] [4])
                {
                }
                column(d1_2__4_; d1[2] [4])
                {
                }
                column(d1_1__4_; d1[1] [4])
                {
                }
                column(d1_1__6_; d1[1] [6])
                {
                }
                column(d1_2__6_; d1[2] [6])
                {
                }
                column(d1_3__6_; d1[3] [6])
                {
                }
                column(d1_4__6_; d1[4] [6])
                {
                }
                column(d1_5__6_; d1[5] [6])
                {
                }
                column(d1_6__6_; d1[6] [6])
                {
                }
                column(d1_7__6_; d1[7] [6])
                {
                }
                column(d1_8__6_; d1[8] [6])
                {
                }
                column(Auth_Name_Control1102152122; Auth_Name)
                {
                }
                column(ITEM_NOCaption_Control1102154027; ITEM_NOCaption_Control1102154027Lbl)
                {
                }
                column(PARTICULARSCaption_Control1102154028; PARTICULARSCaption_Control1102154028Lbl)
                {
                }
                column(QTY_Caption_Control1102154029; QTY_Caption_Control1102154029Lbl)
                {
                }
                column(UNIT_RATE_Rs_Caption_Control1102154030; UNIT_RATE_Rs_Caption_Control1102154030Lbl)
                {
                }
                column(PURPOSECaption_Control1102154031; PURPOSECaption_Control1102154031Lbl)
                {
                }
                column(SERIAL_LOT_NoCaption_Control1102154105; SERIAL_LOT_NoCaption_Control1102154105Lbl)
                {
                }
                column(TIN_No__28350166764Caption_Control1102154015; TIN_No__28350166764Caption_Control1102154015Lbl)
                {
                }
                column(CST_No__VJ2_07_1_1976_02_05_1988Caption_Control1102154016; CST_No__VJ2_07_1_1976_02_05_1988Caption_Control1102154016Lbl)
                {
                }
                column(Signature_of_ReceiverCaption_Control1102152113; Signature_of_ReceiverCaption_Control1102152113Lbl)
                {
                }
                column(with_Rubber_stamp_Caption_Control1102152114; with_Rubber_stamp_Caption_Control1102152114Lbl)
                {
                }
                column(N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_Caption_Control1102152116; N_B___Any_complaint_)
                {
                }
                column(SignatureCaption_Control1102152117; SignatureCaption_Control1102152117Lbl)
                {
                }
                column(Receptionist_Caption_Control1102152118; Receptionist_Caption_Control1102152118Lbl)
                {
                }
                column(SignatureCaption_Control1102152120; SignatureCaption_Control1102152120Lbl)
                {
                }
                column(Authorized_By_Caption_Control1102152121; Authorized_By_Caption_Control1102152121Lbl)
                {
                }
                column(SignatureCaption_Control1102152123; SignatureCaption_Control1102152123Lbl)
                {
                }
                column(Stores_Incharge_Caption_Control1102152124; Stores_Incharge_Caption_Control1102152124Lbl)
                {
                }
                column(DC_Line_Document_No_; "Document No.")
                {
                }
                column(DC_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //Rev01 Code copied from //DC Line, Body (2) - OnPreSection()

                    /*
                    d1[i][1]:=FORMAT("DC Line"."No.");
                    d1[i][2]:=FORMAT("DC Line".Description);
                    d1[i][3]:=FORMAT("DC Line".Quantity);
                    d1[i][4]:=FORMAT("DC Line"."Unit Cost");
                    d1[i][5]:=FORMAT("DC Line".Remarks);
                    IF "DC Line"."Request no"<>'' THEN
                    BEGIN*/
                    Sno := '';
                    MITH.RESET;
                    MITH.SETFILTER(MITH."Order No.", "DC Line"."Document No.");
                    MITH.SETFILTER(MITH."Item No.", "DC Line"."No.");
                    IF MITH.FINDFIRST THEN
                        REPEAT
                            IF MITH."Serial No." <> '' THEN
                                Sno += FORMAT(MITH."Serial No.") + ','
                            ELSE
                                Sno += FORMAT(MITH."Lot No.") + ',';
                        UNTIL MITH.NEXT = 0;
                    IF Sno = '' THEN
                        Sno := "DC Line"."Serial Or Lot No";
                    // END;
                    IF i = 1 THEN
                        Purpose := "DC Header".Remarks
                    ELSE
                        Purpose := '';
                    "Total Cost" += "DC Line"."Unit Cost" * "DC Line".Quantity;
                    i := i + 1;

                    //Rev01 Code Copied From //DC Line, Body (2) - OnPreSection()

                end;

                trigger OnPostDataItem();
                begin
                    //Rev01 Code Copied From //DC Line, Footer (3) - OnPreSection()
                    d1[1] [5] := FORMAT("DC Header".Remarks);
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    //Rev01 Code Copied From //DC Line, Footer (3) - OnPreSection()
                end;

                trigger OnPreDataItem();
                begin
                    i := 1;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF "DC Header".NonReturnable = TRUE THEN
                    Returnable_Text := 'NO'
                ELSE
                    Returnable_Text := 'YES';

                /*//For the Effective date TIN No in Prints   changed by MNRaju on 4-Jun-2014
                tin.RESET;
                tin.SETCURRENTKEY(tin.Code,tin.Description,tin."Effective Date");
                tin.SETFILTER(tin."Effective Date",'<=%1',"DC Header"."Created Date");
                IF tin.FINDLAST THEN
                BEGIN
                  TNo:=tin.Code;
                END;
                //end For the Effective date TIN No in Prints   changed by MNRaju on 4-Jun-2014
                */


                //MNRAJU FOR TIN NO. CHANGING
                /*tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', "DC Header"."Created Date");
                tin.SETFILTER(tin.Group, 'TIN');
                IF tin.FINDLAST THEN BEGIN
                    TNo := tin.Code;
                END;

                tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', "DC Header"."Created Date");
                tin.SETFILTER(tin.Group, 'CST');
                IF tin.FINDLAST THEN BEGIN
                    CSTNo := tin.Code;
                END;*///B2BUpg
                //MNRAJU FOR TIN NO. CHANGING
                gst.RESET;
                gst.SETFILTER("State Code", 'ANP');
                IF gst.FINDFIRST THEN BEGIN
                    GSTNo := gst.Code;
                END;

            end;

            trigger OnPreDataItem();
            begin
                //Rev01 Code Copied From //DC Header, Header (1) - OnPreSection()
                companyinfo.GET;
                companyinfo.CALCFIELDS(companyinfo.Picture);
                //Rev01 Code Copied From //DC Header, Header (1) - OnPreSection()

                //Rev01 Code Copied From //DC Header, Header (2) - OnPreSection()
                IF "DC Header".NonReturnable = TRUE THEN
                    Returnable_Text := 'NO'
                ELSE
                    Returnable_Text := 'YES';
                //Rev01 Code Copied From //DC Header, Header (2) - OnPreSection()
            end;
        }
        dataitem("Integer"; "Integer")
        {
            column(DC_Header___Reciver_Name_; "DC Header"."Reciver Name")
            {
            }
            column(DC_Header___Receptionist_Name_; "DC Header"."Receptionist Name")
            {
            }
            column(Auth_Name_Control1102152108; Auth_Name)
            {
            }
            column(DC_Header___StoreIncharge_Name_; "DC Header"."StoreIncharge Name")
            {
            }
            column(TIN_No__28350166764Caption_Control1102152082; TIN_No__28350166764Caption_Control1102152082Lbl)
            {
            }
            column(CST_No__VJ2_07_1_1976_02_05_1988Caption_Control1102152097; CST_No__VJ2_07_1_1976_02_05_1988Caption_Control1102152097Lbl)
            {
            }
            column(Signature_of_ReceiverCaption_Control1102152100; Signature_of_ReceiverCaption_Control1102152100Lbl)
            {
            }
            column(with_Rubber_stamp_Caption_Control1102152101; with_Rubber_stamp_Caption_Control1102152101Lbl)
            {
            }
            column(N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_Caption_Control1102152102; N_B_Control1102154085Lbl)
            {
            }
            column(SignatureCaption_Control1102152103; SignatureCaption_Control1102152103Lbl)
            {
            }
            column(Receptionist_Caption_Control1102152104; Receptionist_Caption_Control1102152104Lbl)
            {
            }
            column(SignatureCaption_Control1102152106; SignatureCaption_Control1102152106Lbl)
            {
            }
            column(Authorized_By_Caption_Control1102152107; Authorized_By_Caption_Control1102152107Lbl)
            {
            }
            column(SignatureCaption_Control1102152109; SignatureCaption_Control1102152109Lbl)
            {
            }
            column(Stores_Incharge_Caption_Control1102152110; Stores_Incharge_Caption_Control1102152110Lbl)
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnAfterGetRecord();
            begin
                /*IF j=0 THEN
                  CurrReport.QUIT;
                j:=j-1;
                 */

            end;

            trigger OnPreDataItem();
            begin
                j := (CurrReport.PAGENO) * 12 - i + 1;
                Integer.SETFILTER(Integer.Number, '>%1&<%2', 0, j + 1)
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
                    field(sr; sr)
                    {
                        Caption = 'Signature of Receiver';
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

    trigger OnInitReport();
    begin
        /*
        IF "DC Header".NonReturnable = TRUE THEN
          Returnable_Text:='NO'
        ELSE
          Returnable_Text:='YES';
        */

    end;

    var
        d1: array[10, 10] of Text[250];
        i: Integer;
        companyinfo: Record "Company Information";
        sr: Text[30];
        "Total Cost": Decimal;
        MITH: Record "Mat.Issue Track. Specification";
        Auth_Name: Text[50];
        MIH: Record "Material Issues Header";
        User: Record User;
        EMP: Record Employee;
        EMP1: Record Employee;
        EMP2: Record Employee;
        EMP3: Record Employee;
        Sno: Text[1000];
        j: Integer;
        Purpose: Text[120];
        Returnable_Text: Text[30];
        DELIVERY_CHALLANCaptionLbl: Label 'DELIVERY CHALLAN';
        SYSTEMS_PVT__LTD_CaptionLbl: Label 'SYSTEMS PVT. LTD.';
        Ph____91_866__249_3375___FAX____91_866_247_4097CaptionLbl: Label 'Ph:  +91(866) 249-3375,  FAX:  +91(866)247-4097';
        e_mail__info_efftronics_netCaptionLbl: Label 'e-mail: info@efftronics.com';
        Website__efftronics_comCaptionLbl: Label 'Website: efftronics.com';
        Returnable__CaptionLbl: Label 'Returnable :';
        Challan_No_CaptionLbl: Label 'Challan No.';
        Section_Code__CaptionLbl: Label 'Section Code :';
        M_s_CaptionLbl: Label 'M/s.';
        Please_receive_the_following_goods_in_good_order_and_condition_CaptionLbl: Label 'Please receive the following goods in good order and condition.';
        Date__CaptionLbl: Label 'Date :';
        SYSTEMS_PVT__LTD_Caption_Control1102152003Lbl: Label 'SYSTEMS PVT. LTD.';
        DELIVERY_CHALLANCaption_Control1102152005Lbl: Label 'DELIVERY CHALLAN';
        Ph____91_866__249_3375___FAX____91_866_247_4097Caption_Control1102152009Lbl: Label 'Ph:  +91(866) 249-3375,  FAX:  +91(866)247-4097';
        e_mail__info_efftronics_netCaption_Control1102152010Lbl: Label 'e-mail: info@efftronics.com';
        Website__efftronics_comCaption_Control1102152011Lbl: Label 'Website: efftronics.com';
        Returnable__Caption_Control1102152012Lbl: Label 'Returnable :';
        Section_Code__Caption_Control1102152013Lbl: Label 'Section Code :';
        M_s_Caption_Control1102152014Lbl: Label 'M/s.';
        Please_receive_the_following_goods_in_good_order_and_condition_Caption_Control1102152020Lbl: Label 'Please receive the following goods in good order and condition.';
        Challan_No_Caption_Control1102152021Lbl: Label 'Challan No.';
        Date__Caption_Control1102152022Lbl: Label 'Date :';
        PURPOSECaptionLbl: Label 'PURPOSE';
        SERIAL_LOT_NoCaptionLbl: Label 'SERIAL/LOT No';
        UNIT_RATE_Rs_CaptionLbl: Label 'UNIT RATE(Rs)';
        QTY_CaptionLbl: Label 'QTY.';
        PARTICULARSCaptionLbl: Label 'PARTICULARS';
        ITEM_NOCaptionLbl: Label 'ITEM.NO';
        TIN_No__28350166764CaptionLbl: Label 'TIN No. 28350166764';
        CST_No__VJ2_07_1_1976_02_05_1988CaptionLbl: Label 'CST.No. VJ2-07-1-1976/02-05/1988';
        Signature_of_ReceiverCaptionLbl: Label 'Signature of Receiver';
        with_Rubber_stamp_CaptionLbl: Label '(with Rubber stamp)';
        N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_CaptionLbl: Label 'N.B : Any complaint regarding goods you received must be made within 24 hours  after delivery.';
        SignatureCaptionLbl: Label 'Signature';
        Receptionist_CaptionLbl: Label '(Receptionist)';
        SignatureCaption_Control1102152032Lbl: Label 'Signature';
        Authorized_By_CaptionLbl: Label '(Authorized By)';
        SignatureCaption_Control1102152035Lbl: Label 'Signature';
        Stores_Incharge_CaptionLbl: Label '(Stores Incharge)';
        SignatureCaption_Control1102154023Lbl: Label 'Signature';
        Stores_Incharge_Caption_Control1102154024Lbl: Label '(Stores Incharge)';
        SignatureCaption_Control1102154021Lbl: Label 'Signature';
        Authorized_By_Caption_Control1102154022Lbl: Label '(Authorized By)';
        SignatureCaption_Control1102154019Lbl: Label 'Signature';
        Receptionist_Caption_Control1102154020Lbl: Label '(Receptionist)';
        Signature_of_ReceiverCaption_Control1102154017Lbl: Label 'Signature of Receiver';
        with_Rubber_stamp_Caption_Control1102154018Lbl: Label '(with Rubber stamp)';
        N_B_Control1102154085Lbl: Label 'N.B : Any complaint regarding goods you received must be made within 24 hours  after delivery.';
        ITEM_NOCaption_Control1102154027Lbl: Label 'ITEM.NO';
        PARTICULARSCaption_Control1102154028Lbl: Label 'PARTICULARS';
        QTY_Caption_Control1102154029Lbl: Label 'QTY.';
        UNIT_RATE_Rs_Caption_Control1102154030Lbl: Label 'UNIT RATE(Rs)';
        PURPOSECaption_Control1102154031Lbl: Label 'PURPOSE';
        SERIAL_LOT_NoCaption_Control1102154105Lbl: Label 'SERIAL/LOT No';
        TIN_No__28350166764Caption_Control1102154015Lbl: Label 'TIN No. 28350166764';
        CST_No__VJ2_07_1_1976_02_05_1988Caption_Control1102154016Lbl: Label 'CST.No. VJ2-07-1-1976/02-05/1988';
        Signature_of_ReceiverCaption_Control1102152113Lbl: Label 'Signature of Receiver';
        with_Rubber_stamp_Caption_Control1102152114Lbl: Label '(with Rubber stamp)';
        N_B___Any_complaint_: Label 'N.B : Any complaint regarding goods you received must be made within 24 hours  after delivery.';
        SignatureCaption_Control1102152117Lbl: Label 'Signature';
        Receptionist_Caption_Control1102152118Lbl: Label '(Receptionist)';
        SignatureCaption_Control1102152120Lbl: Label 'Signature';
        Authorized_By_Caption_Control1102152121Lbl: Label '(Authorized By)';
        SignatureCaption_Control1102152123Lbl: Label 'Signature';
        Stores_Incharge_Caption_Control1102152124Lbl: Label '(Stores Incharge)';
        TIN_No__28350166764Caption_Control1102152082Lbl: Label 'TIN No. 28350166764';
        CST_No__VJ2_07_1_1976_02_05_1988Caption_Control1102152097Lbl: Label 'CST.No. VJ2-07-1-1976/02-05/1988';
        Signature_of_ReceiverCaption_Control1102152100Lbl: Label 'Signature of Receiver';
        with_Rubber_stamp_Caption_Control1102152101Lbl: Label '(with Rubber stamp)';
        // N_B___Any_complaint_regarding_goods_you_received_must_be_made_within_24_hours__after_delivery_Caption_Control1102152102Lbl: Label 'N.B : Any complaint regarding goods you received must be made within 24 hours  after delivery.';
        SignatureCaption_Control1102152103Lbl: Label 'Signature';
        Receptionist_Caption_Control1102152104Lbl: Label '(Receptionist)';
        SignatureCaption_Control1102152106Lbl: Label 'Signature';
        Authorized_By_Caption_Control1102152107Lbl: Label '(Authorized By)';
        SignatureCaption_Control1102152109Lbl: Label 'Signature';
        Stores_Incharge_Caption_Control1102152110Lbl: Label '(Stores Incharge)';
        //tin: Record "T.I.N. Nos.";//B2Bupg
        TNo: Text[15];
        CSTNo: Text;
        gst: Record "GST Registration Nos.";
        GSTNo: Text[15];
}

