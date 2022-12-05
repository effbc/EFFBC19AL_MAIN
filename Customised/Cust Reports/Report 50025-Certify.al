report 50025 Certify
{
    DefaultLayout = RDLC;
    RDLCLayout = './Certify.rdl';
    UseRequestPage = true;

    dataset
    {
        dataitem(pbh; "Production BOM Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                i := -1;
                j := -1;
                direct_vertical := -1;
                rnoMgr := '';
                rnoVh := '';
                save := TRUE;

                // Code Added  by Vishnu Priya  on 30-09-2020
                Mail_Send_To := 'bharat@efftronics.com';
                rnoVh := '89FD002';
                user.RESET;
                user.SETFILTER("User Id", USERID);
                user.SETRANGE(levels, TRUE);
                IF user.FINDFIRST THEN BEGIN
                    Mail_To := user.MailID;
                    rnoMgr := user.EmployeeID;
                    i := 5;
                    j := 5
                END
                ELSE
                    ERROR('You are not an Authorized User to send BOMs in erp.');

                // Code Added  by Vishnu Priya  on 30-09-2020
                // Code commented  by Vishnu Priya  on 30-09-2020

                /*
                IF vh1=TRUE THEN
                BEGIN
                  i:=1;
                  Mail_Send_To:='bhavani@efftronics.com';
                  rnoVh:='88RD001';
                  // Mail_Send_To:='sundar@efftronics.com';
                  // rnoVh:='10RD010';
                END;
                
                IF vh2=TRUE THEN
                BEGIN
                  i:=2;
                  Mail_Send_To:='ramasamy@efftronics.com';
                  rnoVh:='01QC001';
                END;
                
                IF vh3=TRUE THEN
                BEGIN
                  i:=3;
                  Mail_Send_To:='bala@efftronics.com';
                  rnoVh:='02DV001';
                END;
                
                IF vh4=TRUE THEN
                BEGIN
                  i:=4;
                  Mail_Send_To:='sbshankar@efftronics.com';
                  rnoVh:='06TE017';
                END;
                
                IF vh5=TRUE THEN
                BEGIN
                  i:=5;
                  Mail_Send_To:='anvesh@efftronics.com';
                  rnoVh:='09RD001';
                END;
                
                IF vh6=TRUE THEN
                BEGIN
                  i:=6;
                  Mail_Send_To:='anilkumar@efftronics.com';
                  rnoVh:='06TE028';
                END;
                IF vh7=TRUE THEN
                BEGIN
                  i:=7;
                  Mail_Send_To:='prasanthi@efftronics.com';
                  rnoVh:='99ST005';
                END;
                // added by Vishnu Priya on 14-09-2020 by the Anil Sir Input
                IF vh8 = TRUE THEN
                  BEGIN
                    i := 8;
                    Mail_Send_To := 'ceo@efftronics.com';
                    rnoVh := '85MD001';
                  END;
                // added by Vishnu Priya on 14-09-2020 by the Anil Sir Input
                IF vm31=TRUE THEN
                BEGIN
                  j:=31;
                  Mail_To:='anvesh@efftronics.com';
                  rnoMgr:='09RD001';
                
                END;
                IF vm32=TRUE THEN
                BEGIN
                  j:=32;
                  Mail_To:='supriya@efftronics.com';
                  rnoMgr:='17RD003';
                
                END;
                IF vm33=TRUE THEN
                BEGIN
                  j:=33;
                  Mail_To:='VENKATESH@efftronics.com';
                  rnoMgr:='17RD031';
                
                END;
                IF vm35=TRUE THEN
                BEGIN
                  j:=35;
                  Mail_To:='jayanagasai@efftronics.com';
                  rnoMgr:='17RD052';
                
                END;
                
                
                IF vm34=TRUE THEN
                BEGIN
                  j:=34;
                  Mail_To:='sarat@efftronics.com';
                  rnoMgr:='17RD033';
                
                END;
                
                IF vm1=TRUE THEN
                BEGIN
                  j:=1;
                  Mail_To:='bhavani@efftronics.com';
                  rnoMgr:='88RD001';
                  {Mail_To:='abdulkhadar@efftronics.com';
                  rnoMgr:='11RD034';}
                END;
                
                IF vm2=TRUE THEN
                BEGIN
                  j:=2;
                   Mail_To:='ramasamy@efftronics.com';
                  rnoMgr:='01QC001';
                 { Mail_To:='gphaneendra@efftronics.com';
                  rnoMgr:='15RD009';}
                END;
                
                IF vm3=TRUE THEN
                BEGIN
                  j:=3;
                  Mail_To:='somu@efftronics.com';
                  rnoMgr:='01TD001';
                END;
                
                IF vm4=TRUE THEN
                BEGIN
                  j:=4;
                  Mail_To:='ubedulla@efftronics.com';
                  rnoMgr:='20FT004';
                END;
                
                IF vm5=TRUE THEN
                BEGIN
                  j:=5;
                  Mail_To:='bala@efftronics.com';
                  rnoMgr:='02DV001';
                
                END;
                
                IF vm6=TRUE THEN
                BEGIN
                  j:=6;
                  Mail_To:='parvathi@efftronics.com';
                  rnoMgr:='01RD005';
                END;
                
                IF vm7=TRUE THEN
                BEGIN
                  j:=7;
                  Mail_To:='jhansi@efftronics.com';
                  rnoMgr:='99DS001';
                END;
                
                {IF vm27=TRUE THEN
                BEGIN
                  j:=27;
                  Mail_To:='divyalakshmi@efftronics.com';
                  rnoMgr:='15RD037';
                END;}
                
                IF vm27=TRUE THEN
                BEGIN
                  j:=27;
                  Mail_To:='ynaresh@efftronics.com';
                  rnoMgr:='17RD038';
                END;
                
                IF vm28=TRUE THEN
                BEGIN
                  j:=28;
                  Mail_To:='sandhyag@efftronics.com';
                  rnoMgr:='06TE003';
                END;
                
                IF vm29=TRUE THEN
                BEGIN
                  j:=29;
                  Mail_To:='bharat@efftronics.com';
                  rnoMgr:='89FD002';
                END;
                IF vm30=TRUE THEN
                BEGIN
                  j:=30;
                  Mail_To:='prasanthi@efftronics.com';
                  rnoMgr:='99ST005';
                END;
                
                IF vm8=TRUE THEN
                BEGIN
                  j:=8;
                  Mail_To:='ramakrishnach@efftronics.com';
                  rnoMgr:='91SR003';
                END;
                
                IF vm9=TRUE THEN
                BEGIN
                  j:=9;
                  Mail_To:='tnmrao@efftronics.com';
                  rnoMgr:='99CS002';
                END;
                IF vm10=TRUE THEN
                BEGIN
                  j:=10;
                  Mail_To:='varaprasad@efftronics.com';
                  rnoMgr:='20P1001';
                END;
                IF vm11=TRUE THEN
                BEGIN
                  j:=11;
                  Mail_To:='nvvrao@efftronics.com';
                  rnoMgr:='20CS019';
                END;
                IF vm12=TRUE THEN
                BEGIN
                  j:=12;
                  Mail_To:='gckrao@efftronics.com';
                  rnoMgr:='02P2002';
                END;
                IF vm13=TRUE THEN
                BEGIN
                  j:=13;
                  Mail_To:='bnarendra@efftronics.com';
                  rnoMgr:='05CS007';
                END;
                IF vm14=TRUE THEN
                BEGIN
                  j:=14;
                  Mail_To:='subbaraog@efftronics.com';
                  rnoMgr:='06CS001';
                END;
                
                IF vm15=TRUE THEN
                BEGIN
                  j:=15;
                  Mail_To:='bhargav@efftronics.com';
                  rnoMgr:='05AP003';
                END;IF vm16=TRUE THEN
                BEGIN
                  j:=16;
                  Mail_To:='sivanagababu@efftronics.com';
                  rnoMgr:='06CS032';
                END;
                IF vm17=TRUE THEN
                BEGIN
                  j:=17;
                  Mail_To:='pradeeps@efftronics.com';
                  rnoMgr:='06CS041';
                END;
                IF vm18=TRUE THEN
                BEGIN
                  j:=18;
                  Mail_To:='srikanth@efftronics.com';
                  rnoMgr:='08CS003';
                END;IF vm19=TRUE THEN
                BEGIN
                  j:=19;
                  Mail_To:='venkanna@efftronics.com';
                  rnoMgr:='08CA032';
                END;
                IF vm20=TRUE THEN
                BEGIN
                  j:=20;
                  Mail_To:='abdulmunaff@efftronics.com';
                  rnoMgr:='08CA026';
                END;
                IF vm21=TRUE THEN
                BEGIN
                  j:=21;
                  Mail_To:='chandrasekhark@efftronics.com';
                  rnoMgr:='08CA075';
                END;
                IF vm22=TRUE THEN
                BEGIN
                  j:=22;
                  Mail_To:='nageswararao@efftronics.com';
                  rnoMgr:='08CA080';
                END;
                IF vm23=TRUE THEN
                BEGIN
                  j:=23;
                  Mail_To:='harik@efftronics.com';
                  rnoMgr:='09CA008';
                END;
                IF vm24=TRUE THEN
                BEGIN
                  j:=24;
                  Mail_To:='satyanarayana@efftronics.com';
                  rnoMgr:='09CA052';
                END;IF vm25=TRUE THEN
                BEGIN
                  j:=25;
                  Mail_To:='gvssprasad@efftronics.com';
                  rnoMgr:='10CA056';
                END;
                IF vm26=TRUE THEN
                BEGIN
                  j:=26;
                  Mail_To:='kishore@efftronics.com';
                  rnoMgr:='12CA002';
                END;
                
                
                
                */
                //***************added by sujani on 03-Nov-18 for direct vertical Authorization
                IF DV1 = TRUE THEN BEGIN

                    direct_vertical := 1;
                    IF (i < 0) THEN
                        ERROR('Select Vertical Manager')
                    ELSE BEGIN
                        BEGIN
                            IF pbh.Status = pbh.Status::Certified THEN BEGIN
                                ERROR('BOM was Already Certified');
                            END
                            ELSE BEGIN
                                pbh.StatusCheck3_check(pbh."No.");
                                REPORT.RUNMODAL(50050, FALSE, FALSE, pbh);
                                REPORT.RUNMODAL(50093, FALSE, FALSE, pbh);
                                Single_Approval_Mail;
                            END;
                        END

                    END;
                END

                ELSE BEGIN

                    IF (i > 0) AND (j > 0) THEN BEGIN
                        IF pbh.Status = pbh.Status::Certified THEN BEGIN
                            ERROR('BOM was Already Certified');
                        END
                        ELSE BEGIN
                            pbh.StatusCheck3_check(pbh."No.");
                            REPORT.RUNMODAL(50050, FALSE, FALSE, pbh);
                            REPORT.RUNMODAL(50093, FALSE, FALSE, pbh);

                            // tempexcelbuffer.SaveRout(pbh."No.");     //mnraju
                            // }
                            Mails;
                        END;
                    END
                    ELSE
                        ERROR('Select Atleast one Vertical Head and Vertical Manager')
                END;
                //***************added by sujani on 03-Nov-18 for direct vertical Authorization
                /*IF (i>0) AND (j>0) THEN
                BEGIN
                  IF pbh.Status=pbh.Status::Certified THEN
                  BEGIN
                    ERROR('BOM was Already Certified');
                  END
                  ELSE
                  BEGIN
                    pbh.StatusCheck3_check(pbh."No.");
                    REPORT.RUNMODAL(50050,FALSE,FALSE,pbh);
                    REPORT.RUNMODAL(50093,FALSE,FALSE,pbh);
                
                    // tempexcelbuffer.SaveRout(pbh."No.");     //mnraju
                
                    Mails;
                  END;
                END
                ELSE
                  ERROR('Select Atleast one Vertical Head and Vertical Manager');
                  */ // commented by sujani on 03-Nov-18

            end;

            trigger OnPostDataItem()
            begin
                item.SETFILTER(item."No.", pbh."No.");
                IF item.FINDFIRST THEN
                    groupCode := item."Item Sub Group Code";
                // MESSAGE(groupCode);
            end;

            trigger OnPreDataItem()
            begin
                Test := pbh.GETFILTER(pbh."No.");
                IF Test = '' THEN
                    ERROR('Enter Item No.');
            end;
        }
    }

    requestpage
    {
        Editable = false;

        layout
        {
            area(content)
            {
                group(General)
                {
                    Visible = false;
                    grid(Control1102152002)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group("Vertical Heads")
                        {
                            Caption = 'Vertical Heads';
                            Enabled = true;
                            Visible = true;
                            field(vh1; vh1)
                            {
                                Caption = 'T.BHAVANI SHANKAR';
                                Enabled = true;
                                Visible = true;
                                ApplicationArea = All;
                            }
                            field(vh2; vh2)
                            {
                                Caption = 'S.R.T.RAMASAMY';
                                ApplicationArea = All;
                            }
                            field(vh3; vh3)
                            {
                                Caption = 'K.BALA KRISHNA';
                                ApplicationArea = All;
                            }
                            field(vh4; vh4)
                            {
                                Caption = 'S.BHAVANI SHANKAR';
                                ApplicationArea = All;
                            }
                            field(vh5; vh5)
                            {
                                Caption = 'D.ANVESH';
                                ApplicationArea = All;
                            }
                            field(vh6; vh6)
                            {
                                Caption = 'N.ANIL KUMAR';
                                ApplicationArea = All;
                            }
                            field(vh7; vh7)
                            {
                                Caption = 'D. PRASANTHI';
                                ApplicationArea = All;
                            }
                            field(vh8; vh8)
                            {
                                Caption = 'MD Sir';
                                ApplicationArea = All;
                            }
                        }
                    }
                }
                group("R&D Managers")
                {
                    Caption = 'R&D Managers';
                    Visible = false;
                    grid(Control1102152017)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152016)
                        {
                            Caption = 'R&D Managers';
                            field(vm1; vm1)
                            {
                                Caption = 'T.BHAVANI SHANKAR';
                                ApplicationArea = All;
                            }
                            field(vm2; vm2)
                            {
                                Caption = 'S.R.T.RAMASAMY';
                                ApplicationArea = All;
                            }
                            field(vm3; vm3)
                            {
                                Caption = 'J.S.S.SOMAYAJULU';
                                ApplicationArea = All;
                            }
                            field(vm4; vm4)
                            {
                                Caption = 'SK.UBEDULLA';
                                Visible = false;
                                ApplicationArea = All;
                            }
                            field(vm5; vm5)
                            {
                                Caption = 'K.BALA KRISHNA';
                                ApplicationArea = All;
                            }
                            field(vm6; vm6)
                            {
                                Caption = 'R.PARVATHI';
                                ApplicationArea = All;
                            }
                            field(vm27; vm27)
                            {
                                Caption = 'Y.NARESH';
                                ApplicationArea = All;
                            }
                            field(vm28; vm28)
                            {
                                Caption = 'G.SANDHYA';
                                ApplicationArea = All;
                            }
                            field(vm7; vm7)
                            {
                                Caption = 'E.JHANSI RANI';
                                Visible = false;
                                ApplicationArea = All;
                            }
                            field(vm32; vm32)
                            {
                                Caption = 'B.SUPRIYA';
                                ApplicationArea = All;
                            }
                            field(vm34; vm34)
                            {
                                Caption = 'V.SARAT';
                                ApplicationArea = All;
                            }
                            field(vm35; vm35)
                            {
                                Caption = 'P.JAYA NAGA SAI GOVIND';
                                ApplicationArea = All;
                            }
                            field(vm33; vm33)
                            {
                                Caption = 'K.VENKATESH';
                                ApplicationArea = All;
                            }
                            field(vm31; vm31)
                            {
                                Caption = 'D.ANVESH';
                                ApplicationArea = All;
                            }
                            field(vm29; vm29)
                            {
                                Caption = 'BHARAT VENIGALLA';
                                Visible = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                }
                group("CS Mangers")
                {
                    Caption = 'CS Mangers';
                    Visible = false;
                    grid(Control1102152039)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152025)
                        {
                            Caption = 'CS Mangers';
                            field(vm8; vm8)
                            {
                                Caption = 'C.H.R.K.P.RANGA RAO';
                                ApplicationArea = All;
                            }
                            field(vm9; vm9)
                            {
                                Caption = 'NAGA MALLESWARA RAO THOTA';
                                ApplicationArea = All;
                            }
                            field(vm10; vm10)
                            {
                                Caption = 'N V VARA PRASAD RAVVA';
                                ApplicationArea = All;
                            }
                            field(vm11; vm11)
                            {
                                Caption = 'VEERA VASANTHA RAO NAGIDI';
                                ApplicationArea = All;
                            }
                            field(vm12; vm12)
                            {
                                Caption = 'CHITTI KANTHA RAO GOLLA';
                                ApplicationArea = All;
                            }
                            field(vm13; vm13)
                            {
                                Caption = 'NARENDRA. BOLEM';
                                ApplicationArea = All;
                            }
                            field(vm14; vm14)
                            {
                                Caption = 'SUBBA RAO . GAJJALAKONDA';
                                ApplicationArea = All;
                            }
                            field(vm15; vm15)
                            {
                                Caption = 'BHARGAVRAM PRASAD JUNNURU';
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152022)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152026)
                        {
                            Caption = 'CS Mangers';
                            field(vm16; vm16)
                            {
                                Caption = 'SIVA NAGA BABU NAINAVARAP';
                                ApplicationArea = All;
                            }
                            field(vm17; vm17)
                            {
                                Caption = 'SAMSON PRADEEP KUMAR.K';
                                ApplicationArea = All;
                            }
                            field(vm18; vm18)
                            {
                                Caption = 'SRIKANTH.INDRAKANTI';
                                ApplicationArea = All;
                            }
                            field(vm19; vm19)
                            {
                                Caption = 'VENKANNA.KODURU';
                                ApplicationArea = All;
                            }
                            field(vm20; vm20)
                            {
                                Caption = 'ABDUL MUNAFF';
                                ApplicationArea = All;
                            }
                            field(vm21; vm21)
                            {
                                Caption = 'CHANDRASEKHAR KONDURI';
                                ApplicationArea = All;
                            }
                            field(vm22; vm22)
                            {
                                Caption = 'NAGESWARA RAO KOMMU';
                                ApplicationArea = All;
                            }
                        }
                    }
                    grid(Control1102152035)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152027)
                        {
                            Caption = 'CS Mangers';
                            field(vm23; vm23)
                            {
                                Caption = 'SREE HARI KODALI';
                                ApplicationArea = All;
                            }
                            field(vm24; vm24)
                            {
                                Caption = 'SATYANARAYANA D V V';
                                ApplicationArea = All;
                            }
                            field(vm25; vm25)
                            {
                                Caption = 'VENKATA SIVA SYAMPRASAD G';
                                ApplicationArea = All;
                            }
                            field(vm26; vm26)
                            {
                                Caption = 'KISHORE LANKA';
                                ApplicationArea = All;
                            }
                            field(vm30; vm30)
                            {
                                Caption = 'D. PRASANTHI';
                                ApplicationArea = All;
                            }
                        }
                    }
                }
                group("Direct Approval")
                {
                    Caption = 'Direct Approval';
                    grid(Control1102152069)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group("Single Mail Authorization")
                        {
                            Caption = 'Single Mail Authorization';
                            field(DV1; DV1)
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

        trigger OnInit()
        begin
            Enabled_or_not := FALSE;
        end;

        trigger OnOpenPage()
        begin
            Enabled_or_not := FALSE;
        end;
    }

    labels
    {
    }

    var
        Mail_Body: Text;
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit "SMTP Mail";
        Subject: Text[250];
        fname1: Text[150];
        flag: Boolean;
        attachment1: Text[1000];
        FileDirectory: Text[100];
        //SMTP_MAIL: Codeunit 8901;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        fname2: Text[150];
        attachment2: Text[150];
        Mail_Send_To: Text[250];
        item: Record Item;
        groupCode: Text[30];
        vh1: Boolean;
        vh2: Boolean;
        vh3: Boolean;
        vh4: Boolean;
        vh5: Boolean;
        vh6: Boolean;
        vh7: Boolean;
        vm1: Boolean;
        vm2: Boolean;
        vm3: Boolean;
        vm4: Boolean;
        vm5: Boolean;
        vm6: Boolean;
        vm7: Boolean;
        vm8: Boolean;
        vm9: Boolean;
        Test: Code[20];
        i: Integer;
        j: Integer;
        save: Boolean;
        rnoMgr: Code[10];
        rnoVh: Code[10];
        bom: Report "Explosion Of Prod. BOM";
        //rout: Report "Explosion Of Routings";
        str: Text[150];
        user: Record "User Setup";
        sender: Text[50];
        Mail_Body1: Text;
        vm10: Boolean;
        vm11: Boolean;
        vm12: Boolean;
        vm13: Boolean;
        vm14: Boolean;
        vm15: Boolean;
        vm16: Boolean;
        vm17: Boolean;
        vm18: Boolean;
        vm19: Boolean;
        vm20: Boolean;
        vm21: Boolean;
        vm22: Boolean;
        vm23: Boolean;
        vm24: Boolean;
        vm25: Boolean;
        vm26: Boolean;
        vm27: Boolean;
        vm28: Boolean;
        vm29: Boolean;
        vm30: Boolean;
        vm31: Boolean;
        vm32: Boolean;
        vm33: Boolean;
        vm34: Boolean;
        vm35: Boolean;
        DV1: Boolean;
        direct_vertical: Integer;
        vh8: Boolean;
        Enabled_or_not: Boolean;

    procedure Mails()
    begin

        /*
        user.SETFILTER(user."User Name",USERID);
        IF user.FINDFIRST THEN
          sender:=user.MailID;
        
        Mail_From:=sender;
        
        {
        // Mail_Send_To:='sundar@efftronics.com';
        // Mail_To:='mnraju@efftronics.com';
        rnoVh:='10RD010';
        rnoMgr:='12RD016';
        }
        
        // Mail_Send_To:='mnraju@efftronics.com';
        
        flag:=FALSE;
        IF (DIALOG.CONFIRM('Send Mail to: '+Mail_To)) THEN
        BEGIN
          flag:=TRUE;
        END
        ELSE
        BEGIN
          ERROR('Cancel the process');
        END;
        
        fname1:='';
        str:='';
        str:=pbh."No.";
        WHILE STRPOS(str,'/') > 1 DO BEGIN
          fname1:=fname1+COPYSTR(str,1,STRPOS(str,'/')-1)+'_';
          str := COPYSTR(str,STRPOS(str,'/') + 1);
        END;
        fname1:=fname1+str;
        str:=fname1;
        
        
        IF flag=TRUE THEN
        BEGIN
          pbh.StatusCheck3_New(pbh."No.");
        
          { IF USERID='SA' THEN
            sender:='mnraju@efftronics.com';
          }
          fname1:='\\erpserver\ErpAttachments\Explosion of BOM\BOM_'+str+'.xls';
          fname2:='\\erpserver\ErpAttachments\routing\Routing_'+str+'.xls';
        
          attachment1:=fname1;
          attachment2:=fname2;
        
          Subject:='ERP- Bom for Approval- '+pbh."No.";
        
          Mail_Body:='<html><body><b>Present BOM Status:</b> '+FORMAT(pbh.Status);
          Mail_Body+='<br><b>Product Name:</b> '+pbh.Description+' '+pbh."Description 2";
          Mail_Body+='<Body><form><br><table style="WIDTH:500px; HEIGHT: 20px;" border="1" align="center">';
          // Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-315/Certify'; //428/Bom_Auth';
          // Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-399:8085/Bom_Auth';
          Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://intranet:8080/Bom_Auth';
          Mail_Body+='/Mail.aspx?no='+pbh."No.";   //bom no.
          Mail_Body+='&desc='+pbh.Description;   //bom Desc
          Mail_Body+='&accept=1';                 //accept
          Mail_Body+='&mgr='+Mail_To+'$'+rnoMgr;              // manager
          Mail_Body+='&erp=0';                     //type:from erp
          Mail_Body+='&vh='+Mail_Send_To+'$'+rnoVh;   //vertical head and id
          Mail_Body+='&sender='+sender;                  //sender mail
          Mail_Body+='"  target="_blank">Verified</a></b></td>';
        
          // Mail_Body+=' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-315/Certify';
          Mail_Body+=' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://intranet:8080/Bom_Auth';
          Mail_Body+='/Mail.aspx?no='+pbh."No.";
          Mail_Body+='&desc='+pbh.Description;   //bom Desc
          Mail_Body+='&accept=0';                //reject
          Mail_Body+='&mgr='+Mail_To+'$'+rnoMgr;
          Mail_Body+='&erp=0';   //type: from erp
          Mail_Body+='&vh='+Mail_Send_To+'$'+rnoVh;
          Mail_Body+='&sender='+sender;
          Mail_Body+='"  target="_blank">Rejected</a></b></td></tr></table>';
        
          Mail_Body1:='<br>Mail was automatically forwarded to Vertical Head <b>'+Mail_Send_To+'</b> once Verified';
          Mail_Body1+='<br><br><b>Please find the Attachments:</b> Explosion of BOM and Routings';
        
          // Mail_Body1+='<br><strong><br>Note: <br>If any modifications, contact ERP Team with Modifications';
        
          SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com',Mail_To,Subject,Mail_Body+Mail_Body1,TRUE);
         { IF USERID <> 'EFFTRONICS\VIJAYA' THEN
          BEGIN}
              SMTP_MAIL.AddCC:='vanidevi@efftronics.com,erp@efftronics.com';
        
        
          //END;
          SMTP_MAIL.AddAttachment(attachment1,''); //EFFUPG
          SMTP_MAIL.AddAttachment(attachment2,''); //EFFUPG
          SMTP_MAIL.Send;
          MESSAGE('Mail has been Sent')
        END;
        */

        //B2BUpg>>
        /* user.SETFILTER(user."User ID", USERID);
        IF user.FINDFIRST THEN
            sender := user.MailID;

        Mail_From := sender;
 */
        //B2BUpg<<
        /*
        // Mail_Send_To:='sundar@efftronics.com';
        // Mail_To:='mnraju@efftronics.com';
        rnoVh:='10RD010';
        rnoMgr:='12RD016';
        */

        // Mail_Send_To:='mnraju@efftronics.com';
        //B2BUpg>>
        /* 
        flag := FALSE;
        IF (DIALOG.CONFIRM('Send Mail to: ' + Mail_To)) THEN BEGIN
            flag := TRUE;
        END
        ELSE BEGIN
            ERROR('Cancel the process');
        END;

        fname1 := '';
        str := '';
        str := pbh."No.";
        WHILE STRPOS(str, '/') > 1 DO BEGIN
            fname1 := fname1 + COPYSTR(str, 1, STRPOS(str, '/') - 1) + '_';
            str := COPYSTR(str, STRPOS(str, '/') + 1);
        END;
        fname1 := fname1 + str;
        str := fname1;


        IF flag = TRUE THEN BEGIN
            pbh.StatusCheck3_New(pbh."No.");
 */
        //B2BUpg<<
        /* IF USERID='SA' THEN
          sender:='mnraju@efftronics.com';
        */
        //B2BUpg>>
        /* fname1 := '\\erpserver\ErpAttachments\Explosion of BOM\BOM_' + str + '.xls';
        fname2 := '\\erpserver\ErpAttachments\routing\Routing_' + str + '.xls';

        attachment1 := fname1;
        attachment2 := fname2;

        Subject := 'ERP- Bom for Approval- ' + pbh."No.";

        Mail_Body := '<html><body><b>Present BOM Status:</b> ' + FORMAT(pbh.Status);
        Mail_Body += '<br><b>Product Name:</b> ' + pbh.Description + ' ' + pbh."Description 2";
        Mail_Body += '<br><b>BOM Category:</b> ' + FORMAT(pbh."BOM Category");
        Mail_Body += '<br><b>Reason:</b> ' + FORMAT(pbh."Remarks/Reason");
        Mail_Body += '<Body><form><br><table style="WIDTH:500px; HEIGHT: 20px;" border="1" align="center">';
        // Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-315/Certify'; //428/Bom_Auth';
        // Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-399:8085/Bom_Auth';
        // Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/Bom_Auth';
        Mail_Body += '<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';

        Mail_Body += '/Mail.aspx?no=' + pbh."No.";   //bom no.
        Mail_Body += '&desc=' + pbh.Description;   //bom Desc
        Mail_Body += '&accept=1';                 //accept
        Mail_Body += '&mgr=' + Mail_To + '$' + rnoMgr;              // manager
        Mail_Body += '&erp=0';                     //type:from erp
        Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;   //vertical head and id
                                                            //Mail_Body+= '&dqa=bharat@efftronics.com$89FD002'; // commentd by vishnu
                                                            // Condition to check R&D BOM/CS BOM
        IF COPYSTR(pbh."No.", 1, 4) = 'INST' THEN
            Mail_Body += '&dqa=sambireddy@efftronics.com$08MD002'
        ELSE
            Mail_Body += '&dqa=exsec@efftronics.com$17SE001';  // CEO Mail
        Mail_Body += '&sender=' + sender;                  //sender mail
        Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
        Mail_Body += '"  target="_blank">Verified</a></b></td>';

        // Mail_Body+=' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-315/Certify';
        // Mail_Body+=' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/Bom_Auth';
        Mail_Body += ' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';
        Mail_Body += '/Mail.aspx?no=' + pbh."No.";
        Mail_Body += '&desc=' + pbh.Description;   //bom Desc
        Mail_Body += '&accept=0';                //reject
        Mail_Body += '&mgr=' + Mail_To + '$' + rnoMgr;
        Mail_Body += '&erp=0';   //type: from erp
        Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;
        //Mail_Body+= '&dqa=bharat@efftronics.com$89FD002'; // commentd by vishnu
        // Condition to check R&D BOM/CS BOM
        IF COPYSTR(pbh."No.", 1, 4) = 'INST' THEN
            Mail_Body += '&dqa=sambireddy@efftronics.com$08MD002'
        ELSE
            Mail_Body += '&dqa=exsec@efftronics.com$17SE001';
        Mail_Body += '&sender=' + sender;
        Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
        Mail_Body += '"  target="_blank">Rejected</a></b></td></tr></table>';

        Mail_Body1 := '<br>Mail was automatically forwarded to DQA <b>' + Mail_Send_To + '</b> once Verified';
        Mail_Body1 += '<br><br><b>Please find the Attachments:</b> Explosion of BOM and Routings';

        // Mail_Body1+='<br><strong><br>Note: <br>If any modifications, contact ERP Team with Modifications';
        // ERROR(Mail_Body);
        SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', Mail_To, Subject, Mail_Body + Mail_Body1, TRUE); // Vishnu
                                                                                                              // SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com',Mail_To,Subject,Mail_Body+Mail_Body1,TRUE); // uncomment after test
                                                                                                              //SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com','sujani@efftronics.com',Subject,Mail_Body+Mail_Body1,TRUE);
        SMTP_MAIL.AddCC := 'erp@efftronics.com'; // uncomment after test
                                                 //END;
        SMTP_MAIL.AddAttachment(attachment1, ''); //EFFUPG
        SMTP_MAIL.AddAttachment(attachment2, ''); //EFFUPG
        SMTP_MAIL.Send;
        MESSAGE('Mail has been Sent')
    END; */
        //B2BUpg<<


        user.SETFILTER(user."User ID", USERID);
        IF user.FINDFIRST THEN
            sender := user.MailID;

        //Mail_From := sender;
        flag := FALSE;
        IF (DIALOG.CONFIRM('Send Mail to: ' + Mail_To)) THEN BEGIN
            flag := TRUE;
        END
        ELSE BEGIN
            ERROR('Cancel the process');
        END;

        fname1 := '';
        str := '';
        str := pbh."No.";
        WHILE STRPOS(str, '/') > 1 DO BEGIN
            fname1 := fname1 + COPYSTR(str, 1, STRPOS(str, '/') - 1) + '_';
            str := COPYSTR(str, STRPOS(str, '/') + 1);
        END;
        fname1 := fname1 + str;
        str := fname1;


        IF flag = TRUE THEN BEGIN
            pbh.StatusCheck3_New(pbh."No.");

            fname1 := '\\erpserver\ErpAttachments\Explosion of BOM\BOM_' + str + '.xls';
            fname2 := '\\erpserver\ErpAttachments\routing\Routing_' + str + '.xls';

            attachment1 := fname1;
            attachment2 := fname2;

            Subject := 'ERP- Bom for Approval- ' + pbh."No.";

            Mail_Body := '<html><body><b>Present BOM Status:</b> ' + FORMAT(pbh.Status);
            Mail_Body += '<br><b>Product Name:</b> ' + pbh.Description + ' ' + pbh."Description 2";
            Mail_Body += '<br><b>BOM Category:</b> ' + FORMAT(pbh."BOM Category");
            Mail_Body += '<br><b>Reason:</b> ' + FORMAT(pbh."Remarks/Reason");
            Mail_Body += '<Body><form><br><table style="WIDTH:500px; HEIGHT: 20px;" border="1" align="center">';
            Mail_Body += '<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';

            Mail_Body += '/Mail.aspx?no=' + pbh."No.";   //bom no.
            Mail_Body += '&desc=' + pbh.Description;   //bom Desc
            Mail_Body += '&accept=1';                 //accept
            Mail_Body += '&mgr=' + Mail_To + '$' + rnoMgr;              // manager
            Mail_Body += '&erp=0';                     //type:from erp
            Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;   //vertical head and id
                                                                //Mail_Body+= '&dqa=bharat@efftronics.com$89FD002'; // commentd by vishnu
                                                                // Condition to check R&D BOM/CS BOM
            IF COPYSTR(pbh."No.", 1, 4) = 'INST' THEN
                Mail_Body += '&dqa=sambireddy@efftronics.com$08MD002'
            ELSE
                Mail_Body += '&dqa=exsec@efftronics.com$17SE001';  // CEO Mail
            Mail_Body += '&sender=' + sender;                  //sender mail
            Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
            Mail_Body += '"  target="_blank">Verified</a></b></td>';

            Mail_Body += ' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';
            Mail_Body += '/Mail.aspx?no=' + pbh."No.";
            Mail_Body += '&desc=' + pbh.Description;   //bom Desc
            Mail_Body += '&accept=0';                //reject
            Mail_Body += '&mgr=' + Mail_To + '$' + rnoMgr;
            Mail_Body += '&erp=0';   //type: from erp
            Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;
            IF COPYSTR(pbh."No.", 1, 4) = 'INST' THEN
                Mail_Body += '&dqa=sambireddy@efftronics.com$08MD002'
            ELSE
                Mail_Body += '&dqa=exsec@efftronics.com$17SE001';
            Mail_Body += '&sender=' + sender;
            Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
            Mail_Body += '"  target="_blank">Rejected</a></b></td></tr></table>';

            Mail_Body1 := '<br>Mail was automatically forwarded to DQA <b>' + Mail_Send_To + '</b> once Verified';
            Mail_Body1 += '<br><br><b>Please find the Attachments:</b> Explosion of BOM and Routings';
            Recipients.Add('erp@efftronics.com');
            //SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', Mail_To, Subject, Mail_Body + Mail_Body1, TRUE); // Vishnu
            EmailMessage.Create(Recipients, Subject, Mail_Body + Mail_Body1, true);                                                                                                    // SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com',Mail_To,Subject,Mail_Body+Mail_Body1,TRUE); // uncomment after test
                                                                                                                                                                                       //SMTP_MAIL.AddAttachment(attachment2, ''); //EFFUPG
            EmailMessage.AddAttachment(attachment1, '', '');
            EmailMessage.AddAttachment(attachment2, '', '');
            //SMTP_MAIL.Send;
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            MESSAGE('Mail has been Sent')
        END;


    end;


    procedure Single_Approval_Mail()
    begin
        user.SETFILTER(user."User ID", USERID);
        IF user.FINDFIRST THEN
            sender := user.MailID;

        Mail_From := sender;

        /*
        // Mail_Send_To:='sundar@efftronics.com';
        // Mail_To:='mnraju@efftronics.com';
        rnoVh:='10RD010';
        rnoMgr:='12RD016';
        */

        // Mail_Send_To:='mnraju@efftronics.com';

        flag := FALSE;
        IF (DIALOG.CONFIRM('Send Mail to: ' + Mail_Send_To)) THEN BEGIN
            flag := TRUE;
        END
        ELSE BEGIN
            ERROR('Cancel the process');
        END;


        fname1 := '';
        str := '';
        str := pbh."No.";
        WHILE STRPOS(str, '/') > 1 DO BEGIN
            fname1 := fname1 + COPYSTR(str, 1, STRPOS(str, '/') - 1) + '_';
            str := COPYSTR(str, STRPOS(str, '/') + 1);
        END;
        fname1 := fname1 + str;
        str := fname1;



        IF flag = TRUE THEN BEGIN
            //pbh.StatusCheck3_New(pbh."No.");
            //pbh.StatusCheck4_New_single_level_Approval(pbh."No.");
            pbh.StatusCheck4_New_single_level_Approval(pbh."No.");
            fname1 := '\\erpserver\ErpAttachments\Explosion of BOM\BOM_' + str + '.xls';
            fname2 := '\\erpserver\ErpAttachments\routing\Routing_' + str + '.xls';

            attachment1 := fname1;
            attachment2 := fname2;
            //B2BUpg>>
            /* Subject := 'ERP- Bom for Vertical Approval- ' + pbh."No.";

            Mail_Body := '<html><body><b>Present BOM Status:</b> ' + FORMAT(pbh.Status);
            Mail_Body += '<br><b>Product Name:</b> ' + pbh.Description + ' ' + pbh."Description 2";
            Mail_Body += '<br><b>BOM Category:</b> ' + FORMAT(pbh."BOM Category");
            Mail_Body += '<Body><form><br><table style="WIDTH:500px; HEIGHT: 20px;" border="1" align="center">';
            //Mail_Body+='<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/Bom_Auth';
            Mail_Body += '<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';
            Mail_Body += '/Mail.aspx?no=' + pbh."No.";   //bom no.
            Mail_Body += '&desc=' + pbh.Description;   //bom Desc
            Mail_Body += '&accept=1';                 //accept
            Mail_Body += '&mgr=' + Mail_Send_To + '$' + rnoVh;              // manager
            Mail_Body += '&erp=1';                     //type:from erp
            Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;   //vertical head and id
            Mail_Body += '&dqa=bharat@efftronics.com$89FD002';
            Mail_Body += '&sender=' + sender;                  //sender mail
            Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
            Mail_Body += '"  target="_blank">Accept</a></b></td>';


            //Mail_Body+=' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://app.efftronics.org:8567/Bom_Auth';
            Mail_Body += ' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';
            Mail_Body += '/Mail.aspx?no=' + pbh."No.";
            Mail_Body += '&desc=' + pbh.Description;   //bom Desc
            Mail_Body += '&accept=0';                //reject
            Mail_Body += '&mgr=' + Mail_Send_To + '$' + rnoVh;
            Mail_Body += '&erp=1';   //type: from erp
            Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;
            Mail_Body += '&dqa=bharat@efftronics.com$89FD002';
            Mail_Body += '&sender=' + sender;
            Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
            Mail_Body += '"  target="_blank">Reject</a></b></td></tr></table>';

            // Mail_Body1:='<br>Mail was automatically forwarded to Vertical Head <b>'+Mail_Send_To+'</b> once Verified';
            Mail_Body1 += '<br><br><b>Please find the Attachments:</b> Explosion of BOM and Routings';
            // Mail_Body1+='<br><b><br>Please find the Attachments:</b> Explosion of BOM and Routings';


            // Mail_Body1+='<br><strong><br>Note: <br>If any modifications, contact ERP Team with Modifications';


            SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', Mail_Send_To, Subject, Mail_Body + Mail_Body1, TRUE);
            SMTP_MAIL.AddCC := 'erp@efftronics.com,vanidevi@efftronics.com';

            //    SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com','sujani@efftronics.com',Subject,Mail_Body+Mail_Body1,TRUE);

            SMTP_MAIL.AddAttachment(attachment1, ''); //EFFUPG
            SMTP_MAIL.AddAttachment(attachment2, ''); //EFFUPG
            SMTP_MAIL.Send;
            MESSAGE('Mail has been Sent') */
            //B2BUpg<<


            Subject := 'ERP- Bom for Vertical Approval- ' + pbh."No.";

            Mail_Body := '<html><body><b>Present BOM Status:</b> ' + FORMAT(pbh.Status);
            Mail_Body += '<br><b>Product Name:</b> ' + pbh.Description + ' ' + pbh."Description 2";
            Mail_Body += '<br><b>BOM Category:</b> ' + FORMAT(pbh."BOM Category");
            Mail_Body += '<Body><form><br><table style="WIDTH:500px; HEIGHT: 20px;" border="1" align="center">';
            Mail_Body += '<Tr> <Td bgcolor=#99FF66 color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';
            Mail_Body += '/Mail.aspx?no=' + pbh."No.";   //bom no.
            Mail_Body += '&desc=' + pbh.Description;   //bom Desc
            Mail_Body += '&accept=1';                 //accept
            Mail_Body += '&mgr=' + Mail_Send_To + '$' + rnoVh;              // manager
            Mail_Body += '&erp=1';                     //type:from erp
            Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;   //vertical head and id
            Mail_Body += '&dqa=bharat@efftronics.com$89FD002';
            Mail_Body += '&sender=' + sender;                  //sender mail
            Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
            Mail_Body += '"  target="_blank">Accept</a></b></td>';

            Mail_Body += ' <Td bgcolor=#ffaaaa color=#FFFFFF  align="center" ><b><a href="http://eff-cpu-393:8567/Bom_Auth';
            Mail_Body += '/Mail.aspx?no=' + pbh."No.";
            Mail_Body += '&desc=' + pbh.Description;   //bom Desc
            Mail_Body += '&accept=0';                //reject
            Mail_Body += '&mgr=' + Mail_Send_To + '$' + rnoVh;
            Mail_Body += '&erp=1';   //type: from erp
            Mail_Body += '&vh=' + Mail_Send_To + '$' + rnoVh;
            Mail_Body += '&dqa=bharat@efftronics.com$89FD002';
            Mail_Body += '&sender=' + sender;
            Mail_Body += '&category=' + FORMAT(pbh."BOM Category");                  //BOM CATEROGORY
            Mail_Body += '"  target="_blank">Reject</a></b></td></tr></table>';

            Mail_Body1 += '<br><br><b>Please find the Attachments:</b> Explosion of BOM and Routings';
            Recipients.Add('erp@efftronics.com');
            Recipients.Add('vanidevi@efftronics.com');
            //SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', Mail_Send_To, Subject, Mail_Body + Mail_Body1, TRUE);
            //SMTP_MAIL.AddCC := 'erp@efftronics.com,vanidevi@efftronics.com';
            EmailMessage.Create(Recipients, Subject, Mail_Body + Mail_Body1, true);

            //    SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com','sujani@efftronics.com',Subject,Mail_Body+Mail_Body1,TRUE);

            //SMTP_MAIL.AddAttachment(attachment1, ''); //EFFUPG
            //SMTP_MAIL.AddAttachment(attachment2, ''); //EFFUPG
            EmailMessage.AddAttachment(attachment1, '', '');
            EmailMessage.AddAttachment(attachment2, '', '');
            //SMTP_MAIL.Send;
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            MESSAGE('Mail has been Sent')
        END;

    end;
}

