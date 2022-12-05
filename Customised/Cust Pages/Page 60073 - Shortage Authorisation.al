page 60073 "Shortage Authorisation"
{
    // version Rev01
    Caption = 'Shortage Authorisation';
    ApplicationArea = all;
    UsageCategory = Lists;


    PageType = Worksheet;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Plan Changes,Color Indications,Other Actions,Item Related,Forward Actions',
                                 ENN = 'New,Process,Report,Plan Changes,Color Indications,Other Actions,Item Related,Forward Actions';
    SourceTable = "Shortage Temp";


    layout
    {
        area(content)
        {
            group(Filters)
            {
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        FilterTokens: Codeunit "Filter Tokens";
                        DateFilter2: Text;
                    begin

                        // THIS IS THE CODE FOR FORMATING THE ENTERED DATA INTO TO DATE FORMAT
                        //EFFUPG>>
                        /*
                         IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
                         GLAcc.SETFILTER("Date Filter", DateFilter);
                         DateFilter := GLAcc.GETFILTER("Date Filter");
                         InternalDateFilter := DateFilter;
                         */

                        DateFilter2 := DateFilter;
                        FilterTokens.MakeDateFilter(DateFilter2);
                        DateFilter := CopyStr(DateFilter2, 1, MaxStrLen(DateFilter));
                        InternalDateFilter := DateFilter;
                        //EFFUPG<<

                        // RECALCULATING THE SHORTAGE FUNCTION  & DISPLAY DETAILS ON FORM
                        "Show Shortage";
                    end;
                }
                field(Choice; Choice)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Choice = Choice::Shortage THEN BEGIN
                            Rec.RESET;
                            FormShow;
                            "Calculate Date Filter";
                            "Show Shortage";
                        END ELSE
                            IF Choice = Choice::Purchase THEN BEGIN
                                Rec.RESET;
                                // ACCORDING TO I/P'S SHOWING NECESSAR INORMATION IN FORM
                                FormShow;
                                IF USERID = 'ADMIN' THEN
                                    Data_Choice := Data_Choice::WFA;
                                IF Break_Down THEN BEGIN
                                    IF Choice = Choice::Purchase THEN BEGIN
                                        //Rev01
                                        /*
                                        currpage."Next Week".VISIBLE:=FALSE;
                                        IF Break_Down THEN
                                        BEGIN
                                          currpage."Below Present Week".VISIBLE:=TRUE;
                                          currpage."Next 15 Days".VISIBLE:=TRUE;
                                          currpage."In One Month".VISIBLE:=TRUE;
                                          currpage."Present Week".VISIBLE:=TRUE;
                                        END ELSE
                                        BEGIN
                                          currpage."Below Present Week".VISIBLE:=FALSE;
                                          currpage."Next 15 Days".VISIBLE:=FALSE;
                                          currpage."In One Month".VISIBLE:=FALSE;
                                          currpage."Present Week".VISIBLE:=FALSE;
                                        END;
                                        END ELSE IF  Choice=Choice::PNUC THEN
                                        BEGIN
                                          currpage."Below Present Week".VISIBLE:=FALSE;
                                          currpage."Next Week".VISIBLE:=FALSE;
                                          IF Break_Down THEN
                                          BEGIN
                                            currpage."Present Week".VISIBLE:=TRUE;
                                            currpage."Next 15 Days".VISIBLE:=TRUE;
                                            currpage."In One Month".VISIBLE:=TRUE;
                                         END ELSE
                                         BEGIN
                                           currpage."Present Week".VISIBLE:=FALSE;
                                           currpage."Next 15 Days".VISIBLE:=FALSE;
                                           currpage."In One Month".VISIBLE:=FALSE;
                                         END;
                                       END;
                                       *///Rev01
                                    END;
                                END;
                                "Calculate Date Filter";
                                // RECALCULATING THE SHORTAGE FUNCTION  & DISPLAY DETAILS ON FORM
                                "Show Shortage";
                            END ELSE BEGIN
                                Rec.RESET;
                                // ACCORDING TO I/P'S SHOWING NECESSAR INORMATION IN FORM
                                FormShow;
                                IF USERID = 'ADMIN' THEN
                                    Data_Choice := Data_Choice::WFA;
                                /*
                                IF Break_Down THEN
                                BEGIN
                                  IF Choice=Choice::Purchase THEN
                                  BEGIN
                                    CurrForm."Next Week".VISIBLE:=FALSE;
                                    IF Break_Down THEN
                                    BEGIN
                                      CurrForm."Below Present Week".VISIBLE:=TRUE;
                                      CurrForm."Next 15 Days".VISIBLE:=TRUE;
                                      CurrForm."In One Month".VISIBLE:=TRUE;
                                      CurrForm."Present Week".VISIBLE:=TRUE;
                                    END ELSE
                                    BEGIN
                                      CurrForm."Below Present Week".VISIBLE:=FALSE;
                                      CurrForm."Next 15 Days".VISIBLE:=FALSE;
                                      CurrForm."In One Month".VISIBLE:=FALSE;
                                      CurrForm."Present Week".VISIBLE:=FALSE;
                                    END;
                                    END ELSE IF  Choice=Choice::PNUC THEN
                                    BEGIN
                                      CurrForm."Below Present Week".VISIBLE:=FALSE;
                                      CurrForm."Next Week".VISIBLE:=FALSE;
                                      IF Break_Down THEN
                                      BEGIN
                                        CurrForm."Present Week".VISIBLE:=TRUE;
                                        CurrForm."Next 15 Days".VISIBLE:=TRUE;
                                        CurrForm."In One Month".VISIBLE:=TRUE;
                                     END ELSE
                                     BEGIN
                                       CurrForm."Present Week".VISIBLE:=FALSE;
                                       CurrForm."Next 15 Days".VISIBLE:=FALSE;
                                       CurrForm."In One Month".VISIBLE:=FALSE;
                                     END;
                                   END;
                                END;
                                */
                                "Calculate Date Filter";
                                // RECALCULATING THE SHORTAGE FUNCTION  & DISPLAY DETAILS ON FORM
                                "Show Shortage";
                            END;

                    end;
                }
                field("Data Choice"; Data_Choice)
                {
                    OptionCaption = 'Open, Waiting for Authorisation,Authorised,Indent,Waiting at Purchase,CBP,Send for authorisation';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Choice = Choice::Purchase) OR (Choice = Choice::PNUC) THEN BEGIN
                            Rec.RESET;
                            FormShow;
                            "Show Shortage";
                        END;
                    end;
                }
                field("Cost Estimation (With Taxes)"; "Cost Estimation")
                {
                    ApplicationArea = All;
                }
                field("Sale Orders"; Sale_Order)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        "Show Shortage";
                    end;
                }
                field("Sales Orders Choice"; Sale_Order_Choice)
                {
                    ApplicationArea = All;
                }
                field("Show Week Wise Break Down"; Break_Down)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*
                         IF Choice=Choice::Purchase THEN
                         BEGIN
                           Currpage."Next Week".VISIBLE:=FALSE;
                           IF Break_Down THEN
                           BEGIN
                             Currpage."Below Present Week".VISIBLE:=TRUE;
                             Currpage."Next 15 Days".VISIBLE:=TRUE;
                             Currpage."In One Month".VISIBLE:=TRUE;
                             Currpage."Present Week".VISIBLE:=TRUE;
                           END ELSE
                           BEGIN
                             Currpage."Below Present Week".VISIBLE:=FALSE;
                             Currpage."Next 15 Days".VISIBLE:=FALSE;
                             Currpage."In One Month".VISIBLE:=FALSE;
                             Currpage."Present Week".VISIBLE:=FALSE;
                           END;
                         END ELSE IF  Choice=Choice::PNUC THEN
                         BEGIN
                           Currpage."Below Present Week".VISIBLE:=FALSE;
                            Currpage."Next Week".VISIBLE:=FALSE;
                           IF Break_Down THEN
                           BEGIN
                             Currpage."Present Week".VISIBLE:=TRUE;
                             Currpage."Next 15 Days".VISIBLE:=TRUE;
                             Currpage."In One Month".VISIBLE:=TRUE;
                        
                           END ELSE
                           BEGIN
                             Currpage."Present Week".VISIBLE:=FALSE;
                             Currpage."Next 15 Days".VISIBLE:=FALSE;
                             Currpage."In One Month".VISIBLE:=FALSE;
                           END;
                         END;
                        */ //Rev01

                    end;
                }
                field("Show Requirement Details"; Show_REQ_Det)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*
                        IF Show_REQ_Det THEN
                        BEGIN
                          Currpage."Qty. In Stores".VISIBLE:=TRUE;
                          Currpage."Qty. In MCH".VISIBLE:=TRUE;
                          Currpage."Required  Qty".VISIBLE:=TRUE;
                          Currpage."Qty. In Material Issues".VISIBLE:=TRUE;
                          Currpage.Difference.VISIBLE:=TRUE;
                        END ELSE
                        BEGIN
                          Currpage."Qty. In Stores".VISIBLE:=FALSE;
                          Currpage."Qty. In MCH".VISIBLE:=FALSE;
                          Currpage."Required  Qty".VISIBLE:=FALSE;
                          Currpage."Qty. In Material Issues".VISIBLE:=FALSE;
                          Currpage.Difference.VISIBLE:=FALSE;
                        END;
                        *///Rev01
                        "Show Shortage";

                    end;
                }
                field("Show Other Store Details"; Show_Other_Store_Det)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*
                        IF Show_Other_Store_Det THEN
                        BEGIN
                          Currpage."Qty. In R&D".VISIBLE:=TRUE;
                          Currpage."Get From R&D".VISIBLE:=TRUE;
                          Currpage."Qty. In CS".VISIBLE:=TRUE;
                          Currpage."Get From CS".VISIBLE:=TRUE;
                        END ELSE
                        BEGIN
                          Currpage."Qty. In R&D".VISIBLE:=FALSE;
                          Currpage."Get From R&D".VISIBLE:=FALSE;
                          Currpage."Qty. In CS".VISIBLE:=FALSE;
                          Currpage."Get From CS".VISIBLE:=FALSE;
                         END;
                        *///Rev01

                    end;
                }
                field("Shortage Date"; Shortage_Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Min Date"; "Min Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Max Date"; "Max Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Authorise; Authorise)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //B2B UPG >>>
                        /* IF (Data_Choice = Data_Choice::WFA) AND (Choice = Choice::Purchase) THEN BEGIN
                            IF (USERID = 'EFFTRONICS/ANILKUMAR') OR (USERID = 'EFFTRONICS/PADMAJA') OR (USERID = 'EFFTRONICS\ANVESH') OR (USERID = 'EFFTRONICS\SPURTHI') OR (USERID = 'EFFTRONICS/CHOWDARY') THEN BEGIN
                                Mail_Subject := 'Your Material Request was Authorised for ' + FORMAT(DateFilter) + ' Purchase Items';
                                Mail_Body := '********* Auto Generated Mail From ERP**********';
                                From_Mail := 'erp@efftronics.com';
                                To_mail := 'santhoshk@efftronics.com';
                             
                                IF USERID = 'ADMIN' THEN
                                    From_Mail := 'ceo@efftronics.com'
                                ELSE
                                    IF USERID = '93MK002' THEN
                                        From_Mail := 'dir@efftronics.com';
                                //   To_mail:='padmaja@efftronics.com,chowdary@efftronics.com,santhoshk@efftronics.com';
                                REPORT.RUN(303, FALSE, FALSE, Rec);
                                REPORT.SAVEASPDF(303, FORMAT('\\data\share\erp\' + 'Authorisation Material' + '.PDF'), Rec);
                                Attachment := '\\data\share\erp\' + 'Authorisation Material.PDF';
                             //  SMTP_Mail.CreateMessage('MATERIAL ASUTHORISATION', From_Mail, To_mail, Mail_Subject, Body, FALSE);
                             EmailMessage.Create( To_mail, Mail_Subject, Body, FALSE);
                                EmailMessage.AddAttachment(Attachment, '');
                                 Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                //   Mail.NP_Mail.Send;ewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);

                                "Shortage Details".RESET;
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                // "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date",DateFilter);
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::Authorised;
                                        "Shortage Details".MODIFY;
                                    UNTIL "Shortage Details".NEXT = 0;
                                MESSAGE('Authorisation Was Successfully Completed');
                                "Show Shortage";
                            END ELSE BEGIN
                                Authorise := FALSE;
                                ERROR('You Dont Have Rights to Authorise');
                            END;
                        END ELSE
                            IF (Data_Choice = Data_Choice::WFA) AND (Choice = Choice::PNUC) THEN BEGIN
                                IF (USERID = 'EFFTRONICS/ANILKUMAR') OR (USERID = 'EFFTRONICS/PADMAJA') OR (USERID = 'EFFTRONICS/CHOWDARY') OR (USERID = 'EFFTRONICS\ANVESH') OR (USERID = 'EFFTRONICS\SPURTHI') THEN BEGIN
                                    Mail_Subject := 'Your Material Request was Authorised for Planned Purchase Date Exceeded Purchase Items';
                                    Mail_Body := '********* Auto Generated Mail From ERP**********';
                                    //   From_Mail:='erp@efftronics.com';
                                    //   To_mail:='santhoshk@efftronics.com';
                                    From_Mail := 'ceo@efftronics.com';
                                    To_mail := 'padmaja@efftronics.com,chowdary@efftronics.com,santhoshk@efftronics.com';
                                    REPORT.RUN(303, FALSE, FALSE, Rec);
                                    REPORT.SAVEASPDF(303, FORMAT('\\data\share\erp\' + 'Authorisation Material' + '.PDF'), Rec);
                                    Attachment := '\\data\share\erp\' + 'Authorisation Material.PDF';
                                    //   Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);

                                    "Shortage Details".RESET;
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                    "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                                    IF "Shortage Details".FINDSET THEN
                                        REPEAT
                                            "Shortage Details".Authorisation := "Shortage Details".Authorisation::Authorised;
                                            "Shortage Details".MODIFY;
                                        UNTIL "Shortage Details".NEXT = 0;

                                END ELSE BEGIN
                                    Authorise := FALSE;
                                    ERROR('You Dont Have Rights to Authorise');
                                END;
                            END ELSE BEGIN
                                Authorise := FALSE;
                                ERROR('Please Choose the Correct Option');
                            END;
                        Authorise := FALSE; */
                        //B2B UPG <<<

                        IF (Data_Choice = Data_Choice::WFA) AND (Choice = Choice::Purchase) THEN BEGIN
                            IF (USERID='EFFTRONICS\ANILKUMAR')  OR (USERID='EFFTRONICS\ANVESH') OR (USERID='EFFTRONICS\SPURTHI') OR (USERID='EFFTRONICS\SUVARCHALADEVI') THEN BEGIN
                                Mail_Subject := 'Your Material Request was Authorised for ' + FORMAT(DateFilter) + ' Purchase Items';
                                Mail_Body := '********* Auto Generated Mail From ERP**********';

                                Recipient.Add('santhoshk@efftronics.com');

                                /* IF USERID = 'ADMIN' THEN
                                    From_Mail := 'ceo@efftronics.com'
                                ELSE
                                    IF USERID = '93MK002' THEN
                                        From_Mail := 'dir@efftronics.com'; */

                                REPORT.RUN(50187, FALSE, FALSE, Rec);
                                REPORT.SAVEASPDF(50187, FORMAT('\\data\share\erp\' + 'Authorisation Material' + '.PDF'), Rec);
                                Attachment := '\\data\share\erp\' + 'Authorisation Material.PDF';

                                EmailMessage.Create(Recipient, Mail_Subject, Body, FALSE);



                                InputFile.Open(Attachment);
                                InputFile.CreateInStream(AttachmentInStream);
                                EmailMessage.AddAttachment(Attachment, 'PDF', AttachmentInStream);

                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


                                "Shortage Details".RESET;
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");

                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::Authorised;
                                        "Shortage Details".MODIFY;
                                    UNTIL "Shortage Details".NEXT = 0;
                                MESSAGE('Authorisation Was Successfully Completed');
                                "Show Shortage";
                            END ELSE BEGIN
                                Authorise := FALSE;
                                ERROR('You Dont Have Rights to Authorise');
                            END;
                        END ELSE
                            IF (Data_Choice = Data_Choice::WFA) AND (Choice = Choice::PNUC) THEN BEGIN
                                IF (USERID='EFFTRONICS\ANILKUMAR')  OR (USERID='EFFTRONICS\SUVARCHALADEVI') OR (USERID='EFFTRONICS\ANVESH') OR (USERID='EFFTRONICS\SPURTHI') THEN BEGIN
                                    Mail_Subject := 'Your Material Request was Authorised for Planned Purchase Date Exceeded Purchase Items';
                                    Mail_Body := '********* Auto Generated Mail From ERP**********';
                                    Recipient.Add('padmaja@efftronics.com');
                                    Recipient.Add('chowdary@efftronics.com');
                                    Recipient.Add('santhoshk@efftronics.com');
                                    REPORT.RUN(50187, FALSE, FALSE, Rec);
                                    REPORT.SAVEASPDF(50187, FORMAT('\\data\share\erp\' + 'Authorisation Material' + '.PDF'), Rec);
                                    Attachment := '\\data\share\erp\' + 'Authorisation Material.PDF';

                                    EmailMessage.Create(Recipient, Mail_Subject, Body, true);

                                    InputFile.Open(Attachment);
                                    InputFile.CreateInStream(AttachmentInStream);
                                    EmailMessage.AddAttachment(Attachment, 'PDF', AttachmentInStream);


                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                    "Shortage Details".RESET;
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                    "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                                    IF "Shortage Details".FINDSET THEN
                                        REPEAT
                                            "Shortage Details".Authorisation := "Shortage Details".Authorisation::Authorised;
                                            "Shortage Details".MODIFY;
                                        UNTIL "Shortage Details".NEXT = 0;

                                END ELSE BEGIN
                                    Authorise := FALSE;
                                    ERROR('You Dont Have Rights to Authorise');
                                END;
                            END ELSE BEGIN
                                Authorise := FALSE;
                                ERROR('Please Choose the Correct Option');
                            END;
                        Authorise := FALSE;
                    end;
                }
                field(MinimumStock; MinimumStock)
                {
                    Caption = 'MinimumStock';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Choice = Choice::Shortage THEN BEGIN
                            Rec.RESET;
                            FormShow;
                            "Calculate Date Filter";
                            "Show Shortage";
                        END ELSE
                            IF Choice = Choice::Purchase THEN BEGIN
                                Rec.RESET;
                                // ACCORDING TO I/P'S SHOWING NECESSAR INORMATION IN FORM
                                FormShow;
                                IF USERID = 'ADMIN' THEN
                                    Data_Choice := Data_Choice::WFA;
                                IF Break_Down THEN BEGIN
                                    IF Choice = Choice::Purchase THEN BEGIN
                                        //Rev01
                                        /*
                                        currpage."Next Week".VISIBLE:=FALSE;
                                        IF Break_Down THEN
                                        BEGIN
                                          currpage."Below Present Week".VISIBLE:=TRUE;
                                          currpage."Next 15 Days".VISIBLE:=TRUE;
                                          currpage."In One Month".VISIBLE:=TRUE;
                                          currpage."Present Week".VISIBLE:=TRUE;
                                        END ELSE
                                        BEGIN
                                          currpage."Below Present Week".VISIBLE:=FALSE;
                                          currpage."Next 15 Days".VISIBLE:=FALSE;
                                          currpage."In One Month".VISIBLE:=FALSE;
                                          currpage."Present Week".VISIBLE:=FALSE;
                                        END;
                                        END ELSE IF  Choice=Choice::PNUC THEN
                                        BEGIN
                                          currpage."Below Present Week".VISIBLE:=FALSE;
                                          currpage."Next Week".VISIBLE:=FALSE;
                                          IF Break_Down THEN
                                          BEGIN
                                            currpage."Present Week".VISIBLE:=TRUE;
                                            currpage."Next 15 Days".VISIBLE:=TRUE;
                                            currpage."In One Month".VISIBLE:=TRUE;
                                         END ELSE
                                         BEGIN
                                           currpage."Present Week".VISIBLE:=FALSE;
                                           currpage."Next 15 Days".VISIBLE:=FALSE;
                                           currpage."In One Month".VISIBLE:=FALSE;
                                         END;
                                       END;
                                       *///Rev01
                                    END;
                                END;
                                "Calculate Date Filter";
                                // RECALCULATING THE SHORTAGE FUNCTION  & DISPLAY DETAILS ON FORM
                                "Show Shortage";
                            END ELSE BEGIN
                                Rec.RESET;
                                // ACCORDING TO I/P'S SHOWING NECESSAR INORMATION IN FORM
                                FormShow;
                                IF USERID = 'ADMIN' THEN
                                    Data_Choice := Data_Choice::WFA;
                                /*
                                IF Break_Down THEN
                                BEGIN
                                  IF Choice=Choice::Purchase THEN
                                  BEGIN
                                    CurrForm."Next Week".VISIBLE:=FALSE;
                                    IF Break_Down THEN
                                    BEGIN
                                      CurrForm."Below Present Week".VISIBLE:=TRUE;
                                      CurrForm."Next 15 Days".VISIBLE:=TRUE;
                                      CurrForm."In One Month".VISIBLE:=TRUE;
                                      CurrForm."Present Week".VISIBLE:=TRUE;
                                    END ELSE
                                    BEGIN
                                      CurrForm."Below Present Week".VISIBLE:=FALSE;
                                      CurrForm."Next 15 Days".VISIBLE:=FALSE;
                                      CurrForm."In One Month".VISIBLE:=FALSE;
                                      CurrForm."Present Week".VISIBLE:=FALSE;
                                    END;
                                    END ELSE IF  Choice=Choice::PNUC THEN
                                    BEGIN
                                      CurrForm."Below Present Week".VISIBLE:=FALSE;
                                      CurrForm."Next Week".VISIBLE:=FALSE;
                                      IF Break_Down THEN
                                      BEGIN
                                        CurrForm."Present Week".VISIBLE:=TRUE;
                                        CurrForm."Next 15 Days".VISIBLE:=TRUE;
                                        CurrForm."In One Month".VISIBLE:=TRUE;
                                     END ELSE
                                     BEGIN
                                       CurrForm."Present Week".VISIBLE:=FALSE;
                                       CurrForm."Next 15 Days".VISIBLE:=FALSE;
                                       CurrForm."In One Month".VISIBLE:=FALSE;
                                     END;
                                   END;
                                END;
                                */
                                "Calculate Date Filter";
                                // RECALCULATING THE SHORTAGE FUNCTION  & DISPLAY DETAILS ON FORM
                                "Show Shortage";
                            END;

                    end;
                }
            }
            repeater(Control1102152044)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Overall Requirement"; Rec."Overall Requirement")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Required  Qty"; Rec."Required  Qty")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Qty. In Stores"; Rec."Qty. In Stores")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Qty. In MCH"; Rec."Qty. In MCH")
                {
                    Caption = 'Qty. In MCH Str';
                    ApplicationArea = All;
                }
                field("Qty. In PROD"; Rec."Qty. In PROD")
                {
                    Caption = 'Qty. In PROD Str';
                    ApplicationArea = All;
                }
                field("Qty Under Inspection"; Rec."Qty Under Inspection")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Purchase Line".RESET;
                        //"Purchase Line".SETCURRENTKEY("Purchase Line"."No.","Purchase Line"."Buy-from Vendor No.");
                        "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."Item No.");
                        "Purchase Line".SETFILTER("Purchase Line"."Location Code", '%1|%2', 'STR', 'MCH');

                        IF (Data_Choice <> Data_Choice::WAP) THEN BEGIN
                            "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                            "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date", '>=%1', "G\L"."Shortage. Calc. Date");
                        END;
                        PAGE.RUNMODAL(56, "Purchase Line");
                    end;
                }
                field("Total PO Qty"; Rec."Total PO Qty")
                {
                    Caption = 'Total PO Qty';
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field(Neditemsqty; Rec.Neditemsqty)
                {
                    Enabled = true;
                    HideValue = false;
                    StyleExpr = ItemStyleExp;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(NeedtoPurchaseOrderQTY; ((Rec."Req Qty" + Rec."Qty. In Material Issues") - (Rec."Qty. In Stores" + Rec."Qty. In MCH" + Rec."Qty. In PROD" + Rec."Purchase Orders" + Rec."Total PO Qty" + Rec."Qty Under Inspection")))
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Req Qty"; Rec."Req Qty")
                {
                    Caption = 'Req Qty(Considering Altertantes)';
                    Visible = true;
                    ApplicationArea = All;
                }
                field(saftyStockQty; saftyStockQty)
                {
                    ApplicationArea = All;
                }
                field(Shortage; Rec.Shortage)
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Earliest Required Day"; Rec."Earliest Required Day")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field(Ear_Recv_Day; Ear_Recv_Day)
                {
                    Caption = 'Earliest Mat. Recv Date';
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        //Added by Rakesh for getting the already present purchase lines on 20-Mar-15
                        "Purchase Line".RESET;
                        "Purchase Line".SETCURRENTKEY("Deviated Receipt Date");
                        "Purchase Line".ASCENDING;
                        "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."Item No.");
                        "Purchase Line".SETRANGE("Purchase Line"."Document Type", 1);
                        "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                        PAGE.RUNMODAL(56, "Purchase Line");
                        // end by Rakesh
                    end;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Alternate Item"; Rec."Alternate Item")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Type Of Item"; Rec."Type Of Item")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Qty. In Material Issues"; Rec."Qty. In Material Issues")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Below Present Week"; Rec."Below Present Week")
                {
                    StyleExpr = ItemStyleExp;
                    Visible = Vis_Only;
                    ApplicationArea = All;
                }
                field("Present Week"; Rec."Present Week")
                {
                    StyleExpr = ItemStyleExp;
                    Visible = Vis_Only;
                    ApplicationArea = All;
                }
                field("Next Week"; Rec."Next Week")
                {
                    StyleExpr = ItemStyleExp;
                    Visible = Vis_Only;
                    ApplicationArea = All;
                }
                field("Next 15 Days"; Rec."Next 15 Days")
                {
                    StyleExpr = ItemStyleExp;
                    Visible = Vis_Only;
                    ApplicationArea = All;
                }
                field("In One Month"; Rec."In One Month")
                {
                    StyleExpr = ItemStyleExp;
                    Visible = Vis_Only;
                    ApplicationArea = All;
                }
                field("Don't Repeat"; Rec."Don't Repeat")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (USERID = 'EFFTRONICS\ANILKUMAR') OR (USERID = 'EFFTRONICS\PADMAJA') OR (USERID = 'EFFTRONICS\ANVESH') OR (USERID = 'EFFTRONICS\BSATISH') OR (USERID = 'EFFTRONICS\GRAVI') OR (USERID = 'EFFTRONICS\SPURTHI') THEN
                            Rec.TESTFIELD(Remarks)
                        ELSE
                            ERROR('YOU DONT HAVE SUFFICIENT RIGHTS');


                        IF (Rec.Remarks = '') OR NOT ((USERID = 'EFFTRONICS\ANILKUMAR') OR (USERID = 'EFFTRONICS\PADMAJA') OR (USERID = 'EFFTRONICS\ANVESH') OR (USERID = 'EFFTRONICS\BSATISH') OR (USERID = 'EFFTRONICS\GRAVI')
                            OR (USERID = 'EFFTRONICS\SPURTHI') OR (USERID = 'EFFTRONICS\SANTHOSHK')) THEN
                            Rec."Don't Repeat" := FALSE;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.TESTFIELD(Reason, Rec.Reason::Null);
                    end;
                }
                field("Not Needed"; Rec."Not Needed")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF FORMAT(Rec.Reason) = 'Null' THEN
                            ERROR('Please Enter the Reason');

                        IF FORMAT(Rec.Reason) = 'Null' THEN
                            Rec."Not Needed" := FALSE;
                    end;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Remarks <> '' THEN
                            ERROR('REMARKS FIELD MUST BE NULL');
                    end;
                }
                field(Difference; Rec.Difference)
                {
                    StyleExpr = ItemStyleExp;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Accepted By Purchase"; Rec."Accepted By Purchase")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin

                        IF (USERID = '89OF002') OR (USERID = 'EFFTRONICS\ANILKUMAR') OR (USERID = '93OF001') OR (USERID = '20P2007')
                        OR (USERID = 'EFFTRONICS\RENUKACH') OR (USERID = 'EFFTRONICS\BRAHMAIAH') OR (USERID = 'EFFTRONICS\ANANDA') OR (USERID = 'EFFTRONICS\ANVESH') OR (USERID = 'EFFTRONICS\SPURTHI') OR (USERID = 'EFFTRONICS\BSATISH') OR (USERID = 'EFFTRONICS\GRAVI')
                          OR (USERID = 'EFFTRONICS\PRANAVI') THEN BEGIN
                            IF (Choice = Choice::PNUC) AND (Data_Choice = Data_Choice::Open) THEN BEGIN
                                IF Rec."Accepted By Purchase" THEN BEGIN
                                    "Shortage Details".RESET;
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                    "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                                     "Shortage Details"."Production Order No.");
                                    "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                    "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
                                    IF "Shortage Details".FINDSET THEN
                                        REPEAT
                                            "Shortage Details"."Accepted By Purchase" := TRUE;
                                            "Shortage Details".MODIFY;
                                        UNTIL "Shortage Details".NEXT = 0;
                                END ELSE BEGIN
                                    "Shortage Details".RESET;
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                    "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                                     "Shortage Details"."Production Order No.");
                                    "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                    "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
                                    IF "Shortage Details".FINDSET THEN
                                        REPEAT
                                            "Shortage Details"."Accepted By Purchase" := FALSE;
                                            "Shortage Details".MODIFY;
                                        UNTIL "Shortage Details".NEXT = 0;
                                END;
                            END ELSE BEGIN
                                Rec."Accepted By Purchase" := FALSE;
                                Rec.MODIFY;
                                ERROR('PLEASE SELECT THE CORRECT OPTION');
                            END;
                        END ELSE BEGIN
                            Rec."Accepted By Purchase" := FALSE;
                            Rec.MODIFY;
                            ERROR('YOU DONT HAVE SUFFICIENT RIGHTS');
                        END;



                        IF NOT ((USERID = '89OF002') OR (USERID = '  07TE024') OR (USERID = 'EFFTRONICS\ANILKUMAR') OR (USERID = 'EFFTRONICS\BRAHMAIAH') OR (USERID = 'EFFTRONICS\BSATISH') OR (USERID = 'EFFTRONICS\GRAVI')
                        OR (USERID = '20P2007') OR (USERID = 'EFFTRONICS\RENUKACH') OR (USERID = 'EFFTRONICS\ANANDA') OR (USERID = 'EFFTRONICS\ANVESH') OR (USERID = 'EFFTRONICS\SPURTHI') OR (USERID = 'EFFTRONICS\PRANAVI')) THEN
                            Rec."Accepted By Purchase" := FALSE;
                    end;
                }
                field("Possible Procurement Date"; Rec."Possible Procurement Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Possible Procured Qty"; Rec."Possible Procured Qty")
                {
                    ApplicationArea = All;
                }
                field("Change Plan"; Rec."Change Plan")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.TESTFIELD("Possible Procurement Date");
                        Rec.TESTFIELD("Possible Procured Qty");
                        Procured_Qty_Temp := Rec."Possible Procured Qty";
                        Shortage_Det2.RESET;
                        Shortage_Det2.SETCURRENTKEY(Shortage_Det2."Item No", Shortage_Det2."Planned Date");
                        Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Rec."Item No.");
                        Shortage_Det2.SETFILTER(Shortage_Det2."Planned Date", '>=%1', Rec."Possible Procurement Date");
                        Shortage_Det2.SETRANGE(Shortage_Det2."Planned Purchase Date", 0D);
                        IF Shortage_Det2.FINDSET THEN
                            REPEAT
                                IF Procured_Qty_Temp > 0 THEN BEGIN
                                    Plan_Change.Item_Plan_Change(Shortage_Det2);
                                    Procured_Qty_Temp -= Shortage_Det2.Shortage;
                                END;
                            UNTIL Shortage_Det2.NEXT = 0;
                    end;
                }
                field("Final Mat. Req. Date"; Rec."Final Mat. Req. Date")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Qty. In R&D"; Rec."Qty. In R&D")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Get From R&D"; Rec."Get From R&D")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin

                        IF Rec."Overall Requirement" < Rec."Qty. In R&D" THEN BEGIN
                            IF Rec."Get From R&D" THEN BEGIN
                                "Material Issues Header".RESET;
                                MESSAGE(FORMAT(TODAY));
                                "Material Issues Header".SETFILTER("Material Issues Header".Remarks, 'Create From Indent Automisation');
                                "Material Issues Header".SETRANGE("Material Issues Header"."Receipt Date", TODAY);
                                "Material Issues Header".SETRANGE("Material Issues Header"."Transfer-from Code", 'R&D STR');
                                IF "Material Issues Header".FINDFIRST THEN BEGIN
                                    MESSAGE("Material Issues Header"."No.");
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", "Material Issues Header"."No.");
                                    IF MaterialIssueLine.FINDLAST THEN
                                        LineNo := MaterialIssueLine."Line No.";
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := "Material Issues Header"."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", Rec."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := Rec."Unit of Measure";
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Qty. to Receive", Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity", Rec."Overall Requirement");
                                    MaterialIssueLine."Prod. Order No." := 'EFF08GEN01';
                                    MaterialIssueLine."Prod. Order Line No." := 10000;
                                    MaterialIssueLine.INSERT;
                                END ELSE BEGIN
                                    "Material Issues Header".INIT;
                                    InventorySetup.GET;
                                    ManufacturingSetup.GET();
                                    ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                    "Material Issues Header".RESET;
                                    "Material Issues Header".INIT;
                                    "Material Issues Header"."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                                    "Material Issues Header".Remarks := 'Create From Indent Automisation';
                                    "Material Issues Header"."Receipt Date" := TODAY;
                                    "Material Issues Header"."Transfer-from Code" := 'R&D STR';
                                    "Material Issues Header"."Transfer-to Code" := 'STR';
                                    "Material Issues Header".VALIDATE("Prod. Order No.", 'EFF08GEN01');
                                    "Material Issues Header".VALIDATE("Prod. Order Line No.", 10000);
                                    "Material Issues Header"."User ID" := USERID;
                                    user.RESET;
                                    user.SETRANGE(user."User ID", USERID);
                                    IF user.FINDFIRST THEN;
                                    if UserGrec.Get(user."User ID") then
                                        "Material Issues Header"."Resource Name" := UserGrec."Full Name";
                                    "Material Issues Header"."Creation DateTime" := CURRENTDATETIME;
                                    "Material Issues Header".INSERT;
                                    LineNo := 10000;
                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := "Material Issues Header"."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", Rec."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := Rec."Unit of Measure";
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Qty. to Receive", Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity", Rec."Overall Requirement");
                                    MaterialIssueLine."Prod. Order No." := 'EFF08GEN01';
                                    MaterialIssueLine."Prod. Order Line No." := 10000;
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;
                                END;
                            END;
                        END ELSE BEGIN
                            Rec."Get From R&D" := FALSE;
                            ERROR('THERE IS NO REQUIRED STOCK IN R&d STR');
                            Rec.MODIFY;
                        END;
                    end;
                }
                field("Qty. In CS"; Rec."Qty. In CS")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Get From CS"; Rec."Get From CS")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin

                        IF Rec."Overall Requirement" < Rec."Qty. In CS" THEN BEGIN

                            IF Rec."Get From CS" THEN BEGIN
                                "Material Issues Header".RESET;
                                "Material Issues Header".SETRANGE("Material Issues Header"."Receipt Date", TODAY);
                                "Material Issues Header".SETRANGE("Material Issues Header"."Transfer-from Code", 'CS STR');
                                "Material Issues Header".SETFILTER("Material Issues Header".Remarks, 'Create From Indent Automisation');
                                IF "Material Issues Header".FINDFIRST THEN BEGIN
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", "Material Issues Header"."No.");
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Item No.", Rec."Item No.");
                                    IF MaterialIssueLine.FINDFIRST THEN BEGIN
                                        Rec."Get From R&D" := FALSE;
                                        ERROR(' ALL READY REQUEST WAS CREATED FOR THIS ITEM');
                                    END;
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", "Material Issues Header"."No.");
                                    IF MaterialIssueLine.FINDLAST THEN
                                        LineNo := MaterialIssueLine."Line No.";
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.RESET;

                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := "Material Issues Header"."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", Rec."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := Rec."Unit of Measure";
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Qty. to Receive", Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity", Rec."Overall Requirement");
                                    MaterialIssueLine."Prod. Order No." := 'EFF08GEN01';
                                    MaterialIssueLine."Prod. Order Line No." := 10000;

                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;

                                END ELSE BEGIN
                                    "Material Issues Header".INIT;
                                    InventorySetup.GET;
                                    ManufacturingSetup.GET();
                                    ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                    "Material Issues Header".RESET;
                                    "Material Issues Header".INIT;
                                    "Material Issues Header"."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                                    "Material Issues Header".Remarks := 'Create From Indent Automisation';
                                    "Material Issues Header"."Receipt Date" := TODAY;
                                    "Material Issues Header"."Transfer-from Code" := 'CS STR';
                                    "Material Issues Header"."Transfer-to Code" := 'STR';
                                    "Material Issues Header".VALIDATE("Prod. Order No.", 'EFF08GEN01');
                                    "Material Issues Header".VALIDATE("Prod. Order Line No.", 10000);
                                    "Material Issues Header"."User ID" := USERID;
                                    user.RESET;
                                    user.SETRANGE(user."User ID", USERID);
                                    IF user.FINDFIRST THEN;
                                    if UserGrec.Get(user."User ID") then
                                        "Material Issues Header"."Resource Name" := UserGrec."Full Name";
                                    "Material Issues Header"."Creation DateTime" := CURRENTDATETIME;
                                    "Material Issues Header".INSERT;
                                    LineNo := 10000;
                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := "Material Issues Header"."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", Rec."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := Rec."Unit of Measure";
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Qty. to Receive", Rec."Overall Requirement");
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity", Rec."Overall Requirement");
                                    MaterialIssueLine."Prod. Order No." := 'EFF08GEN01';
                                    MaterialIssueLine."Prod. Order Line No." := 10000;

                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;
                                END;
                            END;
                        END ELSE BEGIN
                            Rec."Get From CS" := FALSE;
                            ERROR('THERE IS NO REQUIRED STOCK IN CS STR');
                        END;
                    end;
                }
                field("Purchase Time Slot"; Rec."Purchase Time Slot")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Suitable Vendor"; Rec."Suitable Vendor")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field(Confirmed; Rec.Confirmed)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.TESTFIELD("Suitable Vendor");
                        Rec.TESTFIELD("Direct Unit Cost");
                        Rec.TESTFIELD("Unit Cost");

                        IF Rec.Confirmed THEN
                            EditAmt := FALSE
                        ELSE
                            EditAmt := TRUE;


                        IF Rec.Confirmed THEN BEGIN
                            "Shortage Details".RESET;
                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                            "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                            IF "Shortage Details".FINDSET THEN
                                REPEAT
                                    "Shortage Details"."Suitable Vendor" := Rec."Suitable Vendor";
                                    "Shortage Details"."Unit Cost" := Rec."Unit Cost";
                                    "Shortage Details".VALIDATE("Shortage Details"."Unit Cost", Rec."Unit Cost");
                                    "Shortage Details"."Direct Unit Cost" := Rec."Direct Unit Cost";
                                    "Shortage Details"."Vendor Name" := Rec."Vendor Name";
                                    "Shortage Details".MODIFY;
                                UNTIL "Shortage Details".NEXT = 0;
                            //  CurrForm."Unit Cost".EDITABLE:=FALSE;
                            //  CurrForm."Suitable Vendor".EDITABLE:=FALSE;
                        END ELSE BEGIN
                            "Shortage Details".RESET;
                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                            "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                            IF "Shortage Details".FINDSET THEN
                                REPEAT
                                    "Shortage Details"."Suitable Vendor" := '';
                                    "Shortage Details"."Unit Cost" := 0;
                                    "Shortage Details".VALIDATE("Shortage Details"."Unit Cost", Rec."Unit Cost");
                                    "Shortage Details"."Direct Unit Cost" := 0;
                                    "Shortage Details"."Vendor Name" := '';
                                    "Shortage Details".MODIFY;
                                UNTIL "Shortage Details".NEXT = 0;
                            //  CurrForm."Unit Cost".EDITABLE:=TRUE;
                            //  CurrForm."Suitable Vendor".EDITABLE:=TRUE;

                        END;



                        IF (Rec."Suitable Vendor" = '') OR (Rec."Direct Unit Cost" = 0) OR (Rec."Unit Cost" = 0) THEN
                            Rec.Confirmed := FALSE;
                    end;
                }
                field("Tax Structure"; Rec."Tax Structure")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = EditAmt;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Confirmed THEN
                            EditAmt := FALSE
                        ELSE
                            EditAmt := TRUE;
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = EditAmt;
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Confirmed THEN
                            EditAmt := FALSE
                        ELSE
                            EditAmt := TRUE;
                        Rec."Total Cost" := Rec."Unit Cost" * Rec.Shortage;
                        Rec.MODIFY;
                    end;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Editable = EditAmt;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec.Confirmed THEN
                            EditAmt := FALSE
                        ELSE
                            EditAmt := TRUE;
                    end;
                }
                field("Production  Orders"; Rec."Production  Orders")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin

                        IF Choice = Choice::Shortage THEN BEGIN
                            "Shortage Details".RESET;
                            "Shortage Details".SETFILTER("Shortage Details"."Planned Date", DateFilter);
                            "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                            PAGE.RUNMODAL(60069, "Shortage Details");
                        END ELSE
                            IF Choice = Choice::Purchase THEN BEGIN
                                "Shortage Details".RESET;

                                IF NOT ((USERID = 'ADMIN') OR (USERID = 'SUPER') OR (USERID = '93MK002')) THEN
                                    "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D)
                                ELSE
                                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, '%1|%2|%3', "Shortage Details".Authorisation::WFA,
                                                                                                            "Shortage Details".Authorisation::indent,
                                                                                                            "Shortage Details".Authorisation::Authorised);
                                "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", DateFilter);
                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                PAGE.RUNMODAL(60069, "Shortage Details");
                            END ELSE BEGIN
                                "Shortage Details".RESET;
                                "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                PAGE.RUNMODAL(60069, "Shortage Details");
                            END;

                    end;
                }
                field("Minimum Order Qty."; Rec."Minimum Order Qty.")
                {
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
            }
            group(Control1102152108)
            {
                ShowCaption = false;
                grid(Control1102152107)
                {
                    ShowCaption = false;
                    group(Control1102152106)
                    {
                        ShowCaption = false;
                        field("xRec.COUNT"; xRec.COUNT)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152104)
                    {
                        ShowCaption = false;
                        field(Color_Alternate; Color_Alternate)
                        {
                            Editable = false;
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152102)
                    {
                        ShowCaption = false;
                        field(Color_MOQ; Color_MOQ)
                        {
                            Editable = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152100)
                    {
                        ShowCaption = false;
                        field(Color_Ordered; Color_Ordered)
                        {
                            Editable = false;
                            Style = Subordinate;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152097)
                    {
                        ShowCaption = false;
                        field(Color_Problematic; Color_Problematic)
                        {
                            Editable = false;
                            Style = Unfavorable;
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
        area(processing)
        {
            group("Plan Changes")
            {
                action(Prodcution)
                {
                    Image = Production;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        // SHOWING "PRODUCTION ORDERS" WHICH ARE IN IN PLAN & THOSE DETIALS
                        "Production Order".RESET;
                        "Production Order".SETCURRENTKEY("Production Order"."Prod Start date");
                        "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', 0D);
                        IF "Production Order".FINDSET THEN
                            REPEAT
                                "Production Order".MARK(FALSE);
                                Shortage_Det2.RESET;
                                Shortage_Det2.SETCURRENTKEY(Shortage_Det2."Production Order No.", Shortage_Det2."Possible Production Plan Date");
                                Shortage_Det2.SETRANGE(Shortage_Det2."Production Order No.", "Production Order"."No.");
                                IF Shortage_Det2.FINDLAST THEN BEGIN
                                    IF Shortage_Det2."Possible Production Plan Date" > 0D THEN BEGIN
                                        "Production Order".MARK(TRUE);
                                        "Production Order"."Plan Shifting Date" := Shortage_Det2."Possible Production Plan Date";
                                        "Production Order".MODIFY;
                                    END;

                                END;
                            UNTIL "Production Order".NEXT = 0;
                        "Production Order".MARKEDONLY(TRUE);
                        PAGE.RUN(99000815, "Production Order");
                    end;
                }
                action("Sale Order")
                {
                    Image = GetOrder;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Sales_Line.RESET;
                        Sales_Line.SETCURRENTKEY(Sales_Line."Material Reuired Date", Sales_Line."No.");
                        Sales_Line.SETFILTER(Sales_Line."Material Reuired Date", '>%1', ("G\L"."Shortage. Calc. Date" + 1));
                        Sales_Line.SETFILTER(Sales_Line."Plan Shifting Date", '>%1', 0D);
                        PAGE.RUN(516, Sales_Line);
                    end;
                }
                action("Sales Schedule")
                {
                    Image = Sales;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Schedule.RESET;
                        Schedule.SETCURRENTKEY(Schedule."Material Required Date", Schedule."No.");
                        Schedule.SETFILTER(Schedule."Material Required Date", '>%1', ("G\L"."Shortage. Calc. Date" + 1));
                        Schedule.SETFILTER(Schedule."Plan Shifting Date", '>%1', 0D);
                        PAGE.RUN(60125, Schedule);
                    end;
                }
            }
            group("Color Indications")
            {
                action("Alternate Items")
                {
                    Image = SelectItemSubstitution;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RESET;
                        Rec.SETRANGE("Type Of Item", Rec."Type Of Item"::Alternate);
                    end;
                }
                action("All Ready Ordered Items")
                {
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RESET;
                        Rec.SETRANGE("Type Of Item", Rec."Type Of Item"::Ordered);
                    end;
                }
                action("Less Than MOQ Items")
                {
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RESET;
                        Rec.SETRANGE("Type Of Item", Rec."Type Of Item"::MOQ);
                    end;
                }
                action("Problematic Items")
                {
                    Image = DefaultFault;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RESET;
                        Rec.SETRANGE("Complicarted Item", TRUE);
                    end;
                }
            }
            group("Other Actions")
            {
                action(Audit)
                {
                    Image = GLBalance;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        REPORT.RUN(501, TRUE, FALSE, Rec);
                    end;
                }
                action(Plan)
                {
                    Image = CalculateRegenerativePlan;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        PAGE.RUN(60009);
                    end;
                }
                action(Refresh)
                {
                    Image = RefreshPlanningLine;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //>> ORACLE UPG
                        /*
                        IF UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\ANVESH', 'EFFTRONICS\PADMASRI', 'SUPER', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\BSATISH', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SARDHAR', 'EFFTRONICS\GRAVI'] THEN BEGIN
                            //Rev01 Start
                            //Code Commented
                            
                            // IF ISCLEAR(SQLConnection) THEN
                            //    CREATE(SQLConnection);
                            // IF ISCLEAR(RecordSet) THEN
                            //    CREATE(RecordSet); //Rev01
                            
                            //  IF ISCLEAR(SQLConnection) THEN
                            //      CREATE(SQLConnection, FALSE, TRUE); //Rev01
                            //  IF ISCLEAR(RecordSet) THEN
                            //      CREATE(RecordSet, FALSE, TRUE); //Rev01
                            //Rev01 End

                            WebRecStatus := Quotes + Text50001 + Quotes;
                            OldWebStatus := Quotes + Text50002 + Quotes;
                            SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                            SQLConnection.Open;
                            SQLQuery := 'select TO_CHAR(AUTH_Status) STATUS from shortage_Aut where shortage_date=''' +
                             FORMAT("G\L"."Shortage. Calc. Date", 0, '<Day>-<Month Text,3>-<Year4>') + '''';
                            //  MESSAGE(SQLQuery);
                            RecordSet := SQLConnection.Execute(SQLQuery);

                            IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                                // MESSAGE('test1');
                                IF FORMAT(RecordSet.Fields.Item('STATUS').Value) = '1' THEN BEGIN
                                    //  MESSAGE('test2');
                                    "Shortage Details".RESET;
                                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                                    IF "Shortage Details".FINDSET THEN
                                        REPEAT
                                                "Shortage Details".Authorisation := "Shortage Details".Authorisation::Authorised;
                                            "Shortage Details".MODIFY;
                                            ShortageAuthorizedMaterialCreation("Shortage Details");
                                        UNTIL "Shortage Details".NEXT = 0;
                                    Data_Choice := Data_Choice::Authorised;
                                    "Show Shortage";
                                    FormShow;

                                END ELSE
                                    ERROR(' YOUR SHORTAGE MATERIAL REQUEST WAS NOT AUTHORISED');
                                SQLConnection.Close;
                            END ELSE BEGIN
                                SQLConnection.Close;
                                ERROR('THERE IS NO SHORTAGE MATERIAL REQUEST FOR THIS CYCLE');
                            END;


                            "Shortage Details".RESET;
                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                            IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::Authorised;
                                        "Shortage Details".MODIFY;
                                    UNTIL "Shortage Details".NEXT = 0;
                            Data_Choice := Data_Choice::Authorised;
                            "Show Shortage";
                            FormShow;

                        END;
*/
                        //<< ORACLE UPG
                    end;
                }
                action(Excel)
                {
                    ApplicationArea = All;
                }
                action(Document)
                {
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        HYPERLINK('\\erpserver\ErpAttachments\Shortage_Process.pdf');
                    end;
                }
            }
            group("Item Related")
            {
                action("Change the Alternate Item")
                {
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        Rec.SETFILTER("Alternate Item", '<>%1', '');
                        IF Rec.FINDSET THEN
                            REPEAT
                                Plan_Change.Change_Alternate_Items(Rec."Item No.", Rec."Alternate Item");
                            UNTIL Rec.NEXT = 0;
                        MESSAGE('ITEMS ARE CHANGED');
                        Rec.RESET;
                        "Show Shortage";
                    end;
                }
                action("Delete Not Needed Items")
                {
                    Image = DeleteAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //B2B UPG >>>
                        /* To_mail := '';
                        Status := 'Not Needed';
                        Rec.SETRANGE("Not Needed", TRUE);
                        IF Rec.FINDSET THEN BEGIN
                                                REPEAT
                                                    IF Choice = Choice::PNUC THEN BEGIN
                                                        "Shortage Details".RESET;
                                                        "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                                        "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                                        "Shortage Details".DELETEALL;
                                                        COMMIT;
                                                    END ELSE BEGIN
                                                        "Shortage Details".RESET;
                                                        "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                                        "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                                                        "Shortage Details".DELETEALL;
                                                        COMMIT;
                                                    END;
                                                    Status := '';
                                                UNTIL Rec.NEXT = 0;
                            user.SETRANGE(user."User Name", USERID);
                            IF user.FINDFIRST THEN BEGIN
                                Mail_Subject := user."Full Name" + ' Deleting Some Items as Not Needed ';
                                Mail_Body := '********* Auto Generated Mail From ERP**********';
                                REPORT.RUN(303, FALSE, FALSE, Rec);
                                REPORT.SAVEASPDF(303, FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation Material' + '.PDF'), Rec);
                                From_Mail := user.MailID;
                                Attachment := '\\erpserver\ErpAttachments\' + 'Authorisation Material.PDF';
                                To_mail += 'padmaja@efftronics.com,anvesh@efftronics.com';
                                SMTP_Mail.CreateMessage('NOT UNDER CONTROL ITEMS', From_Mail, To_mail, Mail_Subject, Body, FALSE);
                                SMTP_Mail.AddRecipients('ERP@efftronics.com');
                                SMTP_Mail.AddAttachment(Attachment, '');//EFFUPG
                                SMTP_Mail.Send;
                            END;

                            MESSAGE('NOT NEEDED ITEMS ARE DELETED');
                            Rec.RESET;
                            "Show Shortage";
                        END; */     //B2B UPG

                        //To_mail := '';
                        Status := 'Not Needed';
                        Rec.SETRANGE("Not Needed", TRUE);
                        IF Rec.FINDSET THEN BEGIN
                            REPEAT
                                IF Choice = Choice::PNUC THEN BEGIN
                                    "Shortage Details".RESET;
                                    "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                    "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                    "Shortage Details".DELETEALL;
                                    COMMIT;
                                END ELSE BEGIN
                                    "Shortage Details".RESET;
                                    "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                    "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                                    "Shortage Details".DELETEALL;
                                    COMMIT;
                                END;
                                Status := '';
                            UNTIL Rec.NEXT = 0;
                            user.SETRANGE(user."User ID", USERID);
                            IF user.FINDFIRST THEN BEGIN
                                if UserGrec.Get(user."User ID") then
                                    Mail_Subject := UserGrec."Full Name" + ' Deleting Some Items as Not Needed ';
                                Mail_Body := '********* Auto Generated Mail From ERP**********';
                                REPORT.RUN(50187, FALSE, FALSE, Rec);
                                REPORT.SAVEASPDF(50187, FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation Material' + '.PDF'), Rec);
                                //From_Mail := user.MailID;
                                Attachment := '\\erpserver\ErpAttachments\' + 'Authorisation Material.PDF';

                                Recipient.Add('padmaja@efftronics.com');
                                Recipient.Add('anvesh@efftronics.com');
                                Recipient.Add('ERP@efftronics.com');
                                EmailMessage.Create(Recipient, Mail_Subject, Body, FALSE);



                                InputFile.Open(Attachment);
                                InputFile.CreateInStream(AttachmentInStream);
                                EmailMessage.AddAttachment(Attachment, 'PDF', AttachmentInStream);


                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            END;

                            MESSAGE('NOT NEEDED ITEMS ARE DELETED');
                            Rec.RESET;
                            "Show Shortage";
                        END;
                    end;
                }
                action("Delete All Ready Ordrd.  Items")
                {
                    Image = DeleteExpiredComponents;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ToolTip = 'Delete All Ready Ordered  Items';
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        Rec.SETRANGE("Type Of Item", Rec."Type Of Item"::Ordered);
                        IF Rec.FINDSET THEN
                            REPEAT
                                "Shortage Details".RESET;
                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Shortage Details".DELETE;
                                    UNTIL "Shortage Details".NEXT = 0;
                            UNTIL Rec.NEXT = 0;
                        MESSAGE('ALL READY ORDERED ITEMS ARE DELETED');
                        Rec.RESET;
                        "Show Shortage";
                    end;
                }
                action("Remove the Don't Repeat Items")
                {
                    Image = VoidElectronicDocument;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        Status := 'Not Needed';
                        Rec.SETRANGE("Don't Repeat", TRUE);


                        IF Rec.FINDSET THEN
                            REPEAT
                                "Shortage Details".RESET;
                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Prod. Order. Component".RESET;
                                        "Prod. Order. Component".SETCURRENTKEY("Prod. Order. Component"."Prod. Order No.", "Prod. Order. Component"."Item No.");
                                        "Prod. Order. Component".SETRANGE("Prod. Order. Component"."Prod. Order No.", "Shortage Details"."Production Order No.");
                                        "Prod. Order. Component".SETRANGE("Prod. Order. Component"."Item No.", "Shortage Details"."Item No");
                                        IF "Prod. Order. Component".FINDSET THEN
                                            REPEAT
                                                "Prod. Order. Component"."Don't Consider" := TRUE;
                                                "Prod. Order. Component".MODIFY;
                                            UNTIL "Prod. Order. Component".NEXT = 0;
                                        "Shortage Details".DELETE;
                                    UNTIL "Shortage Details".NEXT = 0;
                            UNTIL Rec.NEXT = 0;

                        user.SETRANGE(user."User ID", USERID);
                        IF user.FINDFIRST THEN BEGIN
                            if UserRec.Get(user."User ID") then
                                Mail_Subject := UserRec."Full Name" + ' Decided Some Items as Dont Repeat Items ';
                            Mail_Body := '********* Auto Generated Mail From ERP**********';
                            REPORT.RUN(50187, FALSE, FALSE, Rec);
                            REPORT.SAVEASPDF(50187, FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation Material' + '.PDF'), Rec);
                            From_Mail := user.MailID;
                            // .. To_mail := 'Padmaja@efftronics.com,anvesh@efftronics.com,';
                            Recipient.Add('Padmaja@efftronics.com');
                            Recipient.Add('anvesh@efftronics.com');
                            Attachment := '\\erpserver\ErpAttachments\' + 'Authorisation Material.PDF';
                            EmailMessage.Create(Recipient, Mail_Subject, Body, FALSE);


                            InputFile.Open(Attachment);
                            InputFile.CreateInStream(AttachmentInStream);
                            EmailMessage.AddAttachment(Attachment, 'PDF', AttachmentInStream);



                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


                            // Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);
                        END;
                        Status := '';
                        MESSAGE('DONT REPEAT ITEMS ARE DELETED');
                        Rec.RESET;
                        "Show Shortage";
                    end;
                }
            }
            group("Forward Actions")
            {
                action("Frwd To Purch. For Availbility")
                {
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ToolTip = 'Forward To Purchase For Availability';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF UPPERCASE(USERID) IN ['EFFTRONICS\PADMAJA', 'SUPER', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH'] THEN BEGIN
                            IF (Choice = Choice::PNUC) AND (Data_Choice = Data_Choice::Open) THEN BEGIN
                                Mail_Subject := 'Please Specify the Material Availabilty For Follwing Items';
                                Mail_Body := '********* Auto Generated Mail From ERP**********';
                                REPORT.RUN(50187, FALSE, FALSE, Rec);
                                REPORT.SAVEASPDF(50187, FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation Material' + '.PDF'), Rec);
                                From_Mail := 'Padmaja@efftronics.com';
                                // To_mail:='santhoshk@efftronics.com';
                                //To_mail := 'erp@efftronics.com';
                                Recipient.Add('erp@efftronics.com');
                                // Attachment := '\\erpserver\ErpAttachments\' + 'Authorisation Material.PDF';
                                Emailmessage.Create(Recipient, Mail_Subject, Body, false);


                                Attachment1 := FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation Material' + '.PDF');

                                InputFile.Open(Attachment1);
                                InputFile.CreateInStream(AttachmentInStream);
                                EmailMessage.AddAttachment(Attachment1, 'PDF', AttachmentInStream);


                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                // SMTP_Mail.Send;
                                // Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);
                                MESSAGE('DATA WAS SENT TO PURCHASE DEPARTMENT');
                            END ELSE
                                ERROR('PLEASE SELECT THE CORRECT OPTION');
                        END ELSE
                            ERROR('YOU DONT HAVE SUFFICIENT RIGHTS TO FORWARD');
                    end;
                }
                action("Frwd Avail. To Prod.Incharge")
                {
                    Image = AvailableToPromise;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ToolTip = 'Forward Availabilty Details To Production Incharge';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF UPPERCASE(USERID) IN ['EFFTRONICS\CHOWDARY', 'SUPER', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\ANANDA', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI'] THEN BEGIN
                            IF (Choice = Choice::PNUC) AND (Data_Choice = Data_Choice::Open) THEN BEGIN
                                Mail_Subject := 'The Following Items Will be Avaialable for the Earliest Dates';
                                Mail_Body := '********* Auto Generated Mail From ERP**********';
                                Rec.SETRANGE("Accepted By Purchase", TRUE);
                                REPORT.RUN(50187, FALSE, FALSE, Rec);
                                REPORT.SAVEASPDF(50187, FORMAT('\\erpserver\erpattachments\' + 'Authorisation Material' + '.PDF'), Rec);
                                //From_Mail:='CHOWDARY@efftronics.com';
                                From_Mail := 'erp@efftronics.com';
                                // To_mail:='santhoshk@efftronics.com';
                                //  To_mail := 'PADMAJA@efftronics.com,anvesh@efftronics.com';
                                Recipient.Add('PADMAJA@efftronics.com');
                                Recipient.Add('anvesh@efftronics.com');
                                EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, false);
                                //SMTP_Mail.CreateMessage('NOT UNDER CONTROL ITEMS', From_Mail, To_mail, Mail_Subject, Body, FALSE);

                                Attachment1 := FORMAT('\\erpserver\erpattachments\' + 'Authorisation Material' + '.PDF');

                                InputFile.Open(Attachment1);
                                InputFile.CreateInStream(AttachmentInStream);
                                EmailMessage.AddAttachment(Attachment1, 'PDF', AttachmentInStream);


                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                //Attachment := '\\erpserver\erpattachments\' + 'Authorisation Material.PDF';
                                //Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);
                                MESSAGE('DATA WAS SENT TO PRODUCTION INCHARGE');
                            END ELSE
                                ERROR('PLEASE SELECT THE CORRECT OPTION');
                        END ELSE
                            ERROR('YOU DONT HAVE SUFFICIENT RIGHTS TO FORWARD');
                    end;
                }
                action("Specify Change Acording Avail.")
                {
                    Image = ImplementPriceChange;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ToolTip = 'Specify the Changes According to Availability';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        Rec.SETRANGE("Accepted By Purchase", FALSE);
                        IF Rec.FINDSET THEN
                            REPEAT
                                "Shortage Details".RESET;
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                                 "Shortage Details"."Production Order No.");
                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        IF "Shortage Details"."Production Order No." <> '' THEN BEGIN
                                            "Production Order".RESET;
                                            "Production Order".SETRANGE("Production Order"."No.", "Shortage Details"."Production Order No.");
                                            IF "Production Order".FINDFIRST THEN BEGIN
                                                "Production Order"."Change To Specified Plan Date" := TRUE;
                                                "Production Order".MODIFY;
                                            END;
                                        END ELSE BEGIN
                                            Sales_Line.RESET;
                                            Sales_Line.SETRANGE(Sales_Line."Document No.", "Shortage Details"."Sales Order No.");
                                            Sales_Line.SETRANGE(Sales_Line."No.", "Shortage Details"."Item No");
                                            Sales_Line.SETFILTER(Sales_Line."Material Reuired Date", '>%1', "G\L"."Shortage. Calc. Date");
                                            Sales_Line.SETFILTER(Sales_Line."Plan Shifting Date", '>%1', 0D);
                                            IF Sales_Line.FINDFIRST THEN BEGIN
                                                Sales_Line."Change to Specified Plan Date" := TRUE;
                                                Sales_Line.MODIFY;
                                            END;
                                            Schedule.RESET;
                                            Schedule.SETRANGE(Schedule."Document No.", "Shortage Details"."Sales Order No.");
                                            Schedule.SETRANGE(Schedule."No.", "Shortage Details"."Item No");
                                            Schedule.SETFILTER(Schedule."Material Required Date", '>%1', "G\L"."Shortage. Calc. Date");
                                            Schedule.SETFILTER(Schedule."Plan Shifting Date", '>%1', 0D);
                                            IF Schedule.FINDFIRST THEN BEGIN
                                                Schedule."Change To Specified Plan Date" := TRUE;
                                                Schedule.MODIFY;
                                            END;
                                        END;


                                    UNTIL "Shortage Details".NEXT = 0;


                            UNTIL Rec.NEXT = 0;
                    end;
                }
            }
            group(Functions)
            {
                group("&Functions")
                {
                    Image = AnalysisView;
                    action("Dump to Cash Flow")
                    {
                        Image = CashFlow;
                        Visible = true;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin

                            // Modify the Shortage Data into week wise Purchase
                            WINDOW.OPEN(Text001);
                            "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
                            // "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date",'>%1',0D);
                            IF "Shortage Details".FINDSET THEN
                                REPEAT
                                    WINDOW.UPDATE(1, "Shortage Details"."Planned Purchase Date");


                                    IF "Shortage Details"."Planned Purchase Date" = 0D THEN BEGIN
                                        IF ((DATE2DWY(TODAY, 1) = 1) OR (DATE2DWY(TODAY, 1) = 4)) THEN BEGIN
                                            "Shortage Details"."Vitual Purchase Date" := TODAY + 2;
                                        END ELSE
                                            IF ((DATE2DWY(TODAY, 1) = 2) OR (DATE2DWY(TODAY, 1) = 5)) THEN BEGIN
                                                "Shortage Details"."Vitual Purchase Date" := TODAY + 1;
                                            END ELSE BEGIN
                                                "Shortage Details"."Vitual Purchase Date" := TODAY;
                                            END;
                                    END ELSE BEGIN
                                        IF ((DATE2DWY("Shortage Details"."Planned Purchase Date", 1) = 1) OR
                                             (DATE2DWY("Shortage Details"."Planned Purchase Date", 1) = 4)) THEN BEGIN
                                            "Shortage Details"."Vitual Purchase Date" := "Shortage Details"."Planned Purchase Date" + 2;
                                        END ELSE
                                            IF ((DATE2DWY("Shortage Details"."Planned Purchase Date", 1) = 2) OR
                                                (DATE2DWY("Shortage Details"."Planned Purchase Date", 1) = 5)) THEN BEGIN
                                                "Shortage Details"."Vitual Purchase Date" := "Shortage Details"."Planned Purchase Date" + 1;
                                            END ELSE BEGIN
                                                "Shortage Details"."Vitual Purchase Date" := "Shortage Details"."Planned Purchase Date";
                                            END;

                                    END;
                                    "Shortage Details".MODIFY;
                                UNTIL "Shortage Details".NEXT = 0;
                            WINDOW.CLOSE;
                            REPORT.RUN(5909);
                            "G\L".GET;
                            "G\L"."Expected Orders Data Dump" := TRUE;
                            "G\L".MODIFY;
                        end;
                    }
                    action("Calculate Plan Report")
                    {
                        Image = CalculatePlan;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            REPORT.RUN(801);
                        end;
                    }
                    action("Release All the Indents")
                    {
                        Image = ResetStatus;
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Make Intdent")
                    {
                        Caption = '<Make Indent>';
                        Image = Indent;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin


                            IF (Choice = Choice::Purchase) AND (Data_Choice = Data_Choice::Authorised) THEN BEGIN
                                /*
                                  "Shortage Details".RESET;
                                  "Shortage Details".SETCURRENTKEY("Shortage Details"."Sales Order No.","Shortage Details"."Item No");
                                  "Shortage Details".SETFILTER("Shortage Details"."Sales Order No.",'');
                                  IF "Shortage Details".FINDFIRST THEN
                                    MESSAGE('There Are Some Items Which are Not Having the "Sales Order No."');
                                */ //added by pranavi to fill empty sales order number in item lot numbers on 06-01-2015
                                Plan_Change.FillSaleOrdrNum_ItmLotNums;
                                //end pranavi
                                "Indent Header".SETRANGE("Indent Header"."Creation Date", TODAY);
                                "No_Of Indent" := "Indent Header".COUNT + 1;
                                Ind_Count := "Indent Header".COUNT + 1;

                                Prev_Sale_Order := '';
                                Prev_Item := '';
                                // Added by Pranavi on 20-Dec-2016
                                Prev_ProdOrder := '';
                                Prev_Prd_ord_Lin_no := 0;
                                Prev_Prd_ord_Comp_Lin_no := 0;
                                // End by Pranavi

                                "Shortage Details".RESET;
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Sales Order No.", "Shortage Details"."Item No");
                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Authorised');
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT

                                        IF Material_Req_Day > "Shortage Details"."Planned Date" THEN
                                            Material_Req_Day := "Shortage Details"."Planned Date";

                                        IF Prev_Sale_Order <> "Shortage Details"."Sales Order No." THEN BEGIN
                                            IF Prev_Sale_Order <> '' THEN BEGIN
                                                Line_no += 10000;
                                                "Indent Line".INIT;
                                                "Indent Line"."Document No." := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3))
                                                                         + FORMAT("No_Of Indent");
                                                "Indent Line"."Line No." := Line_no;
                                                Shortage_Det2.RESET;
                                                Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                                                Shortage_Det2.SETRANGE(Shortage_Det2."Planned Purchase Date", 0D);
                                                Shortage_Det2.SETFILTER(Shortage_Det2.Authorisation, '%1|%2', Shortage_Det2.Authorisation::Authorised,
                                                                                                            Shortage_Det2.Authorisation::indent);
                                                IF Shortage_Det2.FINDFIRST THEN
                                                    "Indent Line"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2) + 'NC'
                                                ELSE
                                                    "Indent Line"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2);

                                                "Indent Line".VALIDATE("Indent Line"."No.", Prev_Item);
                                                // "Indent Line"."No.":=Prev_Item;
                                                "Indent Line".Description := Prev_Description;
                                                "Indent Line"."Delivery Location" := 'STR';
                                                "Indent Line"."Sale Order No." := Prev_Sale_Order;
                                                "Indent Line"."Suitable Vendor" := Prev_Vendor;
                                                "Indent Line"."Unit Cost" := Prev_Cost;
                                                "Indent Line".Quantity := Tot_Shortage;
                                                // Added by Pranavi on 20-Dec-2016
                                                "Indent Line"."Production Order" := Prev_ProdOrder;
                                                "Indent Line"."Production Order Line No." := Prev_Prd_ord_Lin_no;
                                                "Indent Line"."Production Order Comp Line No." := Prev_Prd_ord_Comp_Lin_no;
                                                // End by Pranavi
                                                //     mnraju
                                                //  "Indent Line"."Release Status":="Indent Line"."Release Status"::Released;
                                                // "Indent Line".Earliest_Req_day := Prev_Earliest_Req_day; //sujani
                                                "Indent Line".INSERT;
                                                //  "Indent Line".VALIDATE("Indent Line"."No.",Prev_Item);
                                                //  "Indent Line".MODIFY;
                                            END;

                                            IF "No_Of Indent" > Ind_Count THEN BEGIN
                                                Temp_Ind_No := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3)) +
                                                               FORMAT("No_Of Indent");

                                                "Indent Header".RESET;
                                                "Indent Header".SETRANGE("Indent Header"."No.", Temp_Ind_No);
                                                "Indent Header"."Person Code" := 'EFFTRONICS\PADMAJA';
                                                IF "Indent Header".FINDFIRST THEN BEGIN
                                                    IF Material_Req_Day > 0D THEN BEGIN
                                                        IF Material_Req_Day > "G\L"."Shortage. Calc. Date" THEN
                                                            "Indent Header"."Production Start date" := Material_Req_Day
                                                        ELSE
                                                            "Indent Header"."Production Start date" := TODAY;
                                                    END ELSE
                                                        "Indent Header"."Production Start date" := TODAY;

                                                    "Indent Header".MODIFY;

                                                END;
                                            END;

                                            "No_Of Indent" += 1;

                                            "Indent Header".RESET;
                                            "Indent Header".INIT;
                                            "Indent Header"."No." := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3))
                                                                          + FORMAT("No_Of Indent");
                                            "Indent Header".Description := 'Created Automatically';
                                            "Indent Header"."Contact Person" := 'Padmaja.g';
                                            "Indent Header"."Delivery Location" := 'STR';
                                            "Indent Header"."Delivery Place" := "Indent Header"."Delivery Place"::Store;
                                            "Indent Header"."Indent Reference" := 'Padmaja.g';
                                            "Indent Header".Department := 'PROD';
                                            "Indent Header"."Person Code" := 'EFFTRONICS\PADMAJA';
                                            "Indent Header"."User Id" := USERID;
                                            "Indent Header"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2);
                                            "Indent Header"."Creation Date" := TODAY;
                                            "Indent Header"."Sale Order No." := "Shortage Details"."Sales Order No.";
                                            //mnraju
                                            // "Indent Header"."Released Status":="Indent Header"."Released Status"::Released;

                                            "Indent Header".INSERT;

                                            Material_Req_Day := 0D;
                                            Material_Req_Day := "Shortage Details"."Planned Date";

                                            Line_no := 0;
                                            Prev_Item := "Shortage Details"."Item No";
                                            Prev_Description := "Shortage Details".Description;
                                            Tot_Shortage := "Shortage Details".Shortage;
                                            Prev_Sale_Order := "Shortage Details"."Sales Order No.";
                                            Prev_Vendor := "Shortage Details"."Suitable Vendor";
                                            Prev_Cost := "Shortage Details"."Direct Unit Cost";
                                            // Added by Pranavi on 20-Dec-2016
                                            Prev_ProdOrder := "Shortage Details"."Production Order No.";
                                            Prev_Prd_ord_Lin_no := "Shortage Details"."Prod. Order Line No.";
                                            Prev_Prd_ord_Comp_Lin_no := "Shortage Details"."Prod. Order Comp Line No.";
                                            /*  "Shortage Details".SETFILTER("Shortage Details"."Material Required Date",'<>%1',0D);
                                               Prev_Earliest_Req_day:="Shortage Details"."Material Required Date";//sujani*/


                                            // End by Pranavi
                                        END ELSE BEGIN
                                            IF Prev_Item <> "Shortage Details"."Item No" THEN BEGIN
                                                Line_no += 10000;
                                                "Indent Line".INIT;
                                                "Indent Line"."Document No." := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3))
                                                                        + FORMAT("No_Of Indent");
                                                "Indent Line"."Line No." := Line_no + 1;
                                                //   "Indent Line"."No.":=Prev_Item;
                                                "Indent Line".VALIDATE("Indent Line"."No.", Prev_Item);
                                                "Indent Line".Description := Prev_Description;
                                                Shortage_Det2.RESET;
                                                Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                                                Shortage_Det2.SETRANGE(Shortage_Det2."Planned Purchase Date", 0D);
                                                Shortage_Det2.SETFILTER(Shortage_Det2.Authorisation, '%1|%2', Shortage_Det2.Authorisation::Authorised,
                                                                                                            Shortage_Det2.Authorisation::indent);
                                                IF Shortage_Det2.FINDFIRST THEN
                                                    "Indent Line"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2) + 'NC'
                                                ELSE
                                                    "Indent Line"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2);

                                                "Indent Line"."Sale Order No." := "Shortage Details"."Sales Order No.";
                                                "Indent Line".Quantity := Tot_Shortage;
                                                "Indent Line"."Suitable Vendor" := Prev_Vendor;
                                                "Indent Line"."Unit Cost" := Prev_Cost;
                                                "Indent Line"."Production Order" := Prev_ProdOrder;
                                                "Indent Line"."Production Order Line No." := Prev_Prd_ord_Lin_no;
                                                "Indent Line"."Production Order Comp Line No." := Prev_Prd_ord_Comp_Lin_no;
                                                // "Indent Line".Earliest_Req_day := Prev_Earliest_Req_day; //sujani
                                                "Indent Line".INSERT;
                                                //   "Indent Line".VALIDATE("Indent Line"."No.",Prev_Item);
                                                //  "Indent Line".MODIFY;
                                                Prev_Item := "Shortage Details"."Item No";
                                                Tot_Shortage := "Shortage Details".Shortage;
                                                Prev_Description := "Shortage Details".Description;
                                                Prev_Sale_Order := "Shortage Details"."Sales Order No.";
                                                Prev_Vendor := "Shortage Details"."Suitable Vendor";
                                                Prev_Cost := "Shortage Details"."Direct Unit Cost";
                                                // Added by Pranavi on 20-Dec-2016
                                                Prev_ProdOrder := "Shortage Details"."Production Order No.";
                                                Prev_Prd_ord_Lin_no := "Shortage Details"."Prod. Order Line No.";
                                                Prev_Prd_ord_Comp_Lin_no := "Shortage Details"."Prod. Order Comp Line No.";
                                                /*  "Shortage Details".SETFILTER("Shortage Details"."Material Required Date",'<>%1',0D);
                                                  Prev_Earliest_Req_day:="Shortage Details"."Material Required Date";//sujani*/




                                                // End by Pranavi
                                            END ELSE BEGIN
                                                Tot_Shortage += "Shortage Details".Shortage;
                                            END;
                                        END;
                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::indent;
                                        "Shortage Details"."Indent No." := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3))
                                                                           + FORMAT("No_Of Indent");
                                        "Shortage Details".MODIFY;
                                    UNTIL "Shortage Details".NEXT = 0;

                                Line_no += 10000;
                                //IF  "Shortage Details".COUNT>0 THEN
                                IF Prev_Item <> '' THEN BEGIN
                                    "Indent Line".INIT;
                                    "Indent Line"."Document No." := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3))
                                                                + FORMAT("No_Of Indent");
                                    "Indent Line"."Line No." := Line_no;
                                    "Indent Line".VALIDATE("Indent Line"."No.", Prev_Item);
                                    Shortage_Det2.RESET;
                                    Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                                    Shortage_Det2.SETRANGE(Shortage_Det2."Planned Purchase Date", 0D);
                                    Shortage_Det2.SETFILTER(Shortage_Det2.Authorisation, '%1|%2', Shortage_Det2.Authorisation::Authorised,
                                                                                                Shortage_Det2.Authorisation::indent);
                                    IF Shortage_Det2.FINDFIRST THEN
                                        "Indent Line"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2) + 'NC'
                                    ELSE
                                        "Indent Line"."ICN No." := FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2);

                                    "Indent Line".Description := Prev_Description;
                                    "Indent Line"."Sale Order No." := "Shortage Details"."Sales Order No.";
                                    "Indent Line".Quantity := Tot_Shortage;
                                    "Indent Line"."Suitable Vendor" := Prev_Vendor;
                                    "Indent Line"."Unit Cost" := Prev_Cost;
                                    // Added by Pranavi on 20-Dec-2016
                                    "Indent Line"."Production Order" := Prev_ProdOrder;
                                    "Indent Line"."Production Order Line No." := Prev_Prd_ord_Lin_no;
                                    "Indent Line"."Production Order Comp Line No." := Prev_Prd_ord_Comp_Lin_no;
                                    // "Indent Line".Earliest_Req_day := Prev_Earliest_Req_day; //sujani
                                    // End by Pranavi

                                    "Indent Line".INSERT;
                                    IF "No_Of Indent" > Ind_Count THEN BEGIN
                                        Temp_Ind_No := 'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3)) +
                                                       FORMAT("No_Of Indent");
                                        "Indent Header".RESET;
                                        "Indent Header".SETRANGE("Indent Header"."No.", Temp_Ind_No);
                                        IF "Indent Header".FINDFIRST THEN BEGIN
                                            IF Material_Req_Day > 0D THEN BEGIN
                                                IF Material_Req_Day > "G\L"."Shortage. Calc. Date" THEN
                                                    "Indent Header"."Production Start date" := Material_Req_Day
                                                ELSE
                                                    "Indent Header"."Production Start date" := TODAY;
                                            END ELSE
                                                "Indent Header"."Production Start date" := TODAY;

                                            "Indent Header".MODIFY;
                                        END;
                                    END;
                                END;
                            END ELSE
                                IF (Choice = Choice::PNUC) AND (Data_Choice = Data_Choice::Authorised) THEN BEGIN
                                    ERROR('Please Create Indents in PURCHASE option only');
                                END;
                            "Indent Header".RESET;
                            "Indent Header".SETFILTER("Indent Header"."No.",
                              'IND-AU' + FORMAT(DATE2DMY(TODAY, 1)) + FORMAT(DATE2DMY(TODAY, 2)) + FORMAT(DATE2DMY(TODAY, 3)) + '*');
                            "Indent Header".SETFILTER("Indent Header"."Released Status", '%1', "Indent Header"."Released Status"::Open);
                            IF "Indent Header".FINDFIRST THEN
                                REPEAT
                                    "Indent Header".ReleaseIndent1("Indent Header"."No.");
                                    TEMCMail("Indent Header");       //added by pranavi for Auto mail to TEMC regarding FILM capacitors
                                UNTIL "Indent Header".NEXT = 0;

                            MESSAGE('Indent Creation Was Completed');

                        end;
                    }
                    action("Shortage Excel")
                    {
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.DELETEALL;
                            Data_Choice := Data_Choice::SendAuth;
                            Rec.RESET;
                            FormShow;
                            "Show Shortage";
                            REPORT.RUN(33000906, FALSE, FALSE);
                            //REPORT.RUN(33000906,TRUE,FALSE);//Rev01 //Renumbered Object
                        end;
                    }
                    action("Send For Authorisation")
                    {
                        Image = SendMail;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            //ERROR('Dont press this button.It is Under Testing');
                         // IF UPPERCASE(USERID) IN ['EFFTRONICS\CHOWDARY', 'SUPER', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\ANANDA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI',
                           //   'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\BSATISH', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']
                          //  THEN BEGIN
                                /*"G\L".GET;
                                IF NOT "G\L"."Expected Orders Data Dump" THEN
                                   ERROR('PLEAESE DUMP THE DATA TO CASH FLOW');*/
                             /*   Rec.DELETEALL;
                                Data_Choice := Data_Choice::SendAuth;
                                Rec.RESET;
                                FormShow;
                                "Show Shortage";
                                Mail_Body := '';
                                IF "Cost Estimation" = 0 THEN
                                    ERROR(' Authorization Value Must not be NULL');
                                "Shortage Details".RESET;
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::WFA;
                                        "Shortage Details".MODIFY;
                                    UNTIL "Shortage Details".NEXT = 0;
                                total_cost := Shortage_Mail_Cost;
                                Total_Amt := formataddress.ChangeCurrency(ROUND("Cost Estimation", 1)); // Added by Rakesh to insert indian format currency on 22-Sep-14
                                                                                                        //Total_Amt := formataddress.ChangeCurrency(ROUND(total_cost,1)); // Added by sujani to 15 May 19
                                Mail_Subject := 'ERP - PURCHASE MATERIAL PROCUREMENT AUTHORIZATION OF AMOUNT ' + Total_Amt + ' Rupees For ' + FORMAT(DateFilter);
                                // Mail_Subject:='ERP- '+FORMAT(ROUND("Cost Estimation",1))+' Rupees Material Authorisation For '+FORMAT(DateFilter);
                                Mail_Body += '<Body><strong><form><table style="WIDTH:500px; HEIGHT: 20px; "border="1" align="center">';
                                //Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://115.119.184.72:5556/erp_reports/';
                                // Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://219.65.70.251:5556/erp_reports/';
                                Mail_Body += '<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/erp_reports/';  //added and above line commented by pranavi on 11-feb-2016
                                                                                                                                                                // Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://203.129.197.133:5556/erp_reports/';
                                                                                                                                                                // Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://localhost:8081/Shortage_Authorisation/';
                                                                                                                                                                //Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://intranet:8080/erp_mat_auh/';

                                //mnraju
                                UserSetup.RESET;
                                UserSetup.SETRANGE("User ID", USERID);
                                IF UserSetup.FINDFIRST THEN BEGIN
                                    CurrentUserID := UserSetup."Current UserId";
                                END;
                                //mnraju

                                // From_Mail := 'erp@efftronics.com';
                                //To_mail := Mail_Send_To;
                                Recipient.Add('erp@efftronics.com');

                                //EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, TRUE);
                                //  SMTP_Mail.CreateMessage('ERP','noreply@efftronics.com','sujani@efftronics.com',Mail_Subject,Mail_Body,TRUE);





                                Body += ('Day_Shortage.aspx?Val1=' + FORMAT("G\L"."Shortage. Calc. Date", 0, '<Closing><Day>-<Month Text,3>-<Year4>'));
                                Body += ('&val2=1');
                                Body += ('&val3=' + FORMAT(CurrentUserID));
                                Body += ('&val4=' + Mail_Send_To);
                                user.SETRANGE(user."User ID", USERID);
                                IF user.FIND('-') THEN BEGIN
                                    Body += ('&val5=' + user.MailID + ' ,Padmaja@efftronics.com,renukach@efftronics.com,ananda@efftronics.com,');
                                    Body += ('anilkumar@efftronics.com,exesec@efftronics.com,Purchase@efftronics.com');
                                END;
                                //    SMTP_Mail.AppendBody('&val5='+user.MailID;
                                Body += ('"  target="_blank">Accept</a></b></td>');
                                // SMTP_Mail.AppendBody('<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://219.65.70.251:5556/erp_reports/');
                                Body += ('<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/erp_reports/');  // above line commented and added by pranavi on 11-feb-2016
                                                                                                                                                         // SMTP_Mail.AppendBody('<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://203.129.197.133:5556/erp_reports/';
                                                                                                                                                         //    SMTP_Mail.AppendBody('<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://localhost:8081/Shortage_Authorisation/';
                                                                                                                                                         // SMTP_Mail.AppendBody('<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://intranet:8080/erp_mat_auh/';
                                Body += ('Day_Shortage.aspx?Val1=' + FORMAT("G\L"."Shortage. Calc. Date", 0, '<Closing><Day>-<Month Text,3>-<Year4>'));
                                Body += ('&val2=0');
                                Body += ('&val3=' + FORMAT(CurrentUserID));
                                Body += ('&val4=' + Mail_Send_To);
                                user.SETRANGE(user."User ID", USERID);
                                IF user.FIND('-') THEN BEGIN
                                    Body += ('&val5=' + user.MailID + ' ,Padmaja@efftronics.com,anvesh@efftronics.com,');
                                    Body += ('anilkumar@efftronics.com,Purchase@efftronics.com');
                                END;
                                //  SMTP_Mail.AppendBody('&val5='+user.MailID;
                                Body += ('"  target="_blank">Reject</b></a></td></tr>');
                                Body += ('</table></form></font></strong></body>');


                                /*
                                  Mail_Body+='<Body><strong><form><table style="WIDTH:500px; HEIGHT: 20px; "border="1" align="center">';
                                  Mail_Body+='<Tr><Td bgcolor=#F2C636 color=#FFFFFF  align="center" ><b>Intranet (In House)</b></Td></Tr>';
                                  Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://192.168.0.155:5556/erp_reports/';

                                  Link_Data1:='Day_Shortage.aspx?Val1='+FORMAT("G\L"."Shortage. Calc. Date",0,'<Closing><Day>-<Month Text,3>-<Year4>');
                                  Link_Data1+='&val2=1';
                                  Link_Data1+='&val3='+FORMAT(CurrentUserID);
                                  Link_Data1+='&val4='+Mail_Send_To;
                                  user.SETRANGE(user."User ID",USERID);
                                  IF user.FIND ('-') THEN
                                  BEGIN
                                    Link_Data1+='&val5='+user.MailID+' ,Padmaja@efftronics.com,spurthi@efftronics.com,anvesh@efftronics.com,renukach@efftronics.com,ananda@efftronics.com,';
                                    Link_Data1+='anilkumar@efftronics.com,exesec@efftronics.com,Purchase@efftronics.com';
                                  END;

                                  Link_Data1+='"  target="_blank">Accept</a></b></td>';
                                  Mail_Body+=Link_Data1;
                                  Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://192.168.0.155:5556/erp_reports/';
                                  Link_Data2:='Day_Shortage.aspx?Val1='+FORMAT("G\L"."Shortage. Calc. Date",0,'<Closing><Day>-<Month Text,3>-<Year4>');
                                  Link_Data2+='&val2=0';
                                  Link_Data2+='&val3='+FORMAT(CurrentUserID);
                                  Link_Data2+='&val4='+Mail_Send_To;
                                  user.SETRANGE(user."User ID",USERID);
                                  IF user.FIND ('-') THEN
                                  BEGIN
                                    Link_Data2+='&val5='+user.MailID+' ,Padmaja@efftronics.com,spurthi@efftronics.com,anvesh@efftronics.com,renukach@efftronics.com,ananda@efftronics.com,';
                                    Link_Data2+='anilkumar@efftronics.com,exesec@efftronics.com,Purchase@efftronics.com';
                                  END;
                                  Link_Data2+='"  target="_blank">Reject</b></a></td></tr>';
                                  Mail_Body+= Link_Data2;
                                  Mail_Body+='<Tr><Td bgcolor=#F2C636 color=#FFFFFF  align="center" ><b>Internet (Out House)</b></Td></Tr>';
                                  Mail_Body+='<Tr><Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://203.129.197.133:5556/erp_reports/';
                                  Mail_Body+=Link_Data1;
                                  Mail_Body+='<Td bgcolor=#FF3300 color=#FFFFFF  align="center" ><b><a href="http://203.129.197.133:5556/erp_reports/';
                                  Mail_Body+=Link_Data2;
                                  Mail_Body+='</table></form></font></strong></body>';
                                */

                                //Temp code commented B2b Rev01
                                /*{
                                IF ISCLEAR(BullZipPDF) THEN
                                //Rev01 Start
                                //Code Commented
                                {
                                CREATE(BullZipPDF);
                                }
                                CREATE(BullZipPDF,FALSE,TRUE);
                                //Rev01 Start
                            
                                FileDirectory := '\\erpserver\ErpAttachments\';
                                WINDOW.OPEN('PREPARING THE REPORT');
                                FileName :='Authorisation Material'+FORMAT(TODAY,0,'<Day>-<Month Text,3>-<Year4>')+'.pdf';
                                BullZipPDF.Init;
                                BullZipPDF.LoadSettings;
                                RunOnceFile := BullZipPDF.GetSettingsFileName(TRUE);
                                BullZipPDF.SetValue('Output',FileDirectory+FileName);
                                BullZipPDF.SetValue('Showsettings', 'never');
                                BullZipPDF.SetValue('ShowPDF', 'no');
                                BullZipPDF.SetValue('ShowProgress', 'no');
                                BullZipPDF.SetValue('ShowProgressFinished', 'no');
                                BullZipPDF.SetValue('SuppressErrors', 'yes');
                                BullZipPDF.SetValue('ConfirmOverwrite', 'no');
                                BullZipPDF.WriteSettings(TRUE);
                                REPORT.RUNMODAL(303,FALSE,FALSE);
                                TimeOut := 0;
                                WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO
                                BEGIN
                                  SLEEP(2000);
                                  TimeOut := TimeOut + 1;
                                END;
                              WINDOW.CLOSE;
                              Attachment:=FileDirectory+FileName;
                              }*///Temp code commented B2b Rev01
                                 // SMTP_Mail.CreateMessage('SHORTAGE MATERIAL AUTHORISATION','erp@efftronics.com',To_mail,Mail_Subject,Mail_Body,TRUE);
                                 //SMTP_Mail.AddAttachment(Attachment);
                                 // REPORT.RUN(33000906, FALSE, FALSE);//Rev01 //Renumbered Object //02-07-18

                             /*   Attachment1 := '';
                                Attachment1 := '\\erpserver\ErpAttachments\Authorisation Material' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>') + '.xlsx';
                                REPORT.SaveAsExcel(33000906, Attachment1, Rec);

                                EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, TRUE);

                                InputFile.Open(Attachment1);
                                InputFile.CreateInStream(AttachmentInStream);
                                EmailMessage.AddAttachment(Attachment1, 'xlsx', AttachmentInStream);

                                //Attachment1:='\\erpserver\ErpAttachments\Authorisation Material2-Jul-2018.xlsx';

                                //EmailMessage.AddAttachment(Attachment1, '', '');//EFFUPG
                                //Attachment1:='\\erpserver\ErpAttachments\Authorisation Material 20-Aug-2012.xlsx';
                                //SMTP_Mail.AddAttachment(Attachment1);
                                // Attachment2:='\\erpserver\ErpAttachments\Authorisation Material 10-Aug-2012.pdf';
                                //SMTP_Mail.AddAttachment(Attachment2);

                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                //WINDOW.CLOSE;
                                //  NewCDOMessage(From_Mail,To_mail,Mail_Subject,Mail_Body,Attachment);
                                // CODE WAS COMMENTED FOR NAVISION UPGRADATION
                                "Shortage Details".RESET;
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                                IF "Shortage Details".FINDSET THEN
                                    REPEAT
                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::WFA;
                                        "Shortage Details".MODIFY;
                                    UNTIL "Shortage Details".NEXT = 0;
                                CLEAR(EmailMessage);
                                MESSAGE('Shortage has been sent for Authorization');

                                /*
                                IF (USERID='89OF002') OR (USERID='SUPER') OR (USERID='93OF001')  OR (USERID='07TE024') THEN
                                BEGIN
                                  IF (Choice=Choice::Purchase)  THEN
                                  BEGIN
                                    Mail_Subject:=FORMAT(ROUND("Cost Estimation",2))+' Rupees Material Authorisation For '+FORMAT(DateFilter);
                                    Mail_Body:='********* Auto Generated Mail From ERP**********';
                                    REPORT.RUN(303,FALSE,FALSE,Rec);
                                    REPORT.SAVEASPDF(303,FORMAT('\\erpserver\erpattachments\'+'Authorisation Material'+'.PDF'),FALSE,Rec);
                                  //  From_Mail:='erp@efftronics.com';
                                  // To_mail:='anilkumar@efftronics.com';
                                       From_Mail:='Chowdary@efftronics.com';
                                       To_mail:='ceo@efftronics.com';

                                    Attachment:='\\erpserver\erpattachments\'+'Authorisation Material.PDF';
                                    Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);

                                    SETFILTER(Shortage,'>%1',0);
                                    IF FINDFIRST THEN
                                    REPEAT
                                      "Shortage Details".RESET;

                                      "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                      "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date",'>%1',0D);
                                //      "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date",DateFilter);
                                      "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No","Shortage Details"."Planned Date");
                                      "Shortage Details".SETRANGE("Shortage Details"."Item No","Item No.");
                                      "Shortage Details".SETFILTER("Shortage Details".Authorisation,'WAP');
                                      IF "Shortage Details".FINDFIRST THEN
                                      REPEAT

                                        "Shortage Details".Authorisation:="Shortage Details".Authorisation::WFA;
                                        "Shortage Details".MODIFY;
                                      UNTIL "Shortage Details".NEXT=0;
                                    UNTIL NEXT=0;
                                    MESSAGE('Data Had Sent For an Approval');
                                    "Show Shortage";
                                  END ELSE  IF (Choice=Choice::PNUC) THEN
                                  BEGIN
                                    Mail_Subject:=FORMAT(ROUND("Cost Estimation",2))+' Rupees Material Authorisation For "Planned Purchase Date" Exceeded Items ';
                                    Mail_Body:='********* Auto Generated Mail From ERP**********';
                                    REPORT.RUN(303,FALSE,FALSE,Rec);
                                 //   REPORT.SAVEASPDF(303,FORMAT('\\erpserver\erpattachments\'+'Authorisation Material'+'.PDF'),FALSE,Rec);
                                      REPORT.SAVEASPDF(303,FORMAT('\\erpserver\erpattachments\'+'Authorisation Material'+'.PDF'),FALSE,Rec);
                                  //  From_Mail:='erp@efftronics.com';
                                //    To_mail:='anilkumar@efftronics.com';
                                        From_Mail:='Chowdary@efftronics.com';
                                     To_mail:='ceo@efftronics.com';
                                {    Attachment:='\\data\share\erp'+'Authorisation Material.PDF';
                                    Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);}

                                    Attachment:='\\erpserver\erpattachments\'+'Authorisation Material.PDF';
                                    //Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);


                                    SETFILTER(Shortage,'>%1',0);
                                    IF FINDFIRST THEN
                                    REPEAT
                                      "Shortage Details".RESET;
                                      "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                      "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date",0D);
                                      "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No","Shortage Details"."Planned Date");
                                      "Shortage Details".SETFILTER("Shortage Details".Authorisation,'WAP');
                                      "Shortage Details".SETRANGE("Shortage Details"."Item No","Item No.");
                                      IF "Shortage Details".FINDSET THEN
                                      REPEAT
                                        "Shortage Details".Authorisation:="Shortage Details".Authorisation::WFA;
                                        "Shortage Details".MODIFY;
                                      UNTIL "Shortage Details".NEXT=0;
                                    UNTIL NEXT=0;
                                    MESSAGE('Data Had Sent For an Approval');
                                    "Show Shortage";
                                  END ELSE
                                    MESSAGE('Please Estimate the Cost (Or) Please Select the Correct Option');*/
                          //  END ELSE
                            //    MESSAGE('You Dont Have Suffiecient Rights');

                        end;
                    }
                    action("Report Preview")
                    {
                        Image = "Report";
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            REPORT.RUN(50187, TRUE, FALSE, Rec);
                        end;
                    }
                    action("ConfirmtheVendor & Item Costs")
                    {
                        Image = ItemCosts;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin

                            /*SETFILTER("Vendor Name",'');
                            IF FINDFIRST THEN
                              ERROR('Please Give the Vendor Information')
                            ELSE
                            BEGIN
                              SETRANGE("Unit Cost",0);
                              IF FIND('_') THEN
                                ERROR('Please Enter the Unit Costs')
                              ELSE
                              BEGIN */
                            IF (USERID = '89OF002') OR (USERID = 'SUPER') OR (USERID = '20P2007') THEN BEGIN
                                IF (Choice = Choice::Purchase) THEN BEGIN
                                    Confirm_Vend_Pur := TRUE;
                                    /*  Mail_Subject:='Vendor & Item Costs Information was Updated For '+FORMAT(DateFilter)+' Purchase Items';
                                      Mail_Body:='********* Auto Generated Mail From ERP**********';
                                      REPORT.RUN(303,FALSE,FALSE,Rec);
                                      REPORT.SAVEASPDF(303,FORMAT('\\eff-cpu-222\ErpAttachments\'+'Authorisation Material'+'.PDF'),FALSE,Rec);
                                      From_Mail:='erp@efftronics.net';
                                      To_mail:='anilkumar@efftronics.net';
                                   //   From_Mail:='Chowdary@efftronics.net';
                                   //   To_mail:='padmaja@efftronics.net';

                                      Attachment:='\\eff-cpu-222\ErpAttachments\'+'Authorisation Material.PDF';
                                      Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);
                                                                                                           */
                                    Rec.SETFILTER(Shortage, '>%1', 0);
                                    IF Rec.FINDSET THEN
                                        REPEAT
                                            "Shortage Details".RESET;
                                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                            // "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date",DateFilter);
                                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                                            "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                            IF "Shortage Details".FINDSET THEN
                                                REPEAT
                                                    "Shortage Details"."Suitable Vendor" := Rec."Suitable Vendor";
                                                    "Shortage Details"."Unit Cost" := Rec."Unit Cost";
                                                    "Shortage Details"."Direct Unit Cost" := Rec."Direct Unit Cost";
                                                    "Shortage Details"."Vendor Name" := Rec."Vendor Name";
                                                    "Shortage Details".MODIFY;
                                                UNTIL "Shortage Details".NEXT = 0;
                                        UNTIL Rec.NEXT = 0;
                                    MESSAGE('Vendor & Costs Was Updated');
                                END ELSE
                                    IF (Choice = Choice::PNUC) THEN BEGIN
                                        Confirm_Vendr_con := TRUE;
                                        /*   Mail_Subject:='Vendor & Item Costs Information was Updated For Plened Purchase Date Exceeded Purchase Items';
                                           Mail_Body:='********* Auto Generated Mail From ERP**********';
                                           REPORT.RUN(303,FALSE,FALSE,Rec);
                                           REPORT.SAVEASPDF(303,FORMAT('\\eff-cpu-222\ErpAttachments\'+'Authorisation Material'+'.PDF'),FALSE,Rec);
                                       //    From_Mail:='erp@efftronics.net';
                                       //    To_mail:='anilkumar@efftronics.net';
                                           From_Mail:='Chowdary@efftronics.net';
                                           To_mail:='padmaja@efftronics.net';

                                           Attachment:='\\eff-cpu-222\ErpAttachments\'+'Authorisation Material.PDF';
                                           Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);    */

                                        Rec.SETFILTER(Shortage, '>%1', 0);
                                        IF Rec.FINDSET THEN
                                            REPEAT
                                                "Shortage Details".RESET;
                                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                                // "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date",0D);
                                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                                IF "Shortage Details".FINDSET THEN
                                                    REPEAT
                                                        "Shortage Details"."Suitable Vendor" := Rec."Suitable Vendor";
                                                        "Shortage Details"."Unit Cost" := Rec."Unit Cost";
                                                        "Shortage Details"."Direct Unit Cost" := Rec."Direct Unit Cost";
                                                        "Shortage Details"."Vendor Name" := Rec."Vendor Name";
                                                        "Shortage Details".MODIFY;
                                                    UNTIL "Shortage Details".NEXT = 0;
                                            UNTIL Rec.NEXT = 0;
                                        MESSAGE('Vendor & Costs Was Updated');
                                    END ELSE
                                        MESSAGE('You Dont Have Sufficient Rights');
                            END;
                            //END;
                            //END;

                        end;
                    }
                    action("Assign Suitable Vendors & Cost")
                    {
                        Image = ChangeCustomer;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            BUOM: Record "Item Unit of Measure";
                        begin

                            IF USERID IN ['EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\ANANDA', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'ERPSERVER\ADMINISTRATOR'
                                      , 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                                "Cost Estimation" := 0;
                                IF (Choice = Choice::Purchase) AND (Data_Choice = Data_Choice::WAP) THEN BEGIN
                                    Rec.SETFILTER(Shortage, '>%1', 0);
                                    //SETFILTER(Confirmed,'%1',FALSE);
                                    IF Rec.FINDSET THEN
                                        REPEAT
                                            Max_qty := 0;
                                            Max_Vendor := '';
                                            /* "Item vendor".SETCURRENTKEY("Item vendor"."Item No.","Item vendor"."Variant Code","Item vendor"."Vendor No.");
                                             "Item vendor".SETRANGE("Item vendor"."Item No.","Item No.");
                                             "Item vendor".SETFILTER("Item vendor"."Total Qty. Supplied",'>%1',0);
                                             IF "Item vendor".FINDSET THEN
                                             REPEAT
                                               "Item vendor".CALCFIELDS( "Item vendor"."Total Qty. Supplied");
                                               IF Max_Qty<"Item vendor"."Total Qty. Supplied" THEN
                                               BEGIN
                                                 Max_Qty:="Item vendor"."Total Qty. Supplied";
                                                 Max_Vendor:="Item vendor"."Vendor No.";
                                               END;
                                             UNTIL "Item vendor".NEXT=0; */


                                            IF Item.GET(Rec."Item No.") THEN BEGIN
                                                Item_COst := 0;
                                                Rec."Direct Unit Cost" := 0;
                                                "Purch. Inv. Line".SETCURRENTKEY("Purch. Inv. Line".Type, "Purch. Inv. Line"."No."
                                                                        , "Purch. Inv. Line"."Variant Code", "Purch. Inv. Line"."Invoice Date");
                                                "Purch. Inv. Line".SETRANGE("Purch. Inv. Line"."No.", Rec."Item No.");
                                                "Purch. Inv. Line".SETFILTER("Purch. Inv. Line".Quantity, '>%1', 0);
                                                IF "Purch. Inv. Line".FINDLAST THEN BEGIN
                                                    /*IF "Purch. Inv. Header".GET("Purch. Inv. Line"."Document No.") THEN
                                                        Rec."Tax Structure" := "Purch. Inv. Header".Structure;*///B2BUpg
                                                    IF Item."Base Unit of Measure" = "Purch. Inv. Line"."Unit of Measure Code" THEN BEGIN
                                                        IF "Purch. Inv. Line"."Gen. Bus. Posting Group" = 'FOREIGN' THEN
                                                            Item_COst := "Purch. Inv. Line"."Unit Cost (LCY)"
                                                        ELSE BEGIN
                                                            IF "Purch. Inv. Line".Quantity = 0 THEN BEGIN
                                                                MESSAGE(Item.Description + '-' + "Purch. Inv. Line"."Document No.");
                                                            END ELSE
                                                                Item_COst := "Purch. Inv. Line"."Amount To Vendor" / "Purch. Inv. Line".Quantity;
                                                        END;
                                                    END
                                                    ELSE BEGIN
                                                        BUOM.RESET;
                                                        BUOM.SETFILTER("Item No.", Item."No.");
                                                        BUOM.SETFILTER(Code, "Purch. Inv. Line"."Unit of Measure Code");
                                                        IF BUOM.FINDFIRST THEN BEGIN
                                                            IF "Purch. Inv. Line"."Gen. Bus. Posting Group" = 'FOREIGN' THEN
                                                                Item_COst := "Purch. Inv. Line"."Unit Cost (LCY)" / BUOM."Qty. per Unit of Measure"
                                                            ELSE BEGIN
                                                                IF "Purch. Inv. Line".Quantity = 0 THEN BEGIN
                                                                    MESSAGE(Item.Description + '-' + "Purch. Inv. Line"."Document No.");
                                                                END ELSE
                                                                    Item_COst := ("Purch. Inv. Line"."Amount To Vendor" / "Purch. Inv. Line".Quantity) / BUOM."Qty. per Unit of Measure";
                                                            END;
                                                        END;
                                                    END;

                                                END;

                                                IF Item_COst = 0 THEN
                                                    Item_COst := Item."Avg Unit Cost";
                                                "Cost Estimation" += Rec.Shortage * Item_COst;
                                                "Purchase Line".RESET;
                                                "Purchase Line".SETCURRENTKEY("Purchase Line"."Document Type",
                                                                              "Purchase Line"."Document No.",
                                                                              "Purchase Line"."No.",
                                                                              "Purchase Line"."Buy-from Vendor No.");
                                                "Purchase Line".SETRANGE("Purchase Line"."Document Type", "Purchase Line"."Document Type"::Order);
                                                "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."Item No.");

                                                IF "Purchase Line".FINDLAST THEN BEGIN
                                                    Rec."Direct Unit Cost" := "Purchase Line"."Direct Unit Cost";
                                                    Max_Vendor := "Purchase Line"."Buy-from Vendor No.";
                                                END;

                                            END;
                                            IF Rec."Suitable Vendor" = '' THEN
                                                Rec.VALIDATE("Suitable Vendor", Max_Vendor);
                                            IF Rec."Unit Cost" = 0 THEN //COMMENTED BY VIJAYA
                                                Rec.VALIDATE("Unit Cost", Item_COst);
                                            Rec."Total Cost" := Rec."Unit Cost" * Rec.Shortage;
                                            IF Rec."Direct Unit Cost" = 0 THEN
                                                Rec.VALIDATE("Direct Unit Cost", "Purchase Line"."Direct Unit Cost");

                                            Rec.MODIFY;
                                        UNTIL Rec.NEXT = 0;
                                END ELSE
                                    IF (Choice = Choice::PNUC) AND (Data_Choice = Data_Choice::WAP) THEN BEGIN
                                        Rec.SETFILTER(Shortage, '>%1', 0);
                                        //SETFILTER(Confirmed,'%1',FALSE);
                                        IF Rec.FINDSET THEN
                                            REPEAT
                                                Max_qty := 0;
                                                Max_Vendor := '';
                                                /*  "Item vendor".SETCURRENTKEY("Item vendor"."Item No.","Item vendor"."Variant Code","Item vendor"."Vendor No.");
                                                  "Item vendor".SETRANGE("Item vendor"."Item No.","Item No.");
                                                  "Item vendor".SETFILTER("Item vendor"."Total Qty. Supplied",'>%1',0);
                                                  IF "Item vendor".FINDSET THEN
                                                  REPEAT
                                                    "Item vendor".CALCFIELDS( "Item vendor"."Total Qty. Supplied");
                                                    IF Max_Qty<"Item vendor"."Total Qty. Supplied" THEN
                                                    BEGIN
                                                      Max_Qty:="Item vendor"."Total Qty. Supplied";
                                                      Max_Vendor:="Item vendor"."Vendor No.";
                                                    END;
                                                  UNTIL "Item vendor".NEXT=0; */
                                                IF Item.GET(Rec."Item No.") THEN BEGIN
                                                    //IF (i3 <=3) THEN
                                                    //  MESSAGE('Loop Star %1',i3);
                                                    i3 += 1;
                                                    Rec."Direct Unit Cost" := 0;
                                                    Item_COst := 0;
                                                    "Purch. Inv. Line".SETCURRENTKEY("Purch. Inv. Line".Type, "Purch. Inv. Line"."No."
                                                                            , "Purch. Inv. Line"."Variant Code", "Purch. Inv. Line"."Invoice Date");
                                                    "Purch. Inv. Line".SETRANGE("Purch. Inv. Line"."No.", Rec."Item No.");
                                                    "Purch. Inv. Line".SETFILTER("Purch. Inv. Line".Quantity, '>%1', 0);
                                                    IF "Purch. Inv. Line".FINDLAST THEN BEGIN
                                                        /*  IF "Purch. Inv. Header".GET("Purch. Inv. Line"."Document No.") THEN
                                                              Rec."Tax Structure" := "Purch. Inv. Header".Structure;*/
                                                        IF "Purch. Inv. Line"."Gen. Bus. Posting Group" = 'FOREIGN' THEN
                                                            Item_COst := "Purch. Inv. Line"."Unit Cost (LCY)"
                                                        ELSE BEGIN
                                                            IF "Purch. Inv. Line".Quantity = 0 THEN BEGIN
                                                                MESSAGE(Item.Description + '-' + "Purch. Inv. Line"."Document No.");
                                                            END ELSE
                                                                Item_COst := "Purch. Inv. Line"."Amount To Vendor" / "Purch. Inv. Line".Quantity;
                                                        END;

                                                    END;
                                                END; //commented by vishnu
                                                IF Item_COst = 0 THEN
                                                    Item_COst := Item."Avg Unit Cost";

                                                "Cost Estimation" += Rec.Shortage * Item_COst;

                                                "Purchase Line".RESET;
                                                "Purchase Line".SETCURRENTKEY("Purchase Line"."Document Type",
                                                                              "Purchase Line"."Document No.",
                                                                              "Purchase Line"."No.",
                                                                              "Purchase Line"."Buy-from Vendor No.");
                                                "Purchase Line".SETRANGE("Purchase Line"."Document Type", "Purchase Line"."Document Type"::Order);
                                                "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."Item No.");
                                                IF "Purchase Line".FINDLAST THEN BEGIN
                                                    Rec."Direct Unit Cost" := "Purchase Line"."Direct Unit Cost";
                                                    Max_Vendor := "Purchase Line"."Buy-from Vendor No.";
                                                END;
                                                //END;//added by vishnu


                                                IF Rec."Suitable Vendor" = '' THEN
                                                    Rec.VALIDATE("Suitable Vendor", Max_Vendor);
                                                IF Rec."Unit Cost" = 0 THEN
                                                    Rec.VALIDATE("Unit Cost", Item_COst);
                                                Rec."Total Cost" := Rec."Unit Cost" * Rec.Shortage;
                                                IF Rec."Direct Unit Cost" = 0 THEN
                                                    Rec.VALIDATE("Direct Unit Cost", "Purchase Line"."Direct Unit Cost");
                                                Rec.MODIFY;
                                            UNTIL Rec.NEXT = 0;
                                    END ELSE
                                        MESSAGE('Please Select the Correct Option');
                            END ELSE
                                MESSAGE('You Dont Have Sufficient Rights ');

                        end;
                    }
                    action(Summary_Excel_Report)
                    {
                        Image = Excel;
                        Visible = false;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin

                            MESSAGE('In Progress');
                            //REPORT.RUN(33000906,TRUE,FALSE);
                        end;
                    }
                    action("Forward To Purchase")
                    {
                        Image = ExportSalesPerson;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin

                            IF (Choice = Choice::Purchase) THEN BEGIN
                                IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\BSATISH', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                                    Mail_Subject := 'Please Give Vendor & Cost Information for' + FORMAT(DateFilter) + ' Purchase Items';
                                    Mail_Body := '********* Auto Generated Mail From ERP**********';
                                    REPORT.RUN(50187, FALSE, FALSE, Rec);
                                    REPORT.SAVEASPDF(50187, FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation' + '.PDF'), Rec);
                                    Attachment1 := FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation' + '.PDF');//EFFUPG1.7
                                    From_Mail := 'Padmaja@efftronics.com';
                                    //  To_mail := 'Purchase@efftronics.com,anilkumar@efftronics.com,erp@efftronics.com';
                                    /*Recipient.Add('Purchase@efftronics.com');
                                    Recipient.Add('anilkumar@efftronics.com');
                                    Recipient.Add('erp@efftronics.com');*/



                                    EmailMessage.Create(Recipient, Mail_Subject, Body, FALSE);
                                    Recipient.Add('erp@efftronics.com');

                                    //EFFUPG1.7>>
                                    InputFile.Open(Attachment1);
                                    InputFile.CreateInStream(AttachmentInStream);
                                    EmailMessage.AddAttachment(Attachment1, 'PDF', AttachmentInStream);

                                    //EFFUPG1.7<<

                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


                                    Rec.SETFILTER(Shortage, '>%1', 0);
                                    IF Rec.FINDSET THEN
                                        REPEAT
                                            "Shortage Details".RESET;
                                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                            IF USERID <> 'EFFTRONICS\PRANAVI' THEN
                                                "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", DateFilter)
                                            ELSE
                                                "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                                            //"Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date",DateFilter);
                                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Open');
                                            "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                            IF "Shortage Details".FINDSET THEN
                                                REPEAT
                                                    "Shortage Details".Authorisation := "Shortage Details".Authorisation::WAP;
                                                    "Shortage Details".MODIFY;
                                                UNTIL "Shortage Details".NEXT = 0;
                                        UNTIL Rec.NEXT = 0;
                                    MESSAGE(' Data Was Forwarded To Purchase Department');
                                END ELSE
                                    MESSAGE('You Dont Have Rights');
                            END ELSE
                                IF (Choice = Choice::PNUC) THEN BEGIN
                                    IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\BSATISH', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                                        Rec.SETRANGE("Accepted By Purchase", FALSE);
                                        IF Rec.FINDFIRST THEN
                                            ERROR('THERE IS SOME NOT UNDER CONTROL ITEMS');
                                        Rec.RESET;

                                        Mail_Subject := 'Please Give Vendor & Cost Information for Planned Purchase Purchase Date Exceeded Purchase Items';
                                        Mail_Body := '********* Auto Generated Mail From ERP**********';
                                        REPORT.RUN(50187, FALSE, FALSE, Rec);
                                        REPORT.SAVEASPDF(50187, FORMAT('\\erpserver\ErpAttachments\' + 'Authorisation' + '.PDF'), Rec);
                                        //''From_Mail := 'Padmaja@efftronics.com';
                                        //To_mail := 'Padmaja@efftronics.com,anilkumar@efftronics.com'; // Chowdary@efftronics.com,
                                        /*Recipient.Add('Padmaja@efftronics.com');
                                        Recipient.Add('anilkumar@efftronics.com');*/
                                        Attachment := '\\erpserver\ErpAttachments\' + 'Authorisation' + '.PDF';
                                        EmailMessage.Create(Recipient, Mail_Subject, Body, FALSE);
                                        Recipient.Add('erp@efftronics.com');


                                        InputFile.Open(Attachment);
                                        InputFile.CreateInStream(AttachmentInStream);
                                        EmailMessage.AddAttachment(Attachment, 'PDF', AttachmentInStream);


                                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                        //Mail.NewCDOMessage(From_Mail,To_mail,Mail_Subject,Body,Attachment);

                                        Rec.SETRANGE("Accepted By Purchase", TRUE);

                                        Rec.SETFILTER(Shortage, '>%1', 0);
                                        IF Rec.FINDSET THEN
                                            REPEAT
                                                "Shortage Details".RESET;
                                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                                                "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Date");
                                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Open');
                                                "Shortage Details".SETRANGE("Shortage Details"."Item No", Rec."Item No.");
                                                IF "Shortage Details".FINDSET THEN
                                                    REPEAT
                                                        "Shortage Details".Authorisation := "Shortage Details".Authorisation::WAP;
                                                        "Shortage Details".MODIFY;
                                                    UNTIL "Shortage Details".NEXT = 0;
                                            UNTIL Rec.NEXT = 0;
                                        MESSAGE(' Data Was Forwarded To Purchase Department');
                                    END ELSE
                                        MESSAGE('You Dont Have Rights');
                                END ELSE
                                    MESSAGE('Please Select the Correct Option');
                        end;
                    }
                    action("Summary Report")
                    {
                        Image = ViewDetails;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            REPORT.RUNMODAL(33000906); //Rev01 //Renumbered Object
                            Fname := '\\erpserver\ErpAttachments\Authorisation Material' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>') + '.xlsx';
                            OpenExistingXlsWorkbook(Fname, 2);
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //Item Number Colors
        IF Rec.Confirmed THEN
            EditAmt := FALSE
        ELSE
            EditAmt := TRUE;
        ItemStyleExp := '';
        IF (Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Open) THEN BEGIN
            IF Rec."Type Of Item" = Rec."Type Of Item"::Alternate THEN BEGIN
                ItemStyleExp := 'Favorable';  //Bold Blue
                                              //CurrForm."Item No.".UPDATEFORECOLOR:=16711680;
                                              //CurrForm."Item No.".UPDATEFONTBOLD:=TRUE;
            END;
            IF Rec."Type Of Item" = Rec."Type Of Item"::MOQ THEN BEGIN
                ItemStyleExp := 'Ambiguous'; //yellow Insted of magneta
                                             //CurrForm."Item No.".UPDATEFORECOLOR:=16711935;
                                             //CurrForm."Item No.".UPDATEFONTBOLD:=TRUE;
            END;
            IF Rec."Type Of Item" = Rec."Type Of Item"::Ordered THEN BEGIN
                ItemStyleExp := 'Subordinate'; //Grey
                                               //CurrForm."Item No.".UPDATEFORECOLOR:=8421504;
                                               ////  CurrForm."Item No.".UPDATEBACKCOLOR:=65000;
                                               //CurrForm."Item No.".UPDATEFONTBOLD:=TRUE;
            END;
            IF Item.GET(Rec."Item No.") THEN BEGIN
                IF (Rec."Overall Requirement" <> ((Rec."Required  Qty" + Rec."Qty. In Material Issues") -
                                          (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection"))) AND Show_REQ_Det THEN BEGIN
                    ItemStyleExp := 'Unfavorable'; //Bold RED
                                                   //CurrForm."Item No.".UPDATEFORECOLOR:=255;
                                                   //CurrForm."Item No.".UPDATEFONTBOLD:=TRUE;
                END;
                saftyStockQty := Item."Safety Stock Quantity";          //added by pranavi on 17-04-2015
            END;

        END;
        //Item Number Colors

        //Added by Rakesh for getting the earliest Receive date on 20-Mar-15
        CLEAR(Ear_Recv_Day);
        "Purchase Line".RESET;
        "Purchase Line".SETCURRENTKEY("Deviated Receipt Date");
        "Purchase Line".ASCENDING;
        "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."Item No.");
        "Purchase Line".SETRANGE("Purchase Line"."Document Type", 1);
        "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
        IF "Purchase Line".FINDFIRST THEN
            Ear_Recv_Day := "Purchase Line"."Deviated Receipt Date";
        // end by Rakesh
    end;

    trigger OnClosePage();
    begin
        Rec.RESET;
    end;

    trigger OnOpenPage();
    begin
        IF USERID = 'EFFTRONICS\SUJANI' THEN
            Vis_Only := TRUE
        ELSE
            Vis_Only := FALSE;
        Rec.RESET;
        // Added by Rakesh for item description on 28-03-14
        //begin
        Color_Alternate := 'Alternate Items';
        Color_MOQ := 'Shortage qty < MOQ';
        Color_Ordered := 'Ordered';
        Color_Problematic := 'Problematic';
        //end

        // UPDATING SHORTAGE CALCULATION DETIALS IN GENERAL LEDGER SETUP
        "G\L".GET;
        Shortage_Date := 'Shortage From  :' + FORMAT("G\L"."Shortage. Calc. Date");

        // EXCEPT FOR PURCHASE PERSON "HIMABINDU" IF ANY PERSON HAS OPENED TOTAL DATA WILL BE RESETED
        // THIS PROVISION IS PROVIDED FOR HER DUE TO "VENDOR & COST" DATA UPDATION FOR SHORTAGE ITEMS
        IF (USERID <> 'EFFTRONICS\PHANI') AND (USERID <> 'EFFTRONICS\BRAHMAIAH') AND (USERID <> 'EFFTRONICS\RENUKACH') AND (USERID <> 'EFFTRONICS\ANANDA') THEN BEGIN
            Rec.RESET;
            Rec.DELETEALL;
        END;

        // PERSONS MAILS LIST TO WHOM WE ARE SENDING THE AUTHORIZATION MAIL
        Mail_Send_To := 'Ceo@efftronics.com,anilkumar@efftronics.com,renukach@efftronics.com,gravi@efftronics.com,mk@effe.in,anvesh@efftronics.com';  // commented in order to remove ceo sir mail suggested by anil sir
                                                                                                                                                      //Mail_Send_To:= 'sujani@efftronics.com';
                                                                                                                                                      //Mail_Send_To:='erp@efftronics.com,anilkumar@efftronics.com,renukach@efftronics.com,gravi@efftronics.com,mk@effe.in,anvesh@efftronics.com';
                                                                                                                                                      //Mail_Send_To+='sundar@efftronics.com,anilkumar@efftronics.com,Padmaja@efftronics.com';
                                                                                                                                                      //Mail_Send_To:='dir@efftronics.com,anilkumar@efftronics.com,sundar@efftronics.com';

        // UPDATING FORM VISIBLITY
        //Rev01
        /*
        Currpage."Below Present Week".VISIBLE:=FALSE;
        Currpage."Next 15 Days".VISIBLE:=FALSE;
        Currpage."In One Month".VISIBLE:=FALSE;
        Currpage."Next Week".VISIBLE:=FALSE;
        Currpage."Present Week".VISIBLE:=FALSE;
        Currpage."Qty. In Stores".VISIBLE:=FALSE;
        Currpage."Qty. In MCH".VISIBLE:=FALSE;
        Currpage."Required  Qty".VISIBLE:=FALSE;
        Currpage."Qty. In Material Issues".VISIBLE:=FALSE;
        Currpage."Earliest Required Day".VISIBLE:=FALSE;
        Currpage."Qty. In R&D".VISIBLE:=FALSE;
        Currpage."Get From R&D".VISIBLE:=FALSE;
        Currpage."Qty. In CS".VISIBLE:=FALSE;
        Currpage."Get From CS".VISIBLE:=FALSE;
        Currpage."Purchase Time Slot".VISIBLE:=FALSE;
        Currpage.Difference.VISIBLE:=FALSE;
        */ //Rev01
           // FOR FOLLOWING PERSONS WHEN THEY OPEN THE FORM DIRECTLY "TO BE AUTHORUIZED MATERIAL" WILL BE DISPLAYED

        IF (USERID = 'EFFTRONICS\PADMAJA') OR  // MD SIR
           (USERID = 'EFFTRONICS\ANILKUMAR') OR  // ERP ADMINISTRATOR
           (USERID = 'EFFTRONICS\PHANI') OR
           (USERID = 'EFFTRONICS\RENUKACH') OR
           (USERID = 'EFFTRONICS\ANANDA') OR
           (USERID = 'EFFTRONICS\BRAHMAIAH') OR  // DIR SIR
           (USERID = 'EFFTRONICS\CHOWDARY')     // EXECUTIVE SEC ( FOR DATA VERIFICATION ONLY)
           THEN BEGIN
            Choice := Choice::Purchase;
            Data_Choice := Data_Choice::WFA;

            /*
            CurrPage."Suitable Vendor".VISIBLE:=TRUE;
            currpage."Unit Cost".VISIBLE:=TRUE;
            currpage."Vendor Name".VISIBLE:=TRUE;
            currpage."Minimum Order Qty.".VISIBLE:=TRUE;
            */ //Rev01
        END ELSE BEGIN
            /*
            currpage."Suitable Vendor".VISIBLE:=FALSE;
            currpage."Unit Cost".VISIBLE:=FALSE;
            currpage."Production  Orders".VISIBLE:=TRUE;
            currpage."Purchase Orders".VISIBLE:=TRUE;


            currpage."Vendor Name".VISIBLE:=FALSE;
            currpage."Minimum Order Qty.".VISIBLE:=FALSE;
            */
        END;
        "Calculate Date Filter";
        "Show Shortage";

        // THIS CODE IS FOR CALCULATING MINIMUM & MAXIMUM PURCHASE DATES  WHICH IS SHOWN ON FORM
        "Shortage Details".RESET;
        "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
        "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
        IF "Shortage Details".FINDLAST THEN
            "Max Date" := 'Maximum Purchase Date := ' + FORMAT("Shortage Details"."Planned Purchase Date");

        "Shortage Details".RESET;
        "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
        "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
        IF "Shortage Details".FINDFIRST THEN BEGIN
            "Min Date" := 'Minimum Purchase Date := ' + FORMAT("Shortage Details"."Planned Purchase Date");
            Min_Purchase_Date := "Shortage Details"."Planned Purchase Date";
        END;


        "Shortage Details".RESET;

    end;

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipient: List of [Text];
        Choice: Option Shortage,Purchase,PNUC;
        DateFilter: Text[250];
        //ApplicationManagement: Codeunit ApplicationManagement;
        GLAcc: Record "G/L Account";
        InternalDateFilter: Text[250];
        "Shortage Details": Record "Item Lot Numbers";
        Prev_Item: Code[20];
        Tot_Shortage: Decimal;
        Prev_Description: Text[50];
        Buffer: Text[30];
        Vendor: Record Vendor;
        "Cost Estimation": Decimal;
        "Indent Header": Record "Indent Header";
        "Indent Line": Record "Indent Line";
        "No_Of Indent": Integer;
        Line_no: Integer;
        // Mail: Codeunit Mail;
        Mail_Body: Text[1024];
        Mail_Subject: Text[1000];
        From_Mail: Text[250];
        // To_mail: Text[250];


        Data_Choice: Option Open,WFA,Authorised,Indent,WAP,CBP,SendAuth;
        Authorise: Boolean;
        Attachment: Text[250];

        "Production Order": Record "Production Order";
        From_Date: Date;
        To_Date: Date;
        Prev_Vendor: Code[20];
        Prev_Vendor_Name: Text[50];
        Prev_Cost: Decimal;
        Prev_Sale_Order: Code[20];
        Material_Req_Day: Date;
        Ind_Count: Integer;
        Temp_Ind_No: Code[20];
        Shortage_Date_Filter: Text[50];
        Purchase_Date_Filter: Text[50];
        Prod_Order_Pnuc: Text[1000];
        Short_Temp: Record "Shortage Temp";
        "Max Date": Text[100];
        "Min Date": Text[100];
        "Purchase Line": Record "Purchase Line";
        Icn: Code[10];
        Min_Purchase_Date: Date;
        Confirm_Vend_Pur: Boolean;
        Confirm_Vendr_con: Boolean;
        Po_Qty: Decimal;
        Shortage_Det2: Record "Item Lot Numbers";
        Week_Start_Date: Date;
        Break_Down: Boolean;
        Sale_Order_Products: array[100] of Code[30];
        Sale_Order_Product_Qty: array[100] of Integer;
        I: Integer;
        Prev_Production_Order: Code[20];
        J: Integer;
        Available: Boolean;
        Order_Avb: Boolean;
        Alternate_Items: Record "Alternate Items";
        Material_Issues: Record "Material Issues Line";
        Prod_Order_Component: Record "Prod. Order Component";
        "G\L": Record "General Ledger Setup";
        Schedule: Record Schedule2;
        Sales_Line: Record "Sales Line";
        Shortage_Date: Text[30];
        "Material Issues Header": Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
        ManufacturingSetup: Record "Manufacturing Setup";
        user: Record "User Setup";
        UserGrec: Record User;
        Body: Text;
        LineNo: Integer;
        Show_REQ_Det: Boolean;
        QILE: Record "Quality Item Ledger Entry";
        "Purch. Rpct. Line": Record "Purch. Rcpt. Line";
        "Purch. Inv. Line": Record "Purch. Inv. Line";
        Item_COst: Decimal;
        Plan_Change: Codeunit "Plan Change";
        Show_Other_Store_Det: Boolean;
        Item_Req: Record "Item wise Requirement";
        Prev_Direct_Cost: Decimal;
        Accp_By_Pur: Boolean;
        Prev_Alternate: Code[20];
        Sale_Order_Choice: Option Plan,Purchase;
        Status: Text[30];
        Procured_Qty_Temp: Decimal;
        "Prod. Order. Component": Record "Prod. Order Component";
        "Purch. Inv. Header": Record "Purch. Inv. Header";
        Order_Qty: Decimal;
        WINDOW: Dialog;
        Mail_Send_To: Text[1000];
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
         objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
        objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
        flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
        fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field"; */
        //<< ORACLE UPG
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        FileDirectory: Text[100];
        FileName: Text[100];

        RunOnceFile: Text[1000];
        TimeOut: Integer;

        SMTPSETUP: Record "SMTP SETUP";
        AttachFileName: Text[30];
        //SMTP_Mail: Codeunit "SMTP Mail";
        Sale_Order: Code[20];
        Item: Record Item;
        Sales_Header: Record "Sales Header";
        Max_qty: Decimal;
        Max_Vendor: Code[10];
        Attachment1: Text[100];
        Link_Data1: Text[1000];
        Link_Data2: Text[1000];
        Attachment2: Text[250];
        Fname: Text[250];
        MOQ_Temp: Decimal;
        Text001: Label 'Updating Virtual Purchase Dates #1#########\';
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';

        ItemStyleExp: Text[20];
        UserSetup: Record "User Setup";
        CurrentUserID: Text[50];
        EditAmt: Boolean;
        Color_Alternate: Text;
        Color_MOQ: Text;
        Color_Ordered: Text;
        Color_Problematic: Text;
        formataddress: Codeunit "Correct Dimension Values Cust";
        Total_Amt: Text;
        prdOrdCmp: Record "Prod. Order Component";
        prdLastDate: Date;
        Ear_Recv_Day: Date;
        saftyStockQty: Decimal;
        UserRec: Record User;
        ILN: Record "Item Lot Numbers";
        PrevProdTypes: Text;
        ProdTypes: Text;
        ProdTypess: Text;
        Prev_ProdOrder: Code[20];
        Prev_Prd_ord_Lin_no: Integer;
        Prev_Prd_ord_Comp_Lin_no: Integer;
        Vis_Only: Boolean;
        MinimumStock: Boolean;
        ShortageItemDetails: Page "Shortage Details";
        Shortage_Data: Record "Item Lot Numbers";
        ShortageAuthorizedMaterial: Record "Shortage Authorized Data";
        Prev_Earliest_Req_day: Date;
        Item_table: Record Item;
        ITEM_EFF_MOQ: Decimal;
        ITEM_MOQ: Decimal;
        i3: Integer;
        "Shortage Temp": Record "Shortage Temp";
        total_cost: Decimal;
        ord_qty2: Decimal;
        AttachmentInStream: InStream;
        InputFile: File;


    procedure "Show Shortage"();
    begin
        // DELETING TOTAL INFORMATION IN SHORTAGE TEMP (TABLE)
        Rec.DELETEALL;

        prdOrdCmp.RESET;
        prdOrdCmp.SETCURRENTKEY("Production Plan Date", "Item No.", "Prod. Order No.");
        prdOrdCmp.SETFILTER(prdOrdCmp."Production Plan Date", '>%1', WORKDATE);
        IF prdOrdCmp.FINDLAST THEN
            prdLastDate := prdOrdCmp."Production Plan Date" - 3;


        "Cost Estimation" := 0;

        IF Choice = Choice::Purchase THEN BEGIN
            Prev_Item := '';

            // BASED ON DATA CHOICE OPTION FILTERING THE "SHORTAGE DETAILS"  INFORMATION WHICH IS CALCULATED IN
            // MATERIAL AVAILABILITY REPORT
            "Shortage Details".RESET;
            "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
            "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
            IF MinimumStock = FALSE THEN BEGIN
                "Shortage Details".SETFILTER("Shortage Details"."Sales Order No.", '<> %1', 'STR INTERNAL');
            END;
            IF Data_Choice = Data_Choice::Open THEN BEGIN
                IF USERID <> 'EFFTRONICS\ANILKUMAR' THEN
                    //IF  NOT(USERID IN['EFFTRONICS\SUJANI','EFFTRONICS\GRAVI']) THEN

                    "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", DateFilter)
                ELSE
                    "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                "Shortage Details"."Production Order No.");
                IF Sale_Order <> '' THEN
                    "Shortage Details".SETRANGE("Shortage Details"."Sales Order No.", Sale_Order);

                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Open');
            END
            ELSE
                IF Data_Choice = Data_Choice::WAP THEN BEGIN

                    "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                   "Shortage Details"."Production Order No.");
                    IF Sale_Order <> '' THEN
                        "Shortage Details".SETRANGE("Shortage Details"."Sales Order No.", Sale_Order);
                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                END ELSE
                    IF Data_Choice = Data_Choice::WFA THEN BEGIN
                        IF NOT (USERID IN ['EFFTRONICS/ANILKUMAR', 'EFFTRONICS/PADMAJA', 'EFFTRONICS/CHOWDARY', 'EFFTRONICS/SPURTHI', 'EFFTRONICS/ANVESH', 'EFFTRONICS/SUJANI']) THEN
                            //IF NOT((USERID='') OR (USERID='SUPER') OR (USERID='93MK002')  OR (USERID='05PD023')) THEN
                            "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                        "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                       "Shortage Details"."Production Order No.");
                        IF Sale_Order <> '' THEN
                            "Shortage Details".SETRANGE("Shortage Details"."Sales Order No.", Sale_Order);
                        "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA');
                    END ELSE
                        IF Data_Choice = Data_Choice::Authorised THEN BEGIN
                            "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);

                            "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                           "Shortage Details"."Production Order No.");
                            IF Sale_Order <> '' THEN
                                "Shortage Details".SETRANGE("Shortage Details"."Sales Order No.", Sale_Order);
                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Authorised');
                        END ELSE
                            IF Data_Choice = Data_Choice::Indent THEN BEGIN

                                "Shortage Details".SETFILTER("Shortage Details"."Planned Purchase Date", '>%1', 0D);
                                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                               "Shortage Details"."Production Order No.");
                                IF Sale_Order <> '' THEN
                                    "Shortage Details".SETRANGE("Shortage Details"."Sales Order No.", Sale_Order);

                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Indent');
                            END ELSE
                                IF Data_Choice = Data_Choice::SendAuth THEN BEGIN
                                    "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                                   "Shortage Details"."Production Order No.");
                                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP');
                                END;
            IF "Shortage Details".FINDSET THEN
                REPEAT
                    IF Prev_Item <> '' THEN BEGIN
                        // COMPARING THE PREVIOUS ITEM WITH CURRENT ITEM ,
                        // IF IT'S A NEW ITEM THEN INSERT PREVIOUS ITEM DETIALS INTO  SHORTAGE TEMP (TABLE)
                        // OTHERWISE  UPDATE THE SHORTAGE DETAILS
                        IF Prev_Item = "Shortage Details"."Item No" THEN BEGIN
                            Tot_Shortage += "Shortage Details".Shortage;
                        END ELSE BEGIN
                            // IF IT'S NEW ITEM THEN CREATING THE NEW ITEM & UPDATE NECESSARY DETAILS
                            Rec.INIT;
                            Rec.VALIDATE("Item No.", Prev_Item);
                            Rec.Description := Prev_Description;
                            Rec.Shortage := Tot_Shortage;
                            Rec."Suitable Vendor" := Prev_Vendor;
                            Rec."Vendor Name" := Prev_Vendor_Name;
                            Rec."Unit Cost" := Prev_Cost;
                            Rec."Alternated Item" := Prev_Alternate;
                            Rec."Direct Unit Cost" := Prev_Direct_Cost;
                            Rec."Total Cost" := Prev_Cost * Tot_Shortage;
                            Item.RESET;
                            IF Item.GET(Prev_Item) THEN BEGIN
                                // UPDATING ITEM DETAILS INTO ITEM CARD
                                Rec."Lead Time" := Item."Safety Lead Time";
                                Rec."Unit of Measure" := Item."Base Unit of Measure";
                                IF Item.EFF_MOQ > 0 THEN
                                    Rec."Minimum Order Qty." := Item.EFF_MOQ
                                ELSE
                                    Rec."Minimum Order Qty." := Item."Minimum Order Quantity";
                                Item.CALCFIELDS(Item."Inventory at Stores", Item."Qty. on Purch. Order",
                                            Item."Quantity Under Inspection", Item."Stock At MCH Location", Item."Stock at PROD Stores");
                                ItmStockAtStores(Item."No.");
                                //"Qty. In Stores":=Item."Stock at Stores"; //praanviR
                                Rec."Qty. In MCH" := Item."Stock At MCH Location";
                                Rec."Qty. In PROD" := Item."Stock at PROD Stores";

                                IF ((Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Open) OR (Data_Choice = Data_Choice::WFA)) THEN BEGIN
                                    //    IF("Item No."='MEBOXCR00436') THEN
                                    //    MESSAGE('"Saftey Items"."No."');
                                    Po_Qty := 0;
                                    Rec."Required  Qty" := 0;
                                    Rec."Req Qty" := 0;
                                    // CALCULATING & UPDATING "QTY. IN PURCHASE ORDERS INFORMATION" INTO LINES
                                    "Purchase Line".RESET;
                                    "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                                    "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                                    "Purchase Line".SETRANGE("Purchase Line"."No.", Prev_Item);
                                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                                    //  "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date",'>=%1',"G\L"."Shortage. Calc. Date");
                                    "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date", '>=%1', prdLastDate);
                                    IF "Purchase Line".FINDSET THEN
                                        REPEAT
                                            Po_Qty += "Purchase Line"."Qty. to Receive";
                                        UNTIL "Purchase Line".NEXT = 0;
                                    Rec."Purchase Orders" := Po_Qty;

                                    Rec."Total PO Qty" := 0;
                                    // CALCULATING & UPDATING "QTY. IN PURCHASE ORDERS INFORMATION" INTO LINES
                                    "Purchase Line".RESET;
                                    "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                                    "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                                    "Purchase Line".SETRANGE("Purchase Line"."No.", Prev_Item);
                                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                                    //"Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date",'>=%1',"G\L"."Shortage. Calc. Date");        //commented by pranavi on 15-04-2015
                                    // "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date",'>=%1',prdLastDate);
                                    IF "Purchase Line".FINDSET THEN
                                        REPEAT
                                            Rec."Total PO Qty" += "Purchase Line"."Qty. to Receive";
                                        UNTIL "Purchase Line".NEXT = 0;



                                    // UPDATING ITEM WISE REQUIREMENT & MATERIAL ISSUES REQUIREMENT INTO LINES
                                    Rec."Req Qty" := 0;
                                    IF Item_Req.GET(Prev_Item) THEN BEGIN
                                        Rec."Required  Qty" := Item_Req."Required Quantity";
                                        Rec."Req Qty" := Item_Req."Req Qty";
                                        Rec."Qty. In Material Issues" := Item_Req."Qty. In Material Issues";
                                    END;

                                    // CALCULATING & UPDATING  "QC UNDER INSPECTION STOCK" INFORMATION
                                    QILE.RESET;
                                    QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                                    QILE.SETRANGE(QILE."Item No.", Prev_Item);
                                    QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                                    QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                                    QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                                    QILE.SETRANGE(QILE."Location Code", 'STR');
                                    QILE.SETRANGE(QILE.Accept, TRUE);
                                    IF QILE.FINDSET THEN
                                        REPEAT
                                            Rec."Qty Under Inspection" += QILE."Remaining Quantity";
                                        UNTIL QILE.NEXT = 0;

                                    // UPDATING OVERALL ,FUTURE (NEXT 1 WEEK , 15 DAYS), LAST WEEK REQUIREMENT INFORMATION
                                    Rec."Present Week" := Tot_Shortage;

                                    IF (Rec."Item No." = 'MEBOXCR00436') THEN
                                        MESSAGE('"Saftey Items"."No."');


                                    Shortage_Det2.RESET;
                                    Shortage_Det2.SETCURRENTKEY("Item No", "Material Required Date");
                                    Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                                    IF Shortage_Det2.FINDFIRST THEN BEGIN
                                        Rec."Earliest Required Day" := Shortage_Det2."Material Required Date";
                                    END;



                                    //"Overall Requirement":=0;
                                    Shortage_Det2.RESET;
                                    Shortage_Det2.SETFILTER(Shortage_Det2.Shortage, '>%1', 0);   //Added by Pranavi on 24-11-2015
                                    Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                                    IF Shortage_Det2.FINDSET THEN
                                        REPEAT
                                            Rec."Overall Requirement" += Shortage_Det2.Shortage;
                                            IF Shortage_Det2."Planned Purchase Date" = 0D THEN
                                                Rec."Below Present Week" += Shortage_Det2.Shortage
                                            ELSE BEGIN
                                                IF (Week_Start_Date + 15 >= Shortage_Det2."Planned Purchase Date") THEN
                                                    Rec."Next 15 Days" += Shortage_Det2.Shortage;
                                                IF (Week_Start_Date < Shortage_Det2."Planned Purchase Date")
                                                   AND (Week_Start_Date + 30 >= Shortage_Det2."Planned Purchase Date") THEN
                                                    Rec."In One Month" += Shortage_Det2.Shortage;
                                            END;
                                        UNTIL Shortage_Det2.NEXT = 0;
                                    Rec."Present Week" += Rec."Below Present Week";
                                    Rec."Next 15 Days" += Rec."Below Present Week";
                                    Rec."In One Month" += Rec."Below Present Week";

                                    // CALCULATING ON WHICH SLOT MOQ WAS MEETING
                                    IF Rec."Minimum Order Qty." > Rec."Present Week" THEN BEGIN
                                        IF Rec."Minimum Order Qty." > Rec."Next 15 Days" THEN
                                            Rec."Purchase Time Slot" := '1 MONTH'
                                        ELSE
                                            Rec."Purchase Time Slot" := '15 DAYS';
                                    END ELSE
                                        Rec."Purchase Time Slot" := 'THIS WEEK';
                                END;

                                Order_Qty := 0;
                                // CALCULATING "PURCHASE ORDER QUANTITY" BASED ON "MINIMUM ORDER" & "STANDARD PACKING " QUANTITY WHICH IS IN ITEM CARD
                                // FOR MORE INFORMATION PLEASE STUDY "MOQ SCENARIOS DOCUMENT"

                                Order_Qty := Tot_Shortage; //Added by Rakesh to reset the order quantity.this effects when MOQ,EFF_MOQ,SPQ not defined in item card.

                                IF Item.GET(Prev_Item) THEN BEGIN
                                    IF Item.EFF_MOQ > 0 THEN
                                        MOQ_Temp := Item.EFF_MOQ
                                    ELSE
                                        MOQ_Temp := Item."Minimum Order Quantity";
                                    IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" = 0) THEN BEGIN
                                        IF MOQ_Temp > 1 THEN BEGIN
                                            IF Tot_Shortage < MOQ_Temp THEN
                                                Order_Qty := MOQ_Temp
                                            ELSE
                                                Order_Qty := Tot_Shortage;
                                        END ELSE
                                            Order_Qty := Tot_Shortage;

                                    END ELSE
                                        IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                                            IF MOQ_Temp > 1 THEN BEGIN
                                                IF Tot_Shortage < MOQ_Temp THEN
                                                    Order_Qty := MOQ_Temp
                                                ELSE BEGIN
                                                    IF MOQ_Temp = 1 THEN
                                                        Order_Qty := (Tot_Shortage DIV Item."Standard Packing Quantity") * Item."Standard Packing Quantity"
                                                    ELSE
                                                        Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                                END;
                                            END ELSE
                                                Order_Qty := Tot_Shortage;
                                        END ELSE
                                            IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                                                IF MOQ_Temp > 1 THEN BEGIN
                                                    IF Tot_Shortage < MOQ_Temp THEN
                                                        Order_Qty := MOQ_Temp
                                                    ELSE
                                                        Order_Qty := ((Tot_Shortage DIV MOQ_Temp) + 1) * MOQ_Temp
                                                END ELSE
                                                    Order_Qty := Tot_Shortage;
                                            END ELSE
                                                IF (MOQ_Temp = 0) AND (Item."Standard Packing Quantity" > 0) THEN BEGIN
                                                    IF Tot_Shortage < Item."Standard Packing Quantity" THEN
                                                        Order_Qty := Item."Standard Packing Quantity"
                                                    ELSE
                                                        Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                                END;
                                END;

                                // UPDATING "TOTAL MATERIAL VALUE (FOR AUTHORIZATION) ", VENDOR , COST INFORMATION FROM SHORTAGE DETAILS
                                //MESSAGE('1');
                                "Cost Estimation" += Prev_Cost * Order_Qty;
                                Prev_Vendor := "Shortage Details"."Suitable Vendor";
                                Prev_Vendor_Name := "Shortage Details"."Vendor Name";
                                Prev_Cost := "Shortage Details"."Unit Cost";
                                Prev_Direct_Cost := "Shortage Details"."Direct Unit Cost";
                                IF Prev_Alternate = '' THEN
                                    Prev_Alternate := "Shortage Details"."Alternated Item";


                                // VERIFYING "OVERALL REQUIREMENT" IS GREATER THAN MOQ/NOT
                                //  BASED ON THIS INFORMATION , IF STOCK IS AVB IN OTHER STORE , THEN WE CAN TAKE FROM AVB STORES
                                IF Rec."Minimum Order Qty." > Rec."Overall Requirement" THEN
                                    Rec."Type Of Item" := Rec."Type Of Item"::MOQ;

                                // VERIFYING ALTERNATE ITEM AVAILABLE THERE/NOT (FOR VISUAL INDICATION PURPOSE)
                                //Added by Pranavi on 31-10-2015 for Alternate_items check for prod group wise
                                PrevProdTypes := '';
                                ProdTypes := 'ALL PRODUCTS|';
                                ProdTypess := '';
                                ILN.RESET;
                                ILN.SETCURRENTKEY("Item No", "Product Type");
                                ILN.SETFILTER(ILN."Item No", Rec."Item No.");
                                IF ILN.FINDSET THEN
                                    REPEAT
                                        IF PrevProdTypes <> ILN."Product Type" THEN
                                            ProdTypes := ProdTypes + ILN."Product Type" + '|';
                                        PrevProdTypes := ILN."Product Type";
                                    UNTIL ILN.NEXT = 0;
                                IF STRLEN(ProdTypes) > 0 THEN
                                    ProdTypess := COPYSTR(ProdTypes, 1, STRLEN(ProdTypes) - 1);
                                Alternate_Items.RESET;
                                Alternate_Items.SETFILTER(Alternate_Items."Item No.", Rec."Item No.");
                                Alternate_Items.SETFILTER(Alternate_Items."Proudct Type", ProdTypess);
                                IF Alternate_Items.FINDFIRST THEN
                                    Rec."Type Of Item" := Rec."Type Of Item"::Alternate;
                                //End By Pranavi
                                /*
                                Alternate_Items.SETRANGE(Alternate_Items."Item No.","Item No.");
                                IF Alternate_Items.FINDFIRST THEN
                                BEGIN
                                  "Type Of Item":="Type Of Item"::Alternate;

                                END;
                                */

                                // IF THERE IS ANY PROBLEM IS SHORTAGE CALCULATION (FOR VISUAL INDICATION PURPOSE)
                                IF Item.GET(Rec."Item No.") THEN
                                    IF Rec."Overall Requirement" <> ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                                        (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")) THEN BEGIN
                                        Rec.Difference := (Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                                    (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")));
                                        Rec."Complicarted Item" := TRUE;
                                    END;

                                //  IF("Item No."='MEBOXCR00436') THEN
                                //  MESSAGE('"Saftey Items"."No."');

                                // IF PURCHASED QUANTITY IS GREATER THAN "OVERALL REQUIREMNET"  (FOR VISUAL INDICATION PURPOSE)
                                IF (Rec."Purchase Orders" + Rec.Difference) >= (Rec."Overall Requirement") THEN BEGIN
                                    Rec."Type Of Item" := Rec."Type Of Item"::Ordered;
                                END;
                            END;
                            IF Rec."Vendor Name" <> '' THEN
                                Rec.Confirmed := TRUE;
                            // INSERTING THE LAST RECORD INFORMATION
                            IF Prev_Item <> '' THEN
                                Rec.INSERT;

                            // UPDATING NEW ITEM DETAILS INTO TEMPORARY VARIABLES & RESETING THE DETIALS
                            Tot_Shortage := 0;
                            Prev_Alternate := '';
                            Prev_Item := "Shortage Details"."Item No";
                            Prev_Description := "Shortage Details".Description;
                            Tot_Shortage += "Shortage Details".Shortage;
                            IF Prev_Alternate = '' THEN
                                Prev_Alternate := "Shortage Details"."Alternated Item";
                        END;
                    END ELSE BEGIN
                        // UPDATING 1 ST ITEM INFORMATION INTO TEMPORARY VARIABLES
                        Tot_Shortage := 0;
                        Prev_Item := "Shortage Details"."Item No";
                        Prev_Description := "Shortage Details".Description;
                        Tot_Shortage += "Shortage Details".Shortage;
                        Prev_Vendor := "Shortage Details"."Suitable Vendor";
                        Prev_Vendor_Name := "Shortage Details"."Vendor Name";
                        Prev_Cost := "Shortage Details"."Unit Cost";
                        Prev_Direct_Cost := "Shortage Details"."Direct Unit Cost";
                        IF Prev_Alternate = '' THEN
                            Prev_Alternate := "Shortage Details"."Alternated Item";
                        "Cost Estimation" := Prev_Cost * "Shortage Details".Shortage;//EFFUPG1.8
                    END;
                UNTIL "Shortage Details".NEXT = 0;
            // THIS CODE HAVING SAME FUNCTIONALITY AS ABOVE ,IT IS FOR LAST ITEM IN THE SHORTAGE DETAILS
            IF "Shortage Details".COUNT > 0 THEN BEGIN
                IF Prev_Item <> '' THEN BEGIN
                    Rec.INIT;
                    Rec.VALIDATE("Item No.", Prev_Item);
                    Rec.Description := Prev_Description;
                    Rec.Shortage := Tot_Shortage;
                    Rec."Suitable Vendor" := Prev_Vendor;
                    Rec."Vendor Name" := Prev_Vendor_Name;
                    Rec."Unit Cost" := Prev_Cost;
                    Rec."Direct Unit Cost" := Prev_Direct_Cost;
                    Rec."Alternated Item" := Prev_Alternate;
                    Rec."Total Cost" := Prev_Cost * Tot_Shortage;
                    Item.RESET;
                    IF Item.GET("Shortage Details"."Item No") THEN BEGIN
                        Item.CALCFIELDS(Item."Inventory at Stores", Item."Qty. on Purch. Order",
                                      Item."Quantity Under Inspection", Item."Stock At MCH Location", Item."Stock at PROD Stores");
                        Rec."Lead Time" := Item."Safety Lead Time";
                        Rec."Unit of Measure" := Item."Base Unit of Measure";
                        ItmStockAtStores(Item."No.");
                        //"Qty. In Stores":=Item."Stock at Stores";
                        Rec."Qty. In MCH" := Item."Stock At MCH Location";
                        Rec."Qty. In PROD" := Item."Stock at PROD Stores";
                        IF Item_Req.GET(Prev_Item) THEN BEGIN
                            Rec."Required  Qty" := Item_Req."Required Quantity";
                            Rec."Req Qty" := Item_Req."Req Qty";
                            Rec."Qty. In Material Issues" := Item_Req."Qty. In Material Issues";
                        END;

                        IF (Data_Choice = Data_Choice::WFA) OR (Data_Choice = Data_Choice::Authorised) OR (Data_Choice = Data_Choice::WAP) THEN BEGIN
                            Order_Qty := 0;
                            IF Item.GET(Prev_Item) THEN BEGIN
                                IF Item.EFF_MOQ > 0 THEN
                                    MOQ_Temp := Item.EFF_MOQ
                                ELSE
                                    MOQ_Temp := Item."Minimum Order Quantity";

                                IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" = 0) THEN BEGIN
                                    IF MOQ_Temp > 1 THEN BEGIN
                                        IF Tot_Shortage < MOQ_Temp THEN
                                            Order_Qty := MOQ_Temp
                                        ELSE
                                            Order_Qty := Tot_Shortage;
                                    END ELSE BEGIN
                                        Order_Qty := Tot_Shortage;
                                    END;
                                END ELSE
                                    IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                                        IF MOQ_Temp > 1 THEN BEGIN
                                            IF Tot_Shortage < MOQ_Temp THEN
                                                Order_Qty := MOQ_Temp
                                            ELSE BEGIN
                                                IF MOQ_Temp = 1 THEN
                                                    Order_Qty := (Tot_Shortage DIV Item."Standard Packing Quantity") * Item."Standard Packing Quantity"
                                                ELSE
                                                    Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                            END;
                                        END ELSE
                                            Order_Qty := Tot_Shortage;
                                    END ELSE
                                        IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                                            IF MOQ_Temp > 1 THEN BEGIN
                                                IF Tot_Shortage < MOQ_Temp THEN
                                                    Order_Qty := MOQ_Temp
                                                ELSE
                                                    Order_Qty := ((Tot_Shortage DIV MOQ_Temp) + 1) * MOQ_Temp
                                            END ELSE
                                                Order_Qty := Tot_Shortage;

                                        END ELSE
                                            IF (MOQ_Temp = 0) AND (Item."Standard Packing Quantity" > 0) THEN BEGIN
                                                IF Tot_Shortage < Item."Standard Packing Quantity" THEN
                                                    Order_Qty := Item."Standard Packing Quantity"
                                                ELSE
                                                    Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                            END;
                            END;
                            //MESSAGE('2');
                            "Cost Estimation" += Prev_Cost * Order_Qty;
                            Prev_Vendor := "Shortage Details"."Suitable Vendor";
                            Prev_Vendor_Name := "Shortage Details"."Vendor Name";
                            Prev_Cost := "Shortage Details"."Unit Cost";
                            Prev_Direct_Cost := "Shortage Details"."Direct Unit Cost";// Rev07
                        END;
                    END;

                    Rec."Required  Qty" := 0;
                    Rec."Req Qty" := 0;
                    Po_Qty := 0;

                    "Purchase Line".RESET;
                    "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                    "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                    "Purchase Line".SETRANGE("Purchase Line"."No.", Prev_Item);
                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                    "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date", '>=%1', "G\L"."Shortage. Calc. Date");
                    IF "Purchase Line".FINDSET THEN
                        REPEAT
                            Po_Qty += "Purchase Line"."Qty. to Receive";
                        UNTIL "Purchase Line".NEXT = 0;
                    Rec."Purchase Orders" := Po_Qty;

                    QILE.RESET;
                    QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                    QILE.SETRANGE(QILE."Item No.", Prev_Item);
                    QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                    QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                    QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                    QILE.SETRANGE(QILE."Location Code", 'STR');
                    QILE.SETRANGE(QILE.Accept, TRUE);
                    IF QILE.FINDSET THEN
                        REPEAT
                            Rec."Qty Under Inspection" += QILE."Remaining Quantity";
                        UNTIL QILE.NEXT = 0;

                    Item_Req.RESET;
                    IF Item_Req.GET(Prev_Item) THEN BEGIN
                        Rec."Required  Qty" := Item_Req."Required Quantity";
                        Rec."Req Qty" := Item_Req."Req Qty";
                        Rec."Qty. In Material Issues" := Item_Req."Qty. In Material Issues";
                    END;


                    Rec."Present Week" := Tot_Shortage;


                    Shortage_Det2.RESET;
                    Shortage_Det2.SETCURRENTKEY("Item No", "Material Required Date");
                    Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                    IF Shortage_Det2.FINDFIRST THEN BEGIN
                        Rec."Earliest Required Day" := Shortage_Det2."Material Required Date";
                    END;

                    Shortage_Det2.RESET;
                    Shortage_Det2.SETFILTER(Shortage_Det2.Shortage, '>%1', 0);   //Added by Pranavi on 24-11-2015
                    Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                    IF Shortage_Det2.FINDSET THEN
                        REPEAT
                            Rec."Overall Requirement" += Shortage_Det2.Shortage;
                            IF Shortage_Det2."Planned Purchase Date" = 0D THEN
                                Rec."Below Present Week" += Shortage_Det2.Shortage
                            ELSE BEGIN
                                IF (Week_Start_Date + 15 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."Next 15 Days" += Shortage_Det2.Shortage;
                                IF (Week_Start_Date < Shortage_Det2."Planned Purchase Date")
                                   AND (Week_Start_Date + 30 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."In One Month" += Shortage_Det2.Shortage;

                            END;
                        UNTIL Shortage_Det2.NEXT = 0;

                    Rec."Present Week" += Rec."Below Present Week";
                    Rec."Next 15 Days" += Rec."Below Present Week";
                    Rec."In One Month" += Rec."Below Present Week";


                    IF Rec."Minimum Order Qty." > Rec."Present Week" THEN BEGIN
                        IF Rec."Minimum Order Qty." > Rec."Next 15 Days" THEN
                            Rec."Purchase Time Slot" := '1 MONTH'
                        ELSE
                            Rec."Purchase Time Slot" := '15 DAYS';
                    END ELSE
                        Rec."Purchase Time Slot" := 'THIS WEEK';


                    Shortage_Det2.RESET;
                    Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                    IF Shortage_Det2.FINDSET THEN
                        REPEAT
                            //        "Overall Requirement"+=Shortage_Det2.Shortage;      //pranaviR
                            IF Shortage_Det2."Planned Purchase Date" = 0D THEN
                                Rec."Below Present Week" += Shortage_Det2.Shortage
                            ELSE BEGIN
                                IF (Week_Start_Date + 15 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."Next 15 Days" += Shortage_Det2.Shortage;
                                IF (Week_Start_Date < Shortage_Det2."Planned Purchase Date")
                                    AND (Week_Start_Date + 30 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."In One Month" += Shortage_Det2.Shortage;
                            END;
                        UNTIL Shortage_Det2.NEXT = 0;

                    Rec."Present Week" += Rec."Below Present Week";
                    Rec."Next 15 Days" += Rec."Below Present Week";
                    Rec."In One Month" += Rec."Below Present Week";


                    IF Rec."Minimum Order Qty." > Rec."Overall Requirement" THEN BEGIN
                        Rec."Type Of Item" := Rec."Type Of Item"::MOQ;
                    END;

                    //Added by Pranavi on 31-10-2015 for Alternate_items check for prod group wise
                    PrevProdTypes := '';
                    ProdTypes := 'ALL PRODUCTS|';
                    ProdTypess := '';
                    ILN.RESET;
                    ILN.SETCURRENTKEY("Item No", "Product Type");
                    ILN.SETFILTER(ILN."Item No", Rec."Item No.");
                    IF ILN.FINDSET THEN
                        REPEAT
                            IF PrevProdTypes <> ILN."Product Type" THEN
                                ProdTypes := ProdTypes + ILN."Product Type" + '|';
                            PrevProdTypes := ILN."Product Type";
                        UNTIL ILN.NEXT = 0;
                    IF STRLEN(ProdTypes) > 0 THEN
                        ProdTypess := COPYSTR(ProdTypes, 1, STRLEN(ProdTypes) - 1);
                    Alternate_Items.RESET;
                    Alternate_Items.SETFILTER(Alternate_Items."Item No.", Rec."Item No.");
                    Alternate_Items.SETFILTER(Alternate_Items."Proudct Type", ProdTypess);
                    IF Alternate_Items.FINDFIRST THEN
                        Rec."Type Of Item" := Rec."Type Of Item"::Alternate;
                    //End By Pranavi
                    /*
                    Alternate_Items.SETRANGE(Alternate_Items."Item No.","Item No.");
                    IF Alternate_Items.FINDFIRST THEN
                    BEGIN
                      "Type Of Item":="Type Of Item"::Alternate;
                    END;
                    */
                    IF Item.GET(Rec."Item No.") THEN BEGIN
                        IF Rec."Overall Requirement" <> ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                            (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")) THEN BEGIN
                            Rec.Difference := (Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                        (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")));
                            IF NOT ((Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues") -
                                    (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection"))) <= Rec."Purchase Orders") THEN
                                Rec."Complicarted Item" := TRUE;
                        END;
                        IF (Rec."Purchase Orders") > (Rec."Overall Requirement" - Rec.Difference) THEN      //anil change
                        BEGIN
                            Rec."Type Of Item" := Rec."Type Of Item"::Ordered;
                        END;
                    END;
                    IF Rec."Vendor Name" <> '' THEN
                        Rec.Confirmed := TRUE;

                    IF Prev_Item <> '' THEN
                        Rec.INSERT;
                END;
            END;
        END ELSE
            IF Choice = Choice::PNUC THEN BEGIN
                // IT IS ALSO SAME AS "PURCHASE UNDER CONTROL" MODEL    //ANIL ADDED FOR SHORTAGE
                Tot_Shortage := 0;
                Prev_Item := '';
                "Shortage Details".RESET;
                "Shortage Details".SETCURRENTKEY("Shortage Details"."Planned Purchase Date");
                "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                 "Shortage Details"."Production Order No.");
                "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
                IF Sale_Order <> '' THEN
                    "Shortage Details".SETRANGE("Shortage Details"."Sales Order No.", Sale_Order);
                //  MESSAGE(FORMAT("Shortage Details".COUNT));
                IF Data_Choice = Data_Choice::Open THEN BEGIN
                    "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Open');
                    //  "Shortage Details".SETFILTER("Shortage Details"."Item No",'ECPCBDS01167')//anil added
                END ELSE
                    IF Data_Choice = Data_Choice::WAP THEN BEGIN
                        "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                        "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WAP')
                    END ELSE
                        IF Data_Choice = Data_Choice::WFA THEN BEGIN
                            "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                            "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'WFA')
                        END ELSE
                            IF Data_Choice = Data_Choice::Authorised THEN BEGIN
                                // IF NOT(USERID='EFFTRONICS\PADMAJA') THEN
                                "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Authorised')
                            END ELSE
                                IF Data_Choice = Data_Choice::Indent THEN BEGIN
                                    IF NOT (USERID = '20P2007') THEN
                                        "Shortage Details".SETRANGE("Shortage Details"."Planned Purchase Date", 0D);
                                    "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Indent');
                                END;
                IF "Shortage Details".FINDSET THEN
                    REPEAT
                        Item.RESET;
                        IF Prev_Item <> '' THEN BEGIN
                            IF Prev_Item = "Shortage Details"."Item No" THEN BEGIN
                                Tot_Shortage += "Shortage Details".Shortage;
                            END ELSE BEGIN
                                Rec.INIT;
                                // MESSAGE('%1 item,%2 dc',Prev_Item,Prev_Direct_Cost);
                                Rec.VALIDATE("Item No.", Prev_Item);                    // error
                                Rec.Description := Prev_Description;
                                Rec.Shortage := Tot_Shortage;
                                // (("Required  Qty"+"Qty. In Material Issues")-("Qty. In Stores"+"Qty. In MCH"+"Purchase Orders"+"Qty Under Inspection"))
                                // Neditemsqty:=
                                // MESSAGE(FORMAT((("Required  Qty"+"Qty. In Material Issues")-("Qty. In Stores"+"Qty. In MCH"+
                                // "Purchase Orders"+"Qty Under Inspection"))));
                                Rec."Suitable Vendor" := Prev_Vendor;
                                Rec."Vendor Name" := Prev_Vendor_Name;
                                Rec."Unit Cost" := Prev_Cost;
                                Rec."Direct Unit Cost" := Prev_Direct_Cost;
                                Rec."Total Cost" := Prev_Cost * Tot_Shortage;
                                Rec."Accepted By Purchase" := Accp_By_Pur;
                                Rec."Alternated Item" := Prev_Alternate;
                                Po_Qty := 0;
                                Rec."Required  Qty" := 0;
                                Rec."Req Qty" := 0;
                                IF Item.GET(Prev_Item) THEN BEGIN
                                    Rec."Lead Time" := Item."Safety Lead Time";
                                    Rec."Unit of Measure" := Item."Base Unit of Measure";
                                    Item_Req.RESET;
                                    IF Item_Req.GET(Prev_Item) THEN BEGIN
                                        Rec."Required  Qty" := Item_Req."Required Quantity";
                                        Rec."Req Qty" := Item_Req."Req Qty";
                                        Rec."Qty. In Material Issues" := Item_Req."Qty. In Material Issues";
                                        Item.CALCFIELDS(Item."Inventory at Stores", Item."Qty. on Purch. Order",
                                                Item."Quantity Under Inspection", Item."Stock At MCH Location", Item."Stock at PROD Stores");
                                        ItmStockAtStores(Item."No.");
                                        //"Qty. In Stores":=Item."Stock at Stores";
                                        Rec."Qty. In MCH" := Item."Stock At MCH Location";
                                        Rec."Qty. In PROD" := Item."Stock at PROD Stores";
                                    END;
                                    IF Item.EFF_MOQ > 0 THEN
                                        Rec."Minimum Order Qty." := Item.EFF_MOQ
                                    ELSE
                                        Rec."Minimum Order Qty." := Item."Minimum Order Quantity";
                                    IF ((Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Open)) THEN BEGIN
                                        "Purchase Line".RESET;
                                        "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                                        "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                                        "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                                        "Purchase Line".SETRANGE("Purchase Line"."No.", Prev_Item);
                                        "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                                        "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date", '>=%1', "G\L"."Shortage. Calc. Date");
                                        IF "Purchase Line".FINDSET THEN
                                            REPEAT
                                                Po_Qty += "Purchase Line"."Qty. to Receive";
                                            UNTIL "Purchase Line".NEXT = 0;
                                        Rec."Purchase Orders" := Po_Qty;
                                        QILE.RESET;
                                        QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                                        QILE.SETRANGE(QILE."Item No.", Prev_Item);
                                        QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                                        QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                                        QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                                        QILE.SETRANGE(QILE."Location Code", 'STR');
                                        QILE.SETRANGE(QILE.Accept, TRUE);
                                        IF QILE.FINDSET THEN
                                            REPEAT
                                                Rec."Qty Under Inspection" += QILE."Remaining Quantity";
                                            UNTIL QILE.NEXT = 0;
                                        //anil write for required qty purpose
                                        //IF "Alternated Item"='' THEN    //commented by pranavi on 27-Nov-2015
                                        IF Item_Req.GET(Prev_Item) THEN BEGIN
                                            Rec."Required  Qty" := Item_Req."Required Quantity";
                                            Rec."Req Qty" := Item_Req."Req Qty";
                                            Rec."Qty. In Material Issues" := Item_Req."Qty. In Material Issues";
                                        END;
                                        /*
                                        IF "Alternated Item"<>'' THEN
                                        IF Item_Req.GET("Alternated Item") THEN  //anil added for testing
                                        BEGIN
                                          "Required  Qty":=Item_Req."Required Quantity";
                                          "Req Qty":=Item_Req."Req Qty";
                                          "Qty. In Material Issues":=Item_Req."Qty. In Material Issues";
                                        END;
                                        *///commented by pranavi on 27-Nov-2015
                                        IF Rec."Minimum Order Qty." > Rec."Present Week" THEN BEGIN
                                            IF Rec."Minimum Order Qty." > Rec."Next 15 Days" THEN
                                                Rec."Purchase Time Slot" := '1 MONTH'
                                            ELSE
                                                Rec."Purchase Time Slot" := '15 DAYS';
                                        END
                                        ELSE
                                            Rec."Purchase Time Slot" := 'THIS WEEK';
                                        //anil need to add
                                        Rec.Neditemsqty := ((Rec."Required  Qty" + Rec."Qty. In Material Issues") - (Rec."Qty. In Stores" + Rec."Qty. In MCH" + Rec."Purchase Orders" + Rec."Qty Under Inspection"));
                                    END;
                                    IF (Data_Choice = Data_Choice::WFA) OR (Data_Choice = Data_Choice::Authorised) OR (Data_Choice = Data_Choice::CBP) OR
                                     (Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Indent) THEN BEGIN
                                        Order_Qty := Tot_Shortage;
                                        IF Item.GET(Prev_Item) THEN BEGIN
                                            IF Item.EFF_MOQ > 0 THEN
                                                MOQ_Temp := Item.EFF_MOQ
                                            ELSE
                                                MOQ_Temp := Item."Minimum Order Quantity";

                                            IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" = 0) THEN BEGIN
                                                IF MOQ_Temp > 1 THEN BEGIN
                                                    IF Tot_Shortage < MOQ_Temp THEN
                                                        Order_Qty := MOQ_Temp
                                                    ELSE
                                                        Order_Qty := Tot_Shortage;
                                                END ELSE BEGIN
                                                    Order_Qty := Tot_Shortage;
                                                END;
                                            END ELSE
                                                IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                                                    IF MOQ_Temp > 1 THEN BEGIN
                                                        IF Tot_Shortage < MOQ_Temp THEN
                                                            Order_Qty := MOQ_Temp
                                                        ELSE BEGIN
                                                            IF MOQ_Temp = 1 THEN
                                                                Order_Qty := (Tot_Shortage DIV Item."Standard Packing Quantity") * Item."Standard Packing Quantity"
                                                            ELSE
                                                                Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                                        END;
                                                    END ELSE
                                                        Order_Qty := Tot_Shortage;
                                                END ELSE
                                                    IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                                                        IF MOQ_Temp > 1 THEN BEGIN
                                                            IF Tot_Shortage < MOQ_Temp THEN
                                                                Order_Qty := MOQ_Temp
                                                            ELSE
                                                                Order_Qty := ((Tot_Shortage DIV MOQ_Temp) + 1) * MOQ_Temp
                                                        END ELSE
                                                            Order_Qty := Tot_Shortage;
                                                    END ELSE
                                                        IF (MOQ_Temp = 0) AND (Item."Standard Packing Quantity" > 0) THEN BEGIN
                                                            IF Tot_Shortage < Item."Standard Packing Quantity" THEN
                                                                Order_Qty := Item."Standard Packing Quantity"
                                                            ELSE
                                                                Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                                        END;
                                        END;
                                    END;
                                    //MESSAGE('3');
                                    "Cost Estimation" += Prev_Cost * Order_Qty;
                                    Prev_Vendor := "Shortage Details"."Suitable Vendor";
                                    Prev_Vendor_Name := "Shortage Details"."Vendor Name";
                                    Prev_Cost := "Shortage Details"."Unit Cost";
                                    //MESSAGE('3'); // error
                                    Prev_Direct_Cost := "Shortage Details"."Direct Unit Cost";
                                END;


                                Shortage_Det2.RESET;
                                Shortage_Det2.SETFILTER(Shortage_Det2.Shortage, '>%1', 0);   //Added by Pranavi on 24-11-2015
                                Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                                IF Shortage_Det2.FINDSET THEN
                                    REPEAT
                                        Rec."Overall Requirement" += Shortage_Det2.Shortage;
                                        IF (Week_Start_Date + 7 >= Shortage_Det2."Planned Purchase Date") THEN
                                            Rec."Present Week" += Shortage_Det2.Shortage;

                                        IF (Week_Start_Date + 15 >= Shortage_Det2."Planned Purchase Date") THEN
                                            Rec."Next 15 Days" += Shortage_Det2.Shortage;

                                        IF (Week_Start_Date + 30 >= Shortage_Det2."Planned Purchase Date") THEN
                                            Rec."In One Month" += Shortage_Det2.Shortage;

                                    UNTIL Shortage_Det2.NEXT = 0;

                                IF Rec."Minimum Order Qty." > Rec."Overall Requirement" THEN BEGIN
                                    Rec."Type Of Item" := Rec."Type Of Item"::MOQ;
                                END;

                                //Added by Pranavi on 31-10-2015 for Alternate_items check for prod group wise
                                PrevProdTypes := '';
                                ProdTypes := 'ALL PRODUCTS|';
                                ProdTypess := '';
                                ILN.RESET;
                                ILN.SETCURRENTKEY("Item No", "Product Type");
                                ILN.SETFILTER(ILN."Item No", Rec."Item No.");
                                IF ILN.FINDSET THEN
                                    REPEAT
                                        IF PrevProdTypes <> ILN."Product Type" THEN
                                            ProdTypes := ProdTypes + ILN."Product Type" + '|';
                                        PrevProdTypes := ILN."Product Type";
                                    UNTIL ILN.NEXT = 0;
                                IF STRLEN(ProdTypes) > 0 THEN
                                    ProdTypess := COPYSTR(ProdTypes, 1, STRLEN(ProdTypes) - 1);
                                Alternate_Items.RESET;
                                Alternate_Items.SETFILTER(Alternate_Items."Item No.", Rec."Item No.");
                                Alternate_Items.SETFILTER(Alternate_Items."Proudct Type", ProdTypess);
                                IF Alternate_Items.FINDFIRST THEN
                                    Rec."Type Of Item" := Rec."Type Of Item"::Alternate;
                                //End By Pranavi
                                /*
                                Alternate_Items.SETRANGE(Alternate_Items."Item No.","Item No.");
                                IF Alternate_Items.FINDFIRST THEN
                                BEGIN
                                  "Type Of Item":="Type Of Item"::Alternate;
                                END;
                                */

                                IF Item.GET(Rec."Item No.") THEN BEGIN
                                    Rec.Difference := (Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                                    (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")));
                                    IF Rec."Overall Requirement" <> ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                                      (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")) THEN BEGIN
                                        IF NOT ((Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues") -
                                            (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection"))) <= Rec."Purchase Orders") THEN
                                            Rec."Complicarted Item" := TRUE;

                                    END;
                                    IF (Rec."Purchase Orders") >= (Rec."Overall Requirement" - Rec.Difference) THEN BEGIN
                                        //  IF"Required  Qty">0 THEN//anil added for alternate items purpose
                                        Rec."Type Of Item" := Rec."Type Of Item"::Ordered;
                                    END;

                                END;
                                IF Rec."Vendor Name" <> '' THEN
                                    Rec.Confirmed := TRUE;

                                IF Prev_Item <> '' THEN
                                    Rec.INSERT;
                                Tot_Shortage := 0;
                                Prev_Alternate := '';
                                Prev_Item := "Shortage Details"."Item No";
                                Prev_Description := "Shortage Details".Description;
                                Tot_Shortage += "Shortage Details".Shortage;
                                Accp_By_Pur := "Shortage Details"."Accepted By Purchase";
                                IF Prev_Alternate = '' THEN
                                    Prev_Alternate := "Shortage Details"."Alternated Item";
                            END;
                        END ELSE BEGIN
                            Prev_Item := "Shortage Details"."Item No";
                            Prev_Description := "Shortage Details".Description;
                            Tot_Shortage += "Shortage Details".Shortage;
                            Accp_By_Pur := "Shortage Details"."Accepted By Purchase";
                            IF Prev_Alternate = '' THEN
                                Prev_Alternate := "Shortage Details"."Alternated Item";
                        END;
                        IF (Data_Choice = Data_Choice::WFA) OR (Data_Choice = Data_Choice::Authorised) OR (Data_Choice = Data_Choice::CBP) OR
                           (Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Indent) THEN BEGIN
                            Prev_Vendor := "Shortage Details"."Suitable Vendor";
                            Prev_Vendor_Name := "Shortage Details"."Vendor Name";
                            Prev_Cost := "Shortage Details"."Unit Cost";
                            Prev_Direct_Cost := "Shortage Details"."Direct Unit Cost";// Rev07
                        END;
                    UNTIL "Shortage Details".NEXT = 0;
                IF "Shortage Details".COUNT > 0 THEN BEGIN

                    IF Prev_Item <> '' THEN BEGIN
                        Rec.INIT;
                        Rec.VALIDATE("Item No.", Prev_Item);
                        Rec.Description := Prev_Description;
                        Rec.Shortage := Tot_Shortage;
                        //    MESSAGE(FORMAT(Shortage));
                        Rec."Suitable Vendor" := Prev_Vendor;
                        Rec."Vendor Name" := Prev_Vendor_Name;
                        Rec."Unit Cost" := Prev_Cost;
                        Rec."Direct Unit Cost" := Prev_Direct_Cost;
                        Rec."Total Cost" := Prev_Cost * Tot_Shortage;
                        Rec."Accepted By Purchase" := Accp_By_Pur;
                        Rec."Alternated Item" := Prev_Alternate;
                        IF Item.GET(Prev_Item) THEN BEGIN
                            Rec."Lead Time" := Item."Safety Lead Time";
                            Rec."Unit of Measure" := Item."Base Unit of Measure";
                            IF (Data_Choice = Data_Choice::WFA) OR (Data_Choice = Data_Choice::Authorised) OR (Data_Choice = Data_Choice::CBP)
                                OR (Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Indent) THEN BEGIN
                                Order_Qty := Tot_Shortage;
                                IF Item.GET(Prev_Item) THEN BEGIN
                                    IF Item.EFF_MOQ > 0 THEN
                                        MOQ_Temp := Item.EFF_MOQ
                                    ELSE
                                        MOQ_Temp := Item."Minimum Order Quantity";

                                    IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" = 0) THEN BEGIN
                                        IF MOQ_Temp > 1 THEN BEGIN
                                            IF Tot_Shortage < MOQ_Temp THEN
                                                Order_Qty := MOQ_Temp
                                            ELSE
                                                Order_Qty := Tot_Shortage;
                                        END ELSE BEGIN
                                            Order_Qty := Tot_Shortage;
                                        END;
                                    END ELSE
                                        IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                                            IF MOQ_Temp > 1 THEN BEGIN
                                                IF Tot_Shortage < MOQ_Temp THEN
                                                    Order_Qty := MOQ_Temp
                                                ELSE BEGIN
                                                    IF MOQ_Temp = 1 THEN
                                                        Order_Qty := (Tot_Shortage DIV Item."Standard Packing Quantity") * Item."Standard Packing Quantity"
                                                    ELSE
                                                        Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                                END;
                                            END ELSE
                                                Order_Qty := Tot_Shortage;
                                        END ELSE
                                            IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                                                IF MOQ_Temp > 1 THEN BEGIN
                                                    IF Tot_Shortage < MOQ_Temp THEN
                                                        Order_Qty := MOQ_Temp
                                                    ELSE
                                                        Order_Qty := ((Tot_Shortage DIV MOQ_Temp) + 1) * MOQ_Temp
                                                END ELSE
                                                    Order_Qty := Tot_Shortage;

                                            END ELSE
                                                IF (MOQ_Temp = 0) AND (Item."Standard Packing Quantity" > 0) THEN BEGIN
                                                    IF Tot_Shortage < Item."Standard Packing Quantity" THEN
                                                        Order_Qty := Item."Standard Packing Quantity"
                                                    ELSE
                                                        Order_Qty := ((Tot_Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                                END;
                                END;
                                // MESSAGE('4');
                                "Cost Estimation" += "Shortage Details"."Unit Cost" * Order_Qty;
                                Prev_Vendor := "Shortage Details"."Suitable Vendor";
                                Prev_Vendor_Name := "Shortage Details"."Vendor Name";
                                Prev_Cost := "Shortage Details"."Unit Cost";
                                Rec."Direct Unit Cost" := Prev_Direct_Cost;
                            END;
                            Item_Req.RESET;
                            IF Item_Req.GET(Prev_Item) THEN BEGIN
                                Rec."Required  Qty" := Item_Req."Required Quantity";
                                Rec."Req Qty" := Item_Req."Req Qty";
                                Rec."Qty. In Material Issues" := Item_Req."Qty. In Material Issues";
                                Item.CALCFIELDS(Item."Inventory at Stores", Item."Qty. on Purch. Order",
                                          Item."Quantity Under Inspection", Item."Stock At MCH Location", Item."Stock at PROD Stores");
                                ItmStockAtStores(Item."No.");
                                //"Qty. In Stores":=Item."Stock at Stores";
                                Rec."Qty. In MCH" := Item."Stock At MCH Location";
                                Rec."Qty. In PROD" := Item."Stock at PROD Stores";
                            END;

                        END;


                        IF ((Data_Choice = Data_Choice::WAP) OR (Data_Choice = Data_Choice::Open)) THEN BEGIN



                            Po_Qty := 0;

                            "Purchase Line".RESET;
                            "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                            "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                            "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                            "Purchase Line".SETRANGE("Purchase Line"."No.", Prev_Item);
                            "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                            "Purchase Line".SETFILTER("Purchase Line"."Deviated Receipt Date", '>=%1', "G\L"."Shortage. Calc. Date");
                            IF "Purchase Line".FINDSET THEN
                                REPEAT
                                    Po_Qty += "Purchase Line"."Qty. to Receive";
                                UNTIL "Purchase Line".NEXT = 0;
                            Rec."Purchase Orders" := Po_Qty;

                            QILE.RESET;
                            QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                            QILE.SETRANGE(QILE."Item No.", Prev_Item);
                            QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                            QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                            QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                            QILE.SETRANGE(QILE."Location Code", 'STR');
                            QILE.SETRANGE(QILE.Accept, TRUE);
                            IF QILE.FINDSET THEN
                                REPEAT
                                    Rec."Qty Under Inspection" += QILE."Remaining Quantity";
                                UNTIL QILE.NEXT = 0;



                        END;
                        Shortage_Det2.RESET;
                        Shortage_Det2.SETFILTER(Shortage_Det2.Shortage, '>%1', 0);   //Added by Pranavi on 24-11-2015
                        Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Prev_Item);
                        IF Shortage_Det2.FINDSET THEN
                            REPEAT
                                Rec."Overall Requirement" += Shortage_Det2.Shortage;
                                IF (Week_Start_Date + 7 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."Present Week" += Shortage_Det2.Shortage;
                                IF (Week_Start_Date + 15 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."Next 15 Days" += Shortage_Det2.Shortage;
                                IF (Week_Start_Date + 30 >= Shortage_Det2."Planned Purchase Date") THEN
                                    Rec."In One Month" += Shortage_Det2.Shortage;
                            UNTIL Shortage_Det2.NEXT = 0;

                        IF Rec."Minimum Order Qty." > Rec."Present Week" THEN BEGIN
                            IF Rec."Minimum Order Qty." > Rec."Next 15 Days" THEN
                                Rec."Purchase Time Slot" := '1 MONTH'
                            ELSE
                                Rec."Purchase Time Slot" := '15 DAYS';
                        END ELSE
                            Rec."Purchase Time Slot" := 'THIS WEEK';

                        IF Rec."Minimum Order Qty." > Rec."Overall Requirement" THEN BEGIN
                            Rec."Type Of Item" := Rec."Type Of Item"::MOQ;

                        END;

                        //Added by Pranavi on 31-10-2015 for Alternate_items check for prod group wise
                        PrevProdTypes := '';
                        ProdTypes := 'ALL PRODUCTS|';
                        ProdTypess := '';
                        ILN.RESET;
                        ILN.SETCURRENTKEY("Item No", "Product Type");
                        ILN.SETFILTER(ILN."Item No", Rec."Item No.");
                        IF ILN.FINDSET THEN
                            REPEAT
                                IF PrevProdTypes <> ILN."Product Type" THEN
                                    ProdTypes := ProdTypes + ILN."Product Type" + '|';
                                PrevProdTypes := ILN."Product Type";
                            UNTIL ILN.NEXT = 0;
                        IF STRLEN(ProdTypes) > 0 THEN
                            ProdTypess := COPYSTR(ProdTypes, 1, STRLEN(ProdTypes) - 1);
                        Alternate_Items.RESET;
                        Alternate_Items.SETFILTER(Alternate_Items."Item No.", Rec."Item No.");
                        Alternate_Items.SETFILTER(Alternate_Items."Proudct Type", ProdTypess);
                        IF Alternate_Items.FINDFIRST THEN
                            Rec."Type Of Item" := Rec."Type Of Item"::Alternate;
                        //End By Pranavi
                        /*
                        Alternate_Items.SETRANGE(Alternate_Items."Item No.","Item No.");
                        IF Alternate_Items.FINDFIRST THEN
                        BEGIN
                          "Type Of Item":="Type Of Item"::Alternate;
                        END;
                        */

                        IF Item.GET(Rec."Item No.") THEN BEGIN
                            IF Rec."Overall Requirement" <> ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                                (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")) THEN BEGIN
                                Rec.Difference := (Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues" + Item."Safety Stock Quantity") -
                                              (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection")));
                                IF NOT ((Rec."Overall Requirement" - ((Rec."Required  Qty" + Rec."Qty. In Material Issues") -
                                       (Item."Stock At MCH Location" + Item."Stock at Stores" + Rec."Qty Under Inspection"))) <= Rec."Purchase Orders") THEN
                                    Rec."Complicarted Item" := TRUE;

                            END;
                            IF (Rec."Purchase Orders") >= (Rec."Overall Requirement" - Rec.Difference) THEN BEGIN
                                Rec."Type Of Item" := Rec."Type Of Item"::Ordered;
                            END;

                        END;

                        IF Rec."Vendor Name" <> '' THEN
                            Rec.Confirmed := TRUE;

                        IF Prev_Item <> '' THEN
                            Rec.INSERT;
                    END;
                END;
            END ELSE BEGIN
                // THIS IS THE CODE WHEN  CHOICE IS IN "SHORTAGE"
                Rec.DELETEALL;
                "Shortage Details".RESET;
                "Shortage Details".SETCURRENTKEY("Shortage Details"."Item No", "Shortage Details"."Planned Purchase Date",
                                                 "Shortage Details"."Production Order No.");
                "Shortage Details".SETFILTER("Shortage Details"."Planned Date", DateFilter);
                "Shortage Details".SETFILTER("Shortage Details".Authorisation, 'Open');
                "Shortage Details".SETFILTER("Shortage Details".Shortage, '>%1', 0);
                IF "Shortage Details".FINDSET THEN
                    REPEAT
                        IF Prev_Item <> '' THEN BEGIN
                            IF Prev_Item = "Shortage Details"."Item No" THEN BEGIN
                                Tot_Shortage += "Shortage Details".Shortage;
                            END ELSE BEGIN
                                Rec.INIT;
                                Rec.VALIDATE("Item No.", Prev_Item);
                                Rec.Description := Prev_Description;
                                Rec.Shortage := Tot_Shortage;
                                Item.RESET;
                                IF Item.GET(Prev_Item) THEN BEGIN
                                    Rec."Lead Time" := Item."Safety Lead Time";
                                    Rec."Unit of Measure" := Item."Base Unit of Measure";
                                    IF FORMAT(Rec."Lead Time") <> '' THEN BEGIN

                                        Buffer := '-' + FORMAT(Item."Safety Lead Time");
                                        Rec."Planned Purchase Date (WOB)" := CALCDATE(Buffer, TODAY + 3);
                                        IF Rec."Planned Purchase Date (WOB)" >= TODAY THEN BEGIN

                                            Buffer := '-' + '6D';
                                            Rec."Planned Purchase Date" := CALCDATE(Buffer, Rec."Planned Purchase Date (WOB)");
                                            IF Rec."Planned Purchase Date" < TODAY THEN
                                                Rec."Planned Purchase Date" := 0D;
                                        END ELSE BEGIN
                                            Rec."Planned Purchase Date" := 0D;
                                            Rec."Planned Purchase Date (WOB)" := 0D;
                                        END;
                                    END;
                                    IF Prev_Item <> '' THEN
                                        Rec.INSERT;
                                    Tot_Shortage := 0;
                                    Prev_Item := "Shortage Details"."Item No";
                                    Prev_Description := "Shortage Details".Description;
                                    Tot_Shortage += "Shortage Details".Shortage;
                                END;
                            END;
                        END ELSE BEGIN
                            Prev_Item := "Shortage Details"."Item No";
                            Prev_Description := "Shortage Details".Description;
                            Tot_Shortage += "Shortage Details".Shortage;
                        END;
                    UNTIL "Shortage Details".NEXT = 0;
            END;
        //SETFILTER( "Type Of Item",'<>%1',"Type Of Item"::Ordered);

    end;


    procedure "Calculate Date Filter"();
    begin

        Shortage_Date_Filter := FORMAT(TODAY + 2) + '..' + FORMAT(TODAY + 8);
        IF DATE2DWY(TODAY, 1) = 1 THEN BEGIN
            Purchase_Date_Filter := FORMAT(TODAY) + '..' + FORMAT(TODAY + 6);
            Week_Start_Date := TODAY;
        END ELSE
            IF DATE2DWY(TODAY, 1) = 2 THEN BEGIN
                Purchase_Date_Filter := FORMAT(TODAY - 1) + '..' + FORMAT(TODAY + 5);
                Week_Start_Date := TODAY - 1;
            END ELSE
                IF DATE2DWY(TODAY, 1) = 3 THEN BEGIN
                    Purchase_Date_Filter := FORMAT(TODAY - 2) + '..' + FORMAT(TODAY + 4);
                    Week_Start_Date := TODAY - 2;
                END ELSE
                    IF DATE2DWY(TODAY, 1) = 4 THEN BEGIN
                        Purchase_Date_Filter := FORMAT(TODAY - 3) + '..' + FORMAT(TODAY + 3);
                        Week_Start_Date := TODAY;
                    END ELSE
                        IF DATE2DWY(TODAY, 1) = 5 THEN BEGIN
                            Purchase_Date_Filter := FORMAT(TODAY - 4) + '..' + FORMAT(TODAY + 2);
                            Week_Start_Date := TODAY - 1;
                        END ELSE
                            IF DATE2DWY(TODAY, 1) = 6 THEN BEGIN
                                Purchase_Date_Filter := FORMAT(TODAY - 5) + '..' + FORMAT(TODAY + 1);
                                Week_Start_Date := TODAY - 2;
                            END ELSE
                                IF DATE2DWY(TODAY, 1) = 7 THEN BEGIN
                                    Purchase_Date_Filter := FORMAT(TODAY - 6) + '..' + FORMAT(TODAY);
                                    Week_Start_Date := TODAY - 3;
                                END;
        IF Choice = Choice::Shortage THEN
            DateFilter := Shortage_Date_Filter
        ELSE
            DateFilter := Purchase_Date_Filter;
    end;


    procedure FormShow();
    begin
        IF (Choice = Choice::Shortage) THEN BEGIN
            /*
            Currpage."Suitable Vendor".VISIBLE:=FALSE;
            Currpage."Unit Cost".VISIBLE:=FALSE;
            Currpage."Production  Orders".VISIBLE:=TRUE;
            Currpage."Purchase Orders".VISIBLE:=TRUE;

            Currpage."Vendor Name".VISIBLE:=FALSE;
            Currpage."Minimum Order Qty.".VISIBLE:=FALSE;
            */ //Rev01
        END ELSE
            IF (Choice <> Choice::Shortage) AND (Data_Choice = Data_Choice::Open) THEN BEGIN
                /*
                Currpage."Suitable Vendor".VISIBLE:=FALSE;
                Currpage."Unit Cost".VISIBLE:=FALSE;
                Currpage."Production  Orders".VISIBLE:=TRUE;
                Currpage."Purchase Orders".VISIBLE:=TRUE;
                Currpage."Alternate Item".VISIBLE:=FALSE;
                Currpage."Final Mat. Req. Date".VISIBLE:=FALSE;
                Currpage."Purchase Time Slot".VISIBLE:=FALSE;
                Currpage.Confirmed.VISIBLE:=FALSE;
                Currpage."Vendor Name".VISIBLE:=FALSE;
                Currpage."Minimum Order Qty.".VISIBLE:=TRUE;
                Currpage."Earliest Required Day".VISIBLE:=TRUE;
                Currpage."Get From CS".VISIBLE:=FALSE;
                */ //Rev01

            END ELSE
                IF (Choice <> Choice::Shortage) AND (Data_Choice = Data_Choice::WAP) THEN BEGIN
                    /*
                    Currpage."Suitable Vendor".VISIBLE:=TRUE;
                    Currpage."Unit Cost".VISIBLE:=TRUE;
                    Currpage."Production  Orders".VISIBLE:=FALSE;
                    Currpage."Alternate Item".VISIBLE:=TRUE;
                    Currpage."Accepted By Purchase".VISIBLE:=FALSE;
                    Currpage."Final Mat. Req. Date".VISIBLE:=FALSE;
                    Currpage."Purchase Orders".VISIBLE:=TRUE;
                    Currpage."Final Mat. Req. Date".VISIBLE:=FALSE;
                    Currpage."Lead Time".VISIBLE:=TRUE;
                    Currpage.Confirmed.VISIBLE:=TRUE;
                    Currpage."Production  Orders".VISIBLE:=FALSE;

                    Currpage."Earliest Required Day".VISIBLE:=TRUE;

                    Currpage."Vendor Name".VISIBLE:=TRUE;
                    Currpage."Minimum Order Qty.".VISIBLE:=TRUE;
                    */ //Rev01
                END ELSE
                    IF (Choice <> Choice::Shortage) AND (Data_Choice = Data_Choice::Authorised) THEN BEGIN
                        /*
                          Currpage."Suitable Vendor".VISIBLE:=TRUE;
                          Currpage."Unit Cost".VISIBLE:=TRUE;
                          Currpage."Production  Orders".VISIBLE:=TRUE;
                          Currpage."Purchase Orders".VISIBLE:=TRUE;
                          Currpage."Earliest Required Day".VISIBLE:=FALSE;
                          Currpage."Purchase Time Slot".VISIBLE:=FALSE;


                          Currpage."Vendor Name".VISIBLE:=TRUE;
                          Currpage."Minimum Order Qty.".VISIBLE:=TRUE;
                          *///Rev01
                    END;

    end;


    procedure GetNextNo() NumberValue: Code[20];
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

        //IF DATE2DMY(WORKDATE,2) < 10 THEN
        YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);

        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '000';
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


    procedure Form_Status() Stat: Text[30];
    begin

        Stat := Status;
        EXIT(Stat);
    end;


    procedure OpenExistingXlsWorkbook(Fname: Text[250]; SheetNr: Integer);
    var
        WorksheetAlreadyOpen: Boolean;
    begin
        /*xlWorkBooks := xlApp.Workbooks;
        WorksheetAlreadyOpen := FALSE; // this is a local variable
        IF xlWorkBooks.Count > 0 THEN BEGIN
        ThisWorkbook := xlApp.ActiveWorkbook;
        WorksheetAlreadyOpen := (ThisWorkbook.FullName = Fname);
        END;
        IF NOT WorksheetAlreadyOpen THEN
        xlWorkBooks.Open(Fname);
        xlWorkBook := xlApp.ActiveWorkbook;
        xlSheets := xlWorkBook.Worksheets;
        xlWorkSheet := xlSheets.Item(SheetNr);
          */

    end;


    procedure TEMCMail(IndentHeader: Record "Indent Header");
    var
        TCount: Decimal;
        test: Integer;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        "from Mail": Text[1000];
        "to mail": Text;
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        mail: Codeunit Mail;
        indentlines: Record "Indent Line";
        space: Integer;
        i: Integer;
        charline: Char;
        item: Record Item;
    begin
        //added by pranavi on 20-05-2015 for auto mail to TEMC for FILM Capacitors, Varistors
        //IF (IndentHeader."Delivery Location"='STR')  THEN
        //BEGIN
        TCount := 0;
        indentlines.RESET;
        indentlines.SETFILTER(indentlines."Document No.", IndentHeader."No.");
        IF indentlines.FINDSET THEN
            REPEAT
                item.RESET;
                item.SETFILTER(item."No.", indentlines."No.");
                IF item.FINDFIRST THEN BEGIN
                    IF (item."Item Sub Group Code" = 'FILM') OR (item."Product Group Code Cust" = 'VARIST') THEN BEGIN
                        TCount := TCount + 1;
                    END;
                END;
            UNTIL indentlines.NEXT = 0;

        //B2B UPG >>>
        /* IF (TCount > 0) THEN BEGIN
            charline := 10;
            Mail_Subject := 'ERP - Indent Released for Film Capacitors, MOVS';
            "to mail" := 'temc@efftronics.com,erp@efftronics.com,anilkumar@efftronics.com';
            "from Mail" := 'erp@efftronics.com';
            Mail_Body := '';
            Mail_Body += 'Indent No.  : ' + IndentHeader."No.";
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Project Name: ' + IndentHeader."Production Order Description";
            Mail_Body += FORMAT(charline);
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Item Description';
            FOR i := 1 TO 34 DO
                Mail_Body += ' ';
            Mail_Body += 'Quantity';
            Mail_Body += FORMAT(charline);
            indentlines.SETRANGE(indentlines."Document No.", IndentHeader."No.");
            IF indentlines.FINDSET THEN
                REPEAT
                        item.SETRANGE(item."No.", indentlines."No.");
                    IF item.FINDFIRST THEN BEGIN
                        IF (item."Item Sub Group Code" = 'FILM') OR (item."Product Group Code cust" = 'VARIST') THEN BEGIN
                            IF STRLEN(Mail_Body) < 800 THEN BEGIN
                                Mail_Body += indentlines.Description;
                                space := 50 - STRLEN(indentlines.Description);
                                FOR i := 1 TO space DO
                                    Mail_Body += ' ';
                                Mail_Body += FORMAT(indentlines.Quantity);
                                Mail_Body += FORMAT(charline);
                            END;
                        END;
                    END;
                UNTIL indentlines.NEXT = 0;
            Mail_Body += FORMAT(charline);
            Mail_Body += '***** Auto Mail Generated From ERP *****';
            SMTP_MAIL.CreateMessage(IndentHeader."Delivery Location", "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
            SMTP_MAIL.Send;
            test := 10;
        END; */  //B2B UPG <<<

        IF (TCount > 0) THEN BEGIN
            charline := 10;
            Mail_Subject := 'ERP - Indent Released for Film Capacitors, MOVS';
            //"to mail" := 'temc@efftronics.com,erp@efftronics.com,anilkumar@efftronics.com';
            Recipient.Add('temc@efftronics.com');
            Recipient.Add('erp@efftronics.com');
            Recipient.Add('anilkumar@efftronics.com');
            //"from Mail" := 'erp@efftronics.com';
            Mail_Body := '';
            Mail_Body += 'Indent No.  : ' + IndentHeader."No.";
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Project Name: ' + IndentHeader."Production Order Description";
            Mail_Body += FORMAT(charline);
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Item Description';
            FOR i := 1 TO 34 DO
                Mail_Body += ' ';
            Mail_Body += 'Quantity';
            Mail_Body += FORMAT(charline);
            indentlines.SETRANGE(indentlines."Document No.", IndentHeader."No.");
            IF indentlines.FINDSET THEN
                REPEAT
                    item.SETRANGE(item."No.", indentlines."No.");
                    IF item.FINDFIRST THEN BEGIN
                        IF (item."Item Sub Group Code" = 'FILM') OR (item."Product Group Code cust" = 'VARIST') THEN BEGIN
                            IF STRLEN(Mail_Body) < 800 THEN BEGIN
                                Mail_Body += indentlines.Description;
                                space := 50 - STRLEN(indentlines.Description);
                                FOR i := 1 TO space DO
                                    Mail_Body += ' ';
                                Mail_Body += FORMAT(indentlines.Quantity);
                                Mail_Body += FORMAT(charline);
                            END;
                        END;
                    END;
                UNTIL indentlines.NEXT = 0;
            Mail_Body += FORMAT(charline);
            Mail_Body += '***** Auto Mail Generated From ERP *****';
            /* SMTP_MAIL.CreateMessage(IndentHeader."Delivery Location", "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
            SMTP_MAIL.Send; */
            EmailMessage.Create(Recipient, Mail_Subject, Mail_Body, FALSE);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            test := 10;
        END;
        //END;
        //end by pranavi
    end;


    procedure ItmStockAtStores(ItmNo: Code[50]);
    var
        Item1: Record Item;
        ItemLedgEntry1: Record "Item Ledger Entry";
        QualityItemLedgEntry1: Record "Quality Item Ledger Entry";
        Stock1: Decimal;
    begin
        Stock1 := 0;
        Item1.RESET;
        Item1.SETRANGE(Item1."No.", ItmNo);
        IF Item1.FINDFIRST THEN BEGIN
            Item1.CALCFIELDS(Item1."Quantity Under Inspection", Item1."Quantity Rejected", Item1."Quantity Rework",
            Item1."Quantity Sent for Rework", Item1."Inventory at Stores");
            IF Item1."QC Enabled" = TRUE THEN BEGIN
                IF (Item1."Quantity Under Inspection" = 0) AND (Item1."Quantity Rejected" = 0) AND
                   (Item1."Quantity Rework" = 0) AND (Item1."Quantity Sent for Rework" = 0) THEN BEGIN
                    ItemLedgEntry1.RESET;
                    ItemLedgEntry1.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                    "Expiration Date", "Lot No.", "Serial No.");
                    ItemLedgEntry1.SETRANGE("Item No.", Item1."No.");
                    ItemLedgEntry1.SETRANGE(Open, TRUE);
                    ItemLedgEntry1.SETRANGE("Location Code", 'STR');
                    IF ItemLedgEntry1.FIND('-') THEN
                        REPEAT
                            Stock1 += ItemLedgEntry1."Remaining Quantity";
                        UNTIL ItemLedgEntry1.NEXT = 0;
                END ELSE BEGIN
                    Stock1 := 0;
                    ItemLedgEntry1.RESET;
                    ItemLedgEntry1.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                                                "Expiration Date", "Lot No.", "Serial No.");
                    ItemLedgEntry1.SETRANGE("Item No.", Item1."No.");
                    ItemLedgEntry1.SETRANGE(Open, TRUE);
                    ItemLedgEntry1.SETRANGE("Location Code", 'STR');
                    IF ItemLedgEntry1.FIND('-') THEN
                        REPEAT
                            ItemLedgEntry1.MARK(TRUE);
                            IF (QualityItemLedgEntry1.GET(ItemLedgEntry1."Entry No.") AND (QualityItemLedgEntry1."Inspection Status" =
                                QualityItemLedgEntry1."Inspection Status"::"Under Inspection")) OR
                                (QualityItemLedgEntry1.GET(ItemLedgEntry1."Entry No.")
                                AND (QualityItemLedgEntry1."Inspection Status" = QualityItemLedgEntry1."Inspection Status"::Rejected)) THEN
                                ItemLedgEntry1.MARK(FALSE);

                        UNTIL ItemLedgEntry1.NEXT = 0;
                END;
            END;
            ItemLedgEntry1.MARKEDONLY(TRUE);
            IF ItemLedgEntry1.FIND('-') THEN
                REPEAT
                    Stock1 := Stock1 + ItemLedgEntry1."Remaining Quantity";
                UNTIL ItemLedgEntry1.NEXT = 0;
            Item1."Stock at Stores" := Stock1;
            Item1.MODIFY;
            Rec."Qty. In Stores" := Item1."Stock at Stores";
        END;
    end;


    local procedure ShortageAuthorizedMaterialCreation(ShortageDetails: Record "Item Lot Numbers");
    begin
        Item_table.RESET;
        Item_table.SETFILTER("No.", ShortageDetails."Item No");
        IF Item_table.FINDSET THEN BEGIN
            ITEM_MOQ := Item_table."Minimum Order Quantity";
            ITEM_EFF_MOQ := Item_table.EFF_MOQ;
        END; // added by sujani on 11-Oct-18 for MOQ in Power BI Report


        ShortageAuthorizedMaterial.RESET;
        ShortageAuthorizedMaterial.INIT;
        ShortageAuthorizedMaterial."Item No" := ShortageDetails."Item No";
        ShortageAuthorizedMaterial."Planned Date" := ShortageDetails."Planned Date";
        ShortageAuthorizedMaterial.Shortage := ShortageDetails.Shortage;
        ShortageAuthorizedMaterial."Planned Purchase Date" := ShortageDetails."Planned Purchase Date";
        ShortageAuthorizedMaterial."Suitable Vendor" := ShortageDetails."Suitable Vendor";
        ShortageAuthorizedMaterial."Unit Cost" := ShortageDetails."Unit Cost";
        ShortageAuthorizedMaterial."Production Orders" := ShortageDetails."Production Orders";
        ShortageAuthorizedMaterial.Description := ShortageDetails.Description;
        ShortageAuthorizedMaterial."Planned Purchase Dare (WOB)" := ShortageDetails."Planned Purchase Dare (WOB)";
        ShortageAuthorizedMaterial.Authorisation := ShortageDetails.Authorisation;
        ShortageAuthorizedMaterial."Minimum Order. Qty" := ShortageDetails."Minimum Order. Qty";
        ShortageAuthorizedMaterial."Unit Of Measure" := ShortageDetails."Unit Of Measure";
        ShortageAuthorizedMaterial."Vendor Name" := ShortageDetails."Vendor Name";
        ShortageAuthorizedMaterial."Indent No." := ShortageDetails."Indent No.";
        ShortageAuthorizedMaterial."Production Order No." := ShortageDetails."Production Order No.";
        ShortageAuthorizedMaterial."Sales Order No." := ShortageDetails."Sales Order No.";
        ShortageAuthorizedMaterial."Customer Name" := ShortageDetails."Customer Name";
        ShortageAuthorizedMaterial."Product Type" := ShortageDetails."Product Type";
        ShortageAuthorizedMaterial.Product := ShortageDetails.Product;
        ShortageAuthorizedMaterial."Direct Unit Cost" := ShortageDetails."Direct Unit Cost";
        ShortageAuthorizedMaterial."Material Required Date" := ShortageDetails."Material Required Date";
        ShortageAuthorizedMaterial."Possible Procured Date" := ShortageDetails."Possible Procured Date";
        ShortageAuthorizedMaterial."Possible Production Plan Date" := ShortageDetails."Possible Production Plan Date";
        ShortageAuthorizedMaterial."Material Required Day" := ShortageDetails."Material Required Day";
        ShortageAuthorizedMaterial."Lead Time" := ShortageDetails."Lead Time";
        ShortageAuthorizedMaterial."Accepted By Purchase" := ShortageDetails."Accepted By Purchase";
        ShortageAuthorizedMaterial."Within Buffer" := ShortageDetails."Within Buffer";
        ShortageAuthorizedMaterial."Alternated Item" := ShortageDetails."Alternated Item";
        ShortageAuthorizedMaterial."Lead Time2" := ShortageDetails."Lead Time2";
        ShortageAuthorizedMaterial.Total := ShortageDetails.Total;
        ShortageAuthorizedMaterial."Vitual Purchase Date" := ShortageDetails."Vitual Purchase Date";
        ShortageAuthorizedMaterial."Virtual Vendor" := ShortageDetails."Virtual Vendor";
        ShortageAuthorizedMaterial."Virtual Value" := ShortageDetails."Virtual Value";
        ShortageAuthorizedMaterial."Virtual Payment Date" := ShortageDetails."Virtual Payment Date";
        ShortageAuthorizedMaterial."Virtual Vendor Name" := ShortageDetails."Virtual Vendor Name";
        ShortageAuthorizedMaterial."Prod. Order Line No." := ShortageDetails."Prod. Order Line No.";
        ShortageAuthorizedMaterial."Prod. Order Comp Line No." := ShortageDetails."Prod. Order Comp Line No.";
        ShortageAuthorizedMaterial."Creation Date" := TODAY;
        ShortageAuthorizedMaterial.Item_MOQ := ITEM_MOQ;
        ShortageAuthorizedMaterial.Item_Eff_MOQ := ITEM_EFF_MOQ;
        ShortageAuthorizedMaterial.INSERT;
    end;


    procedure Shortage_Mail_Cost() "TOTAL COST": Decimal;
    begin
        Order_Qty := 0;
        ord_qty2 := 0;
        //Order_Value:=0;
        /*
        IF Item.GET("Shortage Temp"."Item No.") THEN BEGIN
          IF Item."Minimum Order Quantity">0 THEN BEGIN
            IF Item."Minimum Order Quantity">1 THEN BEGIN
              IF "Shortage Temp".Shortage<Item."Minimum Order Quantity" THEN
                 Order_Qty:=Item."Minimum Order Quantity"
              ELSE
                Order_Qty:=(("Shortage Temp".Shortage DIV Item."Minimum Order Quantity" )+1)*Item."Minimum Order Quantity"
              END ELSE
               Order_Qty:="Shortage Temp".Shortage;
            END ELSE
          ERROR('THERE IS NO MINIMUM ORDER QUANTITY FOR '+ Item.Description);
        END;
        */
        // WRITTEN BY SANTHOSH
        "Shortage Temp".RESET;
        IF "Shortage Temp".FINDSET THEN
            REPEAT
                IF Item.GET("Shortage Temp"."Item No.") THEN BEGIN
                    IF Item.EFF_MOQ > 0 THEN
                        MOQ_Temp := Item.EFF_MOQ
                    ELSE
                        MOQ_Temp := Item."Minimum Order Quantity";
                    IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" = 0) THEN BEGIN
                        IF MOQ_Temp > 1 THEN BEGIN
                            IF "Shortage Temp".Shortage < MOQ_Temp THEN
                                Order_Qty := MOQ_Temp
                            ELSE
                                Order_Qty := "Shortage Temp".Shortage;
                        END ELSE BEGIN
                            Order_Qty := "Shortage Temp".Shortage;
                        END;
                    END ELSE
                        IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                            IF MOQ_Temp > 1 THEN BEGIN
                                IF "Shortage Temp".Shortage < MOQ_Temp THEN
                                    Order_Qty := MOQ_Temp
                                ELSE BEGIN
                                    IF MOQ_Temp = 1 THEN
                                        Order_Qty := ("Shortage Temp".Shortage DIV Item."Standard Packing Quantity") * Item."Standard Packing Quantity"
                                    ELSE
                                        Order_Qty := (("Shortage Temp".Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                END;
                            END ELSE
                                Order_Qty := "Shortage Temp".Shortage;
                        END ELSE
                            IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                                IF MOQ_Temp > 1 THEN BEGIN
                                    IF "Shortage Temp".Shortage < MOQ_Temp THEN
                                        Order_Qty := MOQ_Temp
                                    ELSE
                                        Order_Qty := (("Shortage Temp".Shortage DIV MOQ_Temp) + 1) * MOQ_Temp
                                END ELSE
                                    Order_Qty := "Shortage Temp".Shortage;

                            END ELSE
                                IF (MOQ_Temp = 0) AND (Item."Standard Packing Quantity" > 0) THEN BEGIN
                                    IF "Shortage Temp".Shortage < Item."Standard Packing Quantity" THEN
                                        Order_Qty := Item."Standard Packing Quantity"
                                    ELSE
                                        Order_Qty := (("Shortage Temp".Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                END;

                END;
                Order_Qty := Order_Qty * "Shortage Temp"."Unit Cost";
                ord_qty2 += Order_Qty;

            UNTIL "Shortage Temp".NEXT = 0;
        EXIT(ord_qty2);

    end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;
}

