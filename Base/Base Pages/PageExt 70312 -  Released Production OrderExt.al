pageextension 70312 " Released Production OrderExt" extends 99000831
{
    layout
    {

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                /*
                       //Added By Pranavi On 23-09-2015 to restrict not to modify Quantity
                        "Prod.OrdLine".RESET;
                        "Prod.OrdLine".SETCURRENTKEY(Status,"Prod. Order No.","Line No.");
                        "Prod.OrdLine".SETFILTER("Prod.OrdLine"."Prod. Order No.","No.");
                        IF "Prod.OrdLine".FINDFIRST THEN
                          ERROR('You Can not Change the Quantity!');
                       //End By Pranavi
                       //Added By Pranavi On 23-09-2015 to restrict Quantity picking if sale order qty is already RPO generated.
                       TotRPOQty := 0;
                       Prod_Order.RESET;
                       Prod_Order.SETFILTER(Prod_Order."Sales Order No.","Sales Order No.");
                       Prod_Order.SETFILTER(Prod_Order."Sales Order Line No.",'%1',"Sales Order Line No.");
                       Prod_Order.SETFILTER(Prod_Order."Source No.","Source No.");
                       Prod_Order.SETFILTER(Prod_Order."No.",'<>%1',"No.");
                       IF Prod_Order.FINDSET THEN
                       REPEAT
                         TotRPOQty := TotRPOQty+Prod_Order.Quantity;
                       UNTIL Prod_Order.NEXT=0;
                       SalesLine.RESET;
                       SalesLine.SETFILTER(SalesLine."Document No.","Sales Order No.");
                       SalesLine.SETFILTER(SalesLine."Line No.",'%1',"Sales Order Line No.");
                       SalesLine.SETFILTER(SalesLine."No.","Source No.");
                       IF SalesLine.FINDFIRST THEN
                       BEGIN
                         IF SalesLine.Quantity < TotRPOQty+Quantity THEN
                           ERROR('You can not select the Item'+"Source No."+'as already RPO completed for Sale Order Quantity:'+FORMAT(SalesLine.Quantity));
                       END;
                       //End By Pranavi
                       */
            end;
        }

        // Add changes to page layout here
        addafter("Due Date")
        {
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;

            }
        }
        addafter(Blocked)
        {
            field("Location Code Cust"; Rec."Location Code")
            {
                ApplicationArea = All;

            }
        }
        addafter("Last Date Modified")
        {
            field("User Id"; Rec."User Id")
            {
                ApplicationArea = All;

            }
            field("Prod Start date"; Rec."Prod Start date")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                    ProdLine: Record 5406;
                    Itm: Record Item;
                    "NewNo.": Text;
                begin
                    IF item.GET(Rec."Source No.") THEN
                        item.TESTFIELD(item."No.of Units");
                    IF Rec."Prod Start date" >= 0D THEN BEGIN
                        IF (Rec."Prod Start date" < TODAY) AND (NOT (USERID IN ['EFFTRONICS\SUVARCHALADEVI'])) THEN       //added by pranavi on 10-04-2015
                            ERROR('Prod Start date must be greater than or equal to today!');
                        expStr := COPYSTR(Rec."Sales Order No.", 5, 3);
                        //message(expStr);
                        /* {   IF expStr = 'EXP' THEN
                              IF  "Prod Start date"-TODAY <= 15 THEN
                                ERROR('Production Start Date must be greater than 15 Days for Expected Order!');
                          }*/
                        /* {IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                           MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                         ELSE IF (Planned_Units("Prod Start date")>16) THEN
                           ERROR('YOU ARE EXCEEDING THE 16 UNITS PLAN ON '+FORMAT("Prod Start date"));}*/

                        //END;
                        "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.", Rec."No.");
                        IF "Prod. Order Component".FINDSET THEN BEGIN
                            // Modification by Rakesh to use ModifyAll on 26-Apr-14
                            // Start
                            /*{ REPEAT
                              //  IF "Prod. Order Component"."Material Required Day"<>99 THEN
                              //  BEGIN
                              "Prod. Order Component"."Production Plan Date":="Prod Start date";
                              "Prod. Order Component".MODIFY;
                             //   END;
                              //END ELSE
                            //  BEGIN
                            //    "Prod. Order Component"."Production Plan Date":=0D;
                            //    "Prod. Order Component".MODIFY;
                            //  END;
                            UNTIL "Prod. Order Component".NEXT=0;
                            } */// Commented by Rakesh
                            "Prod. Order Component".MODIFYALL("Production Plan Date", Rec."Prod Start date");
                        END ELSE
                            ERROR('PLEASE REFRESH THE PRODUCTION ORDER PROPERLY');
                    END
                    //coded by anil
                    ELSE BEGIN
                        "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.", Rec."No.");
                        IF "Prod. Order Component".FINDSET THEN
                            "Prod. Order Component".MODIFYALL("Production Plan Date", Rec."Prod Start date"); // Added by Rakesh on 26-Apr-14
                                                                                                              /*  {REPEAT
                                                                                                                  "Prod. Order Component"."Production Plan Date":="Prod Start date";
                                                                                                                  "Prod. Order Component".MODIFY;
                                                                                                                UNTIL "Prod. Order Component".NEXT=0;}*/
                    END;
                    Rec."Location Code" := 'PROD';
                    //----------------Added by Suvarchala for Insert benchmarks in Lines---------------//
                    ProdLine.RESET;
                    ProdLine.SETFILTER("Prod. Order No.", "No.");
                    ProdLine.SETFILTER(ProdLine.Status, '=%1', ProdLine.Status::Released);
                    IF ProdLine.FINDSET THEN BEGIN
                        REPEAT
                            IF Itm.GET(ProdLine."Item No.") THEN BEGIN
                                ProdLine."Benchmark(in Min)" := Itm."Benchmarks(in Min)";
                                ProdLine."Total Benchmarks(in Min)" := (ProdLine.Quantity * Itm."Benchmarks(in Min)") / 60;
                                ProdLine."Soldering Time(in Min)" := (ProdLine.Quantity * Itm."Benchmarks(in Min)") / 60;
                            END;
                            ProdLine.MODIFY;
                        UNTIL ProdLine.NEXT = 0;
                    END;

                    //------------------------------------------------

                    //----------------Added by Suvarchala for sum of Soldering benchmarks from lines---------------//
                    "Soldering Time(in Min)" := 0;
                    ProdLine.RESET;
                    ProdLine.SETFILTER("Prod. Order No.", "No.");
                    ProdLine.SETFILTER(ProdLine.Status, '=%1', ProdLine.Status::Released);
                    IF ProdLine.FINDSET THEN BEGIN
                        REPEAT
                            "NewNo." := COPYSTR(ProdLine."Item No.", 1, 7);
                            IF "NewNo." = 'ECPBPCB' THEN BEGIN
                                "Soldering Time(in Min)" := "Soldering Time(in Min)" + ProdLine."Soldering Time(in Min)";
                            END
                        UNTIL ProdLine.NEXT = 0;
                    END;
                    //------------------------------------------------------------------------

                    //----------------Added by Suvarchala for sum of Total benchmarks from lines---------------//
                    "Benchmarks(in Min)" := 0;
                    "Total Time" := 0;
                    ProdLine.RESET;
                    ProdLine.SETFILTER("Prod. Order No.", "No.");
                    ProdLine.SETFILTER(ProdLine.Status, '=%1', ProdLine.Status::Released);
                    IF ProdLine.FINDSET THEN BEGIN
                        REPEAT
                            "Benchmarks(in Min)" := "Benchmarks(in Min)" + ProdLine."Benchmark(in Min)";
                            "Total Time" := "Total Time" + ProdLine."Total Benchmarks(in Min)";
                        UNTIL ProdLine.NEXT = 0;
                    END;
                    //------------------------------------------------------------------------
                    //END;

                end;

            }
            field("Suppose to Plan"; Rec."Suppose to Plan")
            {
                ApplicationArea = All;
            }
            field("Production Order Status"; Rec."Production Order Status")
            {
                ApplicationArea = All;
            }
            field("Planned Dispatch Date"; Rec."Planned Dispatch Date")
            {
                ApplicationArea = All;

            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;

            }
            field("RDSO No"; Rec."RDSO No")
            {
                ApplicationArea = All;

            }
            field(AlternatePCB_BOM; Rec.AlternatePCB_BOM)
            {
                ApplicationArea = All;
            }
        }
        addbefore("Ending Date-Time")
        {
            field("Finished Date"; Rec."Finished Date")
            {
                Visible = TRUE;
                Editable = FALSE;
                ApplicationArea = All;
            }
            field("Work.MesurInUnits(ASM)"; Rec."Work.MesurInUnits(ASM)")
            {
                ApplicationArea = All;

            }
            field("Work.MesurInUnits(TST)"; Rec."Work.MesurInUnits(TST)")
            {
                ApplicationArea = All;

            }
            field("Work.MesurInUnits(SHF)"; Rec."Work.MesurInUnits(SHF)")
            {
                ApplicationArea = All;

            }
            field("Total Unts"; Rec."Total Unts")
            {
                ApplicationArea = All;

            }
            field("Soldering Time(in Min)"; "Soldering Time(in Min)")
            {
                ApplicationArea = All;
            }


        }
        addafter("Bin Code")
        {
            field("Change To Specified Plan Date"; Rec."Change To Specified Plan Date")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addafter("&Warehouse Entries")

        {
            separator(Action1102152000)
            {

            }
            action("Update &Start Dat")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UpdateStartDate;
                end;
            }
            action("Create Requests For More Lines")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CreateALLMaterialIssues;
                end;
            }
            action("Create Requests For Single Line")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RequestForSingleCard;
                end;
            }
            action("Update in PRM")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PRMintegrate: Codeunit SQLIntegration;
                begin
                    // PRM integration
                    IF Rec."Location Code" = 'PROD' THEN
                        PRMintegrate.ProdOrdRefresh(Rec."No.");
                end;
            }
            action(Convert)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //MESSAGE('Under Implementation!');
                    PAGE.RUN(PAGE::"Convert Sale Order", Rec);
                end;
            }


        }

        // Add changes to page actions here
        addafter("Re&plan")
        {

            action("Offer to QC")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Body: Text[1024];
                    Subject: Text[1000];
                    Mail_To: Text[1000];
                    Mail_From: Text[1000];
                    //SMTP_MAIL: Codeunit "SMTP Mail";
                    MailCC: Text;
                    username: Text;
                    Path_Window: Dialog;
                    Path: Text;
                    t1: Label 'Enter the Testing Reports path #1########';
                    ILE: Record "Item Ledger Entry";
                    slno: Text;
                    UserSetup2: Record "User Setup";//EFFUPG

                begin
                    IF (Rec."Production Order Status" = Rec."Production Order Status"::Soldering) OR (Rec."Production Order Status" = Rec."Production Order Status"::"Call Letter Registered") THEN BEGIN

                        user.RESET;
                        user.SETRANGE(user."User Name", USERID);
                        IF user.FINDFIRST THEN BEGIN
                            username := user."Full Name";
                        END
                        ELSE
                            username := 'ERP USER';
                        //EFFUPG>>

                        UserSetup2.get(user."User Name");
                        UserSetup2.TestField(EmployeeID);

                        //EFFUPG<<
                        ILE.RESET;
                        ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Output);
                        ILE.SETRANGE(ILE."Item No.", Rec."Source No.");
                        ILE.SETRANGE(ILE."Order No.", Rec."No.");
                        slno := '';
                        IF ILE.FINDSET THEN
                            REPEAT
                                slno := slno + ILE."Serial No." + ', ';
                            UNTIL ILE.NEXT = 0;
                        Path := InputBox();
                        SalesLine.RESET;
                        SalesLine.SETRANGE(SalesLine."Document No.", Rec."Sales Order No.");
                        SalesLine.SETRANGE(SalesLine."Line No.", Rec."Sales Order Line No.");
                        /* IF SalesLine.FINDFIRST THEN BEGIN
                            IF (SalesLine."RDSO Inspection Required" = TRUE) AND (Rec."Production Order Status" = Rec."Production Order Status"::Soldering) THEN BEGIN
                                // 3 BUTTONS   READY FOR RDSO, RDSO INSPECTION, REJECT
                                // CODE FOR OFFEREING FOR BEFORE 3RD PARTY TESTING
                                Mail_From := 'testingcom';
                                //Mail_To :=  'vijayacom';
                                Mail_To := 'qascom';
                                //MailCC :=   'vijayacom';
                                MailCC := 'testingcom,padmajacom,sardharcom,vsngeethacom';

                                Subject := 'ERP - Offering to Before RDSO QC, RPO NO :: ' + Rec."No.";
                                Body := '';
                                SMTP_MAIL.CreateMessage('PRD TESTING', Mail_From, Mail_To, Subject, Body, TRUE);
                                SMTP_MAIL.AppendBody('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                SMTP_MAIL.AppendBody('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Product Verification</font></label></div><br/>');
                                SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                                SMTP_MAIL.AppendBody('<br><br>');
                                SMTP_MAIL.AppendBody('RPO is  Offering to Before RDSO QC <br>');
                                SMTP_MAIL.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                SMTP_MAIL.AppendBody('<tr><td> RPO NO</td><td>' + Rec."No." + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Description</td><td>' + Rec.Description + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Serial No </td><td>' + slno + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Item No</td><td>' + Rec."Source No." + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Order NO</td><td>' + Rec."Sales Order No." + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Test Reports Path</td><td>' + Path + '</td></tr></table>');

                                SMTP_MAIL.AppendBody('<br><br>');
                                SMTP_MAIL.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                SMTP_MAIL.AppendBody('<tr><td bgcolor="green">');
                                SMTP_MAIL.AppendBody('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                SMTP_MAIL.AppendBody('&Current_Stage=' + FORMAT(Rec."Production Order Status"::Integration));
                                SMTP_MAIL.AppendBody('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                SMTP_MAIL.AppendBody('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                SMTP_MAIL.AppendBody('&REQID=' + user.EmployeeID);
                                SMTP_MAIL.AppendBody('&AUTHSTATUS=2"target="_blank">');
                                SMTP_MAIL.AppendBody('<font face="arial" color="#ffffff">Ready for RDSO</font></a>');

                                SMTP_MAIL.AppendBody('</td><td bgcolor="green">');
                                SMTP_MAIL.AppendBody('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                SMTP_MAIL.AppendBody('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                SMTP_MAIL.AppendBody('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Call Letter Registered"));
                                SMTP_MAIL.AppendBody('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                SMTP_MAIL.AppendBody('&REQID=' + user.EmployeeID);
                                SMTP_MAIL.AppendBody('&AUTHSTATUS=3"target="_blank">');
                                SMTP_MAIL.AppendBody('<font face="arial" color="#ffffff">RDSO Inspection Completed</font></a>');

                                SMTP_MAIL.AppendBody('</td></tr><tr><td bgcolor="red">');
                                SMTP_MAIL.AppendBody('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                SMTP_MAIL.AppendBody('&Current_Stage=' + FORMAT(Rec."Production Order Status"::Integration));
                                SMTP_MAIL.AppendBody('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                SMTP_MAIL.AppendBody('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                SMTP_MAIL.AppendBody('&REQID=' + user.EmployeeID);
                                SMTP_MAIL.AppendBody('&AUTHSTATUS=4"target="_blank">');
                                SMTP_MAIL.AppendBody('<font face="arial" color="#ffffff">QC REJECT</font></a>');

                                SMTP_MAIL.AppendBody('</td><td bgcolor="red">');
                                SMTP_MAIL.AppendBody('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                SMTP_MAIL.AppendBody('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                SMTP_MAIL.AppendBody('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Call Letter Registered"));
                                SMTP_MAIL.AppendBody('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                SMTP_MAIL.AppendBody('&REQID=' + user.EmployeeID);
                                SMTP_MAIL.AppendBody('&AUTHSTATUS=4"target="_blank">');
                                SMTP_MAIL.AppendBody('<font face="arial" color="#ffffff">RDSO Rejection</font></a>');


                                SMTP_MAIL.AppendBody('</td></tr></table><br>');
                                SMTP_MAIL.AppendBody('<br><br>');
                                SMTP_MAIL.AppendBody('<br><br>With Regards<br><br>');
                                SMTP_MAIL.AppendBody(username + '<br>');
                                SMTP_MAIL.AppendBody('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                SMTP_MAIL.AddCC(MailCC);
                                SMTP_MAIL.AddBCC('vijayacom');
                                SMTP_MAIL.Send;
                                MESSAGE('MAIL HAS BEEN SENT');
                                Rec."Production Order Status" := Rec."Production Order Status"::Integration;


                            END
                            ELSE BEGIN
                                // 2 BUTTONS ACCEPT, REJECT
                                //CONSIGNEE TESTING
                                Mail_From := 'testingcom';
                                //Mail_To :=  'vijayacom';
                                Mail_To := 'qascom';
                                //MailCC :=   'vijayacom';
                                MailCC := 'testingcom,padmajacom,sardharcom,vsngeethacom';
                                IF (SalesLine."RDSO Inspection Required" = TRUE) AND (Rec."Production Order Status" = Rec."Production Order Status"::"Call Letter Registered") THEN
                                    Subject := 'ERP - Offering to Final QC(After RDSO), RPO NO :: ' + Rec."No."
                                ELSE
                                    Subject := 'ERP - Offering to Final QC(Consignee), RPO NO :: ' + Rec."No.";
                                Body := '';
                                SMTP_MAIL.CreateMessage('PRD TESTING', Mail_From, Mail_To, Subject, Body, TRUE);
                                SMTP_MAIL.AppendBody('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');


                                SMTP_MAIL.AppendBody('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Product Verification</font></label></div><br/>');
                                SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                                SMTP_MAIL.AppendBody('<br><br>');
                                IF (SalesLine."RDSO Inspection Required" = TRUE) AND (Rec."Production Order Status" = Rec."Production Order Status"::"Call Letter Registered") THEN
                                    SMTP_MAIL.AppendBody('ERP - Offering to Final QC(After RDSO), RPO NO :: ' + Rec."No.")
                                ELSE
                                    SMTP_MAIL.AppendBody('ERP - Offering to Final QC(Consignee), RPO NO :: ' + Rec."No.");
                                SMTP_MAIL.AppendBody('<br><br>');
                                SMTP_MAIL.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                SMTP_MAIL.AppendBody('<tr><td> RPO NO</td><td>' + Rec."No." + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Description</td><td>' + Rec.Description + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Serial No </td><td>' + slno + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Item No</td><td>' + Rec."Source No." + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Order NO</td><td>' + Rec."Sales Order No." + '</td></tr>');
                                SMTP_MAIL.AppendBody('<tr><td> Test Reports Path</td><td>' + Path + '</td></tr></table>');

                                SMTP_MAIL.AppendBody('<br><br>');
                                SMTP_MAIL.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                SMTP_MAIL.AppendBody('<tr><td bgcolor="green">');
                                SMTP_MAIL.AppendBody('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                SMTP_MAIL.AppendBody('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Inspection Completed"));
                                SMTP_MAIL.AppendBody('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Final Testing"));
                                SMTP_MAIL.AppendBody('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                SMTP_MAIL.AppendBody('&REQID=' + user.EmployeeID);
                                SMTP_MAIL.AppendBody('&AUTHSTATUS=1"target="_blank">');
                                SMTP_MAIL.AppendBody('<font face="arial" color="#ffffff">ACCEPT</font></a>');
                                SMTP_MAIL.AppendBody('</td><td bgcolor="red">');
                                SMTP_MAIL.AppendBody('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                SMTP_MAIL.AppendBody('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Inspection Completed"));
                                SMTP_MAIL.AppendBody('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Final Testing"));
                                SMTP_MAIL.AppendBody('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                SMTP_MAIL.AppendBody('&REQID=' + user.EmployeeID);
                                SMTP_MAIL.AppendBody('&AUTHSTATUS=0"target="_blank">');
                                SMTP_MAIL.AppendBody('<font face="arial" color="#ffffff">REJECT</font></a></td></tr>');
                                SMTP_MAIL.AppendBody('</table><br>');
                                SMTP_MAIL.AppendBody('<br><br>');
                                SMTP_MAIL.AppendBody('<br><br>With Regards<br><br>');
                                SMTP_MAIL.AppendBody(username + '<br>');
                                SMTP_MAIL.AppendBody('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                SMTP_MAIL.AddCC(MailCC);
                                SMTP_MAIL.AddBCC('vijayacom');
                                SMTP_MAIL.Send;
                                MESSAGE('MAIL HAS BEEN SENT');
                                Rec."Production Order Status" := Rec."Production Order Status"::"Inspection Completed";

                            END;
                        END;
                    END 
                    ELSE BEGIN
                        MESSAGE('RPO is not offered to TESTING. You do not have RIGHTS for OFFER TO QC');
                    END;*/

                        IF SalesLine.FINDFIRST THEN BEGIN
                            IF (SalesLine."RDSO Inspection Required" = TRUE) AND (Rec."Production Order Status" = Rec."Production Order Status"::Soldering) THEN BEGIN

                                //Mail_From := 'testingcom';
                                //Mail_To :=  'vijayacom';
                                //Mail_To := 'qascom';
                                //MailCC :=   'vijayacom';

                                Recipients.Add('testingcom');
                                Recipients.Add('padmajacom');
                                Recipients.Add('sardharcom');
                                Recipients.Add('vsngeethacom');

                                Subject := 'ERP - Offering to Before RDSO QC, RPO NO :: ' + Rec."No.";
                                Body := '';
                                EmailMessage.Create(Recipients, Subject, Body, true);
                                Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Product Verification</font></label></div><br/>');
                                Body += ('Dear Sir/Madam,');
                                Body += ('<br><br>');
                                Body += ('RPO is  Offering to Before RDSO QC <br>');
                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                Body += ('<tr><td> RPO NO</td><td>' + Rec."No." + '</td></tr>');
                                Body += ('<tr><td> Description</td><td>' + Rec.Description + '</td></tr>');
                                Body += ('<tr><td> Serial No </td><td>' + slno + '</td></tr>');
                                Body += ('<tr><td> Item No</td><td>' + Rec."Source No." + '</td></tr>');
                                Body += ('<tr><td> Order NO</td><td>' + Rec."Sales Order No." + '</td></tr>');
                                Body += ('<tr><td> Test Reports Path</td><td>' + Path + '</td></tr></table>');

                                Body += ('<br><br>');
                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                Body += ('<tr><td bgcolor="green">');
                                Body += ('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                Body += ('&Current_Stage=' + FORMAT(Rec."Production Order Status"::Integration));
                                Body += ('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                Body += ('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                Body += ('&REQID=' + UserSetup2.EmployeeID);//EFFUPG
                                Body += ('&AUTHSTATUS=2"target="_blank">');
                                Body += ('<font face="arial" color="#ffffff">Ready for RDSO</font></a>');

                                Body += ('</td><td bgcolor="green">');
                                Body += ('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                Body += ('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                Body += ('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Call Letter Registered"));
                                Body += ('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                Body += ('&REQID=' + Usersetup2.EmployeeID);//EFFUPG
                                Body += ('&AUTHSTATUS=3"target="_blank">');
                                Body += ('<font face="arial" color="#ffffff">RDSO Inspection Completed</font></a>');

                                Body += ('</td></tr><tr><td bgcolor="red">');
                                Body += ('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                Body += ('&Current_Stage=' + FORMAT(Rec."Production Order Status"::Integration));
                                Body += ('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                Body += ('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                Body += ('&REQID=' + Usersetup2.EmployeeID);//EFFUPG
                                Body += ('&AUTHSTATUS=4"target="_blank">');
                                Body += ('<font face="arial" color="#ffffff">QC REJECT</font></a>');

                                Body += ('</td><td bgcolor="red">');
                                Body += ('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                Body += ('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                Body += ('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Call Letter Registered"));
                                Body += ('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::"Ready for Inspection"));
                                Body += ('&REQID=' + UserSetup2.EmployeeID);//EFFUPG
                                Body += ('&AUTHSTATUS=4"target="_blank">');
                                Body += ('<font face="arial" color="#ffffff">RDSO Rejection</font></a>');


                                Body += ('</td></tr></table><br>');
                                Body += ('<br><br>');
                                Body += ('<br><br>With Regards<br><br>');
                                Body += (username + '<br>');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                //SMTP_MAIL.AddCC(MailCC);

                                Recipients.Add('vijayacom');
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                MESSAGE('MAIL HAS BEEN SENT');
                                Rec."Production Order Status" := Rec."Production Order Status"::Integration;


                            END
                            ELSE BEGIN
                                // 2 BUTTONS ACCEPT, REJECT
                                //CONSIGNEE TESTING
                                //Mail_From := 'testingcom';
                                //Mail_To :=  'vijayacom';
                                //Mail_To := 'qascom';
                                //MailCC :=   'vijayacom';
                                Recipients.Add('testingcom');
                                Recipients.Add('padmajacom');
                                Recipients.Add('sardharcom');
                                Recipients.Add('vsngeethacom');

                                IF (SalesLine."RDSO Inspection Required" = TRUE) AND (Rec."Production Order Status" = Rec."Production Order Status"::"Call Letter Registered") THEN
                                    Subject := 'ERP - Offering to Final QC(After RDSO), RPO NO :: ' + Rec."No."
                                ELSE
                                    Subject := 'ERP - Offering to Final QC(Consignee), RPO NO :: ' + Rec."No.";
                                Body := '';
                                EmailMessage.Create(Recipients, Subject, Body, true);
                                Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');


                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Product Verification</font></label></div><br/>');
                                Body += ('Dear Sir/Madam,');
                                Body += ('<br><br>');
                                IF (SalesLine."RDSO Inspection Required" = TRUE) AND (Rec."Production Order Status" = Rec."Production Order Status"::"Call Letter Registered") THEN
                                    Body += ('ERP - Offering to Final QC(After RDSO), RPO NO :: ' + Rec."No.")
                                ELSE
                                    Body += ('ERP - Offering to Final QC(Consignee), RPO NO :: ' + Rec."No.");
                                Body += ('<br><br>');
                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                Body += ('<tr><td> RPO NO</td><td>' + Rec."No." + '</td></tr>');
                                Body += ('<tr><td> Description</td><td>' + Rec.Description + '</td></tr>');
                                Body += ('<tr><td> Serial No </td><td>' + slno + '</td></tr>');
                                Body += ('<tr><td> Item No</td><td>' + Rec."Source No." + '</td></tr>');
                                Body += ('<tr><td> Order NO</td><td>' + Rec."Sales Order No." + '</td></tr>');
                                Body += ('<tr><td> Test Reports Path</td><td>' + Path + '</td></tr></table>');

                                Body += ('<br><br>');
                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:11pt;">');
                                Body += ('<tr><td bgcolor="green">');
                                Body += ('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                Body += ('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Inspection Completed"));
                                Body += ('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Final Testing"));
                                Body += ('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                Body += ('&REQID=' + UserSetup2.EmployeeID);//EFFUPG
                                Body += ('&AUTHSTATUS=1"target="_blank">');
                                Body += ('<font face="arial" color="#ffffff">ACCEPT</font></a>');
                                Body += ('</td><td bgcolor="red">');
                                Body += ('<a Href="http://app.efftronics.org:8567/erp_reports/RPO_Authorization.aspx?RPO_NO=' + FORMAT(Rec."No."));
                                Body += ('&Current_Stage=' + FORMAT(Rec."Production Order Status"::"Inspection Completed"));
                                Body += ('&Next_Stage=' + FORMAT(Rec."Production Order Status"::"Final Testing"));
                                Body += ('&Prev_Stage=' + FORMAT(Rec."Production Order Status"::Soldering));
                                Body += ('&REQID=' + UserSetup2.EmployeeID);//EFFUPG
                                Body += ('&AUTHSTATUS=0"target="_blank">');
                                Body += ('<font face="arial" color="#ffffff">REJECT</font></a></td></tr>');
                                Body += ('</table><br>');
                                Body += ('<br><br>');
                                Body += ('<br><br>With Regards<br><br>');
                                Body += (username + '<br>');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                //SMTP_MAIL.AddCC(MailCC);

                                Recipients.Add('vijayacom');
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                MESSAGE('MAIL HAS BEEN SENT');
                                Rec."Production Order Status" := Rec."Production Order Status"::"Inspection Completed";

                            END;
                        END;
                    END
                    ELSE BEGIN
                        MESSAGE('RPO is not offered to TESTING. You do not have RIGHTS for OFFER TO QC');
                    END;
                end;
            }
            action("Get Benchmarks")
            {
                trigger OnAction()
                begin
                    GetBenchmarks;
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //added by Vishnu Priya For checking the pairs Qty on 05-02-2019
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Document No.", "Line No.", "Document Type");
        SalesLine.SETFILTER("Document No.", Rec."Sales Order No.");
        SalesLine.SETFILTER("Line No.", FORMAT(Rec."Sales Order Line No."));
        SalesLine.SETFILTER("No.", Rec."Source No.");
        IF SalesLine.FINDFIRST THEN BEGIN
            IF SalesLine."Unit of Measure" = 'Pairs' THEN
                MESSAGE('Unit of Measure is Pairs . Please check the Qty');
        END;
        // end by Vishnu

        // added by vishnu priya to restrict editings for the Posted RPOs on May 10th 2019
        /* { PostedMaterialIssueHeader.RESET;
          PostedMaterialIssueHeader.SETFILTER("Prod. Order No.",'<>%1&%2','',Rec."No.");
          IF PostedMaterialIssueHeader.FINDFIRST THEN
              CurrPage.EDITABLE(FALSE)
            ELSE
              BEGIN
              MaterialIssueHeader.RESET;
              MaterialIssueHeader.SETFILTER("Prod. Order No.",'<>%1&%2','',Rec."No.");
              IF MaterialIssueHeader.FINDLAST THEN
                CurrPage.EDITABLE(FALSE)
              ELSE
                CurrPage.EDITABLE(TRUE)
              END;
              }*/

        PostedMaterialIssueHeader.RESET;
        PostedMaterialIssueHeader.SETFILTER("Prod. Order No.", '<>%1&%2', '', Rec."No.");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            PRODSTATEDIT := FALSE
        ELSE BEGIN
            MaterialIssueHeader.RESET;
            MaterialIssueHeader.SETFILTER("Prod. Order No.", '<>%1&%2', '', Rec."No.");
            IF MaterialIssueHeader.FINDLAST THEN
                PRODSTATEDIT := FALSE
            ELSE
                PRODSTATEDIT := TRUE
        END;

        Item1.RESET;
        Item1.SETFILTER("No.", Rec."Source No.");
        IF Item1.FINDFIRST THEN
            Rec."Benchmarks(in Min)" := Item1."Benchmarks(in Min)" / 60;
        Rec."Total Time" := Item1."Benchmarks(in Min)" * Rec.Quantity;
        // Rec.MODIFY;



        // end  by vishnu priya to restrict editings for the Posted RPOs on May 10th 2019

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec."User Id" := USERID;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin
        IF Rec."Location Code" = '' THEN
            ERROR('Fill the Location Code');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        MESSAGE('Please update Prod Start Date Once for Benchmarks Updation');
    end;

    var
        "--B2B-KNR--": Integer;
        "Prod.OrdLine": Record "Prod. Order Line";
        RoutingLine: Record "Routing Line";
        RoutingHeader: Record "Routing Header";
        ProdOrderLine2: Record "Prod. Order Line";
        ProdOrderLine3: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        "Component Date": Date;
        "Component Time": Time;
        "Component DateTime": DateTime;
        TempDateTime: DateTime;
        RunTime: Decimal;
        Text0002: Label 'Do you want to create a Material Issue ?';
        Text0003: Label 'Material Issue already existed against this Prod. Order %1';
        Text0004: Label 'Material Issues created.';
        item: Record Item;
        i: Integer;
        MaterialIssueHeader: Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        PostedMaterialIssueHeader: Record "Posted Material Issues Header";
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ManufacturingSetup: Record "Manufacturing Setup";
        user: Record User;
        refreshtime: Codeunit refreshdatetime;
        "Production Bom Line": Record "Production BOM Line";
        "Sales Header": Record "Sales Header";
        "Prod. Order Component": Record "Prod. Order Component";
        Day_Plan: Decimal;
        Prod_Order: Record "Production Order";
        ProdBOMHeader: Record "Production BOM Header";
        "--SubCon--": Integer;
        ProdOrderLine: Record "Prod. Order Line";
        PurchaseLine: Record "Purchase Line";
        DUM: Record Item TEMPORARY;
        k: Integer;
        Item2: Record Item;
        PcbGRec: Record PCB;
        ProdOrdrNew: Record "Production Order";
        expStr: Text;
        TotRPOQty: Decimal;
        SalesLine: Record "Sales Line";
        MIHTestGRec: Record "Material Issues Header";
        pmino: Text;
        PRODSTATEDIT: Boolean;
        Item1: Record Item;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;


    PROCEDURE UpdateStartDate();
    var
        Text001UPG: Label 'No Inbound Whse. Request is created.';
    BEGIN
        //KPK>>
        IF ("Component Date" = 0D) OR (FORMAT("Component Time") = '') THEN
            ERROR(Text001UPG);

        ProdOrderLine.SETRANGE(Status, Rec.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.", Rec."No.");
        IF ProdOrderLine.FINDSET THEN BEGIN
            ProdOrderLine.NEXT(1);
            REPEAT
                "Component DateTime" := CREATEDATETIME("Component Date", "Component Time");
                ProdOrderLine.VALIDATE("Starting Date-Time", "Component DateTime");
                ProdOrderLine.MODIFY;
            UNTIL ProdOrderLine.NEXT = 0;

            ProdOrderLine2.SETRANGE(Status, Rec.Status);
            ProdOrderLine2.SETRANGE("Prod. Order No.", Rec."No.");
            IF ProdOrderLine2.FINDFIRST THEN BEGIN
                ProdOrderLine2.NEXT(1);
                TempDateTime := CREATEDATETIME(ProdOrderLine2."Ending Date", ProdOrderLine2."Ending Time");
                ProdOrderLine2.NEXT(-1);
                ProdOrderLine2.VALIDATE("Starting Date-Time", TempDateTime);
                ProdOrderLine2.MODIFY;
            END;
        END;


        ProdOrderLine3.SETRANGE(Status, Rec.Status);
        ProdOrderLine3.SETRANGE("Prod. Order No.", Rec."No.");
        ProdOrderLine3.SETFILTER(Quantity, '>1');
        IF ProdOrderLine3.FINDSET THEN BEGIN
            REPEAT
                ProdOrderRoutingLine.SETRANGE(Status, ProdOrderLine3.Status);
                ProdOrderRoutingLine.SETRANGE("Prod. Order No.", ProdOrderLine3."Prod. Order No.");
                ProdOrderRoutingLine.SETRANGE("Routing Reference No.", ProdOrderLine3."Line No.");
                //ProdOrderRoutingLine.SETFILTER("Input Quantity",'>1');
                IF ProdOrderRoutingLine.FINDSET THEN BEGIN
                    REPEAT
                        IF ProdOrderRoutingLine."Run Time" <> 0 THEN
                            RunTime += ProdOrderRoutingLine."Run Time"
                        ELSE
                            IF (ProdOrderRoutingLine."Run Time" = 0) AND (ProdOrderRoutingLine."Setup Time" <> 0) THEN BEGIN
                                ProdOrderRoutingLine.VALIDATE("Setup Time", ProdOrderRoutingLine."Setup Time" - ((RunTime) *
                                                                                                                (ProdOrderRoutingLine."Input Quantity" - 1)));
                                ProdOrderRoutingLine.MODIFY;
                                RunTime := 0;
                            END;
                    UNTIL ProdOrderRoutingLine.NEXT = 0;
                END;
            UNTIL ProdOrderLine3.NEXT = 0;
        END;
        //KPK<<
    END;

    PROCEDURE CreateALLMaterialIssues();
    VAR
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
    BEGIN
        IF NOT CONFIRM(Text0002, FALSE) THEN
            EXIT;
        MaterialIssueHeader.SETCURRENTKEY(MaterialIssueHeader."Prod. Order No.",
                                          MaterialIssueHeader."Prod. Order Line No.");
        MaterialIssueHeader.SETRANGE("Prod. Order No.", Rec."No.");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, Rec."No.");
        PostedMaterialIssueHeader.SETCURRENTKEY(PostedMaterialIssueHeader."Prod. Order No.",
                                                PostedMaterialIssueHeader."Prod. Order Line No.");
        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", Rec."No.");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, Rec."No.");

        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE(Status, Rec.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.", Rec."No.");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
            BEGIN
                /* IF ProdOrderLine."Line No."<>10000 THEN
                BEGIN
                  ProdOrderComp.RESET;
                  ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status :: Released);
                  ProdOrderComp.SETRANGE("Prod. Order No.","No.");
                  ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");
                  //ProdOrderComp.SETRANGE("Source No.","Item No.");
                  ProdOrderComp.SETFILTER("Remaining Quantity",'<>0');
                  IF ProdOrderComp.FINDFIRST THEN BEGIN
                    LineNo := 10000;
                    InventorySetup.GET;
                    ManufacturingSetup.GET();
                    ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                    MaterialIssueHeader.RESET;
                    MaterialIssueHeader.INIT;
                    MaterialIssueHeader."No." :=GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                    MaterialIssueHeader."Receipt Date":=TODAY;
                    MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                    MaterialIssueHeader."Transfer-to Code":="Location Code";
                    MaterialIssueHeader.VALIDATE("Prod. Order No.","No.");
                    MaterialIssueHeader.VALIDATE("Prod. Order Line No.",ProdOrderLine."Line No.");
                    MaterialIssueHeader."User ID" := USERID;
                    user.GET(USERID);
                    MaterialIssueHeader."Resource Name":=user.Name;
                    MaterialIssueHeader."Creation DateTime":=CURRENTDATETIME;
                    MaterialIssueHeader."Sales Order No.":="Sales Order No.";
                    MaterialIssueHeader.INSERT;
                  END;
                  REPEAT
                      item.GET(ProdOrderComp."Item No.");
                      item.GET(ProdOrderComp."Item No.");
                      IF  (item."Product Group Code"<>'FPRODUCT') AND (item."Product Group Code"<>'CPCB') THEN
                      BEGIN
                        MaterialIssueLine.INIT;
                        MaterialIssueLine."Document No." :=MaterialIssueHeader."No." ;
                        MaterialIssueLine.VALIDATE("Item No.",ProdOrderComp."Item No.");
                        MaterialIssueLine."Line No." := LineNo;
                        MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                        MaterialIssueLine.VALIDATE("Unit of Measure");
                        MaterialIssueLine.VALIDATE(Quantity,ProdOrderComp."Expected Quantity");
                        MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                        MaterialIssueLine.VALIDATE("Outstanding Quantity",ProdOrderComp."Expected Quantity");
                        MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                        MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                        MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                        LineNo := LineNo + 10000;
                        MaterialIssueLine.INSERT;
                     END;
                  UNTIL ProdOrderComp.NEXT = 0;
                  END; */
                IF ProdOrderLine."Line No." <> 10000 THEN                //line no >10000  ECPBPCB01145
                BEGIN

                    IF ((ProdOrderLine."Item No." = 'ECPBPCB00553') OR (ProdOrderLine."Item No." = 'ECPBPCB00554') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00566') OR (ProdOrderLine."Item No." = 'ECPBPCB00864') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00434') OR (ProdOrderLine."Item No." = 'ECPBPCB00549') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00431') OR (ProdOrderLine."Item No." = 'ECPBPCB00882') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00936') OR (ProdOrderLine."Item No." = 'ECPBPCB00934') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01049') OR (ProdOrderLine."Item No." = 'ECPBPCB01038') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00534') OR (ProdOrderLine."Item No." = 'ECPBPCB01058') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01063') OR (ProdOrderLine."Item No." = 'ECPBPCB00908') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01070') OR (ProdOrderLine."Item No." = 'ECPBPCB01072') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01111') OR (ProdOrderLine."Item No." = 'ECPBPCB00856') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01231') OR (ProdOrderLine."Item No." = 'ECPBPCB00906') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01145') OR (ProdOrderLine."Item No." = 'ECPBPCB01146') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00933') OR (ProdOrderLine."Item No." = 'ECPBPCB00935') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00937') OR (ProdOrderLine."Item No." = 'ECPBPCB01073') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS00878') OR (ProdOrderLine."Item No." = 'ECPCBDS01137') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01000') OR (ProdOrderLine."Item No." = 'ECPBPCB01270') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00582') OR (ProdOrderLine."Item No." = 'ECPBPCB00889') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01306') OR (ProdOrderLine."Item No." = 'ECPBPCB01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01123') OR (ProdOrderLine."Item No." = 'ECPBPCB01344') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01343') OR (ProdOrderLine."Item No." = 'ECPCBDS01230') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01228') OR (ProdOrderLine."Item No." = 'ECPCBDS01229') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01243') OR (ProdOrderLine."Item No." = 'ECPCBDS01257') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01256') OR (ProdOrderLine."Item No." = 'ECPCBDS01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBSS00447') OR (ProdOrderLine."Item No." = 'ECPBPCB01351') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01348') OR (ProdOrderLine."Item No." = 'ECPBPCB01347') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01486') OR (ProdOrderLine."Item No." = 'ECPBPCB01591')) THEN BEGIN
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            //ProdOrderComp.SETRANGE("Source No.","Item No.");
                            ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", 'smd');
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN BEGIN
                                LineNo := 10000;
                                InventorySetup.GET;
                                ManufacturingSetup.GET();
                                ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;
                                MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := 'MCH';
                                MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader.INSERT;

                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB') THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity));
                                        /*{MaterialIssueLine.VALIDATE("Qty. to Receive",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                         MaterialIssueLine.VALIDATE("Outstanding Quantity",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                         MaterialIssueLine.Quantity:=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                         MaterialIssueLine."Qty. to Receive":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                         MaterialIssueLine."Outstanding Quantity":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);}//anil*/
                                        MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                        MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                        MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                        MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                        LineNo := LineNo + 10000;
                                        MaterialIssueLine.INSERT;
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                            END;
                        END;
                    END;
                END;//anil1
                IF ProdOrderLine."Line No." <> 10000 THEN                //line no >10000
                BEGIN

                    IF ((ProdOrderLine."Item No." = 'ECPBPCB00553') OR (ProdOrderLine."Item No." = 'ECPBPCB00554') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00566') OR (ProdOrderLine."Item No." = 'ECPBPCB00864') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00434') OR (ProdOrderLine."Item No." = 'ECPBPCB00549') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00431') OR (ProdOrderLine."Item No." = 'ECPBPCB00882') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00936') OR (ProdOrderLine."Item No." = 'ECPBPCB00934') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01049') OR (ProdOrderLine."Item No." = 'ECPBPCB01038') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00534') OR (ProdOrderLine."Item No." = 'ECPBPCB01058') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01063') OR (ProdOrderLine."Item No." = 'ECPBPCB00908') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01070') OR (ProdOrderLine."Item No." = 'ECPBPCB01072') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01111') OR (ProdOrderLine."Item No." = 'ECPBPCB00856') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01231') OR (ProdOrderLine."Item No." = 'ECPBPCB00906') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01145') OR (ProdOrderLine."Item No." = 'ECPBPCB01146') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00933') OR (ProdOrderLine."Item No." = 'ECPBPCB00935') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00937') OR (ProdOrderLine."Item No." = 'ECPBPCB01073') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS00878') OR (ProdOrderLine."Item No." = 'ECPCBDS01137') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01000') OR (ProdOrderLine."Item No." = 'ECPBPCB01270') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00582') OR (ProdOrderLine."Item No." = 'ECPBPCB00889') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01306') OR (ProdOrderLine."Item No." = 'ECPBPCB01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01123') OR (ProdOrderLine."Item No." = 'ECPBPCB01344') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01343') OR (ProdOrderLine."Item No." = 'ECPCBDS01230') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01228') OR (ProdOrderLine."Item No." = 'ECPCBDS01229') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01243') OR (ProdOrderLine."Item No." = 'ECPCBDS01257') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01256') OR (ProdOrderLine."Item No." = 'ECPCBDS01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBSS00447') OR (ProdOrderLine."Item No." = 'ECPBPCB01351') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01348') OR (ProdOrderLine."Item No." = 'ECPBPCB01347') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01486') OR (ProdOrderLine."Item No." = 'ECPBPCB01591')) THEN BEGIN
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            // ProdOrderComp.SETRANGE("Source No.","Item No.");
                            ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", '<>%1', ProdOrderComp."Type of Solder"::SMD);
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN BEGIN
                                LineNo := 10000;
                                InventorySetup.GET;
                                ManufacturingSetup.GET();
                                ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;

                                MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);

                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                                MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader.INSERT;


                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB') THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity));
                                        /*{MaterialIssueLine.VALIDATE("Qty. to Receive",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                        MaterialIssueLine.VALIDATE("Outstanding Quantity",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                        MaterialIssueLine.Quantity:=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                        MaterialIssueLine."Qty. to Receive":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                        MaterialIssueLine."Outstanding Quantity":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);}*/
                                        MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                        MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                        MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                        MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                        LineNo := LineNo + 10000;
                                        MaterialIssueLine.INSERT;
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                            END;
                        END;
                    END
                    ELSE BEGIN   //anil2
                                 /* {IF ProdOrderLine."Line No."<>10000 THEN                //line no >10000
                                  BEGIN
                                  IF ((ProdOrderLine."Item No."<>'ECPBPCB00553')OR(ProdOrderLine."Item No."<>'ECPBPCB00554')OR
                                  (ProdOrderLine."Item No."<>'ECPBPCB00566')OR (ProdOrderLine."Item No."<>'ECPBPCB00864')OR
                                  (ProdOrderLine."Item No."<>'ECPBPCB00434')OR (ProdOrderLine."Item No."<>'ECPBPCB00549')OR
                                  (ProdOrderLine."Item No."<>'ECPBPCB00431')or(ProdOrderLine."Item No."='ECPBPCB00882')) THEN
                                  BEGIN}*/
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            //ProdOrderComp.SETRANGE("Source No.","Item No.");
                            //  ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder",'<>%1',ProdOrderComp."Type of Solder"::SMD);
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN BEGIN
                                LineNo := 10000;
                                InventorySetup.GET;
                                ManufacturingSetup.GET();
                                ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;
                                MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                                MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader.INSERT;

                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB') THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity));
                                        /* MaterialIssueLine.Quantity:=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                        MaterialIssueLine."Qty. to Receive":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                        MaterialIssueLine."Outstanding Quantity":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity); */
                                        MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                        MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                        MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                        MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                        LineNo := LineNo + 10000;
                                        MaterialIssueLine.INSERT;
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                            END;


                        END;
                    END;
                END;
                //ANIL
                IF ProdOrderLine."Line No." = 10000 THEN BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Mechanical');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDSET THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                        MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Mechanical;
                        user.GET(USERID);
                        MaterialIssueHeader."Resource Name" := user."User Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        MaterialIssueHeader.INSERT;

                        REPEAT
                            item.GET(ProdOrderComp."Item No.");
                            IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB')
                    THEN BEGIN
                                MaterialIssueLine.INIT;
                                MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                MaterialIssueLine."Line No." := LineNo;
                                MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                MaterialIssueLine.VALIDATE("Unit of Measure");
                                MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");//shf only
                                MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                LineNo := LineNo + 10000;
                                MaterialIssueLine.INSERT;
                            END;
                        UNTIL ProdOrderComp.NEXT = 0;
                    END;
                END;  //ANIL


                IF (ProdOrderLine."Line No." = 10000) AND
                   ((Rec."Source No." = 'RLYMNGL001') OR
                    (Rec."Source No." = 'RLYMNRL001') OR
                    (Rec."Source No." = 'RLYMNYL001')) THEN BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDSET THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                        MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        // MaterialIssueHeader."BOM Type":='Mechanical';
                        user.GET(USERID);
                        MaterialIssueHeader."Resource Name" := user."User Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        MaterialIssueHeader.INSERT;

                        REPEAT
                            item.GET(ProdOrderComp."Item No.");
                            IF (item."Product Group Code Cust" = 'PCB') AND
                               (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB') THEN BEGIN

                                MaterialIssueLine.INIT;
                                MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                MaterialIssueLine."Line No." := LineNo;
                                MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                MaterialIssueLine.VALIDATE("Unit of Measure");
                                MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp.Quantity);
                                MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                                MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp.Quantity);
                                MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                LineNo := LineNo + 10000;
                                MaterialIssueLine.INSERT;
                            END;
                        UNTIL ProdOrderComp.NEXT = 0;
                    END;
                END;  //ANIL


                IF ProdOrderLine."Line No." = 10000 THEN BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    // ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type",'<>%1','Mechanical');
                    ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'wiring');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDSET THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                        MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        user.GET(USERID);
                        MaterialIssueHeader."Resource Name" := user."User Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Wiring;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        MaterialIssueHeader.INSERT;

                        REPEAT
                            item.GET(ProdOrderComp."Item No.");
                            IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB')
                    THEN BEGIN
                                MaterialIssueLine.INIT;
                                MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                MaterialIssueLine."Line No." := LineNo;
                                MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                MaterialIssueLine.VALIDATE("Unit of Measure");
                                MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");
                                MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                LineNo := LineNo + 10000;
                                MaterialIssueLine.INSERT;
                            END;
                        UNTIL ProdOrderComp.NEXT = 0;
                    END;
                END;
            END;  //ANIL
            UNTIL ProdOrderLine.NEXT = 0;
        MESSAGE(Text0004);
    END;


    PROCEDURE GetNextNo() NumberValue: Code[20];
    VAR
        DateValue: Text[30];
        MonthValue: Text[30];
        YearValue: Text[30];
        MaterialIssuesHeaderLocal: Record "Material Issues Header";
        PostedMatIssHeaderLocal: Record "Posted Material Issues Header";
        LastNumber: Code[20];
    BEGIN
        IF DATE2DMY(WORKDATE, 1) < 10 THEN
            DateValue := '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            DateValue := FORMAT(DATE2DMY(WORKDATE, 1));

        IF DATE2DMY(WORKDATE, 2) < 10 THEN
            MonthValue := '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            MonthValue := FORMAT(DATE2DMY(WORKDATE, 2));

        IF DATE2DMY(WORKDATE, 2) <= 12 THEN
            YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
        //IF ((TODAY=010810D) OR (TODAY=010910D) OR (TODAY=011010D))THEN
        //  NumberValue := 'V'+YearValue+MonthValue+DateValue
        //ELSE
        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '0000';
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
    END;


    PROCEDURE RequestForSingleCard();
    VAR
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
    BEGIN
        IF NOT CONFIRM(Text0002, FALSE) THEN
            EXIT;

        MaterialIssueHeader.SETRANGE("Prod. Order No.", Rec."No.");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, Rec."No.");
        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", Rec."No.");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, Rec."No.");

        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE(Status, Rec.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.", Rec."No.");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
            BEGIN
                //ANIL
                MESSAGE(FORMAT(ProdOrderLine."Line No."));
                // IF ProdOrderLine."Line No."=10000 THEN
                //BEGIN
                FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                    //single card requests
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    // ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type",'Mechanical');
                    ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", 'SMD');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDFIRST THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'MCH';
                        MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        //  MaterialIssueHeader."BOM Type":='Mechanical';
                        MaterialIssueHeader.INSERT;
                    END;
                    IF MaterialIssueHeader."No." <> '' THEN
                        REPEAT
                            item.GET(ProdOrderComp."Item No.");
                            MaterialIssueLine.INIT;
                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                            MaterialIssueLine."Line No." := LineNo;
                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                            MaterialIssueLine.VALIDATE("Unit of Measure");
                            /* { MaterialIssueLine.VALIDATE(Quantity,ProdOrderComp.Quantity);
                              MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                              MaterialIssueLine.VALIDATE("Outstanding Quantity",ProdOrderComp.Quantity);}*/
                            MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp.Quantity));

                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                            LineNo := LineNo + 10000;
                            MaterialIssueLine.INSERT;
                        UNTIL ProdOrderComp.NEXT = 0;  //single card request coment here for without smd
                                                       //END;
                                                       // END;  //ANIL
                                                       // IF ProdOrderLine."Line No."=10000 THEN
                                                       // BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", Rec."No.");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    // ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type",'<>%1','Mechanical');
                    ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", '<>SMD');
                    // ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type",'wiring');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDFIRST THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                        MaterialIssueHeader."Transfer-to Code" := Rec."Location Code";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", Rec."No.");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Wiring;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        MaterialIssueHeader.INSERT;
                    END;
                    IF MaterialIssueHeader."No." <> '' THEN
                        REPEAT
                            item.GET(ProdOrderComp."Item No.");
                            MaterialIssueLine.INIT;
                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                            MaterialIssueLine."Line No." := LineNo;
                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                            MaterialIssueLine.VALIDATE("Unit of Measure");
                            /*{ MaterialIssueLine.VALIDATE(Quantity,ProdOrderComp.Quantity);
                             MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                             MaterialIssueLine.VALIDATE("Outstanding Quantity",ProdOrderComp.Quantity);}*/
                            MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp.Quantity));  //anil updated for shf items

                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                            LineNo := LineNo + 10000;
                            MaterialIssueLine.INSERT;
                        UNTIL ProdOrderComp.NEXT = 0;
                END;  //ANIL
            END;  //ANIL
            UNTIL ProdOrderLine.NEXT = 0;
        MESSAGE(Text0004);
    END;


    PROCEDURE Planned_Unitscust(Prod_Date: Date) "Units Planned": Decimal;
    BEGIN
        Prod_Order.SETCURRENTKEY(Prod_Order."Prod Start date");
        Prod_Order.SETRANGE(Prod_Order."Prod Start date", Prod_Date);
        IF Prod_Order.FINDSET THEN
            REPEAT
                item.RESET;
                IF item.GET(Prod_Order."Source No.") THEN
                    "Units Planned" += Prod_Order.Quantity * item."No.of Units";

            UNTIL Prod_Order.NEXT = 0;
        EXIT("Units Planned");
    END;


    PROCEDURE CreateALLMaterialIssues1("PROD. Order": Code[20]);
    VAR
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
    BEGIN


        //IF NOT CONFIRM(Text0002,FALSE) THEN
        //EXIT;

        MaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        Rec.SETRANGE("No.", "PROD. Order");
        ProdOrderLine.RESET;

        ProdOrderLine.SETRANGE("Prod. Order No.", "PROD. Order");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
            BEGIN
                /* {IF ProdOrderLine."Line No."<>10000 THEN
                 BEGIN
                   ProdOrderComp.RESET;
                   ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status :: Released);
                   ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                   ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");
                   //ProdOrderComp.SETRANGE("Source No.","Item No.");
                   ProdOrderComp.SETFILTER("Remaining Quantity",'<>0');
                   IF ProdOrderComp.FINDFIRST THEN BEGIN
                     LineNo := 10000;
                     InventorySetup.GET;
                     ManufacturingSetup.GET();
                     ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                     MaterialIssueHeader.RESET;
                     MaterialIssueHeader.INIT;
                     MaterialIssueHeader."No." :=GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                     MaterialIssueHeader."Receipt Date":=TODAY;
                     MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                     MaterialIssueHeader."Transfer-to Code":='PROD';
                     MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                     MaterialIssueHeader.VALIDATE("Prod. Order Line No.",ProdOrderLine."Line No.");
                     MaterialIssueHeader."User ID" := USERID;
                     user.GET(USERID);
                     MaterialIssueHeader."Resource Name":=user.Name;
                     MaterialIssueHeader."Creation DateTime":=CURRENTDATETIME;
                     MaterialIssueHeader."Sales Order No.":="Sales Order No.";
                     MaterialIssueHeader.INSERT;
                   END;
                   REPEAT
                       item.GET(ProdOrderComp."Item No.");
                       IF (NOT item."Dispatch Material") AND (item."Product Group Code"<>'CPCB') AND (item."Product Group Code"<>'FPRODUCT')THEN
                       BEGIN

                       MaterialIssueLine.INIT;
                       MaterialIssueLine."Document No." :=MaterialIssueHeader."No." ;
                       MaterialIssueLine.VALIDATE("Item No.",ProdOrderComp."Item No.");
                       MaterialIssueLine."Line No." := LineNo;
                       MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                       MaterialIssueLine.VALIDATE("Unit of Measure Code");
                       MaterialIssueLine.VALIDATE("Unit of Measure");
                       MaterialIssueLine.VALIDATE(Quantity,ProdOrderComp.Quantity);
                       MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                       MaterialIssueLine.VALIDATE("Outstanding Quantity",ProdOrderComp.Quantity);
                       MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                       MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                       MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                         MaterialIssueLine."Production BOM No.":=MaterialIssueHeader."Prod. BOM No.";
                       LineNo := LineNo + 10000;
                       MaterialIssueLine.INSERT;
                       END;
                   UNTIL ProdOrderComp.NEXT = 0;
                   END;}*/
                IF ProdOrderLine."Line No." <> 10000 THEN                //line no >10000
                BEGIN
                    IF ((ProdOrderLine."Item No." = 'ECPBPCB00553') OR (ProdOrderLine."Item No." = 'ECPBPCB00554') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00566') OR (ProdOrderLine."Item No." = 'ECPBPCB00864') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00434') OR (ProdOrderLine."Item No." = 'ECPBPCB00549') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00431') OR (ProdOrderLine."Item No." = 'ECPBPCB00882') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00936') OR (ProdOrderLine."Item No." = 'ECPBPCB00934') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01049') OR (ProdOrderLine."Item No." = 'ECPBPCB01038') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00534') OR (ProdOrderLine."Item No." = 'ECPBPCB01058') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01063') OR (ProdOrderLine."Item No." = 'ECPBPCB00908') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01070') OR (ProdOrderLine."Item No." = 'ECPBPCB01072') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01111') OR (ProdOrderLine."Item No." = 'ECPBPCB00856') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01231') OR (ProdOrderLine."Item No." = 'ECPBPCB00906') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01145') OR (ProdOrderLine."Item No." = 'ECPBPCB01146') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00933') OR (ProdOrderLine."Item No." = 'ECPBPCB00935') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00937') OR (ProdOrderLine."Item No." = 'ECPBPCB01073') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS00878') OR (ProdOrderLine."Item No." = 'ECPCBDS01137') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01000') OR (ProdOrderLine."Item No." = 'ECPBPCB01270') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00582') OR (ProdOrderLine."Item No." = 'ECPBPCB00889') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01306') OR (ProdOrderLine."Item No." = 'ECPBPCB01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01123') OR (ProdOrderLine."Item No." = 'ECPBPCB01344') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01343') OR (ProdOrderLine."Item No." = 'ECPCBDS01230') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01228') OR (ProdOrderLine."Item No." = 'ECPCBDS01229') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01243') OR (ProdOrderLine."Item No." = 'ECPCBDS01257') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01256') OR (ProdOrderLine."Item No." = 'ECPCBDS01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBSS00447') OR (ProdOrderLine."Item No." = 'ECPBPCB01351') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01348') OR (ProdOrderLine."Item No." = 'ECPBPCB01347') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01486') OR (ProdOrderLine."Item No." = 'ECPBPCB01591')) THEN BEGIN
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            //ProdOrderComp.SETRANGE("Source No.","Item No.");
                            ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", 'smd');
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDFIRST THEN BEGIN
                                LineNo := 10000;
                                InventorySetup.GET;
                                ManufacturingSetup.GET();
                                ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;
                                MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := 'MCH';
                                MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader.INSERT;
                            END;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN

                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                    MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity));
                                    /* MaterialIssueLine.VALIDATE("Qty. to Receive",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                    MaterialIssueLine.Quantity:=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                    MaterialIssueLine."Qty. to Receive":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                    MaterialIssueLine."Outstanding Quantity":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity); *///anil
                                    MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                    MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                    MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                    MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END;
                END;//anil1
                IF ProdOrderLine."Line No." <> 10000 THEN                //line no >10000
                BEGIN

                    IF ((ProdOrderLine."Item No." = 'ECPBPCB00553') OR (ProdOrderLine."Item No." = 'ECPBPCB00554') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00566') OR (ProdOrderLine."Item No." = 'ECPBPCB00864') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00434') OR (ProdOrderLine."Item No." = 'ECPBPCB00549') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00431') OR (ProdOrderLine."Item No." = 'ECPBPCB00882') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00936') OR (ProdOrderLine."Item No." = 'ECPBPCB00934') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01049') OR (ProdOrderLine."Item No." = 'ECPBPCB01038') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00534') OR (ProdOrderLine."Item No." = 'ECPBPCB01058') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01063') OR (ProdOrderLine."Item No." = 'ECPBPCB00908') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01070') OR (ProdOrderLine."Item No." = 'ECPBPCB01072') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01111') OR (ProdOrderLine."Item No." = 'ECPBPCB00856') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01231') OR (ProdOrderLine."Item No." = 'ECPBPCB00906') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01145') OR (ProdOrderLine."Item No." = 'ECPBPCB01146') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00933') OR (ProdOrderLine."Item No." = 'ECPBPCB00935') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00937') OR (ProdOrderLine."Item No." = 'ECPBPCB01073') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS00878') OR (ProdOrderLine."Item No." = 'ECPCBDS01137') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01000') OR (ProdOrderLine."Item No." = 'ECPBPCB01270') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00582') OR (ProdOrderLine."Item No." = 'ECPBPCB00889') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01306') OR (ProdOrderLine."Item No." = 'ECPBPCB01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01123') OR (ProdOrderLine."Item No." = 'ECPBPCB01344') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01343') OR (ProdOrderLine."Item No." = 'ECPCBDS01230') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01228') OR (ProdOrderLine."Item No." = 'ECPCBDS01229') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01243') OR (ProdOrderLine."Item No." = 'ECPCBDS01257') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01256') OR (ProdOrderLine."Item No." = 'ECPCBDS01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBSS00447') OR (ProdOrderLine."Item No." = 'ECPBPCB01351') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01348') OR (ProdOrderLine."Item No." = 'ECPBPCB01347') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01486') OR (ProdOrderLine."Item No." = 'ECPBPCB01591')) THEN BEGIN

                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            // ProdOrderComp.SETRANGE("Source No.","Item No.");
                            ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", '<>%1', ProdOrderComp."Type of Solder"::SMD);
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN BEGIN
                                LineNo := 10000;
                                InventorySetup.GET;
                                ManufacturingSetup.GET();
                                ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;

                                MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);

                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                                MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader.INSERT;

                            END;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN

                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                    MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity));
                                    /* MaterialIssueLine.VALIDATE("Qty. to Receive",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity",(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));
                                    MaterialIssueLine.Quantity:=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                    MaterialIssueLine."Qty. to Receive":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                    MaterialIssueLine."Outstanding Quantity":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity); */
                                    MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                    MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                    MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                    MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END
                    ELSE BEGIN   //anil2
                                 /*{IF ProdOrderLine."Line No."<>10000 THEN                //line no >10000
                                 BEGIN
                                 IF ((ProdOrderLine."Item No."<>'ECPBPCB00553')OR(ProdOrderLine."Item No."<>'ECPBPCB00554')OR
                                 (ProdOrderLine."Item No."<>'ECPBPCB00566')OR (ProdOrderLine."Item No."<>'ECPBPCB00864')OR
                                 (ProdOrderLine."Item No."<>'ECPBPCB00434')OR (ProdOrderLine."Item No."<>'ECPBPCB00549')OR
                                 (ProdOrderLine."Item No."<>'ECPBPCB00431')or(ProdOrderLine."Item No."='ECPBPCB00882')) THEN
                                 BEGIN}*/
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            //ProdOrderComp.SETRANGE("Source No.","Item No.");
                            //  ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder",'<>%1',ProdOrderComp."Type of Solder"::SMD);
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN BEGIN
                                LineNo := 10000;
                                InventorySetup.GET;
                                ManufacturingSetup.GET();
                                ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;
                                MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                                MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader.INSERT;
                            END;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                    MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity));
                                    /* MaterialIssueLine.Quantity:=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                    MaterialIssueLine."Qty. to Receive":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity);
                                    MaterialIssueLine."Outstanding Quantity":=(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity); */
                                    MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                    MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                    MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                    MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;



                        END;
                    END;
                END;
                //ANIL
                IF ProdOrderLine."Line No." = 10000 THEN BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Mechanical');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDSET THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                        MaterialIssueHeader."Transfer-to Code" := 'PROD';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Mechanical;
                        user.GET(USERID);
                        MaterialIssueHeader."Resource Name" := user."User Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        MaterialIssueHeader.INSERT;
                    END;
                    REPEAT
                        item.GET(ProdOrderComp."Item No.");
                        /* {  IF (NOT item."Dispatch Material") AND (item."Product Group Code"<>'CPCB') AND (item."Product Group Code"<>'FPRODUCT')THEN
                           BEGIN }*/
                        IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'FPRODUCT') AND (item."Product Group Code Cust" <> 'CPCB') THEN BEGIN
                            MaterialIssueLine.INIT;
                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                            MaterialIssueLine."Line No." := LineNo;
                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                            MaterialIssueLine.VALIDATE("Unit of Measure");
                            MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp.Quantity);
                            MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                            MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp.Quantity);
                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                            LineNo := LineNo + 10000;
                            MaterialIssueLine.INSERT;
                        END;
                    UNTIL ProdOrderComp.NEXT = 0;
                END;  //ANIL
                Prod_Order.RESET;
                Prod_Order.SETRANGE(Prod_Order."No.", "PROD. Order");
                IF Prod_Order.FINDFIRST THEN BEGIN
                    IF (ProdOrderLine."Line No." = 10000) AND
                       ((Prod_Order."Source No." = 'RLYMNGL001') OR
                        (Prod_Order."Source No." = 'RLYMNRL001') OR
                        (Prod_Order."Source No." = 'RLYMNYL001')) THEN BEGIN
                        ProdOrderComp.RESET;
                        ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                        ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                        ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        //ProdOrderComp.SETRANGE("Source No.","Item No.");
                        ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                        IF ProdOrderComp.FINDSET THEN BEGIN
                            LineNo := 10000;
                            InventorySetup.GET;
                            ManufacturingSetup.GET();
                            ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                            MaterialIssueHeader.RESET;
                            MaterialIssueHeader.INIT;
                            MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                            MaterialIssueHeader."Receipt Date" := TODAY;
                            MaterialIssueHeader."Transfer-from Code" := 'STR';
                            MaterialIssueHeader."Transfer-to Code" := 'PROD';
                            MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                            MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            MaterialIssueHeader."User ID" := USERID;
                            //MaterialIssueHeader."BOM Type":='Mechanical';
                            user.GET(USERID);
                            MaterialIssueHeader."Resource Name" := user."User Name";
                            MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                            MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                            MaterialIssueHeader.INSERT;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF item."Product Group Code Cust" = 'PCB' THEN BEGIN
                                    MaterialIssueLine.INIT;
                                    MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                    MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                    MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                    MaterialIssueLine.VALIDATE("Unit of Measure");
                                    MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp.Quantity);
                                    MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                                    MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp.Quantity);
                                    MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                    MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                    MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                    MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine.INSERT;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END;
                END;

                IF ProdOrderLine."Line No." = 10000 THEN BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    // ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type",'<>%1','Mechanical');
                    ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'wiring');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDFIRST THEN BEGIN
                        LineNo := 10000;
                        InventorySetup.GET;
                        ManufacturingSetup.GET();
                        ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := ManufacturingSetup."MI Transfer From Code";
                        MaterialIssueHeader."Transfer-to Code" := 'PROD';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        MaterialIssueHeader."User ID" := USERID;
                        user.GET(USERID);
                        MaterialIssueHeader."Resource Name" := user."User Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Wiring;
                        MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                        MaterialIssueHeader.INSERT;
                    END;
                    REPEAT
                        item.GET(ProdOrderComp."Item No.");
                        IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                            MaterialIssueLine.INIT;
                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                            MaterialIssueLine."Line No." := LineNo;
                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                            MaterialIssueLine.VALIDATE("Unit of Measure");
                            MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp.Quantity);
                            MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                            MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp.Quantity);
                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                            LineNo := LineNo + 10000;
                            MaterialIssueLine.INSERT;
                        END;
                    UNTIL ProdOrderComp.NEXT = 0;
                END;
            END;  //ANIL
            UNTIL ProdOrderLine.NEXT = 0;
        //  MESSAGE(Text0004);
    END;


    PROCEDURE CreateSTRMaterialIssues("PROD. Order": Code[20]);
    VAR
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
    BEGIN
        DUM.DELETEALL;
        MaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        Rec.SETRANGE("No.", "PROD. Order");
        ProdOrderLine.RESET;

        ProdOrderLine.SETRANGE("Prod. Order No.", "PROD. Order");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
                IF ProdOrderLine."Line No." <> 10000 THEN                //line no >10000
                BEGIN
                    IF ((ProdOrderLine."Item No." = 'ECPBPCB00553') OR (ProdOrderLine."Item No." = 'ECPBPCB00554') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00566') OR (ProdOrderLine."Item No." = 'ECPBPCB00864') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00434') OR (ProdOrderLine."Item No." = 'ECPBPCB00549') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00431') OR (ProdOrderLine."Item No." = 'ECPBPCB00882') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00936') OR (ProdOrderLine."Item No." = 'ECPBPCB00934') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01049') OR (ProdOrderLine."Item No." = 'ECPBPCB01038') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00534') OR (ProdOrderLine."Item No." = 'ECPBPCB01058') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01063') OR (ProdOrderLine."Item No." = 'ECPBPCB00908') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01070') OR (ProdOrderLine."Item No." = 'ECPBPCB01072') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01111') OR (ProdOrderLine."Item No." = 'ECPBPCB00856') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01231') OR (ProdOrderLine."Item No." = 'ECPBPCB00906') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01145') OR (ProdOrderLine."Item No." = 'ECPBPCB01146') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00933') OR (ProdOrderLine."Item No." = 'ECPBPCB00935') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00937') OR (ProdOrderLine."Item No." = 'ECPBPCB01073') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS00878') OR (ProdOrderLine."Item No." = 'ECPCBDS01137') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01000') OR (ProdOrderLine."Item No." = 'ECPBPCB01270') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB00582') OR (ProdOrderLine."Item No." = 'ECPBPCB00889') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01306') OR (ProdOrderLine."Item No." = 'ECPBPCB01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01123') OR (ProdOrderLine."Item No." = 'ECPBPCB01344') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01343') OR (ProdOrderLine."Item No." = 'ECPCBDS01230') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01228') OR (ProdOrderLine."Item No." = 'ECPCBDS01229') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01243') OR (ProdOrderLine."Item No." = 'ECPCBDS01257') OR
                       (ProdOrderLine."Item No." = 'ECPCBDS01256') OR (ProdOrderLine."Item No." = 'ECPCBDS01258') OR
                       (ProdOrderLine."Item No." = 'ECPCBSS00447') OR (ProdOrderLine."Item No." = 'ECPBPCB01351') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01348') OR (ProdOrderLine."Item No." = 'ECPBPCB01347') OR
                       (ProdOrderLine."Item No." = 'ECPBPCB01486') OR (ProdOrderLine."Item No." = 'ECPBPCB01591')) THEN BEGIN
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            // ProdOrderComp.SETRANGE("Source No.","Item No.");
                            ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder", '<>%1', ProdOrderComp."Type of Solder"::SMD);
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN
                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT')
                          THEN BEGIN
                                        DUM.RESET;
                                        IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                            Include_Item(ProdOrderComp."Item No.", TRUE);

                                        IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                            DUM."Maximum Inventory" += (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity);
                                            DUM.MODIFY;
                                        END;
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END
                    ELSE BEGIN
                        FOR i := 1 TO ProdOrderLine.Quantity DO BEGIN
                            ProdOrderComp.RESET;
                            ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                            ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                            ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                            IF ProdOrderComp.FINDSET THEN
                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT')
                          THEN BEGIN
                                        DUM.RESET;
                                        IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                            Include_Item(ProdOrderComp."Item No.", TRUE);

                                        IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                            DUM."Maximum Inventory" += (ProdOrderComp."Expected Quantity" / ProdOrderLine.Quantity);
                                            DUM.MODIFY;
                                        END;
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END;
                END;



                IF ProdOrderLine."Line No." = 10000 THEN BEGIN
                    ProdOrderComp.RESET;
                    ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                    ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                    ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Mechanical');
                    //ProdOrderComp.SETRANGE("Source No.","Item No.");
                    ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                    IF ProdOrderComp.FINDSET THEN
                        REPEAT
                            item.GET(ProdOrderComp."Item No.");
                            IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                DUM.RESET;
                                IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                    Include_Item(ProdOrderComp."Item No.", TRUE);

                                IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                    DUM."Maximum Inventory" += ProdOrderComp.Quantity;
                                    DUM.MODIFY;
                                END;
                            END;
                        UNTIL ProdOrderComp.NEXT = 0;
                END;
                Prod_Order.RESET;
                Prod_Order.SETRANGE(Prod_Order."No.", "PROD. Order");
                IF Prod_Order.FINDFIRST THEN BEGIN
                    IF (ProdOrderLine."Line No." = 10000) AND
                       ((Prod_Order."Source No." = 'RLYMNGL001') OR
                        (Prod_Order."Source No." = 'RLYMNRL001') OR
                        (Prod_Order."Source No." = 'RLYMNYL001')) THEN BEGIN
                        ProdOrderComp.RESET;
                        ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                        ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                        ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                        //ProdOrderComp.SETRANGE("Source No.","Item No.");
                        ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
                        IF ProdOrderComp.FINDSET THEN BEGIN
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF item."Product Group Code Cust" = 'PCB' THEN BEGIN
                                    DUM.RESET;
                                    IF NOT (DUM.GET(ProdOrderComp."Item No.")) THEN
                                        Include_Item(ProdOrderComp."Item No.", TRUE);

                                    IF DUM.GET(ProdOrderComp."Item No.") THEN BEGIN
                                        DUM."Maximum Inventory" := ProdOrderComp.Quantity;
                                        DUM.MODIFY;
                                    END;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;
                    END;
                END;
            UNTIL ProdOrderLine.NEXT = 0;

        /*{
        LineNo := 10000;
        InventorySetup.GET;
        MaterialIssueHeader.RESET;
        MaterialIssueHeader.INIT;
        MaterialIssueHeader."No." :=GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
        MaterialIssueHeader."Receipt Date":=TODAY;
        MaterialIssueHeader."Transfer-from Code" := 'PRODSTR';
        MaterialIssueHeader."Transfer-to Code":='STR';
        MaterialIssueHeader.VALIDATE("Prod. Order No.",'EFF11STR01');
        MaterialIssueHeader.VALIDATE("Prod. Order Line No.",10000);
        MaterialIssueHeader."User ID" := USERID;
        user.GET(USERID);
        MaterialIssueHeader."Resource Name":=user.Name;
        MaterialIssueHeader."Creation DateTime":=CURRENTDATETIME;
        MaterialIssueHeader."Sales Order No.":="Sales Order No.";
        MaterialIssueHeader.INSERT;
         }*/
        k := 0;
        DUM.RESET;
        IF DUM.FIND('-') THEN
            REPEAT
                IF item.GET(DUM."No.") THEN BEGIN
                    item.CALCFIELDS(item."Stock at PROD Stores");
                    IF item."Stock at PROD Stores" > 0 THEN BEGIN
                        IF k = 0 THEN BEGIN
                            LineNo := 10000;
                            InventorySetup.GET;
                            MaterialIssueHeader.RESET;
                            MaterialIssueHeader.INIT;
                            MaterialIssueHeader."No." := GetNextNo;// NoSeriesMgt.GetNextNo(InventorySetup."Material Issue Nos.",WORKDATE,TRUE);
                            MaterialIssueHeader."Receipt Date" := TODAY;
                            MaterialIssueHeader."Transfer-from Code" := 'PRODSTR';
                            MaterialIssueHeader."Transfer-to Code" := 'STR';
                            MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF11STR01');
                            MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                            MaterialIssueHeader."User ID" := USERID;
                            user.GET(USERID);
                            MaterialIssueHeader."Resource Name" := user."User Name";
                            MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                            MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                            MaterialIssueHeader.INSERT;
                            k := 10;
                        END;
                        MaterialIssueLine.INIT;
                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                        MaterialIssueLine.VALIDATE("Item No.", item."No.");
                        MaterialIssueLine."Line No." := LineNo;
                        MaterialIssueLine."Unit of Measure Code" := item."Base Unit of Measure";
                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                        MaterialIssueLine.VALIDATE("Unit of Measure");
                        IF item."Stock at PROD Stores" > DUM."Maximum Inventory" THEN
                            MaterialIssueLine.VALIDATE(Quantity, DUM."Maximum Inventory")
                        ELSE
                            MaterialIssueLine.VALIDATE(Quantity, item."Stock at PROD Stores");
                        MaterialIssueLine."Prod. Order No." := 'EFF11STR01';
                        MaterialIssueLine."Prod. Order Line No." := 10000;
                        MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                        LineNo := LineNo + 10000;
                        MaterialIssueLine.INSERT;
                    END;
                END;
            UNTIL DUM.NEXT = 0;
        k := 0;
    END;


    PROCEDURE Include_Item(item1: Code[20]; Verify: Boolean);
    BEGIN
        item.RESET;
        IF item.GET(item1) THEN BEGIN
            IF (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') AND (NOT item."Dispatch Material") THEN BEGIN
                DUM.INIT;
                DUM."No." := item."No.";
                DUM.Description := item.Description;
                DUM."Maximum Inventory" := 0;
                DUM."Base Unit of Measure" := item."Base Unit of Measure";
                DUM."Product Group Code Cust" := item."Product Group Code Cust";
                DUM.INSERT;
            END;
        END;
    END;


    PROCEDURE CreateALLMaterialIssues_New("PROD. Order": Code[20]);
    VAR
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
        ProdCompLine: Record "Prod. Order Component";
    BEGIN
        MaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF MaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");

        PostedMaterialIssueHeader.SETRANGE("Prod. Order No.", "PROD. Order");
        IF PostedMaterialIssueHeader.FINDFIRST THEN
            ERROR(Text0003, "PROD. Order");
        Rec.SETRANGE("No.", "PROD. Order");


        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE("Prod. Order No.", "PROD. Order");
        IF ProdOrderLine.FINDSET THEN
            REPEAT
            BEGIN
                ProdOrderComp.RESET;
                ProdOrderComp.SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
                ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");

                Item2.RESET;
                Item2.SETFILTER(Item2."No.", ProdOrderLine."Item No.");
                IF Item2.FINDFIRST THEN BEGIN
                    IF (ProdOrderLine."Line No." <> 10000) OR ((ProdOrderLine."Line No." = 10000) AND (Item2."Product Group Code Cust" <> 'FPRODUCT')) THEN BEGIN
                        ProdCompLine.RESET;
                        ProdCompLine.SETFILTER(ProdCompLine."Prod. Order No.", "PROD. Order");
                        ProdCompLine.SETFILTER(ProdCompLine."Prod. Order Line No.", FORMAT(ProdOrderLine."Line No."));
                        ProdCompLine.SETFILTER(ProdCompLine."Product Group Code", 'PCB');

                        IF ProdCompLine.FINDFIRST THEN BEGIN
                            PcbGRec.RESET;
                            PcbGRec.SETRANGE(PcbGRec."PCB No.", ProdCompLine."Item No.");
                            PcbGRec.SETFILTER(PcbGRec.Stencil, '<>%1', '');
                            IF PcbGRec.FINDFIRST THEN

                            /*{ //Added by swathi on 24-10-13 for stencil process
                             PcbGRec.RESET;
                             PcbGRec.SETRANGE(PcbGRec."PCB No.",ProdOrderLine."Item No.");
                             PcbGRec.SETFILTER(PcbGRec.Stencil,'<>%1','');
                             IF PcbGRec. FINDFIRST THEN
                             //Added by swathi on 24-10-13 for stencil process
                             }*/

                            /* {
                                 IF ProdOrderLine."Item No."IN ['ECPBPCB00431','ECPBPCB00434','ECPBPCB00549','ECPBPCB00553',
                                                                'ECPBPCB00882','ECPBPCB00554','ECPBPCB00566','ECPBPCB00856',
                                                                'ECPBPCB00936','ECPBPCB00934','ECPBPCB01049','ECPBPCB01038',
                                                                'ECPBPCB00534','ECPBPCB01058','ECPBPCB01063','ECPBPCB00908',
                                                                'ECPBPCB01070','ECPBPCB01072','ECPBPCB01111','ECPBPCB00864',
                                                                'ECPBPCB01231','ECPBPCB00906','ECPBPCB01145','ECPBPCB01146',
                                                                'ECPBPCB00933','ECPBPCB00935','ECPBPCB00937','ECPBPCB01073',
                                                                'ECPCBDS00878','ECPCBDS01137','ECPBPCB01000','ECPBPCB01270',
                                                                'ECPBPCB00582','ECPBPCB00889','ECPBPCB01306','ECPBPCB01258',
                                                                'ECPCBDS01123','ECPBPCB01344','ECPBPCB01343','ECPCBDS01230',
                                                                'ECPCBDS01228','ECPCBDS01229','ECPCBDS01243','ECPCBDS01257',
                                                                'ECPCBDS01256','ECPCBDS01258','ECPCBSS00447','ECPBPCB01351',
                                                                'ECPBPCB01348','ECPBPCB01347','ECPBPCB01300','ECPBPCB01381',
                                                                'ECPBPCB01109','ECPBPCB01436','ECPBPCB01437','ECPBPCB01461'{,
                                                                'ECPCBSS00497','ECPCBDS01390','ECPCBSS00499','ECPCBSS00496',
                                                                'ECPCBSS00480'},'ECPBPCB01486','ECPBPCB01487','ECPBPCB01528',
                                                                'ECPBPCB01529','ECPBPCB01193','ECPBPCB01591','ECPBPCB00172',
                                                                'ECPBPCB00173','ECPBPCB00015','ECPBPCB00016','ECPBPCB00029',
                                                                'ECPBPCB01289','ECPBPCB00418','ECPBPCB00481',{'ECPBPCB00873',}
                                                                'ECPBPCB00869','ECPBPCB01026','ECPBPCB00400','ECPBPCB00890',
                                                                'ECPBPCB00487','ECPBPCB00559','ECPBPCB00802','ECPBPCB00813',
                                                                'ECPBPCB00938','ECPBPCB00971','ECPBPCB01016','ECPBPCB01075',
                                                                'ECPBPCB01311','ECPBPCB01077','ECPBPCB01076','ECPBPCB01078',
                                                                'ECPBPCB01092','ECPBPCB01224','ECPBPCB01205','ECPBPCB01155',
                                                                'ECPBPCB01185','ECPBPCB01228','ECPBPCB01225','ECPBPCB01226',
                                                                'ECPBPCB01227','ECPBPCB01230','ECPBPCB01263','ECPBPCB01257',
                                                                'ECPBPCB01385','ECPBPCB01384','ECPBPCB01373',{'ECPBPCB01396',}
                                                                {'ECPBPCB01398',}'ECPBPCB01394','ECPBPCB01443','ECPBPCB01442',
                                                                'ECPBPCB01516','ECPBPCB01269','ECPBPCB01282','ECPBPCB01399',
                                                                'ECPBPCB01452','ECPBPCB01455','ECPBPCB01451','ECPBPCB01567',
                                                                'ECPBPCB01566','ECPBPCB01345','ECPBPCB01571','ECPBPCB01545',
                                                                'ECPBPCB01205','ECPBPCB01439','ECPBPCB00400','ECPBPCB01544',
                                                                'ECPBPCB01476','ECPBPCB01469','ECPBPCB01472','ECPBPCB01481',
                                                                'ECPBPCB01260','ECPBPCB01312','ECPBPCB01525','ECPBPCB01533',
                                                                'ECPBPCB01532','ECPBPCB01572','ECPBPCB01573','ECPBPCB01508',
                                                                'ECPBPCB01321','ECPBPCB01488','ECPBPCB01468','ECPBPCB01600',
                                                                'ECPBPCB01572','ECPBPCB01573','ECPBPCB01508','ECPBPCB01321',
                                                                'ECPBPCB01596','ECPBPCB01602','ECPBPCB01603','ECPBPCB01617',
                                                                'ECPBPCB01644','ECPBPCB01650','ECPBPCB01649'] THEN
                             }*/
                            BEGIN
                                ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder2", 'SMD');
                                // FOR i:=1 TO ProdOrderLine.Quantity DO  // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                // BEGIN
                                IF ProdOrderComp.FINDFIRST THEN BEGIN
                                    LineNo := 10000;
                                    MaterialIssueHeader.RESET;
                                    MaterialIssueHeader.INIT;
                                    MaterialIssueHeader."No." := GetNextNo;
                                    MaterialIssueHeader."Receipt Date" := TODAY;
                                    MaterialIssueHeader."Transfer-from Code" := 'MCH';
                                    MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                    MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                    MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                    MaterialIssueHeader."User ID" := USERID;
                                    user.GET(USERSECURITYID);
                                    MaterialIssueHeader."Resource Name" := user."User Name";
                                    MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                    MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                    MaterialIssueHeader."Auto Post" := TRUE;
                                    MaterialIssueHeader.INSERT;
                                END;
                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                        IF ProdOrderComp.COUNT <> 0 THEN BEGIN      //B2b1.0
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            //MaterialIssueLine.VALIDATE(Quantity,(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity)); // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                            MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity"));
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                            //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                   //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;  //B2b1.0
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                                //END;            //for loop end

                                ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder2", '<>%1', 'SMD');
                                //FOR i:=1 TO ProdOrderLine.Quantity DO  // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                //BEGIN
                                IF ProdOrderComp.FINDSET THEN BEGIN
                                    LineNo := 10000;
                                    MaterialIssueHeader.RESET;
                                    MaterialIssueHeader.INIT;
                                    MaterialIssueHeader."No." := GetNextNo;
                                    MaterialIssueHeader."Receipt Date" := TODAY;
                                    MaterialIssueHeader."Transfer-from Code" := 'STR';
                                    MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                    MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                    MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                    MaterialIssueHeader."User ID" := USERID;
                                    user.GET(USERSECURITYID);
                                    MaterialIssueHeader."Resource Name" := user."User Name";
                                    MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                    MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                    MaterialIssueHeader."Auto Post" := TRUE;
                                    MaterialIssueHeader.INSERT;
                                END;
                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                        IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            //MaterialIssueLine.VALIDATE(Quantity,(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));  // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                            MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity"));
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                            //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                        //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;        //B2b1.0
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                                //END; //for loop end
                            END
                            ELSE BEGIN
                                //ProdOrderComp.SETFILTER(ProdOrderComp."Type of Solder2",'<>%1','SMD');
                                //FOR i:=1 TO ProdOrderLine.Quantity DO  // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                // BEGIN
                                IF ProdOrderComp.FINDSET THEN BEGIN
                                    LineNo := 10000;
                                    MaterialIssueHeader.RESET;
                                    MaterialIssueHeader.INIT;
                                    MaterialIssueHeader."No." := GetNextNo;
                                    MaterialIssueHeader."Receipt Date" := TODAY;
                                    MaterialIssueHeader."Transfer-from Code" := 'STR';
                                    MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                    MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                    MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                    MaterialIssueHeader."User ID" := USERID;
                                    user.GET(USERSECURITYID);
                                    MaterialIssueHeader."Resource Name" := user."User Name";
                                    MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                    MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                    MaterialIssueHeader."Auto Post" := TRUE;
                                    MaterialIssueHeader.INSERT;
                                END;
                                REPEAT
                                    item.GET(ProdOrderComp."Item No.");
                                    IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                        IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            //MaterialIssueLine.VALIDATE(Quantity,(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));  // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                            MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity"));
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                            //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                    //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;    //B2b1.0
                                    END;
                                UNTIL ProdOrderComp.NEXT = 0;
                                // END;       //for loop end
                            END;        //else end
                        END         //pcb end
                        ELSE BEGIN
                            // FOR i:=1 TO ProdOrderLine.Quantity DO  // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                            //BEGIN
                            IF ProdOrderComp.FINDSET THEN BEGIN
                                LineNo := 10000;
                                MaterialIssueHeader.RESET;
                                MaterialIssueHeader.INIT;
                                MaterialIssueHeader."No." := GetNextNo;
                                MaterialIssueHeader."Receipt Date" := TODAY;
                                MaterialIssueHeader."Transfer-from Code" := 'STR';
                                MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                MaterialIssueHeader."User ID" := USERID;
                                user.GET(USERSECURITYID);
                                MaterialIssueHeader."Resource Name" := user."User Name";
                                MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                MaterialIssueHeader."Auto Post" := TRUE;
                                MaterialIssueHeader.INSERT;
                            END;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (item."Product Group Code Cust" <> 'CPCB') AND (item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                    IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        //MaterialIssueLine.VALIDATE(Quantity,(ProdOrderComp."Expected Quantity"/ProdOrderLine.Quantity));   // Commented by Vijaya on 01-08-2018 for single request creation for multiple request
                                        MaterialIssueLine.VALIDATE(Quantity, (ProdOrderComp."Expected Quantity"));
                                        MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                        MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                        MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                        MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                        //added by pranavi on 08-04-2015
                                        MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                        MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                        ProdOrdrNew.RESET;                      //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                        ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                        IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                            IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                    ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                ELSE
                                                    IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                        ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                            END;
                                        END;  //End by Pranavi 04-08-2015
                                        MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                        //end by pranavi on 08-04-2015
                                        LineNo := LineNo + 10000;
                                        MaterialIssueLine.INSERT;
                                    END;      //B2b1.0
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                            // END;     //for loop end
                        END;      //else notpcb end
                    END;       //<>10000 line and <>FProduct end

                    ProdOrderComp.SETRANGE(ProdOrderComp."Type of Solder2");
                    IF (ProdOrderLine."Line No." = 10000) AND (Item2."Product Group Code Cust" = 'FPRODUCT') THEN BEGIN
                        IF ProdOrderLine."Item No." IN ['RLYMNGL001', 'RLYMNRL001', 'RLYMNYL001', 'RLYSHT001', 'RLYRTS001', 'RLYCLU001',
                                                          'RLYMNGL002', 'RLYMNRL002', 'RLYMNYL002'] THEN BEGIN

                            IF ProdOrderComp.FINDSET THEN BEGIN
                                IF (UPPERCASE(FORMAT(ProdOrderComp."BOM Type")) <> 'MECHANICAL') OR (UPPERCASE(FORMAT(ProdOrderComp."BOM Type")) <> 'WIRING') THEN BEGIN //added by sundar on 02-Sep-13 as Pcbs are posting double times for route,shunts
                                    LineNo := 10000;
                                    MaterialIssueHeader.RESET;
                                    MaterialIssueHeader.INIT;
                                    MaterialIssueHeader."No." := GetNextNo;
                                    MaterialIssueHeader."Receipt Date" := TODAY;
                                    MaterialIssueHeader."Transfer-from Code" := 'STR';
                                    MaterialIssueHeader."Transfer-to Code" := 'PROD';
                                    MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                                    MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                    MaterialIssueHeader."User ID" := USERID;
                                    user.GET(USERSECURITYID);
                                    MaterialIssueHeader."Resource Name" := user."User Name";
                                    MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                                    MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                                    MaterialIssueHeader."Auto Post" := TRUE;
                                    MaterialIssueHeader.INSERT;
                                    REPEAT
                                        item.GET(ProdOrderComp."Item No.");
                                        IF item."Product Group Code Cust" = 'PCB' THEN BEGIN
                                            IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                                MaterialIssueLine.INIT;
                                                MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                                MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                                MaterialIssueLine."Line No." := LineNo;
                                                MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                                MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                                MaterialIssueLine.VALIDATE("Unit of Measure");
                                                MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                                MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                                MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");
                                                MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                                MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                                MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                                MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                                //added by pranavi on 08-04-2015
                                                MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                                MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                                ProdOrdrNew.RESET;                         //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                                ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                                IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                    IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                        IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                            ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                        ELSE
                                                            IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                                ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                    END;
                                                END;  //End by Pranavi 04-08-2015
                                                MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                                //end by pranavi on 08-04-2015
                                                LineNo := LineNo + 10000;
                                                MaterialIssueLine.INSERT;
                                            END;
                                        END;   //B2b1.0
                                    UNTIL ProdOrderComp.NEXT = 0;
                                END; //<> Mechanical or <> Wiring End
                            END;  //ProdOrdeCompFindSet End
                        END;   //Rilwaysignal lamps end

                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Mechanical');
                        IF ProdOrderComp.FINDSET THEN BEGIN
                            LineNo := 10000;
                            MaterialIssueHeader.RESET;
                            MaterialIssueHeader.INIT;
                            MaterialIssueHeader."No." := GetNextNo;
                            MaterialIssueHeader."Receipt Date" := TODAY;
                            MaterialIssueHeader."Transfer-from Code" := 'STR';
                            MaterialIssueHeader."Transfer-to Code" := 'PROD';
                            MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                            MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            MaterialIssueHeader."User ID" := USERID;
                            MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Mechanical;
                            user.GET(USERSECURITYID);
                            MaterialIssueHeader."Resource Name" := user."User Name";
                            MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                            MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                            MaterialIssueHeader."Auto Post" := TRUE;
                            MaterialIssueHeader.INSERT;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (NOT (item."Product Group Code Cust" IN ['FPRODUCT', 'CPCB'/*,'PCB'*/])) THEN //PCB Commented by Pranavi on 12-Dec-2015
                                BEGIN
                                    IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                        IF NOT ((ProdOrderLine."Item No." IN ['RLYMNGL001', 'RLYMNRL001', 'RLYMNYL001', 'RLYSHT001', 'RLYRTS001', 'RLYCLU001',
                                                                    'RLYMNGL002', 'RLYMNRL002', 'RLYMNYL002']) AND (item."Product Group Code Cust" IN ['PCB'])) THEN BEGIN   // condition Added by Pranavi on 09-Jan-2016 for solving pcb double time posting for shunts and rout
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";     //Added by Pranavi on 29-Dec-2015 for updating BOM no.
                                                                                                                               //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                      //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;
                                    END;
                                END;
                            UNTIL ProdOrderComp.NEXT = 0;
                        END; //Mechanical end
                        IF LineNo = 10000 THEN BEGIN
                            IF MIHTestGRec.GET(MaterialIssueHeader."No.") THEN
                                MaterialIssueHeader.DELETE;
                        END;

                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Wiring');
                        IF ProdOrderComp.FINDFIRST THEN BEGIN
                            LineNo := 10000;
                            MaterialIssueHeader.RESET;
                            MaterialIssueHeader.INIT;
                            MaterialIssueHeader."No." := GetNextNo;
                            MaterialIssueHeader."Receipt Date" := TODAY;
                            MaterialIssueHeader."Transfer-from Code" := 'STR';
                            MaterialIssueHeader."Transfer-to Code" := 'PROD';
                            MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                            MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            MaterialIssueHeader."User ID" := USERID;
                            user.GET(USERSECURITYID);
                            MaterialIssueHeader."Resource Name" := user."User Name";
                            MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                            MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Wiring;
                            MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                            MaterialIssueHeader."Auto Post" := TRUE;
                            MaterialIssueHeader.INSERT;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (NOT (item."Product Group Code Cust" IN ['FPRODUCT', 'CPCB'/*,'PCB'*/])) THEN   //PCB Commented by Pranavi on 12-Dec-2015
                                BEGIN
                                    IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                        IF NOT ((ProdOrderLine."Item No." IN ['RLYMNGL001', 'RLYMNRL001', 'RLYMNYL001', 'RLYSHT001', 'RLYRTS001', 'RLYCLU001',
                                                                    'RLYMNGL002', 'RLYMNRL002', 'RLYMNYL002']) AND (item."Product Group Code Cust" IN ['PCB'])) THEN BEGIN  // condition Added by Pranavi on 09-Jan-2016 for solving pcb double time posting for shunts and rout
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                            //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                      //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;
                                    END;
                                END;     //B2b1.0
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;  //Wiring Material End
                        IF LineNo = 10000 THEN BEGIN
                            IF MIHTestGRec.GET(MaterialIssueHeader."No.") THEN
                                MaterialIssueHeader.DELETE;
                        END;
                        //Added by Pranavi on 11-Jan-2016 for Testing and Packing issues
                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Packing');
                        IF ProdOrderComp.FINDFIRST THEN BEGIN
                            LineNo := 10000;
                            MaterialIssueHeader.RESET;
                            MaterialIssueHeader.INIT;
                            MaterialIssueHeader."No." := GetNextNo;
                            MaterialIssueHeader."Receipt Date" := TODAY;
                            MaterialIssueHeader."Transfer-from Code" := 'STR';
                            MaterialIssueHeader."Transfer-to Code" := 'PROD';
                            MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                            MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            MaterialIssueHeader."User ID" := USERID;
                            user.GET(USERSECURITYID);
                            MaterialIssueHeader."Resource Name" := user."User Name";
                            MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                            MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Packing;
                            MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                            MaterialIssueHeader."Auto Post" := TRUE;
                            MaterialIssueHeader.INSERT;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (NOT (item."Product Group Code Cust" IN ['FPRODUCT', 'CPCB'/*,'PCB'*/])) THEN   //PCB Commented by Pranavi on 12-Dec-2015
                                BEGIN
                                    IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                        IF NOT ((ProdOrderLine."Item No." IN ['RLYMNGL001', 'RLYMNRL001', 'RLYMNYL001', 'RLYSHT001', 'RLYRTS001', 'RLYCLU001',
                                                                    'RLYMNGL002', 'RLYMNRL002', 'RLYMNYL002']) AND (item."Product Group Code Cust" IN ['PCB'])) THEN BEGIN  // condition Added by Pranavi on 09-Jan-2016 for solving pcb double time posting for shunts and rout
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                            //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                      //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;
                                    END;
                                END;     //B2b1.0
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;  //Packing Material End
                        IF LineNo = 10000 THEN BEGIN
                            IF MIHTestGRec.GET(MaterialIssueHeader."No.") THEN
                                MaterialIssueHeader.DELETE;
                        END;

                        ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type", 'Testing');
                        IF ProdOrderComp.FINDFIRST THEN BEGIN
                            LineNo := 10000;
                            MaterialIssueHeader.RESET;
                            MaterialIssueHeader.INIT;
                            MaterialIssueHeader."No." := GetNextNo;
                            MaterialIssueHeader."Receipt Date" := TODAY;
                            MaterialIssueHeader."Transfer-from Code" := 'STR';
                            MaterialIssueHeader."Transfer-to Code" := 'PROD';
                            MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                            MaterialIssueHeader.VALIDATE("Prod. Order Line No.", ProdOrderLine."Line No.");
                            MaterialIssueHeader."User ID" := USERID;
                            user.GET(USERSECURITYID);
                            MaterialIssueHeader."Resource Name" := user."User Name";
                            MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                            MaterialIssueHeader."BOM Type" := MaterialIssueHeader."BOM Type"::Testing;
                            MaterialIssueHeader."Sales Order No." := Rec."Sales Order No.";
                            MaterialIssueHeader."Auto Post" := TRUE;
                            MaterialIssueHeader.INSERT;
                            REPEAT
                                item.GET(ProdOrderComp."Item No.");
                                IF (NOT item."Dispatch Material") AND (NOT (item."Product Group Code Cust" IN ['FPRODUCT', 'CPCB'/*,'PCB'*/])) THEN   //PCB Commented by Pranavi on 12-Dec-2015
                                BEGIN
                                    IF ProdOrderComp.COUNT <> 0 THEN BEGIN //B2b1.0
                                        IF NOT ((ProdOrderLine."Item No." IN ['RLYMNGL001', 'RLYMNRL001', 'RLYMNYL001', 'RLYSHT001', 'RLYRTS001', 'RLYCLU001',
                                                                    'RLYMNGL002', 'RLYMNRL002', 'RLYMNYL002']) AND (item."Product Group Code Cust" IN ['PCB'])) THEN BEGIN  // condition Added by Pranavi on 09-Jan-2016 for solving pcb double time posting for shunts and rout
                                            MaterialIssueLine.INIT;
                                            MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                            MaterialIssueLine.VALIDATE("Item No.", ProdOrderComp."Item No.");
                                            MaterialIssueLine."Line No." := LineNo;
                                            MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                                            MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                            MaterialIssueLine.VALIDATE("Unit of Measure");
                                            MaterialIssueLine.VALIDATE(Quantity, ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine.VALIDATE("Outstanding Quantity", ProdOrderComp."Expected Quantity");
                                            MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                                            MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                                            MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                                            MaterialIssueLine."Production BOM No." := MaterialIssueHeader."Prod. BOM No.";
                                            //added by pranavi on 08-04-2015
                                            MaterialIssueLine."Operation No." := ProdOrderComp."Operation No.";
                                            MaterialIssueLine.Dept := ProdOrderComp.Dept;
                                            ProdOrdrNew.RESET;                      //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                                            ProdOrdrNew.SETFILTER(ProdOrdrNew."No.", ProdOrderComp."Prod. Order No.");
                                            IF ProdOrdrNew.FINDFIRST THEN BEGIN
                                                IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN BEGIN
                                                    IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                                        ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                                    ELSE
                                                        IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                                            ERROR('Material Requisition Day Not updated in Production BOM of Order: !' + ProdOrderComp."Prod. Order No." + '\Please consult Mss.Jhansi or ERP Team!');
                                                END;
                                            END;  //End by Pranavi 04-08-2015
                                            MaterialIssueLine."Material Requisition Date" := ProdOrderComp."Material Requisition Date";
                                            //end by pranavi on 08-04-2015
                                            LineNo := LineNo + 10000;
                                            MaterialIssueLine.INSERT;
                                        END;
                                    END;
                                END;     //B2b1.0
                            UNTIL ProdOrderComp.NEXT = 0;
                        END;  //Testing Material End
                        IF LineNo = 10000 THEN BEGIN
                            IF MIHTestGRec.GET(MaterialIssueHeader."No.") THEN
                                MaterialIssueHeader.DELETE;
                        END;
                        // End by Pranavi
                    END;  // line no 10000 and FProduct end

                    // For Cs Spares Purpose
                    /*{   FOR i:=1 TO ProdOrderLine.Quantity DO
                         BEGIN
                           ProdOrderComp.RESET;
                           ProdOrderComp.SETRANGE(Status,ProdOrderComp.Status :: Released);
                           ProdOrderComp.SETRANGE("Prod. Order No.", "PROD. Order");
                           ProdOrderComp.SETRANGE("Prod. Order Line No.",ProdOrderLine."Line No.");
                           ProdOrderComp.SETFILTER(ProdOrderComp."BOM Type",'');
                           ProdOrderComp.SETFILTER("Remaining Quantity",'<>0');
                           IF ProdOrderComp.FINDSET THEN
                           BEGIN
                             LineNo := 10000;
                             InventorySetup.GET;
                             ManufacturingSetup.GET();
                             ManufacturingSetup.TESTFIELD("MI Transfer From Code");
                             MaterialIssueHeader.RESET;
                             MaterialIssueHeader.INIT;
                             MaterialIssueHeader."No." :=GetNextNo;
                             MaterialIssueHeader."Receipt Date":=TODAY;
                             MaterialIssueHeader."Transfer-from Code" := 'STR';
                             MaterialIssueHeader."Transfer-to Code":='PROD';
                             MaterialIssueHeader.VALIDATE("Prod. Order No.", "PROD. Order");
                             MaterialIssueHeader.VALIDATE("Prod. Order Line No.",ProdOrderLine."Line No.");
                             MaterialIssueHeader."User ID" := USERID;
                             user.GET(USERSECURITYID);
                             MaterialIssueHeader."Resource Name":=user.Name;
                             MaterialIssueHeader."Creation DateTime":=CURRENTDATETIME;
                             MaterialIssueHeader."Sales Order No.":="Sales Order No.";
                             MaterialIssueHeader.INSERT;
                           END;
                           REPEAT
                             item.GET(ProdOrderComp."Item No.");
                               IF (NOT item."Dispatch Material") AND (item."Product Group Code"<>'FPRODUCT') AND (item."Product Group Code"<>'CPCB')  THEN
                             BEGIN
                               MaterialIssueLine.INIT;
                               MaterialIssueLine."Document No." :=MaterialIssueHeader."No." ;
                               MaterialIssueLine.VALIDATE("Item No.",ProdOrderComp."Item No.");
                               MaterialIssueLine."Line No." := LineNo;
                               MaterialIssueLine."Unit of Measure Code" := ProdOrderComp."Unit of Measure Code";
                               MaterialIssueLine.VALIDATE("Unit of Measure Code");
                               MaterialIssueLine.VALIDATE("Unit of Measure");
                               MaterialIssueLine.VALIDATE(Quantity,ProdOrderComp.Quantity);
                               MaterialIssueLine.VALIDATE("Qty. to Receive", ProdOrderComp.Quantity);
                               MaterialIssueLine.VALIDATE("Outstanding Quantity",ProdOrderComp.Quantity);
                               MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                               MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                               MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                               MaterialIssueLine."Production BOM No.":=MaterialIssueHeader."Prod. BOM No.";
                               //added by pranavi on 08-04-2015
                               MaterialIssueLine."Operation No.":=ProdOrderComp."Operation No.";
                               MaterialIssueLine.Dept:=ProdOrderComp.Dept;
                               ProdOrdrNew.RESET;                          //Added by Pranavi on 04-08-2015 to restrict if mat req date not updated
                               ProdOrdrNew.SETFILTER(ProdOrdrNew."No.",ProdOrderComp."Prod. Order No.");
                               IF ProdOrdrNew.FINDFIRST THEN
                               BEGIN
                                 IF NOT ((ProdOrdrNew."Product Group Code" = 'FPRODUCT') AND (ProdOrdrNew."Item Sub Group Code" = 'LED LIGHT')) THEN
                                 BEGIN
                                   IF (FORMAT(ProdOrderComp."Material Requisition Date") = '') AND (ProdOrderComp."Material Required Day" <> 0) THEN
                                     ERROR('Material Requisition dates not updated!\Please ReSelect The Prod. Start Date!')
                                   ELSE IF (FORMAT(ProdOrderComp."Material Required Day") = '') THEN
                                     ERROR('Material Requisition Day Not updated in Production BOM of Order: !'+ProdOrderComp."Prod. Order No."+'\Please consult Mss.Jhansi or ERP Team!');
                                 END;
                               END;  //End by Pranavi 04-08-2015
                               MaterialIssueLine."Material Requisition Date":=ProdOrderComp."Material Requisition Date";
                               //end by pranavi on 08-04-2015
                               LineNo := LineNo + 10000;
                               MaterialIssueLine.INSERT;
                             END;
                           UNTIL ProdOrderComp.NEXT = 0;
                           IF LineNo=10000 THEN
                           BEGIN
                             IF MIHTestGRec.GET(MaterialIssueHeader."No.") THEN
                               MaterialIssueHeader.DELETE;
                           END;
                         END;
                     } */
                    //For Cs Spares Purpose

                END;
            END;
            UNTIL ProdOrderLine.NEXT = 0;
    END;


    LOCAL PROCEDURE ShortcutDimension1CodeOnAfterV()
    BEGIN
        CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    END;

    PROCEDURE GetBenchmarks();
    var
        ProdLine: record 5406;
        ProdOrder: record 5405;
        Itm: Record Item;
    BEGIN
        MESSAGE('Hi');
        ProdLine.RESET;
        ProdOrder.RESET;
        ProdLine.SETFILTER(ProdLine."Prod. Order No.", ProdOrder."No.");
        ProdLine.SETFILTER(ProdLine.Status, '=%1', ProdLine.Status::Released);
        ProdLine.SETRANGE(ProdLine."Item No.", Itm."No.");
        //ProdLine.SETFILTER("Item No.",Itm."No.");
        IF ProdLine.FINDSET THEN BEGIN
            REPEAT
                ProdLine."Benchmark(in Min)" := Itm."Benchmarks(in Min)";
                ProdLine."Total Benchmarks(in Min)" := ProdLine.Quantity * Itm."Benchmarks(in Min)";
                ProdLine.MODIFY;
            UNTIL ProdLine.NEXT = 0;
        END;
    END;

    LOCAL PROCEDURE ShortcutDimension2CodeOnAfterV()
    BEGIN
        CurrPage.ProdOrderLines.PAGE.UpdateForm(TRUE);
    END;


    PROCEDURE InputBox(): Text;
    VAR
        /*
        Prompt: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Form" RUNONCLIENT;
      FormBorderStyle: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.FormBorderStyle" RUNONCLIENT;
      FormStartPosition: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.FormStartPosition" RUNONCLIENT;
      LblRows: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Label" RUNONCLIENT;
      TxtRows: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.

                                                       System.Windows.Forms.TextBox" RUNONCLIENT;
      ButtonOk: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Button" RUNONCLIENT;
      ButtonCancel: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Button" RUNONCLIENT;
      DialogResult: DotNet "'System.Windows.Forms, Version=4.0.0.0,

     Culture=neutral, PublicKeyToken=b77a5c561934e089'.

                                                       System.Windows.Forms.DialogResult" RUNONCLIENT;
                                                       */

        Prompt: DotNet PromptD;


        FormBorderStyle: DotNet FormBorderStyleD;

        FormStartPosition: DotNet FormStartPositionD;
        LblRows: DotNet lblIBINAddressD;


        TxtRows: DotNet txtBINAddressD;


        ButtonOk: DotNet confirmationD;
        ButtonCancel: DotNet ButtonCancelD;
        DialogResult: DotNet DialogResultD;


        NoOFRows_gInt: Integer;
        NoOFColumns_gInt: Integer;
        Result: Text;
        FindWhat: Text[2];
        ReplaceWith: Text[4];
        NewString: Text;
        i: Integer;
    BEGIN

        // ADDED BY VIJAYA ON 20-MAY-2016 for Changing Order Status

        Prompt := Prompt.Form();
        Prompt.Width := 400;
        Prompt.Height := 650;
        Prompt.FormBorderStyle := FormBorderStyle.FixedToolWindow;
        Prompt.Text := 'Remarks';
        Prompt.StartPosition := FormStartPosition.CenterParent;

        LblRows := LblRows.Label();
        LblRows.Text := 'Enter Remarks :: ';
        LblRows.Left := 20;
        LblRows.Top := 20;
        Prompt.Controls.Add(LblRows);

        TxtRows := TxtRows.TextBox();
        TxtRows.Left(20);
        TxtRows.Top(50);
        TxtRows.Width(350);
        TxtRows.Height(520);
        TxtRows.Multiline := TRUE;
        TxtRows.ScrollBars := 1;


        Prompt.Controls.Add(TxtRows);

        ButtonOk := ButtonOk.Button();
        ButtonOk.Text('Ok');
        ButtonOk.Left(215);
        ButtonOk.Top(580);
        ButtonOk.Width(75);
        ButtonOk.DialogResult := DialogResult.OK;
        Prompt.Controls.Add(ButtonOk);

        ButtonCancel := ButtonCancel.Button();
        ButtonCancel.Text('Cancel');
        ButtonCancel.Left(295);
        ButtonCancel.Top(580);
        ButtonCancel.Width(75);
        ButtonCancel.DialogResult := DialogResult.Cancel;
        Prompt.Controls.Add(ButtonCancel);

        IF (Prompt.ShowDialog().ToString() <> DialogResult.OK.ToString()) THEN BEGIN
            EXIT;
        END;
        Prompt.Dispose;
        Result := TxtRows.Text;   /*
        FindWhat := format(13);
        ReplaceWith := 'xx';
        WHILE STRPOS(Result, FindWhat) > 0 DO
            Result := DELSTR(Result, STRPOS(Result, FindWhat)) + ReplaceWith + COPYSTR(Result, STRPOS(Result, FindWhat) + STRLEN(FindWhat));

         //NewString := String;
*/
        i := 1;
        NewString := '';
        WHILE i < STRLEN(Result) + 2 DO BEGIN
            IF (Result[i] = 13) THEN
                NewString := NewString + '<br>'
            ELSE
                NewString := NewString + FORMAT(Result[i]);
            i := i + 1;
        END;



        EXIT(NewString);

        //end by vijaya
    END;

    Var


}