report 33000910 "Service & Req. Excel"
{
    // version EFFUPG

    //     Varibles            usage
    //     -------------------------------
    //       j                To skip quantity if the item already taken into report
    //       CNT              To store the no.of times the item came to service location
    //       Status           To store the current status of the month
    //       DD               Dispatch Date
    DefaultLayout = RDLC;
    RDLCLayout = './Service & Req. Excel.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "Order Date";
            column(Received_DateCaption; Received_DateCaptionLbl)
            {
            }
            column(Service_Item_Line__Document_No__Caption; "Service Item Line".FIELDCAPTION("Document No."))
            {
            }
            column(Service_Item_Line__Item_No__Caption; "Service Item Line".FIELDCAPTION("Item No."))
            {
            }
            column(Service_Item_Line_DescriptionCaption; "Service Item Line".FIELDCAPTION(Description))
            {
            }
            column(Service_Item_Line__Serial_No__Caption; "Service Item Line".FIELDCAPTION("Serial No."))
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(Manfacturing_DateCaption; Manfacturing_DateCaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            column(Service_Item_Line__Response_Date_Caption; "Service Item Line".FIELDCAPTION("Response Date"))
            {
            }
            column(Service_Header_Document_Type; "Document Type")
            {
            }
            column(Service_Header_No_; "No.")
            {
            }
            dataitem("Service Item Line"; "Service Item Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Document Type" = CONST(Order), "Item No." = FILTER(<> ''), "From Location" = CONST('SERVICE'));
                //RequestFilterHeading = "Finishing Date";//B2Bupg
                column(Service_Item_Line__Document_No__; "Document No.")
                {
                }
                column(Service_Item_Line__Item_No__; "Item No.")
                {
                }
                column(Service_Item_Line_Description; Description)
                {
                }
                column(Service_Item_Line__Serial_No__; "Serial No.")
                {
                }
                column(Service_Item_Line__Order_Date_; "Order Date")
                {
                }
                column(Location; Location)
                {
                }
                column(Manf_Date_; "Manf.Date")
                {
                }
                column(Status; Status)
                {
                }
                column(Service_Item_Line__Response_Date_; "Response Date")
                {
                }
                column(Service_Item_Line_Document_Type; "Document Type")
                {
                }
                column(Service_Item_Line_Line_No_; "Line No.")
                {
                }
                dataitem("Service Line"; "Service Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No."), "Service Item No." = FIELD("Service Item No."), "Service Item Line No." = FIELD("Line No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Service Item No.") ORDER(Ascending);

                    trigger OnAfterGetRecord();
                    begin
                        IF EXCEL AND ("Service Line".Type = "Service Line".Type::Item) AND (Choice <> Choice::PC) THEN BEGIN
                            IF J <> 0 THEN BEGIN
                                Row += 1;
                                Entercell(Row, 1, "Service Header"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 2, FORMAT("Service Header"."Order Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                Entercell(Row, 3, "Service Header".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Item.GET("Service Item Line"."Item No.");
                                Entercell(Row, 6, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 8, FORMAT("Service Item Line"."Serial No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                IF "Manf.Date" <> 0D THEN
                                    Entercell(Row, 9, FORMAT("Manf.Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                Entercell(Row, 22, FORMAT("Service Item Line"."Finishing Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                            END;
                            // commented by vishnu priya on
                            //Entercell(Row,4,"Service Line"."Fault Area Description",FALSE,Tempexcelbuffer."Cell Type" :: Text);
                            //Entercell(Row,5,"Service Line"."Sub Module Descrption",FALSE,Tempexcelbuffer."Cell Type" :: Text);
                            // commented by vishnu priya
                            //ERROR("Service Line"."Fault Code Description");
                            Entercell(Row, 10, "Service Line"."Fault Code Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 11, "Service Line"."Symptom Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 12, "Service Line"."Fault Reason Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 13, "Service Line"."Resolution Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 14, "Service Line".Observations, FALSE, Tempexcelbuffer."Cell Type"::Text);

                            Entercell(Row, 15, "Service Line".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 16, FORMAT("Service Line".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(Row, 17, "Service Line"."Component Legending", FALSE, Tempexcelbuffer."Cell Type"::Number);

                            //Person tracking , Lot no tracking for component newly placed
                            ServiceLine.RESET;
                            ServiceLine.SETFILTER(ServiceLine."Document No.", "Service Line"."Document No.");
                            ServiceLine.SETFILTER(ServiceLine."Service Item No.", "Service Line"."Service Item No.");
                            ServiceLine.SETFILTER(ServiceLine."Line No.", '>%1', "Service Line"."Line No.");
                            ServiceLine.SETFILTER(ServiceLine.Type, '%1', 2);
                            IF ServiceLine.FINDFIRST THEN BEGIN
                                I := 0;
                                newvalue := ServiceLine."Line No.";
                                Entercell(Row, 23, ServiceLine.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                IF newvalue <> oldvalue THEN BEGIN
                                    Entercell(Row, 24, FORMAT(ServiceLine.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                                END;
                                oldvalue := ServiceLine."Line No.";
                                PMIH.RESET;
                                PMIH.SETFILTER(PMIH."Service Order No.", "Service Line"."Document No.");
                                PMIH.SETFILTER(PMIH."Service Item", "Service Line"."Service Item No.");
                                PMIH.SETFILTER(PMIH."User ID", ServiceLine."No.");
                                IF PMIH.FINDFIRST THEN
                                    REPEAT
                                        ILE.RESET;
                                        ILE.SETFILTER(ILE."Entry Type", '%1', 4);
                                        ILE.SETFILTER(ILE."Item No.", "Service Line"."No.");
                                        ILE.SETFILTER(ILE."Document No.", PMIH."No.");
                                        IF ILE.FINDFIRST THEN BEGIN
                                            IF I = 0 THEN
                                                Entercell(Row, 18, ILE."Lot No.", FALSE, Tempexcelbuffer."Cell Type"::Number);
                                            I := I + 1;
                                        END;
                                    UNTIL PMIH.NEXT = 0;
                            END;

                            //vendor tracking for component newly placed
                            ILE1.RESET;
                            ILE1.SETFILTER(ILE1."Entry Type", '%1', 0);
                            ILE1.SETFILTER(ILE1."Item No.", "Service Line"."No.");
                            ILE1.SETFILTER(ILE1."Lot No.", COPYSTR(ILE."Lot No.", 1, 10));
                            IF ILE1.FINDFIRST THEN BEGIN
                                PRH.RESET;
                                PRH.SETFILTER(PRH."No.", ILE1."Document No.");
                                IF PRH.FINDFIRST THEN
                                    Entercell(Row, 19, PRH."Buy-from Vendor Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            END;

                            //replaced item Tracking
                            IF Cnt > 1 THEN BEGIN
                                lot := '';
                                PMIH.RESET;
                                PMIH.SETFILTER(PMIH."Service Item", "Service Line"."Service Item No.");
                                IF PMIH.FINDFIRST THEN
                                    REPEAT
                                        IF PMIH."Service Order No." <> "Service Header"."No." THEN BEGIN
                                            ILE.RESET;
                                            ILE.SETFILTER(ILE."Entry Type", '%1', 4);
                                            ILE.SETFILTER(ILE."Item No.", "Service Line"."No.");
                                            ILE.SETFILTER(ILE."Document No.", PMIH."No.");
                                            IF ILE.FINDFIRST THEN BEGIN
                                                test := TRUE;
                                                lot := ILE."Lot No.";
                                            END;
                                        END;
                                    UNTIL PMIH.NEXT = 0;
                                IF lot <> '' THEN BEGIN
                                    Entercell(Row, 20, lot, FALSE, Tempexcelbuffer."Cell Type"::Number);
                                    ILE1.RESET;
                                    ILE1.SETFILTER(ILE1."Entry Type", '%1', 0);
                                    ILE1.SETFILTER(ILE1."Item No.", "Service Line"."No.");
                                    ILE1.SETFILTER(ILE1."Lot No.", COPYSTR(lot, 1, 10));
                                    IF ILE1.FINDFIRST THEN BEGIN
                                        PRH.RESET;
                                        PRH.SETFILTER(PRH."No.", ILE1."Document No.");
                                        IF PRH.FINDFIRST THEN
                                            Entercell(Row, 21, PRH."Buy-from Vendor Name", FALSE, Tempexcelbuffer."Cell Type"::Text);

                                    END;
                                END;
                            END;
                            IF test = FALSE THEN BEGIN
                                ILE.RESET;
                                ILE.SETFILTER(ILE."Entry Type", '%1|%2', 5, 6);
                                ILE.SETFILTER(ILE."Item No.", "Service Item Line"."Item No.");
                                ILE.SETRANGE(ILE."Serial No.", "Service Item Line"."Serial No.");
                                IF ILE.FINDFIRST THEN BEGIN
                                    ILE1.RESET;
                                    ILE1.SETFILTER(ILE1."Entry Type", '%1', 4);
                                    ILE1.SETFILTER(ILE1."Item No.", "Service Line"."No.");
                                    IF ILE1.FINDFIRST THEN BEGIN
                                        Entercell(Row, 20, ILE1."Lot No.", FALSE, Tempexcelbuffer."Cell Type"::Number);
                                        ILE.RESET;
                                        ILE.SETFILTER(ILE."Entry Type", '%1', 0);
                                        ILE.SETFILTER(ILE."Item No.", "Service Line"."No.");
                                        ILE.SETFILTER(ILE."Lot No.", COPYSTR(ILE1."Lot No.", 1, 10));
                                        IF ILE.FINDFIRST THEN BEGIN
                                            PRH.RESET;
                                            PRH.SETFILTER(PRH."No.", ILE1."Document No.");
                                            IF PRH.FINDFIRST THEN
                                                Entercell(Row, 21, PRH."Buy-from Vendor Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                        END;
                                    END;
                                END;
                            END;
                        END;

                        IF EXCEL AND ("Service Line".Type = "Service Line".Type::Resource) AND (Choice <> Choice::PC) THEN BEGIN
                            test1 := 0;
                            ServiceLine.RESET;
                            ServiceLine.SETFILTER(ServiceLine."Document No.", "Service Line"."Document No.");
                            ServiceLine.SETFILTER(ServiceLine."Service Item No.", "Service Line"."Service Item No.");
                            ServiceLine.SETFILTER(ServiceLine."Line No.", '<%1', "Service Line"."Line No.");
                            IF ServiceLine.FINDLAST THEN BEGIN
                                IF ServiceLine.Type = ServiceLine.Type::Item THEN
                                    test1 := 5;
                            END;
                            IF (test1 <> 5) THEN BEGIN
                                IF J <> 0 THEN BEGIN
                                    Row += 1;
                                    Entercell(Row, 1, "Service Header"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 2, FORMAT("Service Header"."Order Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                    Entercell(Row, 3, "Service Header".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 22, FORMAT("Service Item Line"."Finishing Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                    Item.GET("Service Item Line"."Item No.");
                                    Entercell(Row, 6, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    Entercell(Row, 8, FORMAT("Service Item Line"."Serial No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                    IF "Manf.Date" <> 0D THEN
                                        Entercell(Row, 9, FORMAT("Manf.Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                END;
                                // Entercell(Row,4,"Service Line"."Fault Area Description",FALSE,Tempexcelbuffer."Cell Type" :: Text); commented by vishnu on 14-12-2019
                                // Entercell(Row,5,"Service Line"."Sub Module Descrption",FALSE,Tempexcelbuffer."Cell Type" :: Text);  commented by vishnu on 14-12-2019
                                Entercell(Row, 10, "Service Line"."Fault Code Description", FALSE, Tempexcelbuffer."Cell Type"::Text); //ADSK
                                Entercell(Row, 11, "Service Line"."Symptom Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 12, "Service Line"."Fault Reason Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 13, "Service Line"."Resolution Description", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 14, "Service Line".Observations, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 23, "Service Line".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                Entercell(Row, 24, FORMAT("Service Line".Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            END;
                        END;

                        J := 1;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    final := 0;
                    SIL.RESET;
                    SIL.SETRANGE(SIL."Item No.", "Service Item Line"."Item No.");
                    SIL.SETRANGE(SIL."Serial No.", "Service Item Line"."Serial No.");
                    SIL.SETFILTER(SIL."Document No.", "Service Item Line"."Document No.");
                    IF (Choice = Choice::SE) THEN BEGIN
                        IF FORMAT("Service Header"."Order Date") = '' THEN
                            SIL.SETFILTER(SIL."To Location", '%1|%2', 'H-OFF', 'DAMAGE');
                    END
                    ELSE
                        SIL.SETFILTER(SIL."From Location", 'SERVICE');
                    IF SIL.FINDLAST THEN BEGIN
                        final := SIL."Line No.";
                    END;
                    IF "Service Item Line"."Line No." <> final THEN
                        CurrReport.SKIP;
                    "Manf.Date" := 0D;
                    J := 0;
                    Cnt := 0;
                    oldvalue := 0;
                    Status := '';
                    DD := 0D;
                    /*IF ("Service Item Line"."From Location"='H-OFF') AND ("Service Item Line"."From Location"='H-OFF') THEN
                      CurrReport.SKIP; */
                    Item.GET("Service Item Line"."Item No.");

                    // Manfacturing date of card
                    IF Item."Product Group Code Cust" <> 'B OUT' THEN BEGIN
                        ILE.RESET;
                        ILE.SETFILTER(ILE."Entry Type", '%1', 6);
                        ILE.SETRANGE(ILE."Item No.", "Service Item Line"."Item No.");
                        ILE.SETRANGE(ILE."Serial No.", "Service Item Line"."Serial No.");
                        IF ILE.FINDFIRST THEN
                            "Manf.Date" := ILE."Posting Date";
                    END;

                    //Present status of the card
                    IF "Service Item Line"."To Location" <> '' THEN BEGIN
                        ILE.RESET;
                        ILE.SETFILTER(ILE."Item No.", "Service Item Line"."Item No.");
                        ILE.SETRANGE(ILE."Serial No.", "Service Item Line"."Serial No.");
                        ILE.SETFILTER(ILE."Remaining Quantity", '>%1', 0);
                        IF ILE.FINDFIRST THEN BEGIN
                            IF (ILE."Location Code" = 'SITE') OR (ILE."Location Code" = 'CS') THEN BEGIN
                                DV.RESET;
                                DV.SETFILTER(DV."Dimension Code", 'LOCATIONS');
                                DV.SETFILTER(DV.Code, ILE."Global Dimension 2 Code");
                                IF DV.FINDFIRST THEN
                                    Status := DV.Name;
                            END
                            ELSE
                                Status := ILE."Location Code";
                        END;
                    END
                    ELSE
                        Status := 'SERVICE';

                    //Dispatch Date
                    IF "Service Item Line"."To Location" <> '' THEN BEGIN
                        ILE.RESET;
                        ILE.SETFILTER(ILE."Item No.", "Service Item Line"."Item No.");
                        ILE.SETRANGE(ILE."Serial No.", "Service Item Line"."Serial No.");
                        ILE.SETFILTER(ILE."Posting Date", '>=%1', "Service Item Line"."Finishing Date");
                        IF ILE.FINDFIRST THEN BEGIN
                            DD := ILE."Posting Date";
                        END;
                    END;
                    // No. of times the card came to service location
                    SIL.RESET;
                    SIL.SETFILTER(SIL."Item No.", "Service Item Line"."Item No.");
                    SIL.SETRANGE(SIL."Serial No.", "Service Item Line"."Serial No.");
                    SIL.SETFILTER(SIL."From Location", 'SERVICE');
                    IF SIL.FINDFIRST THEN
                        Cnt := SIL.COUNT;

                    IF (Choice = Choice::SE) THEN BEGIN
                        Row += 1;
                        Entercell(Row, 1, "Service Header"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, FORMAT("Service Header"."Order Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 3, "Service Header".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Item.GET("Service Item Line"."Item No.");
                        Entercell(Row, 6, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 7, FORMAT(1), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Total_QTY += 1;
                        Entercell(Row, 8, FORMAT("Service Item Line"."Serial No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        IF "Manf.Date" <> 0D THEN
                            Entercell(Row, 9, FORMAT("Manf.Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        IF "Service Item Line"."Finishing Date" <> 0D THEN BEGIN
                            Entercell(Row, 22, FORMAT("Service Item Line"."Finishing Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                            Entercell(Row, 25, FORMAT("Service Item Line"."Finishing Date" - "Service Header"."Order Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                            IF ("Service Item Line"."Finishing Date" - "Service Header"."Order Date") < Min_days THEN
                                Min_days := ("Service Item Line"."Finishing Date" - "Service Header"."Order Date");
                            IF ("Service Item Line"."Finishing Date" - "Service Header"."Order Date") > Max_days THEN
                                Max_days := ("Service Item Line"."Finishing Date" - "Service Header"."Order Date");
                            Serviced_QTY += 1;
                        END;
                        Entercell(Row, 26, Status, FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 27, FORMAT(Cnt), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 28, FORMAT(DD), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 29, "Service Item Line"."Problem from Site", FALSE, Tempexcelbuffer."Cell Type"::Number);
                        Entercell(Row, 30, "Service Item Line"."QC internal Remarks", FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 31, "Service Header".Name, FALSE, Tempexcelbuffer."Cell Type"::Text); // Added by Pranavi on 03-Feb-2016 for customer name for led cards
                        Entercell(Row, 32, "Service Item Line"."Station Name", FALSE, Tempexcelbuffer."Cell Type"::Text); // Added by Pranavi on 25-Apr-2017 for Station
                                                                                                                          //Added by Vishnu Priya on 14-12-2019 for the Product Models
                        PrdMdls.RESET;
                        PrdMdls.SETRANGE(Active, TRUE);
                        PrdMdls.SETFILTER("Item Number", "Service Item Line"."Item No.");
                        IF PrdMdls.FINDFIRST THEN BEGIN
                            Entercell(Row, 4, PrdMdls.Product, FALSE, Tempexcelbuffer."Cell Type"::Text); //Added by Vishnu Priya on 01-11-2019
                            Entercell(Row, 5, PrdMdls.Module, FALSE, Tempexcelbuffer."Cell Type"::Text);  //Added by Vishnu Priya on 01-11-2019
                            Entercell(Row, 33, PrdMdls.Model, FALSE, Tempexcelbuffer."Cell Type"::Text); //Added by Vishnu Priya on 01-11-2019
                        END;
                        //end  by Vishnu Priya on 14-12-2019 for the Product Models

                    END;

                    IF (Choice = Choice::PC) THEN BEGIN
                        Row += 1;
                        Entercell(Row, 1, "Service Header"."No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, FORMAT("Service Header"."Order Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 3, "Service Header".Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Item.GET("Service Item Line"."Item No.");
                        Entercell(Row, 4, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                        //Added by Vishnu Priya on 01-11-2019 for the Product Models
                        PrdMdls.RESET;
                        PrdMdls.SETRANGE(Active, TRUE);
                        PrdMdls.SETFILTER("Item Number", "Service Item Line"."Item No.");
                        IF PrdMdls.FINDFIRST THEN BEGIN
                            Entercell(Row, 5, PrdMdls.Product, FALSE, Tempexcelbuffer."Cell Type"::Text); //Added by Vishnu Priya on 01-11-2019
                            Entercell(Row, 6, PrdMdls.Module, FALSE, Tempexcelbuffer."Cell Type"::Text);  //Added by Vishnu Priya on 01-11-2019
                            Entercell(Row, 16, PrdMdls.Model, FALSE, Tempexcelbuffer."Cell Type"::Text); //Added by Vishnu Priya on 01-11-2019
                        END;
                        //Entercell(Row,5,"Service Item Line"."Fault Area Description",FALSE,Tempexcelbuffer."Cell Type" :: Text); // commented by Vishnu Priya on 01-11-2019
                        //Entercell(Row,6,"Service Item Line"."Sub Module Descrption",FALSE,Tempexcelbuffer."Cell Type" :: Text);// commented by Vishnu Priya on 01-11-2019
                        Entercell(Row, 7, FORMAT(1), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 8, FORMAT("Service Item Line"."Serial No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        IF "Manf.Date" <> 0D THEN
                            Entercell(Row, 9, FORMAT("Manf.Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 10, FORMAT(TODAY - "Service Header"."Order Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                        Entercell(Row, 11, FORMAT("Service Item Line"."Service Level"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 13, FORMAT("Service Header"."Customer Cards"), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        Entercell(Row, 12, FORMAT(Cnt), FALSE, Tempexcelbuffer."Cell Type"::Number);                //Added by Pranavi on 25-07-2015
                        Entercell(Row, 14, FORMAT("Service Header".Name), FALSE, Tempexcelbuffer."Cell Type"::Text); // Added by Pranavi on 03-Feb-2016 for customer name for led cards
                        Entercell(Row, 15, "Service Item Line"."Station Name", FALSE, Tempexcelbuffer."Cell Type"::Text); // Added by Pranavi on 25-Apr-2017 for Station
                    END;

                end;

                trigger OnPreDataItem();
                begin
                    IF (Choice = Choice::PC) THEN
                        "Service Item Line".SETFILTER("Service Item Line".Account, 'NO');
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Location := "Service Header".Description;
            end;

            trigger OnPostDataItem();
            begin
                IF (Choice = Choice::SE) THEN BEGIN
                    Row := Row + 2;
                    EnterHeadings(Row + 1, 2, 'Min No. of days', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 2, 2, 'Max No. of days', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 1, 6, 'Total Received Cards', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 2, 6, 'Total Serviced Cards', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row + 3, 6, 'Pending Cards', TRUE, Tempexcelbuffer."Cell Type"::Text);

                    Entercell(Row + 1, 4, FORMAT(Min_days), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row + 2, 4, FORMAT(Max_days), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row + 1, 8, FORMAT(Total_QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row + 2, 8, FORMAT(Serviced_QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row + 3, 8, FORMAT(Total_QTY - Serviced_QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);

                END;
            end;

            trigger OnPreDataItem();
            begin
                IF NOT ((Choice = Choice::SE) OR (Choice = Choice::PC)) THEN
                    CurrReport.BREAK;
                Min_days := 100;
                Max_days := 0;

                IF (Choice = Choice::SE) THEN BEGIN
                    Row := 1;
                    EnterHeadings(Row, 1, 'Service Order No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'PCB Received Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Location', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    // EnterHeadings(Row,4,'Product-Module',TRUE,Tempexcelbuffer."Cell Type" :: Text);
                    EnterHeadings(Row, 4, 'Product-Module', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 33, 'Product-Model', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Sub Module', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Pcb Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Serial No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Manfacturing Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Problem Group', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'Symptom', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'Cause identified', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 13, 'Resolution', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 14, 'Observation', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 15, 'Components Replaced', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 16, 'QTY', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 17, 'Component Legending', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 18, 'Batch No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 19, 'Supplier Name', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 20, 'Batch No(Old)', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 21, 'Supplier Name(Old)', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 22, 'Completion Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 23, 'Person', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 24, 'Spent time in hrs', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 25, 'Response Time', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 26, 'Status', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 27, 'No. of times Repeated', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 28, 'Dispatch Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 29, 'Problem From Site', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 30, 'QC Remarks', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 31, 'Customer', TRUE, Tempexcelbuffer."Cell Type"::Text);  // Added by Pranavi on 03-Feb-2016 for customer name of led-cards
                    EnterHeadings(Row, 32, 'Station', TRUE, Tempexcelbuffer."Cell Type"::Text);  // Added by Pranavi on 25-Apr-2017 for station
                END;
                IF (Choice = Choice::PC) THEN BEGIN
                    Row := 1;
                    EnterHeadings(Row, 1, 'Service Order No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'PCB Received Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Location', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Pcb Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Module', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Sub Module', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Serial No.', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Manfacturing Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Pending From', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'Service level', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'No. of times Repeated', TRUE, Tempexcelbuffer."Cell Type"::Text); //Added by Pranavi on 25-07-2015
                    EnterHeadings(Row, 13, 'Customer Card', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 14, 'Customer', TRUE, Tempexcelbuffer."Cell Type"::Text); // Added by Pranavi on 03-Feb-2016 for customer name of led-cards
                    EnterHeadings(Row, 15, 'Station', TRUE, Tempexcelbuffer."Cell Type"::Text); // Added by Pranavi on 25-Apr-2017 for station
                    EnterHeadings(Row, 16, 'Model', TRUE, Tempexcelbuffer."Cell Type"::Text); // Added by Vishnu on 01-11-2019
                END;
            end;
        }
        dataitem("Material Issues Header"; "Material Issues Header")
        {
            DataItemTableView = WHERE("Transfer-from Code" = FILTER('CS'), "Transfer-to Code" = FILTER('SITE'), Status = CONST(Released));
            RequestFilterFields = "Released Date";

            trigger OnAfterGetRecord();
            begin
                MIL.RESET;
                MIL.SETFILTER(MIL."Document No.", "Material Issues Header"."No.");
                MIL.SETFILTER(MIL."Item No.", '<>%1', '');
                MIL.SETFILTER(MIL.Quantity, '>%1', 0);
                MIL.SETFILTER(MIL."Qty. to Receive", '>%1', 0);
                IF MIL.FINDFIRST THEN
                    REPEAT
                        Pending_QTY += MIL."Qty. to Receive";
                        IF (Choice = Choice::REQ) OR (Choice = Choice::REQ_TOT) THEN BEGIN
                            Row += 1;
                            Entercell(Row, 1, FORMAT(Row - 1), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(Row, 2, FORMAT("Material Issues Header"."Released Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);

                            //Rev01
                            //user.GET("Material Issues Header"."User ID");
                            user.RESET;
                            user.SETRANGE("User Name", "Material Issues Header"."User ID");
                            IF user.FINDFIRST THEN
                                Entercell(Row, 3, user."User Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            //Rev01
                            DV.RESET;
                            DV.SETFILTER(DV."Dimension Code", 'LOCATIONS');
                            DV.SETFILTER(DV.Code, "Material Issues Header"."Shortcut Dimension 2 Code");
                            IF DV.FINDFIRST THEN
                                Entercell(Row, 5, FORMAT(DV.Name), FALSE, Tempexcelbuffer."Cell Type"::Text);
                            station.RESET;
                            station.SETRANGE(station."Station Code", MIL.Station);
                            IF station.FINDFIRST THEN
                                Entercell(Row, 6, station."Station Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Item.GET(MIL."Item No.");
                            Entercell(Row, 7, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 8, FORMAT(MIL.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(Row, 9, FORMAT(MIL."Quantity Received"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(Row, 10, FORMAT(MIL."Qty. to Receive"), FALSE, Tempexcelbuffer."Cell Type"::Number);


                            Entercell(Row, 11, "Material Issues Header"."Reason Code", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 12, FORMAT("Material Issues Header".Priority), FALSE, Tempexcelbuffer."Cell Type"::Text);
                        END;
                    UNTIL MIL.NEXT = 0;
            end;

            trigger OnPreDataItem();
            begin
                IF (Choice <> Choice::REQ) AND (Choice <> Choice::REQ_1) AND (Choice <> Choice::REQ_TOT) THEN
                    CurrReport.BREAK;
                IF EXCEL AND ((Choice = Choice::REQ) OR (Choice = Choice::REQ_TOT)) THEN BEGIN
                    Row := 1;
                    EnterHeadings(Row, 1, 'S.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'Request Received Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Project Manager', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Zone', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Division', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Station Name', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'PcbNo', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Qty Requested', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Qty Issued', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Qty to Issue', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'Reason for Requirement', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'Priority', TRUE, Tempexcelbuffer."Cell Type"::Text);
                END;
            end;
        }
        dataitem("Posted Material Issues Header"; "Posted Material Issues Header")
        {
            DataItemTableView = WHERE("Transfer-from Code" = FILTER('CS|SITE'), "Transfer-to Code" = FILTER('CSA|SITE'));
            RequestFilterFields = "Released Date", "Posting Date";

            trigger OnAfterGetRecord();
            begin
                PMIL.RESET;
                PMIL.SETFILTER(PMIL."Document No.", "Posted Material Issues Header"."No.");
                PMIL.SETFILTER(PMIL."Item No.", '<>%1', '');
                IF PMIL.FINDFIRST THEN
                    REPEAT
                        Issued_QTY += PMIL.Quantity;
                        IF (Choice = Choice::REQ_1) OR (Choice = Choice::REQ_TOT) THEN BEGIN
                            SNO := '';
                            Row += 1;
                            Entercell(Row, 1, FORMAT(Row - 1), FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 2, FORMAT("Posted Material Issues Header"."Released Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);

                            //Rev01
                            //user.GET("Posted Material Issues Header"."User ID");
                            user.RESET;
                            user.SETRANGE("User Name", "Posted Material Issues Header"."User ID");
                            IF user.FINDFIRST THEN
                                Entercell(Row, 3, user."User Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                            //Rev01
                            DV.RESET;
                            DV.SETFILTER(DV."Dimension Code", 'LOCATIONS');
                            DV.SETFILTER(DV.Code, "Posted Material Issues Header"."Shortcut Dimension 2 Code");
                            IF DV.FINDFIRST THEN
                                Entercell(Row, 5, FORMAT(DV.Name), FALSE, Tempexcelbuffer."Cell Type"::Text);

                            station.RESET;
                            station.SETRANGE(station."Station Code", PMIL.Station);
                            IF station.FINDFIRST THEN
                                Entercell(Row, 6, station."Station Name", FALSE, Tempexcelbuffer."Cell Type"::Text);

                            Item.GET(PMIL."Item No.");
                            Entercell(Row, 7, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 8, FORMAT(PMIL.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(Row, 9, FORMAT(PMIL.Quantity), FALSE, Tempexcelbuffer."Cell Type"::Number);
                            Entercell(Row, 10, FORMAT(0), FALSE, Tempexcelbuffer."Cell Type"::Text); //ADSK
                            Entercell(Row, 11, "Posted Material Issues Header"."Reason Code", FALSE, Tempexcelbuffer."Cell Type"::Text);

                            ILE.RESET;
                            ILE.SETFILTER(ILE."Document No.", "Posted Material Issues Header"."No.");
                            ILE.SETFILTER(ILE."Item No.", PMIL."Item No.");
                            ILE.SETFILTER(ILE."Location Code", 'SITE');
                            IF ILE.FINDFIRST THEN
                                REPEAT
                                    IF (SNO <> '') AND (STRLEN(SNO) < 150) THEN
                                        SNO := SNO + ',' + ILE."Serial No."
                                    ELSE
                                        SNO := ILE."Serial No.";
                                UNTIL ILE.NEXT = 0;
                            Entercell(Row, 13, FORMAT(SNO), FALSE, Tempexcelbuffer."Cell Type"::Text);
                            Entercell(Row, 14, FORMAT("Posted Material Issues Header"."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                            Entercell(Row, 15, FORMAT("Posted Material Issues Header"."Posting Date" - "Posted Material Issues Header"."Released Date"), FALSE, Tempexcelbuffer."Cell Type"::Number);
                        END;
                    UNTIL PMIL.NEXT = 0;
            end;

            trigger OnPostDataItem();
            begin
                IF (Choice = Choice::REQ_TOT) THEN BEGIN
                    REQ_QTY := Issued_QTY + Pending_QTY;
                    Row += 1;
                    EnterHeadings(Row, 1, 'Total Requested Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Issued Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Pending Quantity', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    Entercell(Row, 2, FORMAT(REQ_QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row, 5, FORMAT(Issued_QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                    Entercell(Row, 9, FORMAT(Pending_QTY), FALSE, Tempexcelbuffer."Cell Type"::Number);
                END;
            end;

            trigger OnPreDataItem();
            begin
                IF (Choice <> Choice::REQ) AND (Choice <> Choice::REQ_1) AND (Choice <> Choice::REQ_TOT) THEN
                    CurrReport.BREAK;
                release_date := "Material Issues Header".GETFILTER("Material Issues Header"."Released Date");
                IF release_date <> '' THEN
                    "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Released Date", release_date);
                IF EXCEL AND ((Choice = Choice::REQ_1) OR (Choice = Choice::REQ_TOT)) THEN BEGIN
                    IF (Choice = Choice::REQ_1) THEN
                        Row += 1
                    ELSE
                        Row += 2;
                    EnterHeadings(Row, 1, 'S.No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'Request Received Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Project Manager', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Zone', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'Division', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'Station Name', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'PcbNo', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Qty', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Qty Issued', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Qty to Issue', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'Reason for Requirement', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'Priority', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 13, 'Sl.no', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 14, 'Dispatch Date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 15, 'Respond Days', TRUE, Tempexcelbuffer."Cell Type"::Text);
                END;
            end;
        }
        dataitem("Integer"; "Integer")
        {

            trigger OnAfterGetRecord();
            begin
                DD := TODAY - Integer.Number;
                IF USERID = 'EFFTRONICS\PRANAVI' THEN
                    EVALUATE(DD, '14-12-2016');
                IF Choice = Choice::DNE THEN BEGIN
                    PMIH.RESET;
                    PMIH.SETFILTER(PMIH."Service Order No.", '<>%1', '');
                    PMIH.SETFILTER(PMIH."Service Item", '<>%1', '');
                    PMIH.SETFILTER(PMIH."Service Item Serial No.", '<>%1', '');
                    PMIH.SETFILTER(PMIH."Posting Date", '>=%1', DD);
                    IF PMIH.FINDFIRST THEN
                        REPEAT
                            PMIL.RESET;
                            PMIL.SETFILTER(PMIL."Document No.", PMIH."No.");
                            PMIL.SETFILTER(PMIL."Item No.", '<>%1', '');
                            IF PMIL.FINDFIRST THEN
                                REPEAT
                                    // >>Added by Pranavi on 01-06-2017
                                    ItemLedgerEntry.RESET;
                                    ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Document No.", ItemLedgerEntry."Item No.", ItemLedgerEntry."Posting Date");
                                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", PMIH."No.");
                                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", PMIL."Item No.");
                                    ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
                                    IF ItemLedgerEntry.FINDFIRST THEN BEGIN   // <<Added by Pranavi on 01-06-2017
                                        ServiceLine.RESET;
                                        ServiceLine.SETFILTER(ServiceLine."Document No.", PMIH."Service Order No.");
                                        ServiceLine.SETFILTER(ServiceLine."Service Item No.", PMIH."Service Item");
                                        ServiceLine.SETFILTER(ServiceLine."No.", PMIL."Item No.");
                                        //pranavi
                                        ServiceLine.SETFILTER(ServiceLine."Fault Code Description", '<>%1', '');
                                        //end pranavi
                                        IF NOT ServiceLine.FINDFIRST THEN BEGIN
                                            Entercell(Row, 1, PMIH."Service Order No.", FALSE, Tempexcelbuffer."Cell Type"::Text); //commented by vishnu on 21-10-2019
                                                                                                                                   //Entercell(Row,1,ServiceLine."Document No.",FALSE,Tempexcelbuffer."Cell Type" :: Text);
                                            IF service_item.GET(PMIH."Service Item") THEN BEGIN
                                                Item.GET(service_item."Item No.");
                                                Entercell(Row, 2, Item.Description, FALSE, Tempexcelbuffer."Cell Type"::Text);
                                            END;
                                            Entercell(Row, 3, FORMAT(PMIH."Service Item Serial No."), FALSE, Tempexcelbuffer."Cell Type"::Text);
                                            Entercell(Row, 4, PMIH."Resource Name", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                            Serv_Item_line.RESET;
                                            Serv_Item_line.SETFILTER(Serv_Item_line."Document No.", PMIH."Service Order No.");
                                            Serv_Item_line.SETFILTER(Serv_Item_line."Service Item No.", PMIH."Service Item");
                                            IF Serv_Item_line.FINDFIRST THEN
                                                Entercell(Row, 5, FORMAT(Serv_Item_line."Finishing Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                            Entercell(Row, 6, FORMAT(PMIH."Posting Date"), FALSE, Tempexcelbuffer."Cell Type"::Date);
                                            // added by Vishnu Priya on 09-11-2019
                                            SIL1.RESET;
                                            SIL1.SETFILTER("Service Item No.", PMIH."Service Item");
                                            SIL1.SETFILTER("Serial No.", PMIH."Service Item Serial No.");
                                            IF SIL1.FINDLAST THEN BEGIN
                                                Entercell(Row, 7, SIL1."Document No.", FALSE, Tempexcelbuffer."Cell Type"::Text);
                                            END;
                                            // added by Vishnu Priya on 09-11-2019
                                            Row := Row + 1;
                                        END;
                                    END;
                                UNTIL PMIL.NEXT = 0;
                        UNTIL PMIH.NEXT = 0;
                END;
                CurrReport.BREAK;
            end;

            trigger OnPreDataItem();
            begin
                IF NOT ((Choice = Choice::DNE)) THEN
                    CurrReport.BREAK;
                Row := 1;
                EnterHeadings(Row, 1, 'Service Order No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                EnterHeadings(Row, 2, 'Pcb Description', TRUE, Tempexcelbuffer."Cell Type"::Text);
                EnterHeadings(Row, 3, 'PCB serial No', TRUE, Tempexcelbuffer."Cell Type"::Text);
                EnterHeadings(Row, 4, 'Person', TRUE, Tempexcelbuffer."Cell Type"::Text);
                EnterHeadings(Row, 5, 'Finish date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                EnterHeadings(Row, 6, 'Posting date', TRUE, Tempexcelbuffer."Cell Type"::Text);
                EnterHeadings(Row, 7, 'Testing', TRUE, Tempexcelbuffer."Cell Type"::Text);
                Row := Row + 1;
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
                    field(Choice; Choice)
                    {
                        OptionCaption = 'Service Excel,REQ_Pending,REQ_Completed,REQ_TOTAL,Data Not entered,To be Serviced Cards';
                        ApplicationArea = All;
                    }
                    field(Excel; EXCEL)
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

    trigger OnInitReport();
    begin
        EXCEL := TRUE;
    end;

    trigger OnPostReport();
    begin
        /*
        IF EXCEL THEN BEGIN
         Tempexcelbuffer.CreateBook('Trouble Shooting Data');
         Tempexcelbuffer.WriteSheet('Trouble Shooting Data',COMPANYNAME,USERID);
         Tempexcelbuffer.OpenExcel;
         Tempexcelbuffer.CloseBook;
         Tempexcelbuffer.GiveUserControl;
        END
        */

        IF EXCEL THEN BEGIN
            Tempexcelbuffer.CreateBookAndOpenExcel('', 'Trouble Shooting Data', 'Trouble Shooting Data', COMPANYNAME, USERID); //EFFUPG
        END

    end;

    trigger OnPreReport();
    begin
        IF EXCEL THEN BEGIN
            CLEAR(Tempexcelbuffer);
            Tempexcelbuffer.DELETEALL;
        END;
    end;

    var
        Choice: Option SE,REQ,REQ_1,REQ_TOT,DNE,PC;
        Location: Text[50];
        ILE: Record "Item Ledger Entry";
        "Manf.Date": Date;
        Item: Record Item;
        Status: Text[100];
        Tempexcelbuffer: Record "Excel Buffer" temporary;
        EXCEL: Boolean;
        Row: Integer;
        "sent Date": Date;
        DV: Record "Dimension Value";
        ServiceLine: Record "Service Line";
        PMIH: Record "Posted Material Issues Header";
        I: Integer;
        J: Integer;
        oldvalue: Integer;
        newvalue: Integer;
        SIL: Record "Service Item Line";
        Cnt: Integer;
        PRH: Record "Purch. Rcpt. Header";
        ILE1: Record "Item Ledger Entry";
        test: Boolean;
        lot: Code[20];
        test1: Integer;
        MIL: Record "Material Issues Line";
        PMIL: Record "Posted Material Issues Line";
        release_date: Text[30];
        service_item: Record "Service Item";
        user: Record User;
        DD: Date;
        station: Record Station;
        REQ_QTY: Decimal;
        Issued_QTY: Decimal;
        Pending_QTY: Decimal;
        SNO: Code[200];
        Min_days: Integer;
        Max_days: Integer;
        Total_QTY: Integer;
        Serviced_QTY: Integer;
        final: Integer;
        Serv_Item_line: Record "Service Item Line";
        Received_DateCaptionLbl: Label 'Received Date';
        LocationCaptionLbl: Label 'Location';
        Manfacturing_DateCaptionLbl: Label 'Manfacturing Date';
        StatusCaptionLbl: Label 'Status';
        ItemLedgerEntry: Record "Item Ledger Entry";
        PrdMdls: Record "Product Model";
        SIL1: Record "Service Item Line";

    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option);
    begin

        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := CellValue;
        Tempexcelbuffer."Cell Type" := CellType;
        Tempexcelbuffer.Bold := bold;


        Tempexcelbuffer.INSERT;
    end;

    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option);
    begin
        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        Tempexcelbuffer."Cell Type" := CellType;
        Tempexcelbuffer.Bold := Bold;

        Tempexcelbuffer.Formula := '';
        Tempexcelbuffer.INSERT;
    end;
}

