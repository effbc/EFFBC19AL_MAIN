pageextension 70213 ServiceOrderSubformExt extends "Service Order Subform"
{

    layout
    {



        /* modify("Control1")
         {



             ShowCaption = false;
         }*/



        addafter(Warranty)
        {
            field(Tested; Rec.Tested)
            {
                ApplicationArea = All;
            }
            field(Station; Rec.Station)
            {
                ApplicationArea = All;
            }
            field("Station Name"; Rec."Station Name")
            {
                ApplicationArea = All;
            }
            field("From Location"; Rec."From Location")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    FromLocationOnAfterValidate;
                end;
            }
            field("To Location"; Rec."To Location")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    ToLocationOnAfterValidate;
                end;
            }
            field(Account; Rec.Account)
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    AccountOnPush;
                end;
            }
            field("Service Level"; Rec."Service Level")
            {
                ApplicationArea = All;
            }
        }
        addafter("Warranty Starting Date (Labor)")
        {
            field("CS Product"; Rec."CS Product")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CS Module"; Rec."CS Module")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CS model"; Rec."CS model")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Fault Area Code")
        {
            field("Fault Area Description"; Rec."Fault Area Description")
            {
                Caption = 'Product Module Description';
                Editable = false;
                ApplicationArea = All;
            }
            field("Sub Module Code"; Rec."Sub Module Code")
            {
                ApplicationArea = All;
            }
            field("Sub Module Descrption"; Rec."Sub Module Descrption")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Problem from Site"; Rec."Problem from Site")
            {
                ApplicationArea = All;
            }
            field("Site Problem Matched"; Rec."Site Problem Matched")
            {
                ApplicationArea = All;
            }
            field("QC internal Remarks"; Rec."QC internal Remarks")
            {
                ApplicationArea = All;
            }
            field("Site Feedback"; Rec."Site Feedback")
            {
                ApplicationArea = All;
            }
        }
        addafter("Finishing Time")
        {
            field("Sent date time"; Rec."Sent date time")
            {
                ApplicationArea = All;
            }
            field("Unit cost"; Rec."Unit cost")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("Resource &Allocations")
        {



            ShortCutKey = 'Shift+Ctrl+A';
        }


        addafter("Service Item &Log")
        {
            action("T&roubleshotting Setup")
            {
                Caption = 'T&roubleshotting Setup';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #5900. Unsupported part was commented. Please check it.
                    /*CurrPage.ServItemLines.Page.*/
                    TroubleShottingforSerItem;

                end;
            }
        }
        addafter("Get St&d. Service Codes")
        {
            action("&Attachments")
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #5900. Unsupported part was commented. Please check it.
                    /*CurrPage.ServItemLines.Page.*/
                    _Attachments;

                end;
            }
            action("Pre Site Visit")
            {
                Caption = 'Pre Site Visit';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #5900. Unsupported part was commented. Please check it.
                    /*CurrPage.ServItemLines.Page.*/
                    Presite;

                end;
            }
        }
    }



    var
        "ITEMLEDGER ENTRY": Record "Item Ledger Entry";
        item: Record Item;
        Customer: Record Customer;
        ServHeader: Record "Service Header";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Mail_From: Text;
        Mail_To: Text;
        Subject: Text;
        Body: Text;









    procedure _Attachments();
    var
        Attach: Record Attachments;
    begin
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Service Header");
        Attach.SETRANGE("Document No.", Rec."Document No.");
        Attach.SETRANGE("Document Type", Rec."Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", Attach);
    end;



    procedure Attachments();
    var
        Attach: Record Attachments;
    begin
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Service Header");
        Attach.SETRANGE("Document No.", Rec."Document No.");
        Attach.SETRANGE("Document Type", Rec."Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", Attach);
    end;





    procedure Presite();
    var
        PreSiteCheckList: Record "Inst. PreSite Check List";
    begin
        PreSiteCheckList.RESET;
        PreSiteCheckList.SETRANGE("Sales Order No.", Rec."Document No.");
        PreSiteCheckList.SETRANGE("Sales Order Line No.", Rec."Line No.");
        PAGE.RUN(PAGE::"Inst. PreSite Check List", PreSiteCheckList);
    end;




    procedure TroubleShottingforSerItem();
    var
        TroubleshottingSetup: Record "Troubleshooting Setup";

    begin
        TroubleshottingSetup.SETRANGE("No.", Rec."Service Item No.");
        TroubleshottingSetup.SETRANGE(TroubleshottingSetup."Service Order No", Rec."Document No.");
        IF NOT (TroubleshottingSetup.FINDFIRST) THEN BEGIN
            TroubleshottingSetup.INIT;
            TroubleshottingSetup.Type := TroubleshottingSetup.Type::"Service Item";
            TroubleshottingSetup."No." := Rec."Service Item No.";
            TroubleshottingSetup."Troubleshooting No." := 'TR00001';
            TroubleshottingSetup."Line No." := 10000;
            TroubleshottingSetup.Date := WORKDATE;
            TroubleshottingSetup."Service Order No" := Rec."Document No.";
            TroubleshottingSetup.INSERT;
        END;

        TroubleshottingSetup.RESET;
        TroubleshottingSetup.SETRANGE("No.", Rec."Service Item No.");
        PAGE.RUN(PAGE::"Troubleshooting Setup", TroubleshottingSetup);
    end;


    local procedure FromLocationOnAfterValidate();
    begin
        IF Rec."To Location" <> '' THEN BEGIN
            IF Rec."To Location" = Rec."From Location" THEN
                ERROR('From and TO Locations Must not be Same');
        END;

        ServHeader.RESET;
        ServHeader.SETRANGE(ServHeader."No.", Rec."Document No.");
        IF ServHeader.FINDFIRST THEN BEGIN
            IF ServHeader.Description = 'Created Automatically' THEN BEGIN
                IF (Rec."From Location" <> 'H-OFF') AND (Rec."From Location" <> 'SERVICE') AND (Rec."From Location" <> 'V-R-L')
                  AND (Rec."From Location" <> 'DAMAGE') THEN
                    ERROR('PLEASE CHOOSE THE CORRECT LOCATION');
            END;
        END;
    end;



    local procedure ToLocationOnAfterValidate();
    begin
        IF Rec."From Location" <> '' THEN BEGIN
            IF Rec."To Location" = Rec."From Location" THEN
                ERROR('From and TO Locations Must not be Same');
        END;

        ServHeader.RESET;
        ServHeader.SETRANGE(ServHeader."No.", Rec."Document No.");
        IF ServHeader.FINDFIRST THEN BEGIN
            IF ServHeader.Description = 'Created Automatically' THEN BEGIN
                IF (Rec."To Location" <> 'H-OFF') AND (Rec."To Location" <> 'SERVICE') AND (Rec."To Location" <> 'V-R-L')
                  AND (Rec."To Location" <> 'DAMAGE') THEN
                    ERROR('PLEASE CHOOSE THE CORRECT LOCATION');
            END;
        END;
    end;


    local procedure AccountOnPush();
    begin






        IF xRec.Account = TRUE THEN BEGIN
            IF xRec."Item No." = '' THEN BEGIN
                MESSAGE('PLEASE SELECT ITEM LOCATION');
                EXIT;
            END;
            IF xRec."From Location" = '' THEN BEGIN
                MESSAGE('PLEASE ENTER FROM LOCATION');
                EXIT;
            END;
            IF xRec."To Location" = '' THEN BEGIN
                MESSAGE('PLEASE ENTER TO LOCATION');
                EXIT;
            END;
            IF xRec."Serial No." = '' THEN BEGIN
                MESSAGE('PLEASE ENTER SERIAL NO LOCATION');
                EXIT;
            END;
        END;


        /*Mail_From := 'erp@efftronics.com';
        Mail_To := 'vishnupriya@efftronics.com';
        Subject := 'Reg: Service Card Account Change ' + Rec."Document No.";
        Body := '';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        SMTP_MAIL.AppendBody('<html><head><style> divone{background-color: white; width: 900px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
        SMTP_MAIL.AppendBody('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 800px;"><label><font size="6">Service Order Account Tick Mark</font></label>');
        SMTP_MAIL.AppendBody('<hr style=solid; color= #3333CC>');
        /*
        SMTP_MAIL.AppendBody('<h>Dear Manufacturing Dept. ,</h><br><br>');
        SMTP_MAIL.AppendBody('<h><b>Responsible Dept: <font color=red>Manufacturing.</b></font></h><br>');
        SMTP_MAIL.AppendBody('<P> The below are details of RPO without Material Issues and have prod start date < today, </P>');
        
       11 SMTP_MAIL.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >User id</th><th >Service Order Number</th><th >service Item Number</th><th >Tickmark</th></tr>');
        //SMTP_MAIL.AppendBody('<th>Schedule Line No.</th><th>Quantity</th><th>Prod Start Date</th></tr>');
        SMTP_MAIL.AppendBody('<tr><td>' + USERID + '</td>');
        SMTP_MAIL.AppendBody('<td>' + Rec."Document No." + '</td>');
        SMTP_MAIL.AppendBody('<td>' + Rec."Service Item No." + '</td>');
        SMTP_MAIL.AppendBody('<td>' + FORMAT(Rec.Account) + '</td></tr></table>');
        SMTP_MAIL.AppendBody('<td>' + FORMAT(Rec."Repair Status Code") + '</td></tr></table>');
        SMTP_MAIL.Send;*/

    end;



}

