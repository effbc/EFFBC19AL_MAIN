report 50065 "For subgroups"
{
    // {
    // UserGRec.RESET;
    // IF PAGE.RUNMODAL(9800,UserGRec) = ACTION :: LookupOK THEN
    //   "Send To" := UserGRec."User Name";
    //  }
    DefaultLayout = RDLC;
    RDLCLayout = './Forsubgroups.rdl';

    Caption = 'For subgroups';
    Permissions = TableData "Item Ledger Entry" = rm;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Location Code", "Global Dimension 2 Code", "Item No.") ORDER(Ascending) WHERE("Location Code" = CONST('SITE'), "Global Dimension 2 Code" = FILTER(<> ''), "Remaining Quantity" = FILTER(> 0), "Entry Type" = CONST(Transfer), "DC Check" = CONST(false));
            RequestFilterFields = "Posting Date", "Global Dimension 2 Code";
            column(company_information__Name; "company information".Name)
            {
            }
            column(company_information__Address; "company information".Address)
            {
            }
            column(company_information___Address_2_; "company information"."Address 2")
            {
            }
            column(company_information___Fax_No__; "company information"."Fax No.")
            {
            }
            column(company_information___Phone_No__; "company information"."Phone No.")
            {
            }
            column(company_information___E_Mail_; "company information"."E-Mail")
            {
            }
            column(company_information___Home_Page_; "company information"."Home Page")
            {
            }
            column(GSTIN; "company information"."GST Registration No.")
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Outward_No__; "Outward No.")
            {
            }
            column(DC_DATA; DC_DATA)
            {
            }
            column(DC_DATA1; DC_DATA1)
            {
            }
            column(DC_DATA2; DC_DATA2)
            {
            }
            column(DC_DATA3; DC_DATA3)
            {
            }
            column(Item_Data; Item_Data)
            {
            }
            column(Item_Data_Control1102154062; Item_Data)
            {
            }
            column(Item_Data_Control1102154046; Item_Data)
            {
            }
            column(Item_Data_Control1102154063; Item_Data)
            {
            }
            column(FAX_Caption; FAX_CaptionLbl)
            {
            }
            column(Ph_Caption; Ph_CaptionLbl)
            {
            }
            column(E__Mail_Caption; E__Mail_CaptionLbl)
            {
            }
            column(To_Provide_Insight_For_Enhancing_WealthCaption; To_Provide_Insight_For_Enhancing_WealthCaptionLbl)
            {
            }
            column(URL_Caption; URL_CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(TinNo; TNo)
            {
            }
            column(CSTNo; CSTNo)
            {
            }
            column(TIN_NO__28350166764Caption; TIN_NO__28350166764CaptionLbl)
            {
            }
            column(VijayawadaCaption; VijayawadaCaptionLbl)
            {
            }
            column(Place_Caption; Place_CaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(TO_WHOM_SO_EVER_IT_MAY_CONCERNCaption; TO_WHOM_SO_EVER_IT_MAY_CONCERNCaptionLbl)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Item_Ledger_Entry_Item_No_; "Item No.")
            {
            }
            column(Grp1; Grp1)
            {
            }
            column(Grp2; Grp2)
            {
            }
            column(Grp3; Grp3)
            {
            }
            column(Grp4; Grp4)
            {
            }
            column(GrouptotalQty; GrouptotalQty)
            {
            }
            column(Type; Type)
            {
            }
            column(Typeint; Type)
            {
            }
            column(AMC_Loc; AMC_Loc)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF flag = FALSE THEN BEGIN
                    PMIHNEW.RESET;
                    PMIHNEW.SETFILTER(PMIHNEW."No.", "Item Ledger Entry"."Document No.");
                    IF PMIHNEW.FINDFIRST THEN BEGIN
                        IF (PMIHNEW."Transfer-from Code" IN ['CS STR', 'STR']) AND (PMIHNEW."Shortcut Dimension 2 Code" = "Item Ledger Entry"."Global Dimension 2 Code") THEN BEGIN
                            conformation := CONFIRM('There is also a material posted from CS STR! \ Would you like to Post That Also or Not! ', FALSE);
                            flag := TRUE;
                        END;
                    END;
                END;
                PMIHNEW.RESET;
                PMIHNEW.SETFILTER(PMIHNEW."No.", "Item Ledger Entry"."Document No.");
                IF PMIHNEW.FINDFIRST THEN
                    IF (((PMIHNEW."Transfer-from Code" IN ['CS STR', 'STR']) AND (conformation = TRUE)) OR (NOT (PMIHNEW."Transfer-from Code" IN ['CS STR', 'STR']))) THEN BEGIN
                        IF Item.GET("Item Ledger Entry"."Item No.") THEN BEGIN
                            IF Item."Item Tracking Code" = 'LOT NO' THEN
                                "Ser_No's" := "Ser_No's" + "Item Ledger Entry"."Lot No." + ', '
                            ELSE
                                "Ser_No's" := "Ser_No's" + "Item Ledger Entry"."Serial No." + ', ';
                        END;

                        //------------------------------
                        //Rev01 Item Ledger Entry, GroupHeader (4) - OnPreSection()
                        IF PrevItemNo <> "Item Ledger Entry"."Item No." THEN BEGIN
                            Print := TRUE;
                            Type := '';
                            IF PrevItemNo <> '' THEN BEGIN
                                reasonGvar := '';
                                StatGVar := '';
                                projectcode := '';
                                PostedMaterialIssuesLine.RESET;
                                PostedMaterialIssuesLine.SETFILTER(PostedMaterialIssuesLine."Document No.", InsertPrevDoc);
                                PostedMaterialIssuesLine.SETFILTER(PostedMaterialIssuesLine."Item No.", PrevItemNo);
                                IF PostedMaterialIssuesLine.FINDFIRST THEN BEGIN
                                    IF PostedMaterialIssuesLine."Non-Returnable" = TRUE THEN
                                        Type := 'Non-Returnable'
                                    ELSE
                                        Type := 'Returnable';
                                    PMIH.RESET;
                                    PMIH.SETFILTER(PMIH."No.", InsertPrevDoc);
                                    IF PMIH.FINDFIRST THEN BEGIN
                                        reasonGvar := PMIH."Reason Code";
                                        projectcode := PMIH."Prod. Order No.";
                                        PrevFrmLoc := PMIH."Transfer-from Code";
                                    END;
                                    StatGVar := PostedMaterialIssuesLine.Station;
                                END;
                                Item_Data1 := DELSTR(Item_Data1, STRLEN(Item_Data1), 1);
                                Item_Data := Item_Data1 + ')--' + FORMAT(GrouptotalQty) + ' ' + ItemUOM/*"Item Ledger Entry"."Unit of Measure Code"+','+Type1+Type2*/;
                                IF Choice = Choice::PostPrint THEN BEGIN
                                    /* DC_LINE.INIT;
                                    DC_LINE."Document No.":="Outward No.";
                                    LINE_NO+=10000;
                                    DC_LINE."Line No.":=LINE_NO;
                                    DC_LINE.Type:=DC_LINE.Type::Item;
                                    DC_LINE."No.":= PrevItemNo;
                                    IF ItemNewRec.GET(PrevItemNo) THEN
                                      DC_LINE.Description:=ItemNewRec.Description;
                                    DC_LINE.Quantity:=GrouptotalQty;
                                    DC_LINE."Non-Returnable":=PostedMaterialIssuesLine."Non-Returnable";
                                    IF Type='Non-Returnable' THEN
                                      DC_LINE."Non-Returnable":=PostedMaterialIssuesLine."Non-Returnable";
                                    DC_LINE.INSERT;
                                    */ //commented by pranav on 16-07-2015
                                    LINE_NO += 10000;
                                    CstransEntry;
                                    Type := Type1 + Type2;
                                END;
                                GrouptotalQty := 0;
                            END
                            ELSE              //Added by pranavi on 03-08-2015
                            BEGIN
                                PMIH.RESET;
                                PMIH.SETFILTER(PMIH."No.", "Item Ledger Entry"."Document No.");
                                IF PMIH.FINDFIRST THEN BEGIN
                                    reasonGvar := PMIH."Reason Code";
                                    projectcode := PMIH."Prod. Order No.";
                                    PrevFrmLoc := PMIH."Transfer-from Code";
                                END;          //end by pranavi
                            END;
                            PrevItemNo := "Item Ledger Entry"."Item No.";
                            prevDoc := "Item Ledger Entry"."Document No.";
                            prevGDC := "Item Ledger Entry"."Global Dimension 2 Code";
                            ItemUOM := "Item Ledger Entry"."Unit of Measure Code";
                            Item_Data1 := '';
                            "Sl No." += 1;
                            Item.RESET;
                            IF Item.GET("Item Ledger Entry"."Item No.") THEN BEGIN
                                IF Item."Item Tracking Code" <> 'LOT NO' THEN
                                    Item_Data1 := FORMAT("Sl No.") + '.' + ' ' + Item.Description + ' ' + '(Sl no. '
                                ELSE
                                    Item_Data1 := FORMAT("Sl No.") + '.' + ' ' + Item.Description + ' ';
                            END;
                        END
                        ELSE
                            Item_Data := '';
                        //Rev01 Item Ledger Entry, Body (5) - OnPreSection()
                        IF Item."Item Tracking Code" <> 'LOT NO' THEN
                            Item_Data1 += "Item Ledger Entry"."Serial No." + ' ,';
                        GrouptotalQty += "Item Ledger Entry".Quantity;
                        InsertPrevDoc := "Item Ledger Entry"."Document No.";
                        //Rev01 Item Ledger Entry, Body (5) - OnPreSection()
                        Grp1 := TRUE;

                    END
                    ELSE
                        CurrReport.SKIP;

            end;

            trigger OnPostDataItem()
            begin
                //ADSK  {
                IF flag = FALSE THEN BEGIN
                    PMIHNEW.RESET;
                    PMIHNEW.SETFILTER(PMIHNEW."No.", prevDoc);
                    IF PMIHNEW.FINDFIRST THEN BEGIN
                        IF (PMIHNEW."Transfer-from Code" IN ['CS STR', 'STR']) AND (PMIHNEW."Shortcut Dimension 2 Code" = prevGDC) THEN BEGIN
                            conformation := CONFIRM('There is also a material posted from CS STR! \ Would you like to Post That Also or Not! ', FALSE);
                            flag := TRUE;
                        END;
                    END;
                END;
                PMIHNEW.RESET;
                PMIHNEW.SETFILTER(PMIHNEW."No.", prevDoc);
                IF PMIHNEW.FINDFIRST THEN
                    IF (((PMIHNEW."Transfer-from Code" IN ['CS STR', 'STR']) AND (conformation = TRUE)) OR (NOT (PMIHNEW."Transfer-from Code" IN ['CS STR', 'STR']))) THEN BEGIN
                        IF (PrevItemNo <> '') THEN BEGIN
                            IF ItemNewRec.GET(PrevItemNo) THEN
                                Grp1 := TRUE;
                            IF Choice = Choice::PostPrint THEN BEGIN
                                reasonGvar := '';
                                StatGVar := '';
                                /*
                                 DC_LINE.INIT;
                                 DC_LINE."Document No.":="Outward No.";
                                 LINE_NO+=10000;
                                 DC_LINE."Line No.":=LINE_NO;
                                 DC_LINE.Type:=DC_LINE.Type::Item;
                                 DC_LINE."No.":= PrevItemNo;
                                 DC_LINE.Description:=ItemNewRec.Description;
                                 DC_LINE.Quantity:=GrouptotalQty;
                                 */
                                PostedMaterialIssuesLine.RESET;
                                PostedMaterialIssuesLine.SETFILTER(PostedMaterialIssuesLine."Item No.", PrevItemNo);
                                PostedMaterialIssuesLine.SETFILTER(PostedMaterialIssuesLine."Document No.", InsertPrevDoc);
                                IF PostedMaterialIssuesLine.FINDFIRST THEN BEGIN
                                    DC_LINE."Non-Returnable" := PostedMaterialIssuesLine."Non-Returnable";
                                    IF PostedMaterialIssuesLine."Non-Returnable" = TRUE THEN
                                        Type := 'Non-Returnable'
                                    ELSE
                                        Type := 'Returnable';
                                    PMIH.RESET;
                                    PMIH.SETFILTER(PMIH."No.", InsertPrevDoc);
                                    IF PMIH.FINDFIRST THEN BEGIN
                                        reasonGvar := PMIH."Reason Code";
                                    END;
                                    StatGVar := PostedMaterialIssuesLine.Station;
                                END;
                                // DC_LINE.INSERT;
                                LINE_NO += 10000;
                                CstransEntry;
                            END;
                            Item_Data1 := DELSTR(Item_Data1, STRLEN(Item_Data1), 1);
                            IF ItemNewRec."Item Tracking Code" <> 'LOT NO' THEN
                                Item_Data1 += ')--' + FORMAT(GrouptotalQty) + ' ' + ItemNewRec."Base Unit of Measure"/*+','+Type1+Type2*/
                            ELSE
                                Item_Data1 += '--' + FORMAT(GrouptotalQty) + ' ' + ItemNewRec."Base Unit of Measure"/*+','+Type1+Type2*/;
                            Item_Data := Item_Data1;
                            Type := Type1 + Type2;
                            Print := TRUE;
                        END;
                        CTHGRec.RESET;
                        CTHGRec.SETFILTER(CTHGRec."Transaction ID", TransNoGVar);
                        IF CTHGRec.FINDFIRST THEN BEGIN
                            CTHGRec.Status := CTHGRec.Status::Released;
                            CTHGRec.MODIFY;
                        END;
                    END;
                //ADSK
                /*
                IF "Item Ledger Entry".COUNT = 0 THEN
                BEGIN
                  p2 := FALSE;
                  "Outward No.":='';
                END;
                */
                //MESSAGE(FORMAT("Item Ledger Entry".COUNT));

            end;

            trigger OnPreDataItem()
            begin
                //MNRAJU FOR TIN NO. CHANGING
                //MESSAGE('ile:'+FORMAT("Item Ledger Entry".GETFILTERS));
                /*//B2BUpg
                tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', TODAY);
                tin.SETFILTER(tin.Group, 'TIN');
                IF tin.FINDLAST THEN BEGIN
                    TNo := tin.Code;
                END;

                tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', TODAY);
                tin.SETFILTER(tin.Group, 'CST');
                IF tin.FINDLAST THEN BEGIN
                    CSTNo := tin.Code;
                END;*///B2BUpg
                //MNRAJU FOR TIN NO. CHANGING


                IF FORMAT("Outward No.") = '' THEN
                    ERROR('PLEASE ENTER THE DC No');

                IF FORMAT("Mode Of Transport") = '' THEN
                    ERROR('PLEASE ENTER THE "MODE OF TRANSPORT" INFORMTATION');
                /*IF FORMAT("Authorised By")='' THEN
                   ERROR('PLEASE ENTER THE AUTHORISATION PERSON INFORMATION');*/
                IF "Send To" = '' THEN
                    ERROR('PLEASE ENTER THE SEND TO PERSON INFORMATION');
                IF FORMAT(Purpose) = '' THEN
                    ERROR('PLEASE ENTER THE PURPOSE INFORMATION');
                // IF ("Authorised By"=3) OR  ("Authorised By">7) THEN
                User.RESET;
                User.SETRANGE(User.EmployeeID, incharge_id_no);
                IF User.FIND('-') THEN BEGIN
                    SP.RESET;
                    SP.SETRANGE(SP.Code, User.EmployeeID);
                    IF SP.FINDFIRST THEN
                        Text_Mng := SP."Job Title"
                    ELSE
                        Text_Mng := 'Project Manager';
                    userrec.Reset;
                    userrec.Setrange("User Name", User."User ID");
                    if userrec.findfirst then
                        AuthName := UserRec."Full Name";
                    //AuthName := incharge_name;
                    AuthNo := incharge_no;

                END
                ELSE BEGIN
                    Text_Mng := 'Project Manager';
                    // AuthName:="Authorised By";
                    AuthName := incharge_name;
                    AuthNo := incharge_no;
                END;
                //Text_Mng:=FORMAT(Role);
                //ELSE
                //Text_Mng:='Manager';
                //Rev01 Item Ledger Entry, Header (1) - OnPreSection()
                "company information".GET;
                // p1:=TRUE; //Rev01
                //Rev01 Item Ledger Entry, Header (1) - OnPreSection()
                //Rev01 Item Ledger Entry, Header (2) - OnPreSection()

                //p2:=TRUE; //Rev01
                AuthName := "Send To";//EFFUPG1.6
                CASE DATE2DMY(TODAY, 2) OF
                    1:
                        BEGIN
                            Month := 'JAN';
                            Days_Of_Month := 31;
                        END;
                    2:
                        BEGIN
                            Month := 'FEB';
                            Days_Of_Month := 28;
                        END;
                    3:
                        BEGIN
                            Month := 'MAR';
                            Days_Of_Month := 31;
                        END;
                    4:
                        BEGIN
                            Month := 'APR';
                            Days_Of_Month := 30;
                        END;
                    5:
                        BEGIN
                            Month := 'MAY';
                            Days_Of_Month := 31;
                        END;
                    6:
                        BEGIN
                            Month := 'JUN';
                            Days_Of_Month := 30;
                        END;
                    7:
                        BEGIN
                            Month := 'JUL';
                            Days_Of_Month := 31;
                        END;
                    8:
                        BEGIN
                            Month := 'AUG';
                            Days_Of_Month := 31;
                        END;
                    9:
                        BEGIN
                            Month := 'SEP';
                            Days_Of_Month := 30;
                        END;
                    10:
                        BEGIN
                            Month := 'OCt';
                            Days_Of_Month := 31;
                        END;
                    11:
                        BEGIN
                            Month := 'NOV';
                            Days_Of_Month := 30;
                        END;
                    12:
                        BEGIN
                            Month := 'DEC';
                            Days_Of_Month := 31;
                        END;
                END;
                //   Month:='JUL';
                outwardnumber := "Outward No.";
                Start_Date := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                "Final Date" := DMY2DATE(Days_Of_Month, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
                "Outward No." := 'CUS/DR/' + Month + '/' + YearValue + '/' + "Outward No.";

                IF Choice = Choice::PostPrint THEN BEGIN
                    p2 := TRUE;
                    // MESSAGE('sTART');
                    IF NOT (DC_HEADER.GET("Outward No.")) THEN BEGIN
                        DC_HEADER.INIT;
                        DC_HEADER."No." := "Outward No.";
                        IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code") <> 'LED-GEN' THEN
                            DC_HEADER.Type := DC_HEADER.Type::Site
                        ELSE BEGIN
                            DC_HEADER.Type := DC_HEADER.Type::Customer;
                            DC_HEADER."Customer No." := CustrNo;
                            IF CustrNo <> '' THEN
                                DC_HEADER.VALIDATE("Customer No.");
                        END;
                        DC_HEADER."User Id" := USERID;
                        DC_HEADER."Created Date" := TODAY;
                        DC_HEADER.Reciver := "Send To";
                        User.RESET;
                        User.SETRANGE("User ID", "Send To");
                        IF User.FINDFIRST THEN;
                        userrec.Reset;
                        userrec.Setrange("User Name", "Send To");
                        if userrec.findfirst then
                            DC_HEADER."Reciver Name" := UserRec."Full Name";
                        DC_HEADER."StoreIncharge Name" := USERID;
                        // DC_HEADER.Indented:=FORMAT("Authorised By");

                        User.RESET;
                        User.SETRANGE(EmployeeID, incharge_id_no);
                        IF User.FINDFIRST THEN;
                        DC_HEADER."Indented Name" := UserRec."Full Name";
                        DC_HEADER.Indented := FORMAT(UserRec."User Name");
                        DC_HEADER.Remarks := FORMAT(Purpose);
                        DC_HEADER."Mode Of Transport" := FORMAT("Mode Of Transport");
                        DC_HEADER."Location Code" := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                        DC_HEADER.VALIDATE(DC_HEADER."Location Code", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
                    END ELSE BEGIN
                        //Added By Pranavi On 25-08-2015 not to allow DC for Other Site if already Done to some Other Site
                        IF (DC_HEADER."Location Code" <> "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code")) THEN
                            ERROR('You cannot DC to Site' + "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code") +
                                  '\Already DC Done on Number: ' + DC_HEADER."No." + ' for Site ' + DC_HEADER."Location Code");
                        //Added By Pranavi On 25-08-2015
                        Selection := STRMENU(Text001, 1);
                        IF Selection = 2 THEN BEGIN
                            CTHGRec.RESET;
                            CTHGRec.SETFILTER(CTHGRec."DC No", "Outward No.");
                            IF CTHGRec.FINDFIRST THEN BEGIN
                                transID := CTHGRec."Transaction ID";
                                CTLGRec.RESET;
                                CTLGRec.SETFILTER(CTLGRec."Transaction ID", CTHGRec."Transaction ID");
                                IF CTLGRec.FIND('-') THEN BEGIN
                                    CTLGRec.DELETEALL;
                                END;
                                CTLedgGRec.RESET;
                                CTLedgGRec.SETFILTER(CTLedgGRec."Transaction ID", CTHGRec."Transaction ID");
                                IF CTLedgGRec.FIND('-') THEN BEGIN
                                    CTLedgGRec.DELETEALL;
                                END;
                                CTHGRec.DELETE;
                            END;
                            ItemsTobeDeleted := '';
                            ItemsTobeDeleted1 := '';
                            prevdcno := '';
                            DCLINE1.RESET;
                            DCLINE1.SETFILTER(DCLINE1."Document No.", "Outward No.");
                            DCLINE1.SETFILTER(DCLINE1."No.", '<>%1', '');
                            IF DCLINE1.FINDSET THEN
                                REPEAT
                                    IF prevdcno <> DCLINE1."No." THEN
                                        ItemsTobeDeleted := ItemsTobeDeleted + DCLINE1."No." + '|';
                                    prevdcno := DCLINE1."No.";
                                UNTIL DCLINE1.NEXT = 0;
                            IF ItemsTobeDeleted <> '' THEN
                                ItemsTobeDeleted1 := COPYSTR(ItemsTobeDeleted, 1, STRLEN(ItemsTobeDeleted) - 1);
                            IF ItemsTobeDeleted1 <> '' THEN BEGIN
                                ILECheck.RESET;
                                ILECheck.SETCURRENTKEY(ILECheck."Location Code", ILECheck."Posting Date", ILECheck."Item No.");
                                ILECheck.SETFILTER(ILECheck."Entry Type", '%1', ILECheck."Entry Type"::Transfer);
                                ILECheck.SETFILTER(ILECheck."Global Dimension 2 Code", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
                                IF FORMAT("Item Ledger Entry"."Posting Date") <> '' THEN
                                    ILECheck.SETFILTER(ILECheck."Posting Date", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Posting Date"));
                                IF "Item Ledger Entry"."Document No." <> '' THEN
                                    ILECheck.SETFILTER(ILECheck."Document No.", "Item Ledger Entry"."Document No.");
                                ILECheck.SETFILTER(ILECheck."Location Code", '%1', 'SITE');
                                ILECheck.SETFILTER(ILECheck."Item No.", ItemsTobeDeleted1);
                                ILECheck.SETFILTER(ILECheck."Remaining Quantity", '>%1', 0);
                                ILECheck.SETFILTER(ILECheck."DC Check", '%1', TRUE);
                                IF ILECheck.FINDSET THEN
                                    REPEAT
                                        ILECheck."DC Check" := FALSE;
                                        ILECheck.MODIFY;
                                    UNTIL ILECheck.NEXT = 0;    //by pranavi     //not working
                            END ELSE    //Added by Pranavi on 22-Dec-2015 for empty DC print
                            BEGIN
                                ILECheck.RESET;
                                ILECheck.SETFILTER(ILECheck."Entry Type", '%1', ILECheck."Entry Type"::Transfer);
                                ILECheck.SETFILTER(ILECheck."Global Dimension 2 Code", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
                                IF FORMAT("Item Ledger Entry"."Posting Date") <> '' THEN
                                    ILECheck.SETFILTER(ILECheck."Posting Date", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Posting Date"));
                                IF "Item Ledger Entry"."Document No." <> '' THEN
                                    ILECheck.SETFILTER(ILECheck."Document No.", "Item Ledger Entry"."Document No.");
                                ILECheck.SETFILTER(ILECheck."Location Code", '%1', 'SITE');
                                ILECheck.SETFILTER(ILECheck."Remaining Quantity", '>%1', 0);
                                ILECheck.SETFILTER(ILECheck."DC Check", '%1', TRUE);
                                IF ILECheck.FINDSET THEN
                                    REPEAT
                                        ILECheck."DC Check" := FALSE;
                                        ILECheck.MODIFY;
                                    UNTIL ILECheck.NEXT = 0;
                            END;
                            DC_LINE.SETRANGE(DC_LINE."Document No.", "Outward No.");
                            IF DC_LINE.FIND('-') THEN
                                DC_LINE.DELETEALL;
                            DC_HEADER.DELETE;
                            DC_LINE.RESET;
                            DC_HEADER.INIT;
                            DC_HEADER."No." := "Outward No.";
                            IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code") <> 'LED-GEN' THEN
                                DC_HEADER.Type := DC_HEADER.Type::Site
                            ELSE BEGIN
                                DC_HEADER.Type := DC_HEADER.Type::Customer;
                                DC_HEADER."Customer No." := CustrNo;
                                IF CustrNo <> '' THEN
                                    DC_HEADER.VALIDATE("Customer No.");
                            END;
                            DC_HEADER."User Id" := USERID;
                            DC_HEADER."Created Date" := TODAY;
                            DC_HEADER.Reciver := "Send To";
                            User.RESET;
                            User.SETRANGE("User ID", "Send To");
                            IF User.FINDFIRST THEN
                                DC_HEADER."Reciver Name" := UserRec."Full Name";
                            User.RESET;
                            User.SETRANGE(EmployeeID, incharge_id_no);
                            IF User.FINDFIRST THEN BEGIN
                                DC_HEADER.Indented := FORMAT(UserRec."User Name");
                                DC_HEADER."StoreIncharge Name" := FORMAT(UserRec."User Name");
                            END;
                            DC_HEADER.Remarks := FORMAT(Purpose);
                            DC_HEADER."Mode Of Transport" := FORMAT("Mode Of Transport");
                            DC_HEADER."Location Code" := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                            DC_HEADER.VALIDATE(DC_HEADER."Location Code", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
                            /*
                            noseries:='CS TRANS';
                            NoSeriesMgt.InitSeries('CS TRANS','CS TRANS',TODAY,TransNoGVar,noseries);
                            CTHGRec.INIT;
                            CTHGRec."Transaction ID":=TransNoGVar;
                            CTHGRec."Transaction Type":=CTHGRec."Transaction Type"::"Card Transfer";
                            CTHGRec."Transfer From Location":='H-OFF';
                            CTHGRec."Transfer To Location":="Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                            CTHGRec."Mode of Transport":="Mode Of Transport";
                            CTHGRec."Courier Details":=' ';
                            CTHGRec."Transaction Status":= CTHGRec."Transaction Status"::"In-Transit";
                            CTHGRec.Status:=CTHGRec.Status::Open;
                            CTHGRec."Posting Date":=TODAY;
                            CTHGRec."User ID":=USERID;
                            CTHGRec."Created Date":=TODAY;
                            CTHGRec.Remarks:=FORMAT(Purpose);
                            CTHGRec."DC No":="Outward No.";
                            CTHGRec.INSERT;
                            */
                        END
                        ELSE
                            EXIT;
                    END;
                    //site stock transaction entry. Added by mnraju on 20-Mar-2014
                    // MESSAGE('head');
                    /*
                     CTHGRec.RESET;
                    IF CTHGRec.FINDLAST THEN
                    BEGIN
                     TransNoGVar:=INCSTR(CTHGRec."Transaction ID");
                    END;
                    */
                    //end of mnraju
                END;
                //Rev01 Item Ledger Entry, Header (2) - OnPreSection()

                //Rev01 Item Ledger Entry, Header (3) - OnPreSection()
                //p3:=TRUE; //Rev01
                //Rev01 Item Ledger Entry, Header (3) - OnPreSection()
                GrouptotalQty := 0;
                InsertPrevItemDetails := ''

            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);
            MaxIteration = 1;
            column(LastRec_Integer_Type; Type)
            {
            }
            column(Int1_Item_Data; Item_Data)
            {
            }
            column(company_information__Name_Control1102154021; "company information".Name)
            {
            }
            column(company_information__Address_Control1102154022; "company information".Address)
            {
            }
            column(company_information___Address_2__Control1102154023; "company information"."Address 2")
            {
            }
            column(company_information___Fax_No___Control1102154024; "company information"."Fax No.")
            {
            }
            column(company_information___Phone_No___Control1102154026; "company information"."Phone No.")
            {
            }
            column(company_information___E_Mail__Control1102154029; "company information"."E-Mail")
            {
            }
            column(company_information___Home_Page__Control1102154032; "company information"."Home Page")
            {
            }
            column(company_information___GSTIN__Control111; "company information"."GST Registration No.")
            {
            }
            column(TODAY_Control1102154039; TODAY)
            {
            }
            column(Outward_No___Control1102154042; "Outward No.")
            {
            }
            column(TO_WHOM_SO_EVER_IT_MAY_CONCERNCaption_Control1102154043; TO_WHOM_SO_EVER_IT_MAY_CONCERNCaption_Control1102154043Lbl)
            {
            }
            column(DC_DATA_Control1102154044; DC_DATA)
            {
            }
            column(DC_DATA1_Control1102154044; DC_DATA1)
            {
            }
            column(DC_DATA2_Control1102154044; DC_DATA2)
            {
            }
            column(DC_DATA3_Control1102154044; DC_DATA3)
            {
            }
            column(Item_Data_Control1000000021; Item_Data4)
            {
            }
            column(Item_Data_Control1000000022; Item_Data5)
            {
            }
            column(Item_Data_Control1000000023; Item_Data6)
            {
            }
            column(Item_Data_Control1000000024; Item_Data7)
            {
            }
            column(Item_Data_Control1000000025; Item_Data8)
            {
            }
            column(Item_Data_Control1000000026; Item_Data9)
            {
            }
            column(Item_Data_Control1000000027; Item_Data10)
            {
            }
            column(Item_Data_Control1000000028; Item_Data11)
            {
            }
            column(Item_Data_Control1102154057; Item_Data12)
            {
            }
            column(Item_Data_Control1102154058; Item_Data13)
            {
            }
            column(Item_Data_Control1102154059; Item_Data14)
            {
            }
            column(Item_Data_Control1102154060; Item_Data15)
            {
            }
            column(Authorised_By_; "Authorised By")
            {
            }
            column(AuthName; AuthName)
            {
            }
            column(AuthNo; AuthNo)
            {
            }
            column(Text_Mng; Text_Mng)
            {
            }
            column(Transport_Service_Name_; "Transport Service Name")
            {
            }
            column(Transport_Service_Person_Name_; "Transport Service Person Name")
            {
            }
            column(FAX_Caption_Control1102154025; FAX_Caption_Control1102154025Lbl)
            {
            }
            column(Ph_Caption_Control1102154027; Ph_Caption_Control1102154027Lbl)
            {
            }
            column(E__Mail_Caption_Control1102154028; E__Mail_Caption_Control1102154028Lbl)
            {
            }
            column(To_Provide_Insight_For_Enhancing_WealthCaption_Control1102154030; To_Provide_Insight_For_Enhancing_WealthCaption_Control1102154030Lbl)
            {
            }
            column(URL_Caption_Control1102154031; URL_Caption_Control1102154031Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154037; EmptyStringCaption_Control1102154037Lbl)
            {
            }
            column(TIN_NO__28350166764Caption_Control1102154061; TIN_NO__28350166764Caption_Control1102154061Lbl)
            {
            }
            column(VijayawadaCaption_Control1102154038; VijayawadaCaption_Control1102154038Lbl)
            {
            }
            column(Place_Caption_Control1102154040; Place_Caption_Control1102154040Lbl)
            {
            }
            column(S_No_Caption_Control1102154041; S_No_Caption_Control1102154041Lbl)
            {
            }
            column(attributed__For_Efftronics_systems_Pvt__Ltd_Caption; attributed__For_Efftronics_systems_Pvt__Ltd_CaptionLbl)
            {
            }
            column(The_above_is_not_for_sale_hence_no_commercial_value_can_be_Caption; The_above_is_not_for_sale_hence_no_commercial_value_can_be_CaptionLbl)
            {
            }
            column(Customer_SupportCaption; Customer_SupportCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000017; EmptyStringCaption_Control1000000017Lbl)
            {
            }
            column(DATE_Caption; DATE_CaptionLbl)
            {
            }
            column(FOR_OFFICE_USE_ONLYCaption; FOR_OFFICE_USE_ONLYCaptionLbl)
            {
            }
            column(This_is_to_certify_that_the_materials_are_dispatched_to___________for_Caption; This_is_to_certify_that_the_materials_are_dispatched_to___________for_CaptionLbl)
            {
            }
            column(to___Mr______________Caption; to___Mr______________CaptionLbl)
            {
            }
            column(to___Mr______________by__Mode_of_transport__Caption; to___Mr______________by__Mode_of_transport__CaptionLbl)
            {
            }
            column(Bearing_D_C__No________Caption; Bearing_D_C__No________CaptionLbl)
            {
            }
            column(Bearing_D_C__No________Dt__________Parcel_takenCaption; Bearing_D_C__No________Dt__________Parcel_takenCaptionLbl)
            {
            }
            column(By________Caption; By________CaptionLbl)
            {
            }
            column(Transport_Service_Name______________Caption; Transport_Service_Name______________CaptionLbl)
            {
            }
            column(Transport_Service_Preson_Name__Caption; Transport_Service_Preson_Name__CaptionLbl)
            {
            }
            column(Receptionist_Caption; Receptionist_CaptionLbl)
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(DC_REPORT__GENERATED_FROM_ERP_____Caption; DC_REPORT__GENERATED_FROM_ERP_____CaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            column(IntegerDisplay; IntegerDisplay)
            {
            }
            column(IntegerDisplay2; IntegerDisplay2)
            {
            }
            column(IntegerDisplay3; IntegerDisplay3)
            {
            }
            column(IntegerDisplay4; IntegerDisplay4)
            {
            }
            column(IntegerDisplay5; IntegerDisplay5)
            {
            }
            column(IntegerDisplay6; IntegerDisplay6)
            {
            }
            column(IntegerDisplay7; IntegerDisplay7)
            {
            }
            column(IntegerDisplay8; IntegerDisplay8)
            {
            }
            column(IntegerDisplay9; IntegerDisplay9)
            {
            }
            column(IntegerDisplay10; IntegerDisplay10)
            {
            }
            column(IntegerDisplay11; IntegerDisplay11)
            {
            }
            column(IntegerDisplay12; IntegerDisplay12)
            {
            }
            column(IntegerDisplay13; IntegerDisplay13)
            {
            }
            column(IntegerDisplay14; IntegerDisplay14)
            {
            }
            column(IntegerDisplay15; IntegerDisplay15)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Choice = Choice::PostPrint THEN
                    DC_HEADER.INSERT;
            end;

            trigger OnPreDataItem()
            begin

                "company information".GET;

                IntegerDisplay := NOT p1;

                IntegerDisplay2 := TRUE;//NOT p2;

                IntegerDisplay3 := TRUE;//NOT p3;


                CASE DATE2DMY(TODAY, 2) OF
                    1:
                        BEGIN
                            Month := 'JAN';
                            Days_Of_Month := 31;
                        END;
                    2:
                        BEGIN
                            Month := 'FEB';
                            Days_Of_Month := 28;
                        END;
                    3:
                        BEGIN
                            Month := 'MAR';
                            Days_Of_Month := 31;
                        END;
                    4:
                        BEGIN
                            Month := 'APR';
                            Days_Of_Month := 30;
                        END;
                    5:
                        BEGIN
                            Month := 'MAY';
                            Days_Of_Month := 31;
                        END;
                    6:
                        BEGIN
                            Month := 'JUN';
                            Days_Of_Month := 30;
                        END;
                    7:
                        BEGIN
                            Month := 'JUL';
                            Days_Of_Month := 31;
                        END;
                    8:
                        BEGIN
                            Month := 'AUG';
                            Days_Of_Month := 31;
                        END;
                    9:
                        BEGIN
                            Month := 'SEP';
                            Days_Of_Month := 30;
                        END;
                    10:
                        BEGIN
                            Month := 'OCt';
                            Days_Of_Month := 31;
                        END;
                    11:
                        BEGIN
                            Month := 'NOV';
                            Days_Of_Month := 30;
                        END;
                    12:
                        BEGIN
                            Month := 'DEC';
                            Days_Of_Month := 31;
                        END;
                END;

                IF (NOT p2) AND (Choice = Choice::PostPrint) THEN BEGIN
                    Start_Date := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                    "Final Date" := DMY2DATE(Days_Of_Month, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                    YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
                    "Outward No." := 'CUS/DR/' + Month + '/' + YearValue + '/' + "Outward No.";

                    // "Outward No.":='CUS/DR/'+Month+'/'+"Outward No.";

                    IF NOT (DC_HEADER.GET("Outward No.")) THEN BEGIN
                        DC_HEADER.INIT;
                        DC_HEADER."No." := "Outward No.";
                        DC_HEADER.Type := DC_HEADER.Type::Site;
                        DC_HEADER."User Id" := USERID;
                        DC_HEADER."Created Date" := TODAY;
                        DC_HEADER.Reciver := "Send To";
                        UserRec.RESET;
                        UserRec.SETRANGE("User Name", "Send To");
                        IF UserRec.FINDFIRST THEN//Rev01
                            DC_HEADER."Reciver Name" := UserRec."Full Name";
                        DC_HEADER.StoreIncharge := USERID;
                        UserRec.RESET;
                        UserRec.SETRANGE("User name", USERID);
                        IF UserRec.FINDFIRST THEN
                            DC_HEADER."StoreIncharge Name" := UserRec."Full Name";

                        //DC_HEADER.Indented:="Authorised By";
                        User.RESET;
                        User.SETRANGE(EmployeeID, incharge_id_no);
                        IF User.FINDFIRST THEN
                            UserRec.RESET;
                        UserRec.SETRANGE("User name", user."User ID");
                        IF UserRec.FINDFIRST THEN
                            DC_HEADER.Indented := UserRec."User Name";
                        DC_HEADER."Indented Name" := UserRec."Full Name";
                        DC_HEADER.Remarks := FORMAT(Purpose);
                        DC_HEADER."Mode Of Transport" := FORMAT("Mode Of Transport");
                        DC_HEADER."Location Code" := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                        DC_HEADER.VALIDATE(DC_HEADER."Location Code", "Item Ledger Entry".GETFILTER("Global Dimension 2 Code"));

                    END ELSE BEGIN
                        Selection := STRMENU(Text001, 1);
                        IF Selection = 2 THEN BEGIN
                            DC_LINE.SETRANGE(DC_LINE."Document No.", DC_HEADER."No.");
                            IF DC_LINE.FIND('-') THEN
                                DC_LINE.DELETE;
                            DC_HEADER.DELETE;
                            DC_LINE.RESET;

                            DC_HEADER.INIT;
                            DC_HEADER."No." := "Outward No.";
                            DC_HEADER.Type := DC_HEADER.Type::Site;
                            DC_HEADER."User Id" := USERID;
                            DC_HEADER."Created Date" := TODAY;
                            DC_HEADER.Reciver := "Send To";
                            User.RESET;
                            User.SETRANGE(User."User Id", "Send To");
                            IF User.FINDFIRST THEN//Rev01
                                DC_HEADER."Reciver Name" := UserRec."Full Name";
                            DC_HEADER.StoreIncharge := USERID;
                            User.RESET;
                            User.SETRANGE(User."User ID", USERID);
                            IF User.FINDFIRST THEN
                                DC_HEADER."StoreIncharge Name" := UserRec."Full Name";
                            //DC_HEADER.Indented:="Authorised By";
                            User.RESET;
                            User.SETRANGE(EmployeeID, incharge_id_no);
                            IF User.FINDFIRST THEN BEGIN
                                DC_HEADER.Indented := UserRec."User Name";
                                DC_HEADER."Indented Name" := UserRec."Full Name";
                            END;
                            DC_HEADER.Remarks := FORMAT(Purpose);
                            DC_HEADER."Mode Of Transport" := FORMAT("Mode Of Transport");
                            DC_HEADER."Location Code" := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                            DC_HEADER.VALIDATE(DC_HEADER."Location Code", "Item Ledger Entry".GETFILTER("Global Dimension 2 Code"));

                        END ELSE
                            EXIT;
                    END;
                END;



                "Sl No." := 0;//Rev01
                IF FA1 <> '' THEN BEGIN
                    IntegerDisplay4 := TRUE;
                    "Sl No." += 1;
                    "Fixed Asset".RESET;
                    "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA1);
                    IF "Fixed Asset".FIND('-') THEN
                        Item_Data4 := FORMAT("Sl No.") + '. ' + "Fixed Asset".Description + '( Sl No.' + "Fixed Asset"."Serial No." + ')- 1 No.s';
                END ELSE
                    IntegerDisplay4 := FALSE;


                IF FA2 <> '' THEN BEGIN
                    IntegerDisplay5 := TRUE;
                    "Sl No." += 1;
                    "Fixed Asset".RESET;
                    "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA2);
                    IF "Fixed Asset".FIND('-') THEN
                        Item_Data5 := FORMAT("Sl No.") + '. ' + "Fixed Asset".Description + '(Sl No.' + "Fixed Asset"."Serial No." + ')- 1 No.s';
                END ELSE
                    IntegerDisplay5 := FALSE;


                IF FA3 <> '' THEN BEGIN
                    IntegerDisplay6 := TRUE;
                    "Sl No." += 1;
                    "Fixed Asset".RESET;
                    "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA3);
                    IF "Fixed Asset".FIND('-') THEN
                        Item_Data6 := FORMAT("Sl No.") + '. ' + "Fixed Asset".Description + '( Sl No.' + "Fixed Asset"."Serial No." + ')- 1 No.s';
                END ELSE
                    IntegerDisplay6 := FALSE;


                IF FA4 <> '' THEN BEGIN
                    IntegerDisplay7 := TRUE;
                    "Sl No." += 1;
                    "Fixed Asset".RESET;
                    "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA4);
                    IF "Fixed Asset".FIND('-') THEN
                        Item_Data7 := FORMAT("Sl No.") + '. ' + "Fixed Asset".Description + '( Sl No.' + "Fixed Asset"."Serial No." + ')- 1 No.s';
                END ELSE
                    IntegerDisplay7 := FALSE;


                IF MiscItem1 <> '' THEN BEGIN
                    IntegerDisplay8 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem1;
                        DC_LINE.Quantity := MQTY_1;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data8 := FORMAT("Sl No.") + '. ' + MiscItem1 + '--' + FORMAT(MQTY_1) + ' No.s';
                END ELSE
                    IntegerDisplay8 := FALSE;


                IF MiscItem2 <> '' THEN BEGIN
                    IntegerDisplay9 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem2;
                        DC_LINE.Quantity := MQTY_2;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data9 := FORMAT("Sl No.") + '. ' + MiscItem2 + '--' + FORMAT(MQTY_2) + ' No.s';
                END ELSE
                    IntegerDisplay9 := FALSE;



                IF MiscItem3 <> '' THEN BEGIN
                    IntegerDisplay10 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem3;
                        DC_LINE.Quantity := MQTY_3;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data10 := FORMAT("Sl No.") + '. ' + MiscItem3 + '--' + FORMAT(MQTY_3) + ' No.s';
                END ELSE
                    IntegerDisplay10 := FALSE;


                IF MiscItem4 <> '' THEN BEGIN
                    IntegerDisplay11 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem4;
                        DC_LINE.Quantity := MQTY_4;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data11 := FORMAT("Sl No.") + '. ' + MiscItem4 + '--' + FORMAT(MQTY_4) + ' No.s';
                END ELSE
                    IntegerDisplay11 := FALSE;

                IF MiscItem5 <> '' THEN BEGIN
                    IntegerDisplay12 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem5;
                        DC_LINE.Quantity := MQTY_5;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data12 := FORMAT("Sl No.") + '. ' + MiscItem5 + '--' + FORMAT(MQTY_5) + ' No.s';
                END ELSE
                    IntegerDisplay12 := FALSE;


                IF MiscItem6 <> '' THEN BEGIN
                    IntegerDisplay13 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem6;
                        DC_LINE.Quantity := MQTY_6;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data13 := FORMAT("Sl No.") + '. ' + MiscItem6 + '--' + FORMAT(MQTY_6) + ' No.s';
                END ELSE
                    IntegerDisplay13 := FALSE;


                IF MiscItem7 <> '' THEN BEGIN
                    IntegerDisplay14 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem7;
                        DC_LINE.Quantity := MQTY_7;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data14 := FORMAT("Sl No.") + '. ' + MiscItem7 + '--' + FORMAT(MQTY_7) + ' No.s';
                END ELSE
                    IntegerDisplay14 := FALSE;


                IF MiscItem8 <> '' THEN BEGIN
                    IntegerDisplay15 := TRUE;
                    IF Choice = Choice::PostPrint THEN BEGIN
                        DC_LINE.INIT;
                        DC_LINE."Document No." := "Outward No.";
                        LINE_NO += 10000;
                        DC_LINE."Line No." := LINE_NO;
                        DC_LINE.Description := MiscItem8;
                        DC_LINE.Quantity := MQTY_8;
                        DC_LINE.INSERT;
                    END;
                    "Sl No." += 1;
                    Item_Data15 := FORMAT("Sl No.") + '. ' + MiscItem8 + '--' + FORMAT(MQTY_8) + ' No.s';
                END ELSE
                    IntegerDisplay15 := FALSE;
            end;
        }
    }

    requestpage
    {
        Caption = 'Note: Please Click on Check Box After Entering the Fixed Asset';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Control1102152001)
                {
                    ShowCaption = false;
                    label("DC Details")
                    {
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    field("DC No."; "Outward No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Mode of Transport"; "Mode Of Transport")
                    {
                        ApplicationArea = All;
                    }
                    field("Send To"; "Send To")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            UserREc.RESET;
                            IF PAGE.RUNMODAL(9800, UserRec) = ACTION::LookupOK THEN
                                "Send To" := UserRec."User Name";
                        end;
                    }
                    field(Gender; Gender)
                    {
                        ApplicationArea = All;
                    }
                    field(Role; Role)
                    {
                        ApplicationArea = All;
                    }
                    field(Purpose; Purpose)
                    {
                        ApplicationArea = All;
                    }
                    field("Transport Service Name"; "Transport Service Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Transport Service Person Name"; "Transport Service Person Name")
                    {
                        ApplicationArea = All;
                    }
                    field(Choice; Choice)
                    {
                        ApplicationArea = All;
                    }
                    field(SendToLoc; SendToLoc)
                    {
                        Caption = 'Send To Location';
                        ApplicationArea = All;
                    }
                    field(Site; Site)
                    {
                        Caption = 'Select Site';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            DimValGRec.RESET;
                            DimValGRec.SETRANGE(DimValGRec."Dimension Code", 'LOCATIONS');
                            DimValGRec.SETFILTER(DimValGRec.Blocked, '%1', FALSE);
                            IF PAGE.RUNMODAL(560, DimValGRec) = ACTION::LookupOK THEN
                                Site := DimValGRec.Code;
                        end;
                    }
                    field(AMC_Orders; AMC_Orders)
                    {
                        Caption = 'Select AMC Order';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AMCGRec.RESET;
                            AMCGRec.SETRANGE(AMCGRec.SaleDocType, AMCGRec.SaleDocType::Amc);//EFFUPG1.5
                            IF PAGE.RUNMODAL(45, AMCGRec) = ACTION::LookupOK THEN BEGIN
                                AMC_Orders := AMCGRec."Customer OrderNo.";
                                AMCNo := AMCGRec."No.";
                            END;
                        end;
                    }
                    label("Fixed Assets")
                    {
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    grid(Control1102152023)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group("Fixed Asset1")
                        {
                            field(FA1; FA1)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(Ac1; Ac1)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;

                                trigger OnValidate()
                                begin
                                    //Rev01
                                    //<Control1102154025> - OnPush()
                                    IF Ac1 THEN BEGIN
                                        IF "Send To" = '' THEN
                                            ERROR('Please Enter the Send To Person Code ')
                                        ELSE BEGIN
                                            "Fixed Asset".RESET;
                                            "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA1);
                                            IF "Fixed Asset".FIND('-') THEN BEGIN
                                                //IF "Fixed Asset"."Responsible Employee"='99ST005' THEN
                                                //BEGIN

                                                "Fixed Asset".VALIDATE("Fixed Asset"."Responsible Employee", "Send To");
                                                "Fixed Asset"."Responsible Employee" := "Send To";
                                                "Fixed Asset".MODIFY;
                                                //END ELSE
                                                //ERROR('Given Fixed Asset not Under CS Control');
                                            END;
                                        END;
                                    END;
                                end;
                            }
                        }
                    }
                    grid(Control1102152028)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group("Fixed Asset2")
                        {
                            field(FA2; FA2)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(Ac2; Ac2)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;

                                trigger OnValidate()
                                begin
                                    //Rev01
                                    IF Ac2 THEN BEGIN
                                        IF "Send To" = '' THEN
                                            ERROR('Please Enter the Send To Person Code ')
                                        ELSE BEGIN
                                            "Fixed Asset".RESET;
                                            "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA2);
                                            IF "Fixed Asset".FIND('-') THEN BEGIN
                                                IF "Fixed Asset"."Responsible Employee" = '99ST005' THEN BEGIN

                                                    "Fixed Asset".VALIDATE("Fixed Asset"."Responsible Employee", "Send To");
                                                    "Fixed Asset"."Responsible Employee" := "Send To";
                                                    "Fixed Asset".MODIFY;
                                                END ELSE
                                                    ERROR('Given Fixed Asset not Under CS Control');
                                            END
                                        END;
                                    END;
                                end;
                            }
                        }
                    }
                    grid(Control1102152029)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group("Fixed Asset3")
                        {
                            field(FA3; FA3)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(Ac3; Ac3)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;

                                trigger OnValidate()
                                begin
                                    //Rev01
                                    IF Ac3 THEN BEGIN
                                        IF "Send To" = '' THEN
                                            ERROR('Please Enter the Send To Person Code ')
                                        ELSE BEGIN
                                            "Fixed Asset".RESET;
                                            "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA3);
                                            IF "Fixed Asset".FIND('-') THEN BEGIN
                                                IF "Fixed Asset"."Responsible Employee" = '99ST005' THEN BEGIN

                                                    "Fixed Asset".VALIDATE("Fixed Asset"."Responsible Employee", "Send To");
                                                    "Fixed Asset"."Responsible Employee" := "Send To";
                                                    "Fixed Asset".MODIFY;
                                                END ELSE
                                                    ERROR('Given Fixed Asset not Under CS Control');
                                            END
                                        END;
                                    END;
                                end;
                            }
                        }
                    }
                    grid(Control1102152030)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group("Fixed Asset4")
                        {
                            field(FA4; FA4)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(Ac4; Ac4)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;

                                trigger OnValidate()
                                begin
                                    //Rev01
                                    IF Ac4 THEN BEGIN
                                        IF "Send To" = '' THEN
                                            ERROR('Please Enter the Send To Person Code ')
                                        ELSE BEGIN
                                            "Fixed Asset".RESET;
                                            "Fixed Asset".SETRANGE("Fixed Asset"."No.", FA4);
                                            IF "Fixed Asset".FIND('-') THEN BEGIN
                                                IF "Fixed Asset"."Responsible Employee" = '99ST005' THEN BEGIN

                                                    "Fixed Asset".VALIDATE("Fixed Asset"."Responsible Employee", "Send To");
                                                    "Fixed Asset"."Responsible Employee" := "Send To";
                                                    "Fixed Asset".MODIFY;
                                                END ELSE
                                                    ERROR('Given Fixed Asset not Under CS Control');
                                            END
                                        END;
                                    END;
                                end;
                            }
                        }
                    }
                    label(Accessories)
                    {
                        Caption = 'Accessories';
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    grid(Control1102152038)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item1)
                        {
                            field(MiscItem1; MiscItem1)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_1; MQTY_1)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152042)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item2)
                        {
                            field(MiscItem2; MiscItem2)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_2; MQTY_2)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152046)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item3)
                        {
                            field(MiscItem3; MiscItem3)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_3; MQTY_3)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152050)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item4)
                        {
                            field(MiscItem4; MiscItem4)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_4; MQTY_4)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152054)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item5)
                        {
                            field(MiscItem5; MiscItem5)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_5; MQTY_5)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152058)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item6)
                        {
                            field(MiscItem6; MiscItem6)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_6; MQTY_6)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152062)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item7)
                        {
                            field(MiscItem7; MiscItem7)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_7; MQTY_7)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152066)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item8)
                        {
                            field(MiscItem8; MiscItem8)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_8; MQTY_8)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152070)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item9)
                        {
                            field(MiscItem9; MiscItem9)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_9; MQTY_9)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152074)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Item10)
                        {
                            field(MiscItem10; MiscItem10)
                            {
                                ColumnSpan = 2;
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field(MQTY_10; MQTY_10)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
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
        //Added by Pranavi on 31-Dec-2015 to solve empty DC generation problem
        DCLINE2.RESET;
        DCLINE2.SETRANGE(DCLINE2."Document No.", "Outward No.");
        IF NOT DCLINE2.FINDFIRST THEN BEGIN
            ILECheck.RESET;
            ILECheck.SETCURRENTKEY(ILECheck."Location Code", ILECheck."Posting Date", ILECheck."Item No.");
            ILECheck.SETFILTER(ILECheck."Entry Type", '%1', ILECheck."Entry Type"::Transfer);
            ILECheck.SETFILTER(ILECheck."Global Dimension 2 Code", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
            IF FORMAT("Item Ledger Entry"."Posting Date") <> '' THEN
                ILECheck.SETFILTER(ILECheck."Posting Date", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Posting Date"));
            IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Document No.") <> '' THEN
                ILECheck.SETFILTER(ILECheck."Document No.", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Document No."));
            ILECheck.SETFILTER(ILECheck."Location Code", '%1', 'SITE');
            ILECheck.SETFILTER(ILECheck."Remaining Quantity", '>%1', 0);
            ILECheck.SETFILTER(ILECheck."DC Check", '%1', TRUE);
            IF ILECheck.FINDSET THEN
                REPEAT
                    ILECheck."DC Check" := FALSE;
                    ILECheck.MODIFY;
                UNTIL ILECheck.NEXT = 0;
        END;
        //End by Pranavi
    end;

    trigger OnPreReport()
    begin
        "company information".GET;

        IF (FORMAT("Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code")) = 'LED-GEN') AND (SendToLoc = SendToLoc::Site) THEN BEGIN
            IF Site = '' THEN
                ERROR('Please select the Site!\As you selected Send To Loc = Site and location is LED-GEN!');
        END;

        User.RESET;
        User.SETRANGE(User."User ID", "Send To");
        IF User.FIND('-') THEN BEGIN
            Handovered_Person := UserRec."Full Name";
            Handovered_person_id := User.EmployeeID;
            //Handovered_Person_mob_no:= sqlintegratation_codeunit.tams_employee_details(Handovered_person_id);
            /*//OracleUpg
            IF ISCLEAR(SQLConnection) THEN
                CREATE(SQLConnection, FALSE, TRUE);

            IF ISCLEAR(RecordSet) THEN
                CREATE(RecordSet, FALSE, TRUE);*///OracleUpg

            //Commented by Vishnu Priya For testing Purpose
            /*OracleUpg
            IF ConnectionOpen <> 1 THEN BEGIN
                SQLConnection.ConnectionString := 'DSN=TAMS;UID=tams;PASSWORD=firewall123;SERVER=oracle_80;';
                SQLConnection.Open;
                ConnectionOpen := 1;
            END;

            SQLQuery := 'SELECT EMP_NO, GENERALNAME, CELLNO, AUTHID_NO, INCHARGE_NAME, IN_CELLNO, IN_E_MAIL FROM SITE_ENGG_DC WHERE EMP_NO = ''' + Handovered_person_id + '''';
            //MESSAGE(SQLQuery);
            RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
            IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                RecordSet.MoveFirst;

            WHILE NOT RecordSet.EOF DO BEGIN
                EVALUATE(Handovered_Person_mob_no, FORMAT(RecordSet.Fields.Item('CELLNO').Value));
                EVALUATE(incharge_name, FORMAT(RecordSet.Fields.Item('INCHARGE_NAME').Value));
                EVALUATE(incharge_no, FORMAT(RecordSet.Fields.Item('IN_CELLNO').Value));
                EVALUATE(incharge_id_no, FORMAT(RecordSet.Fields.Item('AUTHID_NO').Value));


                //MESSAGE(mobno);

                RecordSet.MoveNext;
            END;
            SQLConnection.Close;
            ConnectionOpen := 0;*///OracleUpg

            /* EVALUATE(Handovered_Person_mob_no,FORMAT('7036664684'));
                        EVALUATE(incharge_name,FORMAT('N V VARA PRASAD RAVVA'));
                        EVALUATE(incharge_no,FORMAT('9849252233'));
                        EVALUATE(incharge_id_no,FORMAT('20P1001'));*/
            //Commented by Vishnu Priya For testing Purpose
        END;
        //if  FORMAT("Mode Of Transport")<>'Train' THEN
        //Begin
        IF NOT (FORMAT("Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code")) IN ['', 'LED-GEN']) THEN BEGIN
            IF DivGRec.GET(FORMAT("Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"))) THEN
                IF ZoneGRec.GET(DivGRec.Code) THEN
                    AMC_Loc := ZoneGRec.Description + '(' + DivGRec."Division Name" + ')'
                ELSE
                    AMC_Loc := DivGRec."Division Name";
        END;
        ILEGVar.RESET;
        ILEGVar.SETCURRENTKEY(ILEGVar."Location Code", ILEGVar."Posting Date", ILEGVar."Item No.");
        //ILEGVar.COPYFILTERS("Item Ledger Entry");
        ILEGVar.SETFILTER(ILEGVar."Entry Type", '%1', ILEGVar."Entry Type"::Transfer);
        ILEGVar.SETFILTER(ILEGVar."Global Dimension 2 Code", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
        IF FORMAT("Item Ledger Entry".GETFILTER("Item Ledger Entry"."Posting Date")) <> '' THEN
            ILEGVar.SETFILTER(ILEGVar."Posting Date", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Posting Date"));
        IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Document No.") <> '' THEN
            ILEGVar.SETFILTER(ILEGVar."Document No.", "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Document No."));
        ILEGVar.SETFILTER(ILEGVar."Location Code", '%1', 'SITE');
        ILEGVar.SETFILTER(ILEGVar."Remaining Quantity", '>%1', 0);
        IF ILEGVar.FINDFIRST THEN BEGIN
            PostedMatIssHdr.RESET;
            IF PostedMatIssHdr.GET(ILEGVar."Document No.") THEN
                CustrNo := PostedMatIssHdr."Customer No";
        END;
        "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
        IF (FORMAT("Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code")) = 'LED-GEN') AND (SendToLoc = SendToLoc::Site) AND (Site <> '') THEN
            "Dimension Value".SETRANGE("Dimension Value".Code, Site)
        ELSE
            "Dimension Value".SETRANGE("Dimension Value".Code, "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
        IF "Dimension Value".FIND('-') THEN BEGIN
            IF ("Dimension Value".Code = 'LED-GEN') AND (SendToLoc = SendToLoc::Customer) THEN BEGIN
                IF CustGRec.GET(CustrNo) THEN BEGIN
                    IF FORMAT("Mode Of Transport") <> 'By Hand' THEN BEGIN
                        DC_DATA := '                 This is to certify that the below mentioned material is being  Sent to Our ' + FORMAT(Role) + ' ' + FORMAT(Gender) +
                                   ' ' + Handovered_Person + ' for ' + FORMAT(Purpose) + ' Purpose by ' + FORMAT("Mode Of Transport") +
                                   ' which are covered under the maintainence contract as mentioned below, ';
                    END ELSE BEGIN
                        DC_DATA := '                 This is to certify that the below mentioned material is being  Sent with Our ' + FORMAT(Role) + ' ' + FORMAT(Gender) +
                                   ' ' + Handovered_Person + ' for ' + FORMAT(Purpose) + ' Purpose by ' + FORMAT("Mode Of Transport") +
                                   ' which are covered under the maintainence contract as mentioned below, ';
                    END;
                    DC_DATA2 := 'Address: ' + CustGRec.Name + ' ' + CustGRec.Address + ', ' + FORMAT(CustGRec.City) + ', ' + FORMAT(CustGRec."Post Code") + '   Site Person Ph: ' + Handovered_Person_mob_no;
                END;
            END
            ELSE BEGIN
                IF FORMAT("Mode Of Transport") <> 'By Hand' THEN BEGIN
                    DC_DATA := '                 This is to certify that the below mentioned material is being  Sent to  Our ' + FORMAT(Role) + ' ' + FORMAT(Gender) +
                               ' ' + Handovered_Person + ' for ' + FORMAT(Purpose) + ' Purpose by ' + FORMAT("Mode Of Transport") +
                               ' which are covered under the maintainence contract as mentioned below, ';
                    DC_DATA2 := 'Address: ' + "Dimension Value".Address1 + '  Site Person Ph:' + Handovered_Person_mob_no;
                END ELSE BEGIN
                    DC_DATA := '                 This is to certify that the below mentioned material is being  Sent with Our ' + FORMAT(Role) + ' ' + FORMAT(Gender) +
                               ' ' + Handovered_Person + ' for ' + FORMAT(Purpose) + ' Purpose by ' + FORMAT("Mode Of Transport") +
                               ' which are covered under the maintainence contract as mentioned below, ';
                    DC_DATA2 := 'Address: ' + "Dimension Value".Name + '  Site Person Ph:' + Handovered_Person_mob_no;
                END;
            END;
            DC_DATA1 := 'AMC order no - ' + AMC_Orders + ' ' + AMC_Loc;
            DC_DATA3 := '  The movement of goods covered under Maintainence contract is exempt from tax vide circular No.     ' +
                        '1/1/2017-IGST Dt: 7/7/2017 as per the GST Act and the said circular is attached herewith.';
        END;
        //end;
        conformation := FALSE;
        flag := FALSE;

    end;

    var
        UserRec: Record User;
        CompanyAddr: array[8] of Text[50];
        "Sl No.": Integer;
        Zone: Text[100];
        Station: Text[100];
        Handovered_person_id: Text[7];
        Handovered_Person_mob_no: Text[30];
        Handovered_Person: Text[100];
        User: Record "User Setup";
        Location: Record "Dimension Value";
        "Outward No.": Code[30];
        Month: Code[5];
        "Final No.": Integer;
        Start_Date: Date;
        "Final Date": Date;
        Days_Of_Month: Integer;
        "Shipped Date": Text[30];
        "Total No. Of Items": Integer;
        "Ser_No's": Text;
        "Service Address": Text[1000];
        Serv_Add1: Text[80];
        Serv_Add2: Text[80];
        "pOSTED MATERIAL ISSUE HEADER": Record "Posted Material Issues Header";
        "Mode Of Transport": Option Courier,Train,Bus,"By Hand",VRL,Lorry,ANL;
        "Hand Overed To": Code[30];
        "Transport Service Name": Text[50];
        "Transport Service Person Name": Text[50];
        "Authorised By": Code[50];
        Purpose: Option AMC,Waranty,Replacement,Maintainence,"R&D Testing",Demo,Installation;
        "Final Outward No.": Integer;
        Item: Record Item;
        "company information": Record "Company Information";
        "Material Issues Header": Record "Material Issues Header";
        Data_Verification: Boolean;
        Item_Desc: Text[50];
        DC_DATA: Text;
        DC_DATA1: Text;
        DC_DATA2: Text;
        DC_DATA3: Text;
        Item_Data: Text;
        "DC No.": Code[20];
        "Send To": Code[50];
        Material_Request: array[10] of Code[15];
        Requests_Data: Text[150];
        Requests: array[10] of Text[30];
        "Request_No.": Text[15];
        Request_Count: Integer;
        i: Integer;
        FA1: Code[50];
        FA2: Code[50];
        FA3: Code[50];
        FA4: Code[50];
        "Fixed Asset": Record "Fixed Asset";
        Ac1: Boolean;
        Ac2: Boolean;
        Ac3: Boolean;
        Ac4: Boolean;
        MiscItem1: Text[50];
        MiscItem2: Text[50];
        MiscItem3: Text[50];
        MiscItem4: Text[50];
        MiscItem5: Text[50];
        MiscItem6: Text[50];
        MiscItem7: Text[50];
        MiscItem8: Text[50];
        MiscItem9: Text[50];
        MiscItem10: Text[50];
        MQTY_1: Integer;
        MQTY_2: Integer;
        MQTY_3: Integer;
        MQTY_4: Integer;
        MQTY_5: Integer;
        MQTY_6: Integer;
        MQTY_7: Integer;
        MQTY_8: Integer;
        MQTY_9: Integer;
        MQTY_10: Integer;
        Print: Boolean;
        SM: Record "Service Mgt. Setup";
        p1: Boolean;
        p2: Boolean;
        p3: Boolean;
        Role: Option "Service Engineer","R&D Engineer",Manager,"Project Manager","Sys Admin";
        "Dimension Value": Record "Dimension Value";
        Gender: Option "Mr.",Miss;
        PostedMaterialIssuesLine: Record "Posted Material Issues Line";
        DC_HEADER: Record "DC Header";
        DC_LINE: Record "DC Line";
        Text001: Label 'Exit, Remove the Old Record & Insert New One';
        Selection: Integer;
        LINE_NO: Integer;
        Choice: Option Print,PostPrint;
        YearValue: Text[30];
        Type: Text[50];
        Text_Mng: Text[30];
        FAX_CaptionLbl: Label 'FAX:';
        Ph_CaptionLbl: Label 'Ph:';
        E__Mail_CaptionLbl: Label 'E- Mail:';
        To_Provide_Insight_For_Enhancing_WealthCaptionLbl: Label 'To Provide Insight For Enhancing Wealth';
        URL_CaptionLbl: Label 'URL:';
        EmptyStringCaptionLbl: Label '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
        TIN_NO__28350166764CaptionLbl: Label 'TIN NO -37350166764';
        VijayawadaCaptionLbl: Label 'Mangalgiri';
        Place_CaptionLbl: Label 'Place:';
        S_No_CaptionLbl: Label 'S No:';
        TO_WHOM_SO_EVER_IT_MAY_CONCERNCaptionLbl: Label 'TO WHOM SO EVER IT MAY CONCERN';
        FAX_Caption_Control1102154025Lbl: Label 'FAX:';
        Ph_Caption_Control1102154027Lbl: Label 'Ph:';
        E__Mail_Caption_Control1102154028Lbl: Label 'E- Mail:';
        To_Provide_Insight_For_Enhancing_WealthCaption_Control1102154030Lbl: Label 'To Provide Insight For Enhancing Wealth';
        URL_Caption_Control1102154031Lbl: Label 'URL:';
        EmptyStringCaption_Control1102154037Lbl: Label '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
        TIN_NO__28350166764Caption_Control1102154061Lbl: Label 'TIN NO -37350166764';
        VijayawadaCaption_Control1102154038Lbl: Label 'Mangalgiri';
        Place_Caption_Control1102154040Lbl: Label 'Place:';
        S_No_Caption_Control1102154041Lbl: Label 'S No:';
        TO_WHOM_SO_EVER_IT_MAY_CONCERNCaption_Control1102154043Lbl: Label 'TO WHOM SO EVER IT MAY CONCERN';
        attributed__For_Efftronics_systems_Pvt__Ltd_CaptionLbl: Label 'attributed. For Efftronics systems Pvt. Ltd.';
        The_above_is_not_for_sale_hence_no_commercial_value_can_be_CaptionLbl: Label 'The above is not for sale hence no commercial value can be ';
        Customer_SupportCaptionLbl: Label 'Customer Support';
        EmptyStringCaption_Control1000000017Lbl: Label '.............................................................................................................................................................................................................................................';
        DATE_CaptionLbl: Label 'DATE:';
        FOR_OFFICE_USE_ONLYCaptionLbl: Label 'FOR OFFICE USE ONLY';
        This_is_to_certify_that_the_materials_are_dispatched_to___________for_CaptionLbl: Label 'This is to certify that the materials are dispatched to ...............................................for.';
        to___Mr______________CaptionLbl: Label '......................... to   Mr. .......................................................................                      ';
        to___Mr______________by__Mode_of_transport__CaptionLbl: Label ' ......................... to   Mr. ......................................by (Mode of transport).';
        Bearing_D_C__No________CaptionLbl: Label 'Bearing D.C. No .............................';
        Bearing_D_C__No________Dt__________Parcel_takenCaptionLbl: Label '….........................Bearing D.C. No ……………… Dt …………………. Parcel taken';
        By________CaptionLbl: Label ' By ……………….';
        Transport_Service_Name______________CaptionLbl: Label 'Transport Service Name             :';
        Transport_Service_Preson_Name__CaptionLbl: Label 'Transport Service Preson Name :';
        Receptionist_CaptionLbl: Label '(Receptionist)';
        SignatureCaptionLbl: Label 'Signature';
        DC_REPORT__GENERATED_FROM_ERP_____CaptionLbl: Label '                              *** DC REPORT  GENERATED FROM ERP  ***';
        "--REV01": Integer;
        PrevItemNo: Code[20];
        GrouptotalQty: Decimal;
        InsertPrevItemDetails: Code[20];
        ItemNewRec: Record Item;
        InsertPrevDoc: Code[20];
        Grp1: Boolean;
        Grp2: Boolean;
        Grp3: Boolean;
        Grp4: Boolean;
        IntegerDisplay: Boolean;
        IntegerDisplay2: Boolean;
        IntegerDisplay3: Boolean;
        IntegerDisplay4: Boolean;
        IntegerDisplay5: Boolean;
        IntegerDisplay6: Boolean;
        IntegerDisplay7: Boolean;
        IntegerDisplay8: Boolean;
        IntegerDisplay9: Boolean;
        IntegerDisplay10: Boolean;
        IntegerDisplay11: Boolean;
        IntegerDisplay12: Boolean;
        IntegerDisplay13: Boolean;
        IntegerDisplay14: Boolean;
        IntegerDisplay15: Boolean;
        Item_Data4: Text;
        Item_Data5: Text;
        Item_Data6: Text;
        Item_Data7: Text;
        Item_Data8: Text;
        Item_Data9: Text;
        Item_Data10: Text;
        Item_Data11: Text;
        Item_Data12: Text;
        Item_Data13: Text;
        Item_Data14: Text;
        Item_Data15: Text;
        SingleItemQtyDesc: Text[50];
        TempPosition: Integer;
        Item_Data1: Text;
        UserGRec: Record User;
        CTHGRec: Record "CS Transaction Header";
        CTLGRec: Record "CS Transaction Line";
        CTLedgGRec: Record "CS Stock Ledger";
        TransNoGVar: Code[20];
        CTCardGPag: Page "CS Transaction Card";
        StatusGVar: Option Working;
        totCardsGVar: Decimal;
        entryNoGVar: Integer;
        ItemGRec: Record Item;
        PMIL: Record "Posted Material Issues Line";
        reasonGvar: Code[20];
        StatGVar: Code[20];
        PMIH: Record "Posted Material Issues Header";
        ILEGVar: Record "Item Ledger Entry";
        NoSeriesMgt: Codeunit 396;
        noseries: Code[10];
        transID: Code[20];
        hasLines: Boolean;
        //tin: Record 13701;//B2BUpg
        TNo: Text[20];
        CSTNo: Text;
        Type1: Code[50];
        Type2: Code[50];
        ItemCodes: Text;
        ItemCodes1: Text;
        Itm2: Record Item;
        flag: Boolean;
        PMIHNEW: Record "Posted Material Issues Header";
        conformation: Boolean;
        prevDoc: Code[15];
        prevGDC: Code[15];
        PMIHCheck: Record "Posted Material Issues Header";
        ILECheck: Record "Item Ledger Entry";
        outwardnumber: Text;
        ItemsTobeDeleted: Text;
        ItemsTobeDeleted1: Text;
        projectcode: Code[20];
        ILENew1: Record "Item Ledger Entry";
        DCLINE1: Record "DC Line";
        prevdcno: Code[50];
        PrevFrmLoc: Code[20];
        testing: Text;
        ItemUOM: Code[20];
        Test: Code[10];
        DCHeader1: Record "DC Header";
        DCLINE2: Record "DC Line";
        PostedMatIssHdr: Record "Posted Material Issues Header";
        CustrNo: Code[20];
        CustGRec: Record Customer;
        SP: Record "Salesperson/Purchaser";
        AuthNo: Text[50];
        AuthName: Text[100];
        RespPersn: Code[30];
        TempCHLG: Record "CS Stock Ledger";
        Divsn: Record "Employee Statistics Group";
        SendToLoc: Option Customer,Site;
        Site: Code[20];
        DimValGRec: Record "Dimension Value";
        modeOfTransf: Text[50];
        AMC_Orders: Code[65];
        AMCGRec: Record "Sales Header";
        AMCNo: Code[30];
        AMC_Loc: Text;
        DivGRec: Record "Employee Statistics Group";
        ZoneGRec: Record "Cause of Inactivity";
        sqlintegratation_codeunit: Codeunit SQLIntegration;
        /*SQLConnection: Automation;
        RecordSet: Automation;*///OracleUpg
        mobno: Text;
        ConnectionOpen: Integer;
        SQLQuery: Text[1000];
        RowCount: Integer;
        incharge_name: Text[1024];
        incharge_no: Text[30];
        incharge_id_no: Text[7];


    procedure Cards_Calc(Item: Code[20]; Status: Option ,Working,"Non Working") res: Decimal
    var
        CsLedgerLRec: Record "CS Stock Ledger";
    begin

        totCardsGVar := 0;
        CsLedgerLRec.RESET;
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Location, 'H-OFF');
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Item No", Item);
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Received, '%1', TRUE);
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Card Status", '%1', Status);
        IF CsLedgerLRec.FINDFIRST THEN
            REPEAT
                totCardsGVar := totCardsGVar + CsLedgerLRec.Quantity;
            UNTIL CsLedgerLRec.NEXT = 0;

        CsLedgerLRec.RESET;
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Location, 'H-OFF');
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Item No", Item);
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Received, '%1', FALSE);
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Card Status", '%1', Status);
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Quantity, '<0');
        IF CsLedgerLRec.FINDFIRST THEN
            REPEAT
                totCardsGVar := totCardsGVar + CsLedgerLRec.Quantity;
            UNTIL CsLedgerLRec.NEXT = 0;

        //ILEGVar.SETFILTER();
        // ILE
        res := totCardsGVar;
    end;


    procedure CstransEntry()
    var
        CSLGE: Record "CS Stock Ledger";
        NeededQty: Decimal;
        DateVar: Date;
        DCHead: Record "DC Header";
        DCLn: Record "DC Line";
    begin
        //ItemGRec.RESET;
        Type1 := '';
        Type2 := '';
        IF ItemGRec.GET(PrevItemNo) AND (PrevFrmLoc = 'CS') THEN
          //IF (ItemGRec."CS IGC"<>'') AND (ItemGRec."CS IGC"<>'SHOULD NOT COME IN STOCK') THEN   //commented by pranavi on 25-07-2015 15:25 PM
          BEGIN
            IF hasLines = FALSE THEN BEGIN
                PostedMatIssHdr.RESET;
                IF PostedMatIssHdr.GET("Item Ledger Entry"."Document No.") THEN BEGIN
                    CustrNo := PostedMatIssHdr."Customer No";
                    TempCHLG.RESET;
                    TempCHLG.SETRANGE(TempCHLG."Transaction ID", PostedMatIssHdr."Transaction ID");
                    IF TempCHLG.FINDFIRST THEN
                        RespPersn := TempCHLG."Responsible Persion";
                END;
                IF RespPersn = '' THEN BEGIN
                    IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code") = 'LED-GEN' THEN BEGIN
                        //          RespPersn:="Authorised By";
                        RespPersn := incharge_id_no;
                    END
                    ELSE BEGIN
                        Divsn.RESET;
                        Divsn.SETRANGE(Divsn.Code, "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
                        IF Divsn.FINDFIRST THEN BEGIN
                            User.RESET;
                            User.SETRANGE(User.EmployeeID, Divsn."Project Manager");
                            IF User.FINDFIRST THEN
                                RespPersn := UserRec."User Name";
                        END;
                    END;
                END;
                noseries := 'CS TRANS';
                NoSeriesMgt.InitSeries('CS TRANS', 'CS TRANS', TODAY, TransNoGVar, noseries);


                CTHGRec.INIT;
                CTHGRec."Transaction ID" := TransNoGVar;
                IF Type = 'Non-Returnable' THEN
                    CTHGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer"
                ELSE
                    CTHGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";

                CTHGRec."Transfer From Location" := 'H-OFF';
                CTHGRec."Transfer To Location" := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                CTHGRec."Mode of Transport" := "Mode Of Transport";
                CTHGRec."Courier Details" := ' ';
                CTHGRec."Transaction Status" := CTHGRec."Transaction Status"::"In-Transit";
                CTHGRec.Status := CTHGRec.Status::Open;
                CTHGRec."Posting Date" := TODAY;
                CTHGRec."User ID" := USERID;
                CTHGRec."Created Date" := TODAY;
                CTHGRec.Remarks := FORMAT(Purpose);
                CTHGRec."DC No" := "Outward No.";
                CTHGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                CTHGRec.VALIDATE("Customer No");
                CTHGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                CTHGRec.INSERT;
                hasLines := TRUE;
            END;


            //site stock transaction entry. Added by mnraju on 20-Mar-2014

            //   totCardsGVar:=Cards_Calc(PrevItemNo,StatusGVar::Working);
            //   IF totCardsGVar< GrouptotalQty THEN
            //      ERROR('Quantity for Item %1 Status %2 must be equal or less than %3',PrevItemNo,StatusGVar::Working,FORMAT(totCardsGVar));
            //   MESSAGE('line');
            //EFFUPG1.0>>
            /*
            IF USERID = 'EFFTRONICS\PRANAVI' THEN
              EVALUATE(DateVar,'21-07-15')
            ELSE
              EVALUATE(DateVar,'7/21/15');
            */
            DateVar := DMY2DATE(21, 7, 2015);
            //EFFUPG1.0<<
            NeededQty := 0;
            ItemCodes := '';
            ItemCodes1 := '';
            Itm2.RESET;
            IF ItemGRec."CS IGC" <> '' THEN                  //Added by Pranavi on 25-07-2015
                Itm2.SETFILTER(Itm2."CS IGC", ItemGRec."CS IGC")
            ELSE
                Itm2.SETFILTER(Itm2."No.", ItemGRec."No.");
            IF Itm2.FINDSET THEN
                REPEAT
                    ItemCodes := ItemCodes + Itm2."No." + '|';
                UNTIL Itm2.NEXT = 0;
            IF ItemCodes <> '' THEN
                ItemCodes1 := COPYSTR(ItemCodes, 1, STRLEN(ItemCodes) - 1);
            //MESSAGE(ItemCodes+'\'+ItemCodes1);
            //MESSAGE(ItemCodes1);
            CSLGE.RESET;
            CSLGE.SETFILTER(CSLGE."Posting Date", '>=%1', DateVar);
            CSLGE.SETFILTER(CSLGE.Location, "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code"));
            IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code") = 'LED-GEN' THEN
                CSLGE.SETFILTER(CSLGE."Customer No", CustrNo);
            CSLGE.SETFILTER(CSLGE."Transaction Type", '%1', CSLGE."Transaction Type"::"Custmer card Transfer");
            CSLGE.SETFILTER(CSLGE."Item No", '<>%1', '');
            //CSLGE.SETFILTER(CSLGE.NonReturnable,'%1',TRUE);
            CSLGE.SETFILTER(CSLGE."Item No", ItemCodes1);
            //testing := '';
            IF CSLGE.FINDSET THEN
                REPEAT
                    //testing:=testing+CSLGE."Item No"+',';
                    NeededQty := NeededQty + CSLGE.Quantity;
                UNTIL CSLGE.NEXT = 0;
            //MESSAGE(testing);
            IF NeededQty < 0 THEN BEGIN
                IF GrouptotalQty <= -NeededQty THEN BEGIN
                    CTLGRec.INIT;
                    CTLGRec."Transaction ID" := TransNoGVar;
                    CTLGRec."Line No." := LINE_NO;
                    CTLGRec."Item No." := PrevItemNo;
                    CTLGRec.VALIDATE("Item No.");
                    CTLGRec.Quantity := GrouptotalQty;
                    CTLGRec.Status := CTLGRec.Status::Working;
                    CTLGRec.Reason := reasonGvar;
                    CTLGRec.Station := StatGVar;
                    /*   IF Type='Non-Returnable' THEN */
                    CTLGRec.NonReturnable := TRUE;
                    // CTLGRec."Order No":=
                    CTLGRec.INSERT;
                    DC_LINE.INIT;
                    DC_LINE."Document No." := "Outward No.";
                    DC_LINE."Line No." := LINE_NO;
                    DC_LINE.Type := DC_LINE.Type::Item;
                    DC_LINE."No." := PrevItemNo;
                    DC_LINE.VALIDATE(DC_LINE."No.");
                    DC_LINE.Quantity := GrouptotalQty;
                    DC_LINE."Non-Returnable" := TRUE;
                    DC_LINE.INSERT;
                    Type1 := 'Non-Returnable--' + FORMAT(GrouptotalQty);
                END   // End_of_GrouptotalQty <= -NeededQty
                ELSE BEGIN
                    CTLGRec.INIT;
                    CTLGRec."Transaction ID" := TransNoGVar;
                    CTLGRec."Line No." := LINE_NO;
                    CTLGRec."Item No." := PrevItemNo;
                    CTLGRec.VALIDATE("Item No.");
                    CTLGRec.Quantity := -NeededQty;
                    CTLGRec.Status := CTLGRec.Status::Working;
                    CTLGRec.Reason := reasonGvar;
                    CTLGRec.Station := StatGVar;
                    /*   IF Type='Non-Returnable' THEN */
                    CTLGRec.NonReturnable := TRUE;
                    // CTLGRec."Order No":=
                    CTLGRec.INSERT;
                    CTLGRec.INIT;
                    CTLGRec."Transaction ID" := TransNoGVar;
                    CTLGRec."Line No." := LINE_NO + 10000;
                    CTLGRec."Item No." := PrevItemNo;
                    CTLGRec.VALIDATE("Item No.");
                    CTLGRec.Quantity := GrouptotalQty + NeededQty;
                    CTLGRec.Status := CTLGRec.Status::Working;
                    CTLGRec.Reason := reasonGvar;
                    CTLGRec.Station := StatGVar;
                    /*   IF Type='Non-Returnable' THEN */
                    CTLGRec.NonReturnable := FALSE;
                    // CTLGRec."Order No":=
                    CTLGRec.INSERT;
                    DC_LINE.INIT;
                    DC_LINE."Document No." := "Outward No.";
                    DC_LINE."Line No." := LINE_NO;
                    DC_LINE.Type := DC_LINE.Type::Item;
                    DC_LINE."No." := PrevItemNo;
                    DC_LINE.VALIDATE(DC_LINE."No.");
                    DC_LINE.Quantity := -NeededQty;
                    DC_LINE."Non-Returnable" := TRUE;
                    DC_LINE.INSERT;
                    DC_LINE.INIT;
                    DC_LINE."Document No." := "Outward No.";
                    DC_LINE."Line No." := LINE_NO + 10000;
                    DC_LINE.Type := DC_LINE.Type::Item;
                    DC_LINE."No." := PrevItemNo;
                    DC_LINE.VALIDATE(DC_LINE."No.");
                    DC_LINE.Quantity := GrouptotalQty + NeededQty;
                    DC_LINE."Non-Returnable" := FALSE;
                    DC_LINE.INSERT;
                    Type1 := 'Non-Returnable--' + FORMAT(-NeededQty);
                    Type2 := ', Returnable--' + FORMAT(GrouptotalQty + NeededQty);

                    CTHGRec.RESET;
                    CTHGRec.SETFILTER(CTHGRec."Transaction ID", '%1', TransNoGVar);
                    IF CTHGRec.FINDFIRST THEN BEGIN
                        CTHGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";
                        CTHGRec.MODIFY;
                    END;

                END;
                CTLedgGRec.LOCKTABLE;

                // REC1
                // MESSAGE('ledger');
                CTLedgGRec.RESET;
                CTLedgGRec.SETCURRENTKEY(CTLedgGRec."Entry No.");
                IF CTLedgGRec.FINDLAST THEN BEGIN
                    entryNoGVar := CTLedgGRec."Entry No.";
                END;
                // MESSAGE(FORMAT(entryNoGVar));
                IF GrouptotalQty <= -NeededQty THEN BEGIN
                    CTLedgGRec.INIT;
                    CTLedgGRec."Entry No." := entryNoGVar + 1;
                    CTLedgGRec."Posted By" := USERID;
                    CTLedgGRec."Posting Date" := TODAY;
                    CTLedgGRec.Received := FALSE;
                    CTLedgGRec.Quantity := -GrouptotalQty;
                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer";

                    CTLedgGRec.Location := 'H-OFF';
                    CTLedgGRec."User ID" := USERID;
                    CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                    CTLedgGRec."Courier Details" := ' ';
                    CTLedgGRec.Remarks := FORMAT(Purpose);
                    CTLedgGRec."Line No." := LINE_NO;
                    CTLedgGRec."Item No" := PrevItemNo;
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                    CTLedgGRec."DC No" := "Outward No.";
                    CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                    CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                    CTLedgGRec.NonReturnable := TRUE;


                    CTLedgGRec.INSERT;

                    //REC2
                    entryNoGVar := entryNoGVar + 2;
                    CTLedgGRec.INIT;
                    CTLedgGRec."Entry No." := entryNoGVar;
                    CTLedgGRec."Posted By" := USERID;
                    CTLedgGRec."Posting Date" := TODAY;
                    CTLedgGRec.Received := FALSE;
                    CTLedgGRec.Location := "Item Ledger Entry"."Global Dimension 2 Code";
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                    CTLedgGRec.Quantity := GrouptotalQty;
                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer";
                    CTLedgGRec."User ID" := USERID;
                    CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                    CTLedgGRec."Courier Details" := ' ';
                    CTLedgGRec.Remarks := FORMAT(Purpose);
                    CTLedgGRec."Line No." := LINE_NO;
                    CTLedgGRec."Item No" := PrevItemNo;
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."DC No" := "Outward No.";
                    CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                    CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                    CTLedgGRec.NonReturnable := TRUE;

                    CTLedgGRec.INSERT;
                    //end of mnraju
                END
                ELSE BEGIN
                    CTLedgGRec.INIT;
                    CTLedgGRec."Entry No." := entryNoGVar + 1;
                    CTLedgGRec."Posted By" := USERID;
                    CTLedgGRec."Posting Date" := TODAY;
                    CTLedgGRec.Received := FALSE;
                    CTLedgGRec.Quantity := NeededQty;
                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer";
                    CTLedgGRec.Location := 'H-OFF';
                    CTLedgGRec."User ID" := USERID;
                    CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                    CTLedgGRec."Courier Details" := ' ';
                    CTLedgGRec.Remarks := FORMAT(Purpose);
                    CTLedgGRec."Line No." := LINE_NO;
                    CTLedgGRec."Item No" := PrevItemNo;
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                    CTLedgGRec."DC No" := "Outward No.";
                    CTLedgGRec.NonReturnable := TRUE;
                    CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                    CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                    CTLedgGRec.INSERT;

                    //REC2
                    entryNoGVar := entryNoGVar + 2;
                    CTLedgGRec.INIT;
                    CTLedgGRec."Entry No." := entryNoGVar;
                    CTLedgGRec."Posted By" := USERID;
                    CTLedgGRec."Posting Date" := TODAY;
                    CTLedgGRec.Received := FALSE;
                    CTLedgGRec.Location := "Item Ledger Entry"."Global Dimension 2 Code";
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                    CTLedgGRec.Quantity := -NeededQty;
                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer";
                    CTLedgGRec."User ID" := USERID;
                    CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                    CTLedgGRec."Courier Details" := ' ';
                    CTLedgGRec.Remarks := FORMAT(Purpose);
                    CTLedgGRec."Line No." := LINE_NO;
                    CTLedgGRec."Item No" := PrevItemNo;
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."DC No" := "Outward No.";
                    CTLedgGRec.NonReturnable := TRUE;
                    CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                    CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                    CTLedgGRec.INSERT;
                    //end of mnraju
                    CTLedgGRec.INIT;
                    CTLedgGRec."Entry No." := entryNoGVar + 1;
                    CTLedgGRec."Posted By" := USERID;
                    CTLedgGRec."Posting Date" := TODAY;
                    CTLedgGRec.Received := FALSE;
                    CTLedgGRec.Quantity := -(GrouptotalQty + NeededQty);
                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";
                    CTLedgGRec.Location := 'H-OFF';
                    CTLedgGRec."User ID" := USERID;
                    CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                    CTLedgGRec."Courier Details" := ' ';
                    CTLedgGRec.Remarks := FORMAT(Purpose);
                    CTLedgGRec."Line No." := LINE_NO + 10000;
                    CTLedgGRec."Item No" := PrevItemNo;
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                    CTLedgGRec."DC No" := "Outward No.";
                    CTLedgGRec.NonReturnable := FALSE;
                    CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                    CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                    CTLedgGRec.INSERT;

                    //REC2
                    entryNoGVar := entryNoGVar + 2;
                    CTLedgGRec.INIT;
                    CTLedgGRec."Entry No." := entryNoGVar;
                    CTLedgGRec."Posted By" := USERID;
                    CTLedgGRec."Posting Date" := TODAY;
                    CTLedgGRec.Received := FALSE;
                    CTLedgGRec.Location := "Item Ledger Entry"."Global Dimension 2 Code";
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                    CTLedgGRec.Quantity := (GrouptotalQty + NeededQty);
                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";
                    CTLedgGRec."User ID" := USERID;
                    CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                    CTLedgGRec."Courier Details" := ' ';
                    CTLedgGRec.Remarks := FORMAT(Purpose);
                    CTLedgGRec."Line No." := LINE_NO + 10000;
                    CTLedgGRec."Item No" := PrevItemNo;
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."DC No" := "Outward No.";
                    CTLedgGRec.NonReturnable := FALSE;
                    CTLedgGRec.INSERT;
                    CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                    CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                    LINE_NO := LINE_NO + 10000; //pranavi1
                                                //end of mnraju
                END;
            END  //End_of_IF_NeedQty<0
            ELSE BEGIN
                CTLGRec.INIT;
                CTLGRec."Transaction ID" := TransNoGVar;
                CTLGRec."Line No." := LINE_NO;
                CTLGRec."Item No." := PrevItemNo;
                CTLGRec.VALIDATE("Item No.");
                CTLGRec.Quantity := GrouptotalQty;
                CTLGRec.Status := CTLGRec.Status::Working;
                CTLGRec.Reason := reasonGvar;
                CTLGRec.Station := StatGVar;
                /*IF Type='Non-Returnable' THEN
                   CTLGRec.NonReturnable:=TRUE; */
                IF reasonGvar = 'INSTALLA' THEN
                    CTLGRec.NonReturnable := TRUE
                ELSE
                    CTLGRec.NonReturnable := FALSE;
                //   CTLGRec."Order No":=
                CTLGRec.INSERT;
                DC_LINE.INIT;
                DC_LINE."Document No." := "Outward No.";
                DC_LINE."Line No." := LINE_NO;
                DC_LINE.Type := DC_LINE.Type::Item;
                DC_LINE."No." := PrevItemNo;
                DC_LINE.VALIDATE(DC_LINE."No.");
                DC_LINE.Quantity := GrouptotalQty;
                IF reasonGvar = 'INSTALLA' THEN BEGIN
                    DC_LINE."Non-Returnable" := TRUE;
                    Type1 := 'Non-Returnable--' + FORMAT(GrouptotalQty);
                END
                ELSE BEGIN
                    DC_LINE."Non-Returnable" := FALSE;
                    Type1 := 'Returnable--' + FORMAT(GrouptotalQty);
                END;
                DC_LINE.INSERT;
                CTHGRec.RESET;
                CTHGRec.SETFILTER(CTHGRec."Transaction ID", '%1', TransNoGVar);
                IF CTHGRec.FINDFIRST THEN BEGIN
                    CTHGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";
                    CTHGRec.MODIFY;
                END;
                CTLedgGRec.LOCKTABLE;

                //REC1
                // MESSAGE('ledger');
                CTLedgGRec.RESET;
                CTLedgGRec.SETCURRENTKEY(CTLedgGRec."Entry No.");
                IF CTLedgGRec.FINDLAST THEN BEGIN
                    entryNoGVar := CTLedgGRec."Entry No.";
                END;
                // MESSAGE(FORMAT(entryNoGVar));

                CTLedgGRec.INIT;
                CTLedgGRec."Entry No." := entryNoGVar + 1;
                CTLedgGRec."Posted By" := USERID;
                CTLedgGRec."Posting Date" := TODAY;
                CTLedgGRec.Received := FALSE;
                CTLedgGRec.Quantity := -GrouptotalQty;

                CTLedgGRec."Transaction ID" := TransNoGVar;
                /*  IF Type='Non-Returnable' THEN
                    CTLedgGRec."Transaction Type":=CTHGRec."Transaction Type"::"Customer card Transfer"
                  ELSE  */
                CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";

                CTLedgGRec.Location := 'H-OFF';
                CTLedgGRec."User ID" := USERID;
                CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                CTLedgGRec."Courier Details" := ' ';
                CTLedgGRec.Remarks := FORMAT(Purpose);
                CTLedgGRec."Line No." := LINE_NO;
                CTLedgGRec."Item No" := PrevItemNo;
                CTLedgGRec.Reason := reasonGvar;
                CTLedgGRec.Station := StatGVar;
                CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                CTLedgGRec."DC No" := "Outward No.";
                /*  IF Type='Non-Returnable' THEN
                    CTLedgGRec.NonReturnable:=TRUE;  */
                CTLedgGRec.NonReturnable := FALSE;

                CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led lights process
                CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                CTLedgGRec.INSERT;

                //REC2
                entryNoGVar := entryNoGVar + 2;
                CTLedgGRec.INIT;
                CTLedgGRec."Entry No." := entryNoGVar;
                CTLedgGRec."Posted By" := USERID;
                CTLedgGRec."Posting Date" := TODAY;
                CTLedgGRec.Received := FALSE;
                CTLedgGRec.Location := "Item Ledger Entry"."Global Dimension 2 Code";
                CTLedgGRec."Card Status" := CTLGRec.Status::Working;
                CTLedgGRec.Quantity := GrouptotalQty;

                CTLedgGRec."Transaction ID" := TransNoGVar;
                /*  IF Type='Non-Returnable' THEN
                    CTLedgGRec."Transaction Type":=CTHGRec."Transaction Type"::"Customer card Transfer"
                  ELSE    */
                CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";

                CTLedgGRec."User ID" := USERID;
                CTLedgGRec."Mode of Transport" := "Mode Of Transport";
                CTLedgGRec."Courier Details" := ' ';
                CTLedgGRec.Remarks := FORMAT(Purpose);
                CTLedgGRec."Line No." := LINE_NO;
                CTLedgGRec."Item No" := PrevItemNo;
                CTLedgGRec.Reason := reasonGvar;
                CTLedgGRec.Station := StatGVar;
                CTLedgGRec."DC No" := "Outward No.";
                /*  IF Type='Non-Returnable' THEN
                    CTLedgGRec.NonReturnable:=TRUE;   */
                IF reasonGvar = 'INSTALLA' THEN
                    CTLedgGRec.NonReturnable := TRUE
                ELSE
                    CTLedgGRec.NonReturnable := FALSE;
                CTLedgGRec."Customer No" := CustrNo;   // Added by Pranavi on 28-jan-2016 for led cards process
                CTLedgGRec."Responsible Persion" := RespPersn;   // Added by Pranavi on 29-Jan-2016 for Resp Person Tracking for LED cards process
                CTLedgGRec.INSERT;
                LINE_NO := LINE_NO + 10000;  //pranavi1
                                             //end of mnraju

            END;
        END
        ELSE BEGIN
            DC_LINE.INIT;
            DC_LINE."Document No." := "Outward No.";
            DC_LINE."Line No." := LINE_NO;
            DC_LINE.Type := DC_LINE.Type::Item;
            DC_LINE."No." := PrevItemNo;
            DC_LINE.VALIDATE(DC_LINE."No.");
            DC_LINE.Quantity := GrouptotalQty;
            IF (reasonGvar = 'INSTALLA') OR (projectcode = 'EFF14STA01') THEN BEGIN
                DC_LINE."Non-Returnable" := TRUE;
                Type1 := 'Non-Returnable--' + FORMAT(GrouptotalQty);
            END
            ELSE BEGIN
                DC_LINE."Non-Returnable" := FALSE;
                Type1 := 'Returnable--' + FORMAT(GrouptotalQty);
            END;
            DC_LINE.INSERT;
            // Type1:='Returnable--'+FORMAT(GrouptotalQty);
        END;
        ILENew1.RESET;
        ILENew1.SETCURRENTKEY(ILENew1."Location Code", ILENew1."Posting Date", ILENew1."Item No.");
        ILENew1.SETFILTER(ILENew1."Entry Type", '%1', ILENew1."Entry Type"::Transfer);
        ILENew1.SETFILTER(ILENew1."Item No.", PrevItemNo);
        ILENew1.SETFILTER(ILENew1."Posting Date", '%1', "Item Ledger Entry"."Posting Date");
        ILENew1.SETFILTER(ILENew1."Global Dimension 2 Code", "Item Ledger Entry"."Global Dimension 2 Code");
        IF "Item Ledger Entry"."Document No." <> '' THEN    //Added by Pranavi on 31-Dec-2015 to solve empty DC generation problem
            ILENew1.SETFILTER(ILENew1."Document No.", "Item Ledger Entry"."Document No.");
        ILENew1.SETFILTER(ILENew1."Location Code", '%1', 'SITE');
        ILENew1.SETFILTER(ILENew1."Remaining Quantity", '>%1', 0);
        IF ILENew1.FINDSET THEN
            REPEAT
                ILENew1."DC Check" := TRUE;
                ILENew1.MODIFY;
            UNTIL ILENew1.NEXT = 0;

    end;
}

