report 50107 "Dispatch Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DispatchNote.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Sales_Header__Sales_Header___No__; "Sales Header"."No.")
            {
            }
            column(Sales_Header__Sales_Header___Sell_to_Customer_Name_; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(Sales_Header__Sales_Header___Customer_OrderNo__; "Sales Header"."Customer OrderNo.")
            {
            }
            column(Sales_Header__Sales_Header___Ship_to_Name_; "Sales Header"."Ship-to Name")
            {
            }
            column(pronos; pronos)
            {
            }
            column(Sales_Header__Sales_Header___Transport_Method_; "Sales Header"."Transport Method")
            {
            }
            column(FORMAT__Sales_Header___Posting_Date__0_4_; FORMAT("Sales Header"."Posting Date", 0, 4))
            {
            }
            column(ORDER_NOCaption; ORDER_NOCaptionLbl)
            {
            }
            column(CUSTOMER_NAMECaption; CUSTOMER_NAMECaptionLbl)
            {
            }
            column(PURCHASE_ORDER_NOCaption; PURCHASE_ORDER_NOCaptionLbl)
            {
            }
            column(CONSIGNEE_ADDRESSCaption; CONSIGNEE_ADDRESSCaptionLbl)
            {
            }
            column(EFFTRONICSCaption; EFFTRONICSCaptionLbl)
            {
            }
            column(Dispatch_MaterialCaption; Dispatch_MaterialCaptionLbl)
            {
            }
            column(QMS__Std__Ref___7_5Caption; QMS__Std__Ref___7_5CaptionLbl)
            {
            }
            column(EFF_MPR_R_001Caption; EFF_MPR_R_001CaptionLbl)
            {
            }
            column(REVISION_1Caption; REVISION_1CaptionLbl)
            {
            }
            column(PROJECT_CODECaption; PROJECT_CODECaptionLbl)
            {
            }
            column(TRANSPORT_DETAILSCaption; TRANSPORT_DETAILSCaptionLbl)
            {
            }
            column(DISPATCH_DATECaption; DISPATCH_DATECaptionLbl)
            {
            }
            column(SH_NOCaption; SH_NOCaptionLbl)
            {
            }
            column(TENDER_SCHEDULECaption; TENDER_SCHEDULECaptionLbl)
            {
            }
            column(QTYCaption; QTYCaptionLbl)
            {
            }
            column(DISPATCH_DETAILSCaption; DISPATCH_DETAILSCaptionLbl)
            {
            }
            column(SL_NOsCaption; SL_NOsCaptionLbl)
            {
            }
            column(QTYCaption_Control1102154176; QTYCaption_Control1102154176Lbl)
            {
            }
            column(PACKET_NO_Caption; PACKET_NO_CaptionLbl)
            {
            }
            column(INVOICE_NO_Caption; INVOICE_NO_CaptionLbl)
            {
            }
            column(EFFTRONICSCaption_Control1102154156; EFFTRONICSCaption_Control1102154156Lbl)
            {
            }
            column(Dispatch_MaterialCaption_Control1102154157; Dispatch_MaterialCaption_Control1102154157Lbl)
            {
            }
            column(QMS__Std__Ref___7_5Caption_Control1102154158; QMS__Std__Ref___7_5Caption_Control1102154158Lbl)
            {
            }
            column(EFF_MPR_R_001Caption_Control1102154159; EFF_MPR_R_001Caption_Control1102154159Lbl)
            {
            }
            column(REVISION_1Caption_Control1102154160; REVISION_1Caption_Control1102154160Lbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.") ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    /*WHILE(i<>30) DO
                    BEGIN
                    descon[i]:='';
                    qty[i]:=0;
                    ser[i]:='';
                    i:=i+1;
                    END; */
                    i := 1;
                    SC.SETRANGE(SC."Document No.", "Sales Header"."No.");
                    SC.SETRANGE(SC."Document Line No.", "Sales Line"."Line No.");
                    IF SC.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            /*IF SC.Type=SC.Type::Item THEN
                            descon[i]:=SC.Description;
                            qty[i]:=SC.Quantity;
                            ser[i]:=FORMAT(SC."Serial No.");
                            */
                            IF "Sales Line"."No." = SC."No." THEN BEGIN
                                qty1 := FORMAT("Sales Line".Quantity);
                                des := SC."Sales Description";
                            END;
                            i := i + 1;
                        END;
                        UNTIL SC.NEXT = 0;
                    END;

                end;
            }
            dataitem(Schedule2; Schedule2)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.") ORDER(Ascending);
                column(Schedule2__Sales_Description_; "Sales Description")
                {
                }
                column(Schedule2_Description; Description)
                {
                }
                column(FORMAT_Quantity_; FORMAT(Quantity))
                {
                }
                column(serialno; serialno)
                {
                }
                column(FORMAT_Quantity__Control1102154012; FORMAT(Quantity))
                {
                }
                column(Schedule2__M_S_Item_; "M/S Item")
                {
                }
                column(Schedule2_Description_Control1102154124; Description)
                {
                }
                column(FORMAT_Quantity__Control1102154125; FORMAT(Quantity))
                {
                }
                column(Schedule2__Serial_No__; "Serial No.")
                {
                }
                column(Schedule2__Packet_No_; "Packet No")
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(FORMAT__Page_no___FORMAT_CurrReport_PAGENO___of__FORMAT_CurrReport_PAGENO__; FORMAT('Page no:' + FORMAT(CurrReport.PAGENO) + 'of' + FORMAT(CurrReport.PAGENO)))
                {
                }
                column(PREPARED_BYCaption; PREPARED_BYCaptionLbl)
                {
                }
                column(VERIFIED_BYCaption; VERIFIED_BYCaptionLbl)
                {
                }
                column(DATE__Caption; DATE__CaptionLbl)
                {
                }
                column(Incharge___MDDCaption; Incharge___MDDCaptionLbl)
                {
                }
                column(Manager__G_PadmajaCaption; Manager__G_PadmajaCaptionLbl)
                {
                }
                column(APPROVED_BYCaption; APPROVED_BYCaptionLbl)
                {
                }
                column(Sr_Manager__SALCaption; Sr_Manager__SALCaptionLbl)
                {
                }
                column(Schedule2_Document_Type; "Document Type")
                {
                }
                column(Schedule2_Document_No_; "Document No.")
                {
                }
                column(Schedule2_Document_Line_No_; "Document Line No.")
                {
                }
                column(Schedule2_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Schedule2.Type <> Schedule2.Type::Item THEN
                        CurrReport.SKIP;
                end;
            }

            trigger OnPreDataItem()
            begin
                i := 1;
                j := 1;
                c := 0;
                Schedule2.SETRANGE("Document No.", SH."No.");
                IF SH.FIND('-') THEN
                    cusname := SH."Bill-to Name";
                //pno:=SH."Customer Order No.";//B2B
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

    trigger OnPostReport()
    begin
        descon[1] := '';
        descon[2] := '';
        descon[3] := '';
    end;

    trigger OnPreReport()
    begin
        /*IF c=0 THEN
        BEGIN
        descon[7]:='';
        descon[8]:='';
        descon[9]:='';
        descon[10]:='';
        descon[11]:='';
        descon[12]:='';
        descon[13]:='';
        descon[14]:='';
        descon[15]:='';
        descon[16]:='';
        descon[17]:='';
        descon[18]:='';
        descon[19]:='';
        descon[20]:='';
        descon[21]:='';
        descon[22]:='';
        descon[23]:='';
        descon[24]:='';
        
        END;
        IF c=1 THEN
        BEGIN
        descon[1]:='';
        descon[2]:='';
        descon[3]:='';
        descon[4]:='';
        descon[5]:='';
        descon[6]:='';
        descon[13]:='';
        descon[14]:='';
        descon[15]:='';
        descon[16]:='';
        descon[17]:='';
        descon[18]:='';
        descon[19]:='';
        descon[20]:='';
        descon[21]:='';
        descon[22]:='';
        descon[23]:='';
        descon[24]:='';
        END;
        IF c=3 THEN
        BEGIN
        descon[1]:='';
        descon[2]:='';
        descon[3]:='';
        descon[4]:='';
        descon[5]:='';
        descon[6]:='';
        descon[7]:='';
        descon[8]:='';
        descon[13]:='';
        descon[14]:='';
        descon[15]:='';
        descon[16]:='';
        descon[17]:='';
        descon[18]:='';
        descon[19]:='';
        descon[20]:='';
        END;
        IF c=4 THEN
        BEGIN
        descon[1]:='';
        descon[2]:='';
        descon[3]:='';
        descon[4]:='';
        descon[5]:='';
        descon[6]:='';
        descon[7]:='';
        descon[8]:='';
        descon[9]:='';
        descon[10]:='';
        descon[17]:='';
        descon[18]:='';
        descon[19]:='';
        descon[20]:='';
        END;
        {if c=5 then
        begin
        descon[1]:='';
        descon[2]:='';
        descon[3]:='';
        descon[4]:='';
        descon[5]:='';
        descon[6]:='';
        descon[7]:='';
        descon[8]:='';
        descon[9]:='';
        descon[10]:='';
        descon[11]:='';
        descon[12]:='';
        descon[13]:='';
        descon[14]:='';
        descon[15]:='';
        descon[20]:='';
        end;
        }
        */

    end;

    var
        SH: Record "Sales Header";
        cusname: Text[40];
        pno: Code[20];
        ordno: Code[20];
        dd: array[10] of Text[50];
        desc: array[30, 2] of Text[250];
        i: Integer;
        amt: array[10] of Decimal;
        lineno: Integer;
        j: Integer;
        saldes: array[30] of Text[250];
        descon: array[30] of Text[250];
        qty: array[30] of Decimal;
        SC: Record Schedule2;
        c: Integer;
        qty1: Text[10];
        qty2: Text[10];
        des: Text[250];
        ser: array[30] of Text[30];
        SL: Record "Sales Line";
        TS: Record "Tracking Specification";
        serialno: Text[250];
        itemcard: Record Item;
        PRO: Record "Production Order";
        pronos: Text[250];
        ORDER_NOCaptionLbl: Label 'ORDER NO';
        CUSTOMER_NAMECaptionLbl: Label 'CUSTOMER NAME';
        PURCHASE_ORDER_NOCaptionLbl: Label 'PURCHASE ORDER NO';
        CONSIGNEE_ADDRESSCaptionLbl: Label 'CONSIGNEE ADDRESS';
        EFFTRONICSCaptionLbl: Label 'EFFTRONICS';
        Dispatch_MaterialCaptionLbl: Label 'Dispatch Material';
        QMS__Std__Ref___7_5CaptionLbl: Label 'QMS. Std. Ref:  7.5';
        EFF_MPR_R_001CaptionLbl: Label 'EFF/MPR/R-001';
        REVISION_1CaptionLbl: Label 'REVISION:1';
        PROJECT_CODECaptionLbl: Label 'PROJECT CODE';
        TRANSPORT_DETAILSCaptionLbl: Label 'TRANSPORT DETAILS';
        DISPATCH_DATECaptionLbl: Label 'DISPATCH DATE';
        SH_NOCaptionLbl: Label 'SH NO';
        TENDER_SCHEDULECaptionLbl: Label 'TENDER SCHEDULE';
        QTYCaptionLbl: Label 'QTY';
        DISPATCH_DETAILSCaptionLbl: Label 'DISPATCH DETAILS';
        SL_NOsCaptionLbl: Label 'SL NOs';
        QTYCaption_Control1102154176Lbl: Label 'QTY';
        PACKET_NO_CaptionLbl: Label 'PACKET NO.';
        INVOICE_NO_CaptionLbl: Label 'INVOICE NO.';
        EFFTRONICSCaption_Control1102154156Lbl: Label 'EFFTRONICS';
        Dispatch_MaterialCaption_Control1102154157Lbl: Label 'Dispatch Material';
        QMS__Std__Ref___7_5Caption_Control1102154158Lbl: Label 'QMS. Std. Ref:  7.5';
        EFF_MPR_R_001Caption_Control1102154159Lbl: Label 'EFF/MPR/R-001';
        REVISION_1Caption_Control1102154160Lbl: Label 'REVISION:1';
        PREPARED_BYCaptionLbl: Label 'PREPARED BY';
        VERIFIED_BYCaptionLbl: Label 'VERIFIED BY';
        DATE__CaptionLbl: Label 'DATE :';
        Incharge___MDDCaptionLbl: Label 'Incharge - MDD';
        Manager__G_PadmajaCaptionLbl: Label 'Manager- G.Padmaja';
        APPROVED_BYCaptionLbl: Label 'APPROVED BY';
        Sr_Manager__SALCaptionLbl: Label 'Sr.Manager- SAL';
}

